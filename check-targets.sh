#!/bin/bash

if ! [ -x "$(command -v xcproj)" ]; then
  echo "Error: Missing xcproj. You can install it by executing: brew install xcproj";
  return;
fi

devTarget=`xcproj list-targets | grep 'Dev$' | wc -l`
prodTarget=`xcproj list-targets | grep 'Prod$' | wc -l`

if [ "$devTarget" -eq "0" ]; then
  echo "Warning: Missing DEV target";
fi

if [ "$prodTarget" -eq "0" ]; then
  echo "Warning: Missing Prod target";
fi
