#!/bin/bash
sudo chmod 777 /dev/ttyUSB0
stty -F /dev/ttyUSB0 sane
stty -F /dev/ttyUSB0 19200 cs8 -cstopb -parenb -opost -inlcr
stty -F /dev/ttyUSB0
