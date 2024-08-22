
#!/usr/bin/bash

# A script to set up mkcc, clones repo to home dir and creates alias

#shopt -s expand_aliases

gitlink="https://github.com/noaburt/makeccproj/mkcc.sh"

echo "Setting up mkcc [ version 0.0.1 ]"
chmod +x ./mkcc.sh

echo "Linking mkcc script to home directory '$HOME'"
ln ./mkcc.sh ${HOME}/.mkcc.sh


echo "Aliasing '${HOME}/.mkcc.sh' to mkcc"
alias mkcc="${HOME}/.mkcc.sh"

echo ""
echo "Setup complete, run mkcc to see more info"
