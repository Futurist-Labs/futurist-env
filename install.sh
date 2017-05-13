#!/bin/bash

targetFile=~/.bash_flabs

echo >> $targetFile
echo "# FuturistLabs Env" >> $targetFile
echo "# ###" >> $targetFile
echo "PATH=\$PATH:\"`pwd`\"" >> $targetFile
echo >> $targetFile

