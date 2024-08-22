
# mkcc Tool

## Installation

### Git

Firstly, install git and clone this repo to the local machine
```
$ sudo GET GIT
$ git clone git@github.com:noaburt/makeccproj.git
```

### Install.sh

Then source the install script to finish the setup, you will need to enter root password to install to correct dir
```
$ cd makeccproj
$ source ./install.sh
```

## Usage

This info is detailed by running
```
$ mkcc
```

Run the CLI and answer the questions to create a Coding Challenges project
```
$ mkcc [challenge name]
Create project '[challenge name]'? [y/n]:
...
```

## Updates

When an update is released, clone repo again and re-source the install script
```
$ git clone git@github.com:noaburt/makeccproj.git
$ cd makeccproj
$ source ./install.sh
```