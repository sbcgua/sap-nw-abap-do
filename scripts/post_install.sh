#!/bin/sh

echo "Adjusting SAP profile - increasing workers number..."
PROFILE_PATH=/sapmnt/NPL/profile/NPL_D00_vhcalnplci
cp $PROFILE_PATH $PROFILE_PATH.bak
sed -i -e 's/wp_no_dia = 2/wp_no_dia = 6/' $PROFILE_PATH

echo "SAP HARDWARE KEY"
sudo -i -u npladm saplicense -get || true
