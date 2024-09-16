
#!/usr/bin/bash

: '

MIT License

Copyright (C) 2024 Noa Burt
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

'


VERSION="1.1.1"

# function for giving user information on the cli

function info {

    INFO="
Welcome to mkcc [ version ${VERSION} ]

This is a CLI tool created by Noa Burt, used for automating the creation of new projects to attempt and complete Coding Challenges by John Crickett (in c)
Each project is created according to the following structure:

     ChallengeTitle/

	Makefile
	main.c
	functions.c
	main.h
	test.sh

	ChallengeFiles/ (if required, added using -f flag)


> mkcc [ChallengeTitle]

This begins project creation (use -f flag if extra challenge files are required e.g. as input for testing)
Then input details of the challenge for main.c header comment, such as Name, Date, Challenge Name, and Challenge URL

This results in the main.c file looking like this upon project creation:

/*

Coding Challenges | John Crickett

Author: xxx xxx
Date: xx/xx/xxx

This is my solution for the xxx coding challenge
found at - codingchallenges.fyi/challenges/xxx

Development Notes:
x
x
x

*/"
    
    echo "$INFO"

}


# printing usage info from -h / --help flag

function help {
    HELP="Usage: mkcc [OPTION] [PROJECT]
Begin process of creating the project PROJECT.

  -f               create challenge files directory to store additional files (e.g. for testing input)
  -h, --help       display this help and exit
  -v, --version    output version information and exit

Full documentation <https://www.github.com/noaburt/makeccproj>"

    echo "$HELP"
    exit
}


# printing version info from -v, --version flag

function version {
    VINFO="mkcc $VERSION
Copyright (C) 2024 Noa Burt
This is a free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Noa Burt"

    echo "$VINFO"
    exit
}


# function for showing an error message, followed by -h / --help prompt

function issue {
    echo "mkcc: $1" >&2
    echo "Try 'mkcc -h / --help' for more information" >&2
    exit
}



# Deal with too many / incorrect parameters

if [ -z $1 ]; then
    # There are no parameters
    issue "Missing operand"
fi

if [ ! -z $3 ]; then

    # There are three parameters
    issue "Too many operand"
fi

fileflag=0
projectname="NONE"


if [ -z $2 ]; then

    # There is one parameter

    if [[ $1 == "-h" || $1 == "--help" ]]; then
	help
    fi

    if [[ $1 == "-v" || $1 == "--version" ]]; then
	version
    fi

    if [[ $1 == -* ]]; then

	# Only a flag has been passed
	issue "Missing operand"
	
    fi

    # Project name is only parameter
    projectname=$1

else

    # There are two parameters

    projectset=0
    
    # fileflag       0 == no files, 1 == yes files, 2 == too many flags

    for arg in "$@"
    do

	if [[ $arg == -* ]]; then
	    if [[ $arg == "-h" || $arg == "--help" ]]; then
		help
	    fi

	    if [[ $arg == "-v" || $arg == "--version" ]]; then
		version
	    fi

	    if [[ $arg != "-f" ]]; then
		issue "Invalid option -- '${arg}'"
	    fi
	    
	    fileflag=fileflag+1
	else
	    projectname=$arg
	    projectset=projectset+1
	fi
	
    done


    # no flags or no project name
    
    if [[ $projectset == 2 ]]; then
	issue "Too many operand (multiple project creation not supported yet)"
    fi

    if [[ $fileflag == 2 ]]; then
	issue "Missing operand"
    fi
           
fi


# Prepare to create project

if [[ $fileflag == 1 ]]; then
    withorwithout=" (with ChallengeFiles directory)"
else
    withorwithout=""
fi

echo ""

# If project name already exists, ask to overwrite

if [ -d "$(pwd)/$projectname" ]; then
    read -p "Project '$projectname' already exists in current directory, overwrite project? [y/n]: " confirm
else  
    read -p "Create project '$projectname'$withorwithout in current directory '$(pwd)'? [y/n]: " confirm
fi

if [[ $confirm == "n" ]] || [[ $confirm != "y" ]]; then
    echo "Cancelling project creation..."
    exit
fi

# Remove existing project of same name

if [ -d "$(pwd)/$projectname" ]; then
    echo "Deleting project '$projectname'"
    rm -r $projectname
fi


echo ""
read -p "Please enter your name: " devname
read -p "Please enter the date of project creation (this can be changed later): " projdate
read -p "Please enter the full name of this coding challenge (e.g. Build Your Own CLI): " challenge

read -p "Please enter the shortened name of the challenge (used when calling from command line): " shortname

if [ -z $shortname ]; then
    echo "Shortened name cannot be blank, cancelling project creation..."
    exit
fi

read -p "Please enter the full URL of the coding challenge (or leave blank to include later): " pageurl

echo ""
read -p "Create project '${challenge}' (${shortname}) by '${devname}' on '${projdate}'? [y/n]: " confirm

if [[ $confirm == "n" ]] || [[ $confirm != "y" ]]; then
    echo "Cancelling project creation..."
    exit
fi


# Create all files

mkdir $projectname

if [[ $fileflag == 1 ]]; then
    mkdir ${projectname}/ChallengeFiles
fi


# Write to files

defaultmake="
# This is the default makefile for coding challenges as set by mkcc ${VERSION}

all: ${shortname}

${shortname}: main.c functions.c
	      gcc -o ${shortname} functions.c main.c -I. -Wall -pedantic
"


maincomment="
/*

Coding Challenges | John Crickett

Author: $devname
Date: $projdate

This is my solution for the $challenge coding challenge
found at - $pageurl

Development Notes:

*/

#include <main.h>

int main(int argc, char** argv) {

    /* good luck */

    return 0;
}
"

headercomment="
/*

Coding Challenges | John Crickett

Author: $devname
Date: $projdate

This is the header file for this coding challenge

*/

/* includes */



/* functions */


"


functioncomment="
/*

Coding Challenges | John Crickett

Author: $devname
Date: $projdate

This is the functions file for this coding challenge

*/

#include <main.h>

"


testcomment="
#!/usr/bin/bash

: '

Coding Challenges | John Crickett

Author: $devname
Date: $projdate

This is the file to run all tests required of this coding challenge

 '

function runtest {

    # Simple function to format tests; arg 1 is test arguments, arg 2 is expected result

    printf \"\n ./${shortname} %-70s | expecting: %40s\n\" \"\$1\" \"\$2\"
    printf \"I==================================================================\"
    printf \"===================================================================I\n\"
    printf \"\$(./${shortname} \$1)\n\"
}

make

if [ \$? -ne 0 ]; then
    exit 1
fi

echo \"Beginning testing...\"

"


echo "$defaultmake" > ${projectname}/Makefile
echo "$maincomment" > ${projectname}/main.c
echo "$headercomment" > ${projectname}/main.h
echo "$functioncomment" > ${projectname}/functions.c
echo "$testcomment" > ${projectname}/test.sh

# make test script executable for non-bash shells
chmod +x ${projectname}/test.sh

echo ""
echo "Project created successfully! Don't forget to add and commit to your git repo."

