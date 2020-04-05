#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GRE='\033[0;32m'
NC='\033[0m'

SRC_PATH='./enum-scripts/'
DOWNLOADS_PATH='/tmp/'
TOOLS_PATH="$HOME/tools/"
PRIVESC_CHECK_PATH=${TOOLS_PATH}'priv-esc-checks/'
CRYPTO_PATH=${TOOLS_PATH}'crypto/'
REV_PATH=${TOOLS_PATH}'reversing/'
STEGO_PATH=${TOOLS_PATH}'stego/'
verb=0

header() {
    echo "    ____           __        __________            __    ";
    echo "   /  _/___  _____/ /_____ _/ / /_  __/___  ____  / /____";
    echo "   / // __ \/ ___/ __/ __ \`/ / / / / / __ \/ __ \/ / ___/";
    echo " _/ // / / (__  ) /_/ /_/ / / / / / / /_/ / /_/ / (__  ) ";
    echo "/___/_/ /_/____/\__/\__,_/_/_/ /_/  \____/\____/_/____/  ";
    echo "                                 by @havocsec & @jorgectf";
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

# ----------------------------------------- MAIN DEPENDENCIES

# PYTHON
echo_info "Downloading python pip..."
apt install -y python-pip python3-pip &> /dev/null
if_err "downloading python pip"
on_succ "python pip"

# GIT
echo_info "Downloading git..."
apt install -y git &> /dev/null
if_err "downloading git"
on_succ "git"

# RUBY
echo_info "Downloading ruby..."
apt install -y ruby &> /dev/null
if_err "downloading ruby"
on_succ "ruby"

# RUBY-DEV
echo_info "Downloading ruby-dev..."
apt install -y ruby-dev &> /dev/null
if_err "downloading ruby-dev"
on_succ "ruby-dev"

# openjdk-8-jre
echo_info "Downloading openjdk-8-jre..."
apt install -y openjdk-8-jre &> /dev/null
if_err "downloading openjdk-8-jre"
on_succ "openjdk-8-jre"

# default-jdk
echo_info "Downloading default-jdk..."
apt install -y default-jdk &> /dev/null
if_err "downloading default-jdk"
on_succ "default-jdk"

# RUBY
echo_info "Downloading gcc-multilib g++-multilib..."
apt install -y gcc-multilib g++-multilib &> /dev/null
if_err "downloading gcc-multilib g++-multilib"
on_succ "gcc-multilib g++-multilib"

dpkg --add-architecture i386 &> /dev/null && apt-get update &> /dev/null
if_err "adding i386 arch"
on_succ "i386 architecture"

# ----------------------------------------- BUG BOUNTY

# Golang
echo_info "Downloading golang..."
apt install -y golang &> /dev/null
if_err "downloading golang"
on_succ "golang"

export PATH=$PATH:/root/go/bin/
echo 'export PATH=$PATH:/root/go/bin/' >> $HOME/.profile

# FFUF
echo_info "Downloading FFUF..."
go get github.com/ffuf/ffuf &> /dev/null
if_err "downloading FFUF"
on_succ "FFUF"

# HAKRAWLER
echo_info "Downloading HAKRAWLER..."
go get github.com/hakluke/hakrawler &> /dev/null
if_err "downloading HAKRAWLER"
on_succ "HAKRAWLER"

# SUBLIST3R
echo_info "Installing SUBLIST3R..."
apt install -y sublist3r &> /dev/null
if_err "installing SUBLIST3R"
on_succ "SUBLIST3R"

# AMASS
echo_info "Installing AMASS..."
apt install -y amass &> /dev/null
if_err "installing AMASS"
on_succ "AMASS"

# GoBuster
echo_info "Installing GoBuster..."
apt install -y gobuster &> /dev/null
if_err "installing GoBuster"
on_succ "GoBuster"

# WFuzz
echo_info "Installing WFuzz..."
apt install -y wfuzz &> /dev/null
if_err "installing WFuzz"
on_succ "WFuzz"

# FINDOMAIN
echo_info "Downloading FINDOMAIN..."
wget -q -O /usr/bin/findomain 'https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux' &> /dev/null
if_err "downloading FINDOMAIN..."
chmod +x /usr/bin/findomain
on_succ "FINDOMAIN"

# KNOCK
echo_info "Downloading KNOCK..."
apt install -y python-dnspython &> /dev/null
if_err "installing KNOCK dependencies"
cd ${DOWNLOADS_PATH}
rm -rf knock
git clone https://github.com/guelfoweb/knock.git &> /dev/null
if_err "cloning KNOCK"
cd knock/
python setup.py install &> /dev/null
if_err "installing KNOCK"
on_succ "KNOCK"

# SubFinder
cd ${DOWNLOADS_PATH}
echo_info "Downloading SubFinder..."
wget -q -O ${DOWNLOADS_PATH}subfinder.tar  'https://github.com/projectdiscovery/subfinder/releases/download/v2.3.2/subfinder-linux-amd64.tar' &> /dev/null
if_err "dwonloading SubFinder"
tar -xzvf ${DOWNLOADS_PATH}subfinder.tar &> /dev/null
mv ${DOWNLOADS_PATH}subfinder-linux-amd64 /usr/bin/subfinder
if_err "installing SubFinder"
on_succ "SubFinder"

# HTTPROBE
echo_info "Downloading HTTPROBE..."
go get github.com/tomnomnom/httprobe &> /dev/null
if_err "installing HTTPROBE"
on_succ "HTTPROBE"


# ----------------------------------------- PENTESTING

# Impacket
echo_info "Downloading impacket..."
apt install -y impacket-scripts &> /dev/null
if_err "downloading impacket"
on_succ "impacket"

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

# SMBMap
echo_info "Installing smbmap..."
apt install -y smbmap &> /dev/null
if_err "installing smbmap"
on_succ "smbmap"

# ----------------------------------------- PRIVILEGE ESCALATION SCRIPTS 

mkdir ${TOOLS_PATH}
mkdir ${PRIVESC_CHECK_PATH} &> /dev/null
cd ${PRIVESC_CHECK_PATH}

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

# LSE
echo_info "Downloading LSE..."
wget -q -O ./lse.sh 'https://github.com/diego-treitos/linux-smart-enumeration/blob/master/lse.sh' &> /dev/null
if_err "downloading LSE..."
on_succ "LSE"

# ----------------------------------------- REVERSING

# CUTTER
echo_info "Downloading CUTTER..."
wget -q -O /usr/bin/cutter 'https://github.com/radareorg/cutter/releases/download/v1.10.1/Cutter-v1.10.1-x64.Linux.AppImage'  &> /dev/null
if_err "downloading CUTTER..."
chmod +x /usr/bin/cutter
on_succ "CUTTER"

# ----------------------------------------- CTF TOOLS

mkdir ${CRYPTO_PATH}
mkdir ${REV_PATH}
mkdir ${STEGO_PATH}

# ------------------------------------- Crypto

cd ${CRYPTO_PATH}

# RsaCtfTool
echo_info "Installing RsaCtfTool..."
git clone https://github.com/Ganapati/RsaCtfTool &> /dev/null
if_err "cloning RsaCtfTool"
cd RsaCtfTool/
apt install -y python3-gmpy2 &> /dev/null
if_err "installing GMPY2"
pip3 install -r requirements.txt &> /dev/null && cd ..
if_err "installing RsaCtfTool requirements"
on_succ "RsaCtfTool"

# xortool
echo_info "Installing xortool..."
git clone https://github.com/hellman/xortool &> /dev/null
if_err "cloning xortool"
cd xortool/
python3 setup.py install &> /dev/null && cd ..
if_err "installing xortool requirements"
on_succ "xortool"


# ------------------------------------- Stego

cd ${STEGO_PATH}

# BPStegano
echo_info "Installing BPStegano..."
git clone https://github.com/TapanSoni/BPStegano &> /dev/null
if_err "cloning BPStegano"
cd BPStegano/
pip3 install -r requirements.txt &> /dev/null && cd ..
if_err "installing BPStegano requirements"
on_succ "BPStegano"

# stegosuite
echo_info "Installing stegosuite..."
apt install -y stegosuite &> /dev/null
if_err "installing stegosuite"
on_succ "stegosuite"

# Stegsolve
echo_info "Downloading Stegsolve..."
wget -q -O /usr/bin/stegsolve 'http://www.caesum.com/handbook/Stegsolve.jar' &> /dev/null
if_err "downloading Stegsolve..."
chmod +x /usr/bin/stegsolve
on_succ "Stegsolve"

# stegpy
echo_info "Installing stegpy..."
pip3 install -U stegpy &> /dev/null
if_err "installing stegpy"
on_succ "stegpy"

# stegano
echo_info "Installing stegano..."
pip3 install -U stegano &> /dev/null
if_err "installing stegano"
on_succ "stegano"

# stegoveritas
echo_info "Installing stegoveritas..."
pip3 install -U stegoveritas &> /dev/null
if_err "installing stegoveritas"
stegoveritas_install_deps &> /dev/null
if_err "installing stegoveritas requirements"
on_succ "stegoveritas"

# sonic-visualiser
echo_info "Installing sonic-visualiser..."
apt install -y sonic-visualiser &> /dev/null
if_err "installing sonic-visualiser"
on_succ "sonic-visualiser"

# outguess
echo_info "Downloading outguess..."
wget -q -O /usr/bin/outguess 'https://github.com/mmayfield1/SSAK/raw/master/programs/64/outguess_0.13' &> /dev/null
if_err "downloading outguess..."
chmod +x /usr/bin/outguess
on_succ "outguess"

# jsteg
echo_info "Downloading jsteg..."
wget -q -O /usr/bin/jsteg 'https://github.com/lukechampine/jsteg/releases/download/v0.1.0/jsteg-linux-amd64' &> /dev/null
if_err "downloading jsteg..."
chmod +x /usr/bin/jsteg
on_succ "jsteg"

# slink
echo_info "Downloading slink..."
wget -q -O /usr/bin/slink 'https://github.com/lukechampine/jsteg/releases/download/v0.2.0/slink-linux-amd64' &> /dev/null
if_err "downloading slink..."
chmod +x /usr/bin/slink
on_succ "slink"

# jphide
echo_info "Downloading jphide..."
wget -q -O /usr/bin/jphide 'https://github.com/mmayfield1/SSAK/raw/master/programs/64/jphide' &> /dev/null
if_err "downloading jphide..."
chmod +x /usr/bin/jphide
on_succ "jphide"

# jpseek
echo_info "Downloading jpseek..."
wget -q -O /usr/bin/jpseek 'https://github.com/mmayfield1/SSAK/raw/master/programs/64/jpseek' &> /dev/null
if_err "downloading jpseek..."
chmod +x /usr/bin/jpseek
on_succ "jpseek"

# python-opencv
echo_info "Installing python3-opencv..."
apt install -y python3-opencv &> /dev/null
if_err "installing python3-opencv"
on_succ "python3-opencv"
