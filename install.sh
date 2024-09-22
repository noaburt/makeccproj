
#!/usr/bin/bash

# A script to set up mkcc; 

scriptpath="${HOME}/.mkcc"
gitversion="$(curl -s https://raw.githubusercontent.com/noaburt/mkcc/refactor/VERSION)"

echo ""

if [[ $? -ne 0 ]]; then
    echo "Failed to fetch from git, exiting..." >&2
    return
fi

# Check if mkcc is already installed

if [ -d "$scriptpath" ]; then

    # Check for updated version
    
    read -r currentv < $scriptpath/VERSION
    echo "Checking for updates for: mkcc version $currentv"
    
    if [ currentv = gitversion ]; then
	echo "No new versions avaliable, exiting..." >&2
	return
    fi
    
    echo "Version $gitversion avaliable"
    echo ""
    rm -rf $scriptpath
fi

echo "Installing mkcc version $gitversion"


# Install mkcc

mkdir $scriptpath
git clone -q https://github.com/noaburt/mkcc.git $scriptpath

if [[ $? -ne 0 ]]; then
    rm -rf $scriptpath
    echo "Git cloning failed, exiting..." >&2
    return
fi

make -q -C $scriptpath

if [[ $? -ne 0 ]]; then
    rm -rf $scriptpath
    echo "Make failed, exiting..." >&2
    return
fi


echo ""
echo "mkcc version $gitversion installed successfully"
echo "add 'alias mkcc=${scriptpath}/mkcc' to your .bashrc (or .zshrc if you use zshell)"
echo "then run 'source .bashrc (or .zshrc)' to reload shell"
echo "run 'mkcc -h / --help' for usage"
