#!/bin/bash
#
# Demo Docker: This script demonstrates how to use the
# dockerised version of swagger2aglio
#

##########
# config - vary these for your local requirements
#

# swagger file name (not including directory/path)
INFILE=example.yml
# full path of the directory holding INFILE
# you probably want to make sure there is a swagger file there...
INDIR=`pwd`

# what you want your output file to be called
OUTFILE=apidoc.html
# where you want your output file written
OUTDIR=`pwd`/_tmp

#############
# execution - no need to edit from here down
# but read it to see how to use the container

# First, ensure ensure the OUTDIR exists.
mkdir -p $OUTDIR

# Second, ensure we have a docker image to work with.
# We can build this locally... (as we do here)
docker build -t swagger2aglio .
IMAGE_NAME=swagger2aglio
# or you could just use monkeypants/swagger2aglio
# and avoid building the image (or directly touching
# this repo - the built image is published via swaggerhub
# IMAGE_NAME=monkeypants/swagger2aglio

# This is where we use the containerised version.
# Note, we can use any of --options supported by 
# swagger2aglio here
docker run \
 -v $INDIR:/app/indir -v $OUTDIR:/app/outdir  \
 $IMAGE_NAME swagger2aglio \
 --input=/app/indir/$INFILE --output=/app/outdir/$OUTFILE  \
 --theme-variables slate --theme-template triple

echo ""
echo "If the docker container proudly reported Success!, then your docs are here:"
echo "    $OUTDIR/$OUTFILE"
