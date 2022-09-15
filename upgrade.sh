#!/bin/bash

index=$(curl -s https://snapshot-de.mydefichain.com/index.txt | tail -1)
file="https://snapshot-de.mydefichain.com/${index}"

DFI_FOLDER=$HOME
DFI_RELEASE=$1
DFI_SNAPSHOT=$2
DONE="[\e[32mDONE\e[39m]"

if [[ $# -lt 1 ]];
then
  echo "Usage: $0 [release] [snapshot]"
  echo "release - Release number like 2.6.2"
  echo "snapshot - true if you like to restore from current snapshot"
  exit 2
fi

echo -n "Downloading binary and checking SHA256: "
cd $DFI_FOLDER
wget -q https://github.com/DeFiCh/ain/releases/download/v${DFI_RELEASE}/defichain-${DFI_RELEASE}-x86_64-pc-linux-gnu.tar.gz
wget -q https://github.com/DeFiCh/ain/releases/download/v${DFI_RELEASE}/defichain-${DFI_RELEASE}-x86_64-pc-linux-gnu.tar.gz.SHA256

sha256sum -c defichain-${DFI_RELEASE}-x86_64-pc-linux-gnu.tar.gz.SHA256 > /dev/null

if [ $? -ne 0 ]; then
  echo "FAILED CHECKSUM!"
  exit 1
fi

echo -e $DONE

echo -n "Disable CRON: "
crontab -l > $DFI_FOLDER/cron_tmp
echo "" | crontab -
echo -e $DONE

echo -n "Stop dfid: "
PIDS=$(pidof defid)
if [ -n "$PIDS" ];
then
  kill $PIDS
  while [ -n "$PIDS" ]; do
    sleep 1
    PIDS=$(pidof defid)
  done
fi
echo -e $DONE

echo -n "Updating defi node v.${DFI_RELEASE}: "

tar xzf defichain-${DFI_RELEASE}-x86_64-pc-linux-gnu.tar.gz
cp defichain-${DFI_RELEASE}/bin/* .defi/
rm -rf defichain-${DFI_RELEASE}*
echo -e $DONE

if [ "$DFI_SNAPSHOT" == "true" ];
then
  echo -n "Setup from snapshot: "
  cd .defi
  rm -rf anchors/ burn/ blocks/ chainstate/ enhancedcs/ history/ spv
  wget -q $file
  tar xzf $index
  rm -rf *.tar.gz
  echo -e $DONE
fi

echo -n "Enable CRON: "
crontab $DFI_FOLDER/cron_tmp
rm $DFI_FOLDER/cron_tmp
echo -e $DONE

echo ".:[ DONE ]:."
