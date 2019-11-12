#!/bin/bash

echo "Path to NW752 distrib:" $NW752_DISTRIB
if [ -z $NW752_DISTRIB ]; then
    echo "Path to NW752 distrib is not defined"
    echo "Please define it with 'export NW752_DISTRIB=/path/to/distrib'"
    exit 1
fi

export NW752_SCRIPT_HOME=$(cd `dirname $0` && pwd)
echo "Installation scipt homedir is:" $NW752_SCRIPT_HOME

# Timestamp
# date +%s > /tmp/provision-start.timestamp
PROVISION_START_TS=`date +%s`

./scripts/add_swap.sh
./scripts/pre_install.sh
./scripts/install_nw.sh
./scripts/startup.sh
./scripts/post_install.sh

echo "Installation sequence complete"

# Elapsed time calculation
# PROVISION_START_TS=`cat /tmp/provision-start.timestamp`
PROVISION_END_TS=`date +%s`
ELAPSED_TIME=$(($PROVISION_END_TS - $PROVISION_START_TS))
echo "Installation took $(($ELAPSED_TIME / 60)) minutes and $(($ELAPSED_TIME % 60)) seconds"
