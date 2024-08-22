
#!/usr/bin/bash

# A script to set up mkcc, clones repo to home dir and creates alias

# curl -s GITHUBLINK/install.sh
# chmod +x mkcc.sh (?)

shopt -s expand_aliases

gitlink="https://github.com/LINK/mkcc.sh"

echo "Setting up mkcc [ version 0.0.1 ]"

echo "Cloning mkcc files to home directory '$HOME'"
curl -s $gitlink > ~/.mkcc.sh

echo "Aliasing '${HOME}/.mkcc.sh' to mkcc"
alias mkcc="${HOME}/.mkcc.sh"
