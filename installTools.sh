#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GRE='\033[0;32m'
NC='\033[0m'

SCR_PATH='./enum-scripts/'
verb=0

header() {
    echo "    ____           __        __________            __    ";
    echo "   /  _/___  _____/ /_____ _/ / /_  __/___  ____  / /____";
    echo "   / // __ \/ ___/ __/ __ \`/ / / / / / __ \/ __ \/ / ___/";
    echo " _/ // / / (__  ) /_/ /_/ / / / / / / /_/ / /_/ / (__  ) ";
    echo "/___/_/ /_/____/\__/\__,_/_/_/ /_/  \____/\____/_/____/  ";
    echo "                                             by @havocsec";
    echo ""
    echo "Now installs/updates the following tools:"
    echo " - Impacket by SecureAuthCorp (https://github.com/SecureAuthCorp/impacket)"
    echo " - Kerbrute by Tarlogic Security (https://github.com/TarlogicSecurity/kerbrute)"
    echo " - GoBuster by OJ Reeves AKA @TheColonial (https://github.com/OJ/gobuster)"
    echo " - Evil-WinRM by HackPlayers (https://github.com/Hackplayers/evil-winrm)"
    echo " - Enum4linux by Portcullis Labs (https://github.com/portcullislabs/enum4linux)"
    echo " - smbclient, a component of the SAMBA suite"
    echo ""
    echo "And the following enumeration scripts on ${SCR_PATH}:"
    echo " - LinEnum by rebootuser (https://github.com/rebootuser/LinEnum)"
    echo " - LinuxSmartEnumeration by diego-treitos (https://github.com/diego-treitos/linux-smart-enumeration)"
    echo " - UnixPrivescCheck by pentestmonkey (https://github.com/pentestmonkey/unix-privesc-check)"
    echo " - JAWS by 411Hall (https://github.com/411Hall/JAWS)"
    echo ""
}

if_err () {
    if [[ $? -gt 0 ]]; then
        echo -e "${RED}Error $1, exiting...${NC}"
        exit -1
    fi
}

echo_info () {
    if [[ "$verb" -eq 1 ]]; then
        echo "$1"
    fi
}

on_succ() {
    echo -e "${GRE}Successfully installed $1${NC}"
}

help () {
    echo "Usage: ./installTools.sh [-h] [-v]"
    echo "  -h  Print this help"
    echo "  -v  Verbose mode"
    exit 0
}

# Argument handling
header
for arg in "$@"; do
    if [ "$arg" = "-h" ]; then
        help
    elif [ "$arg" = "-v" ]; then
        verb=1
    elif [ "$arg" = "$0" ]; then
        :
    else
        echo -e "${RED}Invalid argument${NC}"
        help
    fi
done

# Impacket
echo_info "Downloading impacket..."
wget -q -O ./impacket-0.9.20.tar.gz 'https://github.com/SecureAuthCorp/impacket/releases/download/impacket_0_9_20/impacket-0.9.20.tar.gz' &> /dev/null
if_err "downloading impacket"
echo_info "Extracting impacket..."
tar -xzf ./impacket-0.9.20.tar.gz &> /dev/null
if_err "extracting impacket"
echo_info "Installing impacket..."
cd ./impacket-0.9.20
pip3 install . &> /dev/null && cd .. && rm -rf ./impacket-0.9.20*
if_err "installing impacket"
on_succ "impacket"


# Kerbrute
echo_info "Downloading kerbrute..."
git clone 'https://github.com/TarlogicSecurity/kerbrute' &> /dev/null
if_err "downloading kerbrute"
echo_info "Installing dependencies for kerbrute..."
pip3 install -r ./kerbrute/requirements.txt &> /dev/null
if_err "installing dependencies for kerbrute"
echo_info "Installing kerbrute..."
mv ./kerbrute/kerbrute.py /usr/local/bin/kerbrute.py && chown root:root /usr/local/bin/kerbrute.py && chmod 755 /usr/local/bin/kerbrute.py && rm -rf ./kerbrute
if_err "installing kerbrute"
on_succ "kerbrute"

# GoBuster
echo_info "Installing GoBuster..."
apt install -y gobuster &> /dev/null
if_err "installing GoBuster"
on_succ "GoBuster"

# Evil-winrm
echo_info "Installing Evil-winRM..."
gem install evil-winrm &> /dev/null
if_err "installing Evil-winRM"
on_succ "Evil-winRM"

# Enum4linux
echo_info "Installing enum4linux..."
apt install -y enum4linux &> /dev/null
if_err "installing enum4linux"
on_succ "enum4linux"

# SMBClient
echo_info "Installing smbclient..."
apt install -y smbclient &> /dev/null
if_err "installing smbclient"
on_succ "smbclient"

mkdir ${SCR_PATH} &> /dev/null
cd ${SCR_PATH}

# LinEnum
echo_info "Downloading LinEnum..."
wget -q -O ./LinEnum.sh 'https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh' &> /dev/null
if_err "downloading LinEnum..."
on_succ "LinEnum"

# LinuxSmartEnumeration
echo_info "Downloading LinuxSmartEnumeration..."
wget -q -O ./lse.sh 'https://raw.githubusercontent.com/diego-treitos/linux-smart-enumeration/master/lse.sh' &> /dev/null
if_err "downloading LinuxSmartEnumeration..."
on_succ "LinuxSmartEnumeration"

# UnixPrivescCheck
echo_info "Downloading UnixPrivescCheck..."
wget -q -O ./upc.sh 'https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/master/upc.sh' &> /dev/null
if_err "downloading UnixPrivescCheck..."
on_succ "UnixPrivescCheck"

# JAWS
echo_info "Downloading JAWS..."
wget -q -O ./jaws-enum.ps1 'https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1' &> /dev/null
if_err "downloading JAWS..."
on_succ "JAWS"

