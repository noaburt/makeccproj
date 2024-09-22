
#!/usr/bin/bash

# A script to set up mkcc; 

scriptpath="$($HOME)/.mkcc/"
gitversion="$(curl https://raw.githubusercontent.com/noaburt/mkcc/refactor/VERSION)"


if [[ $? -ne 0 ]]; then
    echo "Failed to fetch from git, exiting..." >&2
    exit
fi

# Check if mkcc is already installed

if [ -d "$scriptpath" ]; then
    echo "Checking for updates for: mkcc version $version"

    # Check for updated version
    
    currentv="$(cat ${scriptpath}/VERSION)"
    if [ currentv == gitversion ]; then
	echo "No new versions avaliable, exiting..." >&2
	exit
    fi

    # Confirm update
    
    echo "Version $gitversion avaliable"
    read -p "Install mkcc version ${gitversion}? [y/n]: " confirm

    if [[ $confirm == "n" ]] || [[ $confirm != "y" ]]; then
	echo "Cancelling installation..."
	exit
    fi
    
fi

echo "Installing mkcc version $gitversion"


# Install mkcc

git clone https://github.com/noaburt/mkcc.git $scriptpath

if [[ $? -ne 0 ]]; then
    echo "Git cloning failed, exiting..." >&2
    exit
fi

make -C $scriptpath

if [[ $? -ne 0 ]]; then
    echo "Make failed, exiting..." >&2
    exit
fi


echo ""
echo "mkcc version $gitversion installed successfully"
echo "add 'alias mkcc=${scriptpath}' to your .bashrc (or .zshrc if you use zshell)"
echo "then run 'source .bashrc (or .zshrc)' to reload shell"
echo "run 'mkcc -h / --help' for usage"
