#!/bin/bash

# ---- stuff to limit build log ---
set -e
export PING_SLEEP=30s
export WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export BUILD_OUTPUT=$WORKDIR/build.out

touch $BUILD_OUTPUT

dump_output() {
   echo Tailing the last 500 lines of output:
   tail -500 $BUILD_OUTPUT  
}

error_handler() {
  echo ERROR: An error was encountered with the build.
  dump_output
  exit 1
}

# If an error occurs, run our error handler to output a tail of the build
trap 'error_handler' ERR

bash -c "while true; do echo \$(date) - building ...; sleep $PING_SLEEP; done" &
PING_LOOP_PID=$!

# My build is using maven, but you could build anything with this, E.g.
# your_build_command_1 >> $BUILD_OUTPUT 2>&1
# your_build_command_2 >> $BUILD_OUTPUT 2>&1

# ---- stuff to limit build log ---

# Pull poky repo
echo "Clone poky fido..."
git clone -b fido https://git.yoctoproject.org/git/poky
cd poky

# Pull meta-openembedded
echo "Clone meta-openembedded..."
git clone https://github.com/openembedded/meta-openembedded.git

# Pull meta-jellyfish
echo "Clone meta-jellyfish..."
git clone https://github.com/letanphuc/meta-jellyfish.git

# Source environment variables
echo "Source environment variables..."
source oe-init-build-env

# ---- stuff to add update meta-jellyfish to conf ---

# Goto conf folder
cd conf/

# Search string
STR1=$(grep -m 1 "meta-yocto-bsp" bblayers.conf)
#echo $STR1

# Remove backslash
STR2=$(echo $STR1 | sed 's/\\//g')
#echo $STR2

# Remove pattern
STR3=$(echo $STR2 | sed -E 's/(meta-yocto-bsp)+$//')
#echo $STR3

# Create new meta
STR4=$STR3'meta-jellyfish \'
echo PATTERN=$STR4

# Get line number match pattern
LINE1=$(grep -nr "meta-yocto-bsp" bblayers.conf | sed 's/:.*//')
echo LINE1=$LINE1

# Append patterns
sed -i "${LINE1} i \  ${STR4} \\" bblayers.conf

# Get line number match pattern
LINE2=$(grep -n "meta-yocto" bblayers.conf | tail -1 | sed 's/:.*//')
echo LINE2=$LINE2

# Append patterns
sed -i "${LINE2} i \  ${STR4} \\" bblayers.conf

# Print out the config file
cat bblayers.conf

# Return to build folder
cd ../

# ---- stuff to add update meta-jellyfish to conf ---

bitbake MACHINE=jf4418 core-image-minimal >> $BUILD_OUTPUT 2>&1

# ---- stuff to limit build log ---
# The build finished without returning an error so dump a tail of the output
dump_output

# nicely terminate the ping output loop
kill $PING_LOOP_PID
# ---- stuff to limit build log ---

