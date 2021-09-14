#!/bin/sh

(cd package && zip -r /lambda/function.zip .)
chmod 755 main.py
zip -g /lambda/function.zip main.py --exclude *.sh *.txt Dockerfile.*

chmod 777 /lambda/function.zip
