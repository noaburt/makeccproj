
# mkcc Tool

A simple automation tool to create template projects for completting John Crickett's Coding Challenges

## Installation

To install ```mkcc``` run:

```bash <(curl -sS https://raw.githubusercontent.com/noaburt/mkcc/main/install.sh)```

Follow the instructions displayed after installation is complete:

```add 'alias mkcc=~/.mkcc/mkcc' to your .bashrc file (or .zshrc if you use zshell)```

```reload shell with 'source ~/.bashrc' (or .zshrc)```

```run 'mkcc -h / --help' for usage```

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

To check for updates, run ```mkcc -u / --upgrade```

The version update will display and the tool will update automatically