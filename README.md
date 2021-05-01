# bdu-os-environment-setup

A basic automated VPS environment setup for Debian 10.9.0 (amd64) - netinst

Currently included:

	* Webmin

# How to install

## Install environment with zipped file of the repository project
```
su root bash -c "apt-get install unzip && wget https://github.com/frahohen/bdu-os-environment-setup/archive/master.zip && unzip master.zip && rm master.zip && cd bdu-os-environment-setup-master && bash setup.sh"
```

## Install environment with a clone of the Git repository
```
su root bash -c "apt-get install -y git-all && git clone https://github.com/frahohen/bdu-os-environment-setup.git && cd bdu-os-environment-setup && bash setup.sh"
```