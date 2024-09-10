
#!/usr/bin/bash


# Function for giving user information on the cli

VERSION="1.0.5"

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


# If no parameter passed, show info

if [ -z $1 ]; then
    info
    exit
fi


# Deal with too many / incorrect parameters

if [ ! -z $3 ]; then

    # There are three parameters
    echo "mkcc: Too many operand" >&2
    echo "Try 'mkcc' for more information" >&2
    exit
fi

fileflag=0
projectname="NONE"

if [ -z $2 ]; then

    # There is one parameter

    if [[ $1 == -* ]]; then

	# Only a flag has been passed
	echo "mkcc: Missing operand" >&2
	echo "Try 'mkcc' for more information" >&2
	exit
	
    fi

    # Project name is only parameter
    projectname=$1

else

    # There are two parameters

    if [[ $1 == -* ]]; then

	# First parameter is flag

	if [[ $2 == -* ]]; then
	    echo "mkcc: Missing operand" >&2
	    echo "Try 'mkcc' for more information" >&2
	    exit
	fi
	
	if [[ $1 != '-f' ]]; then
	    echo "mkcc: Unknown argument $1" >&2
	    exit
	fi

	filesflag=1
	projectname=$2
	

    elif [[ $2 == -* ]]; then

	# Second parameter is flag

	if [[ $2 != '-f' ]]; then
	    echo "mkcc: Unknown argument $2" >&2
	    exit
	fi

	fileflag=1
	projectname=$1

    else

	# Neither parameter is a flag
	
	echo "mkcc: Too many operand" >&2
	echo "Try 'mkcc' for more information" >&2
	exit

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

all: $shortname

${shortname}: main.c functions.c
	gcc -o $shortname functions.c main.c -I. -Wall -pedantic
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

    # Simple function to format tests; arg 1 is test arguments, arg 2 is expected result, arg 3 is show tests [0 - no, 1 - yes]

    printf \"\n> ./${shortname} %-50s | expecting: %40s\" \"\$1\" \"\$2\"
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

