#!/bin/bash

# remove some tools required for installation
# purposes only; trying to keep the container
# as large as necessary but as small as possible.
apt-get remove --purge subversion
apt-get remove --purge wget
apt-get remove --purge gcc
apt-get remove --purge g++
apt-get remove --purge gfortran
apt-get remove --purge gdebi-core
apt-get clean

# Remove some shell scripts we created
rm /setup.sh
rm /cleanup.sh
find /tmp -type f -exec rm {} \;
