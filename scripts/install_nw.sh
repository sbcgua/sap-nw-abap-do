#!/bin/sh

echo "Installing SAP NW ..."
if [ -e /sapmnt ]; then
    echo "  seems SAP is already installed, skipping"
    exit 0
fi

if [ ! -e $NW752_DISTRIB/install.sh ]; then
    echo "  install.sh NOT found, NW install failed, continue manually"
    exit 0
fi

cd $NW752_DISTRIB
# cp /vagrant/scripts/run-install.sh /tmp
# chmod +x install.sh
# chmod +x /tmp/run-install.sh
sudo expect -f $NW752_SCRIPT_HOME/scripts/install_nw.expect
# rm /tmp/run-install.sh

if [ ! -n "$(netstat -tan4 | grep 3200)" ]; then
    echo "Waiting for NW to start ..."
    sleep 60s
    if [ ! -n "$(netstat -tan4 | grep 3200)" ]; then
        echo "Still not started ... waiting more ..."
        sleep 60s
        if [ ! -n "$(netstat -tan4 | grep 3200)" ]; then
            echo "[!] NW hasn't started after 2 minutes, this is strage"
            echo "[!] Continuing with the script but there might be some issue"
        fi
    fi
fi

if [ -n "$(netstat -tan4 | grep 3200)" ]; then
    echo "NW instance detected and listening"
fi

# TODO cd back no matter what ... kind of catch/finally
cd $NW752_SCRIPT_HOME
