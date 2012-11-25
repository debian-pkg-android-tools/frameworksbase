#!/bin/bash

REVISION=21
DIRECTORY=androidframeworksbase

if [ -d $DIRECTORY -o -f $DIRECTORY ]
then
    echo "The file/directory '$DIRECTORY' exists .. aborting."
    exit
fi


git clone -b tools_r$REVISION https://android.googlesource.com/platform/frameworks/base/ $DIRECTORY

VERSION=`git --git-dir=$DIRECTORY/.git log -1 --format=%cd~%h --date=short | sed s/-//g`

echo "Version $VERSION"

# now we delete the files that we dont intend to use
echo "Deleting not needed files ..."
rm -fr `find $DIRECTORY -maxdepth 1 -type d ! -name $DIRECTORY ! -name tools`
rm -fr `find $DIRECTORY/tools -maxdepth 1 -type d ! -name tools ! -name aidl`
rm -f preloaded-classes


echo "Packaging archive into ../${DIRECTORY}_$REVISION+git$VERSION.orig.tar.gz ..."
tar -czf ../${DIRECTORY}_$REVISION+git$VERSION.orig.tar.gz $DIRECTORY
echo "Deleting folder '$DIRECTORY'"
rm -Ir $DIRECTORY

