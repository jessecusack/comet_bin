#!/bin/bash
# A bash script to copy MITgcm models to scratch for running on comet

MODEL_PATH=$(readlink -f ${1})
echo "Copying: $MODEL_PATH"

# Check the model path looks like an MITgcm dir
if [ -d "$MODEL_PATH/input" ]; then
  echo "Found: $MODEL_PATH/input"
  INPUT=$MODEL_PATH/input
else
  echo "Could not find input directory, exiting."
  exit 1
fi

if [ -d "$MODEL_PATH/build" ]; then
  echo "Found: $MODEL_PATH/build"
  BUILD=$MODEL_PATH/build
else
  echo "Could not find build directory, exiting."
  exit 1
fi

SCRATCH_PATH="/oasis/scratch/comet/$USER/temp_project"
echo "Scratch path: $SCRATCH_PATH"

RUN_BASENAME=${2:-$(basename $MODEL_PATH)}
echo "Creating: $SCRATCH_PATH/$RUN_BASENAME"
RUN_PATH=$SCRATCH_PATH/$RUN_BASENAME
mkdir -p $RUN_PATH
mkdir -p $RUN_PATH/logs

echo "Copying input"
cp -v $INPUT/*.bin $INPUT/data* $INPUT/eedata $RUN_PATH
echo "Copying mitgcmuv"
cp -v $BUILD/mitgcmuv $RUN_PATH
