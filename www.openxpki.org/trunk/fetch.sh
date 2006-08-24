#!/bin/sh

# Script for updating OpenXPKI nightly snapshot at a www mirror.

WGET=`which wget`
if [ ! -x ${WGET} ]; then
    WGET="/usr/local/bin/wget"
fi
THIS_DIR=`pwd`

# Fetch newer files from the master server
# (do NOT shorten the name "sourceforge" below, 
# this would ruin the operation of wget):

${WGET} -nH -m -I lastmidnight http://openxpki.sourceforge.net/lastmidnight/index.html

# Remove those files at the mirror, which are 
# not referenced by new index.html any more:

cd ${THIS_DIR}/lastmidnight
FILES_LIST=`ls`
 
for file in ${FILES_LIST}; do
    if [ ! $file = 'index.html' ]; then
        RES=`grep -o -e $file index.html`
        if [ ! "${RES}" ]; then
            echo "File $file will be removed"
            rm -f $file
        fi
    fi
done

