
#!/usr/bin/bash

# A script to set up mkcc; copy script to local and create alias

scriptpath="/usr/bin"

echo "Setting up mkcc [ version 1.1.0 ]"

# Make script executable
chmod +x ./mkcc.sh

if [[ $? -ne 0 ]]; then
    echo "Setup failed, exiting..." >&2
    return
fi

echo "Installing mkcc script to directory '${scriptpath}'"
sudo cp mkcc.sh ${scriptpath}/mkcc.sh

if [[ $? -ne 0 ]]; then
    echo "Setup failed, exiting..." >&2
    return
fi

echo "Aliasing '${scriptpath}/mkcc.sh' to mkcc"
alias mkcc="${scriptpath}/mkcc.sh"

if [[ $? -ne 0 ]]; then
    echo "Setup failed, exiting..." >&2
    return
fi

echo ""
echo "Setup complete, run 'mkcc -h / --help' to see usage and more"
