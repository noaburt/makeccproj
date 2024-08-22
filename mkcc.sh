
#!/usr/bin/bash


# Function for giving user information on the cli

VERSION="1.0"

function info {

    INFO="
Welcome to mkcc [ version ${VERSION} ]

This is a CLI tool created by Noa Burt, used for automating the creation of new projects to attempt and complete Coding Challenges by John Crickett (in c)
Each project is created according to the following structure:

     ChallengeTitle/

	Makefile
	runtests.c
	main.c
	functions.c
	main.h

	ChallengeFiles/ (if required, added using -f flag)


> mkcc [ChallengeTitle]

This begins project creation (use -f flag if extra challenge files are required e.g. as input for testing)
Then input details of the challenge for main.c header comment, such as Name, Date, Challenge Name, and Challenge URL

This results in the main.c file looking like this upon project creation:

/*

Coding Challenges | John Crickett

Name: xxx xxx
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
    echo "Too many parameter error"
    exit
fi

fileflag=0
projectname="NONE"

if [ -z $2 ]; then

    # There is one parameter

    if [[ $1 == -* ]]; then

	# Only a flag has been passed
	echo "Flag only error"
	exit
	
    fi

    # Project name is only parameter
    projectname=$1

else

    # There are two parameters

    if [[ $1 == -* ]]; then

	# First parameter is flag

	if [[ $2 == -* ]]; then
	    echo "Flag only error"
	    exit
	fi
	
	if [[ $1 != '-f' ]]; then
	    echo "Flag $1 not recognised"
	    exit
	fi

	filesflag=1
	projectname=$2
	

    elif [[ $2 == -* ]]; then

	# Second parameter is flag

	if [[ $2 != '-f' ]]; then
	    echo "Flag $2 not recognised"
	    exit
	fi

	fileflag=1
	projectname=$1

    else

	echo "No flag error"
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
read -p "Create project '$projectname'$withorwithout in current directory '$(pwd)'? [y/n]: " confirm

if [[ $confirm == "n" ]] || [[ $confirm != "y" ]]; then
    echo "Cancelling project creation..."
    exit
fi


echo ""
read -p "Please enter your name: " devname
read -p "Please enter the date of project creation (this can be changed later): " projdate
read -p "Please enter the full name of this coding challenge (e.g. Build Your Own CLI): " challenge
read -p "Please enter the full URL of the coding challenge (or leave blank to include later): " pageurl


echo ""
read -p "Create project by '${devname}' on '${projdate}'? [y/n]: " confirm

if [[ $confirm == "n" ]] || [[ $confirm != "y" ]]; then
    echo "Cancelling project creation..."
    exit
fi


# Create all files

#exit # Remove when testing

mkdir $projectname
cd $projectname

if [[ $fileflag == 1 ]]; then
    mkdir ChallengeFiles
fi


# Write to files

defaultmake="
# This is the default makefile for coding challenges as set by mkcc ${VERSION}

all: main test

main: main.c functions.c
      gcc -o main functions.c main.c -I. -Wall -pedantic

test: test.c
      gcc -o test test.c -Wall -pedantic
"

maincomment="
/*

Coding Challenges | John Crickett

Name: $devname
Date: $projdate

This is my solution for the $challenge coding challenge
found at - $pageurl

Development Notes:

*/

#include <main.h>

"

headercomment="
/*

Coding Challenges | John Crickett

Name: $devname
Date: $projdate

This is the header file for this coding challenge

*/"

functionscomment="
/*

Coding Challenges | John Crickett

Name: $devname
Date: $projdate

This is the functions file for this coding challenge

*/

#include <main.h>

"

testcomment="
/*

Coding Challenges | John Crickett

Name: $devname
Date: $projdate

This is the file to run all tests required of this coding challenge

*/

int main() {
    return 0;
}"


# THERE MUST BE A BETTER WAY

# Makefile echos

echo "# This is the default makefile for coding challenges as set by mkcc ${VERSION}" >> Makefile
echo "" >> Makefile
echo "all: main test" >> Makefile
echo "" >> Makefile
echo "main: main.c functions.c" >> Makefile
echo $'\tgcc -o main functions.c main.c -I. -Wall -pedantic' >> Makefile
echo "" >> Makefile
echo "test: test.c" >> Makefile
echo $'\tgcc -o test test.c -Wall -pedantic' >> Makefile

# main.c echos

echo "/*" >> main.c
echo "" >> main.c
echo "Coding Challenges | John Crickett" >> main.c
echo "" >> main.c
echo "Name: $devname" >> main.c
echo "Date: $projdate" >> main.c
echo "" >> main.c
echo "This is my solution for the $challenge coding challenge" >> main.c
echo "found at - $pageurl" >> main.c
echo "" >> main.c
echo "Development Notes:" >> main.c
echo "" >> main.c
echo "*/" >> main.c
echo "" >> main.c
echo "#include <main.h>" >> main.c

# main.h echos

echo "/*" >> main.h
echo "" >> main.h
echo "Coding Challenges | John Crickett" >> main.h
echo "" >> main.h
echo "Name: $devname" >> main.h
echo "Date: $projdate" >> main.h
echo "" >> main.h
echo "This is the header file for this coding challenge" >> main.h
echo "" >> main.h
echo "*/" >> main.h

# functions.c echos

echo "/*" >> functions.c
echo "" >> functions.c
echo "Coding Challenges | John Crickett" >> functions.c
echo "" >> functions.c
echo "Name: $devname" >> functions.c
echo "Date: $projdate" >> functions.c
echo "" >> functions.c
echo "This is the functions file coding challenge" >> functions.c
echo "" >> functions.c
echo "*/" >> functions.c
echo "" >> functions.c
echo "#include <main.h>" >> functions.c

# test.c echos

echo "/*" >> test.c
echo "" >> test.c
echo "Coding Challenges | John Crickett" >> test.c
echo "" >> test.c
echo "Name: $devname" >> test.c
echo "Date: $projdate" >> test.c
echo "" >> test.c
echo "This is the file to run all tests required of this coding challenge" >> test.c
echo "" >> test.c
echo "*/" >> test.c
echo "" >> test.c
echo "int main() {" >> test.c
echo $'\treturn 0;' >> test.c
echo "}" >> test.c

# SADLY DOESN'T WORK, NO NEW LINES WHEN ECHOED TO FILE
#echo $defaultmake > Makefile
#echo $maincomment > main.c
#echo $headercomment > main.h
#echo $functioncomment > functions.c
#echo $testcomment > test.c


echo ""
echo "Project created successfully! Don't forget to add and commit to your git repo."
