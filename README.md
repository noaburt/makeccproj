
# mkcc Tool

## Installation

### Git

Firstly install git, then clone this repo to the local machine
```
$ sudo [ apt install / apt-get / pacman -S / dnf install / ... ] git
$ git clone git@github.com:noaburt/makeccproj.git
```

### Install script

Then make the script executable, and source the install script to finish the setup
(you will need to enter root password to install to correct path)
```
$ cd makeccproj
$ chmod +x ./install.sh
$ source ./install.sh
```
The cloned repo can then be removed from machine

The cloned repo can then be deleted

## Usage

This info is detailed by running:
```
$ mkcc -h / --help
```

Run the CLI and answer the prompts to create a Coding Challenges project
```
$ mkcc [OPTIONS] [PROJECT]

Create project '[PROJECT]'? [y/n]: y
...
```

## Updates

When an update is released, clone repo again and re-source the install script
```
$ git clone git@github.com:noaburt/makeccproj.git
$ cd makeccproj
$ source ./install.sh
```
The cloned repo can then be removed from machine
