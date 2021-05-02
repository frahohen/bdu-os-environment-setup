# bdu-os-environment-setup

A basic automated VPS environment setup for Debian 10

Currently included:

* Webmin
* Docker

# How to install

## Option 1: Install environment with zipped file of the repository project
```
su root bash -c "apt-get install unzip && wget https://github.com/frahohen/bdu-os-environment-setup/archive/master.zip && unzip master.zip && rm master.zip && cd bdu-os-environment-setup-master && bash setup.sh"
```

## Option 2: Install environment with a clone of the Git repository
```
su root bash -c "apt-get install -y git-all && git clone https://github.com/frahohen/bdu-os-environment-setup.git && cd bdu-os-environment-setup && bash setup.sh"
```

# Requirements

* debian-10.9.0-amd64-netinst.iso with "standard system utilities" installed