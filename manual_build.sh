#!/bin/bash
# Yocto build script for JF4418
# Copyright @ 2016 Dang Minh Phuong

# Check source code folder exists
if [ -f "poky" ]; then
    cd poky
    # Source environment variables
    echo "Source environment variables..."
    source oe-init-build-env
else
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

    # Replace the machine name
    sed -i '/MACHINE ??= "qemux86"/c\MACHINE ??= "jf4418"' local.conf

    # Print out the config file
    cat local.conf

    # Return to build folder
    cd ../
fi

# Build yocto
bitbake $1
