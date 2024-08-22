
#!/usr/bin/bash

# A script to set up mkcc, clones repo to dir and creates alias

gitlink="https://github.com/noaburt/makeccproj/mkcc.sh"
scriptpath="/usr/bin"

echo "Setting up mkcc [ version 1.0.1 ]"
chmod +x ./mkcc.sh

echo "Hard linking mkcc script to directory '${scriptpath}'"
ln ./mkcc.sh ${scriptpath}/mkcc.sh


echo "Aliasing '${scriptpath}/mkcc.sh' to mkcc"
alias mkcc="${scriptpath}/mkcc.sh"

echo ""
echo "Setup complete, run mkcc to see more info"
