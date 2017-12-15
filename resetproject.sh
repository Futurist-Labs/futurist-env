#!/bin/bash

rm -r -f Pods
rm -r -f *.xcworkspace
rm Podfile.lock
pod install
open `ls | grep *.xcworkspace`

