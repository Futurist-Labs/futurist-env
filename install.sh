#!/bin/bash

targetFile=~/.bash_flabs

echo >> $targetFile
echo "# FuturistLabs Env" >> $targetFile
echo "# ###" >> $targetFile
echo "PATH=\$PATH:\"`pwd`\"" >> $targetFile
echo >> $targetFile


echo >> ~/.bash_profile
echo "# FuturistLabs Env" >> ~/.bash_profile
echo 'source ~/.bash_flabs' >> ~/.bash_profile
echo >> ~/.bash_profile

