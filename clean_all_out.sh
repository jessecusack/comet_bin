#!/bin/bash
# A bash script to clean MITgcm output on comet

DIR=$(readlink -f ${1})

read -p "Are you sure you want to delete the contents of $(basename $DIR)? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Check if it seems like an MITgcm run directory on scratch...
if test -f "$DIR/mitgcmuv"; then
    echo "$DIR/mitgcmuv exists so it seems safe to clean."
else
    echo "Could not find mitgcmuv, exiting without doing anything."
    exit 1
fi

rm -rfv $DIR/*.data $DIR/*.meta $DIR/mnc_* $DIR/available_diagnostics.log $DIR/STD* $DIR/*.nc
