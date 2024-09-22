
# mkcc Tool

A simple automation tool to create template projects for completting John Crickett's Coding Challenges

## Installation

To install ```mkcc``` run:

    bash <(curl -sS https://raw.githubusercontent.com/noaburt/mkcc/main/install.sh)
    
## Setup

Add `alias mkcc=~/.mkcc/mkcc` to your `.bashrc` file (or .zshrc if you use zshell)

Reload shell with `source ~/.bashrc` (or `.zshrc`)

Run `mkcc -h / --help` for usage

## Making a Project

Note: This info, and more, is detailed by running

    $ mkcc -h / --help

### General Usage

Run the CLI and answer the prompts to create a Coding Challenges project

    $ mkcc [OPTIONS] [PROJECT]
    
    Create project '[PROJECT]'? [y/n]: y
    ...

### Upgrading

To check for updates, run ```mkcc -u / --upgrade```

The version update will display and the tool will update automatically
