
# mkcc Tool

## Installation

### Git

Firstly install git, then clone this repo to the local machine
```
$ sudo [ apt install / apt-get / pacman -S / dnf install / ... ] git
$ git clone git@github.com:noaburt/makeccproj.git
```

### Install script

Then source the install script to finish the setup
```
$ cd makeccproj
$ source ./install.sh
```

The cloned repo can then be deleted

## Usage

This info is detailed by running:
```
$ mkcc
```

Run the CLI and answer the questions to create a Coding Challenges project
```
$ mkcc [challenge name]

Create project '[challenge name]'? [y/n]: y
...
```

## Updates

When an update is released, clone repo again and re-source the install script
```
$ git clone git@github.com:noaburt/makeccproj.git
$ cd makeccproj
$ source ./install.sh
```
