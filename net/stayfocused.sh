#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    echo "[!] Unsupported operating system: $(uname)."
    exit
fi

# Catch ctrlc
trap ctrl_c INT
function ctrl_c() {
    echo "[!] You need to stay focused!"
}

# $1 - how many hours to block, in seconds
BLOCKLIST='/etc/timeblock.conf'
if [ -f "$BLOCKLIST" ]; then
    echo "[+] Blocklist exists..commencing."
else
    echo "[!] Blocklist not found. Please populate /etc/timeblock.conf."
    exit
fi

echo "[+] Creating backup of host file at /etc/hosts.bak..."
cp /etc/hosts /etc/hosts.bak

echo "[+] Deleting current host file entries...please adjust truncation when necessary to correspond with your host entries"
sed -i '12,$d' /etc/hosts

echo "[+] Parsing lines in blocklist..."
while IFS= read -r line; do
    echo "127.0.0.1 $line" >> /etc/hosts
done < "$BLOCKLIST"

# Block hours as seconds, call sleep
timeToBlock=$1
echo '[+] Blocking...'
sleep $timeToBlock

echo "[+] Tried your best!"
echo "[+] Reverting to original file hosts file..."
cp /etc/hosts.bak /etc/hosts && rm /etc/hosts.bak && echo "[!] Goodbye!"
