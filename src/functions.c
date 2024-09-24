
#include <mkcc.h>


void issue(short int toexit, char* msg) {

  if (toexit) { errx(1, "%s", msg); }

  warnx("%s\n", msg);
}

flagstruct* parseflags(int argc, char** argv) {

  flagstruct* getflags = getemptyflags();

  /* start index at 1 as argv[0] is always source (i.e. command called) */
  for( int currentindex = 1; currentindex < argc; currentindex++ ) {

    if ( **(argv+currentindex) == '-' ) {

      /* parse options */
      if ( strcmp( *(argv+currentindex), "-h" ) == 0 || strcmp( *(argv+currentindex), "--help" ) == 0 ) {
	getflags->help = 1;
      }else if ( strcmp( *(argv+currentindex), "-v" ) == 0 || strcmp( *(argv+currentindex), "--version" ) == 0 ) {
	getflags->version = 1;
      } else if ( strcmp( *(argv+currentindex), "-u" ) == 0 || strcmp( *(argv+currentindex), "--upgrade" ) == 0 ) {
	getflags->upgrade = 1;
      } else if ( strcmp( *(argv+currentindex), "-t" ) == 0 || strcmp( *(argv+currentindex), "--test" ) == 0 ) {
	getflags->test = 1;
      } else if ( strcmp( *(argv+currentindex), "-f" ) == 0 || strcmp( *(argv+currentindex), "--files" ) == 0 ) {
	getflags->files = 1;
      } else {
	errx(1, "unknown argument %s", *(argv+currentindex) );
      }
      
    } else {
      getflags->projectname = *(argv+currentindex);
    }
    
  }

  return getflags;
}

flagstruct* getemptyflags() {

  flagstruct* emptyflags = malloc( sizeof( flagstruct* ) );

  emptyflags->help = 0;
  emptyflags->version = 0;
  emptyflags->upgrade = 0;
  emptyflags->test = 0;
  emptyflags->files = 0;

  emptyflags->projectname = malloc( sizeof( char* ) );

  return emptyflags;
}

void freeflags(flagstruct* flags) {

  if ( !flags ) { issue(1, "Flag structure null before intended"); }

  free(flags->projectname);
  free(flags);  
}


projectstruct* getprojectdata(char* projectname) {

  projectstruct* fullprojectdata = getemptyproject();

  /* ask user questions and fill out project data */

  printf("Preparing to create %s in current directory...\n", projectname);
  printf("(type 'q' at any time to exit project creation)\n\n");
  size_t maxbuffersize = 50; /* set buffer size required for fgets */

  /* get name, date, challenge name, short name, and challenge url from user */
  fullprojectdata->devname = readto("your name ", maxbuffersize, 1);
  fullprojectdata->devdate = readto("the date of project creation", maxbuffersize, 1);
  fullprojectdata->challengename = readto("the full name of the challenge (e.g. Build Your Own CLI)", maxbuffersize, 1);
  fullprojectdata->shortname = readto("the shortened name of the challenge (used for calling from command line)", maxbuffersize, 1);

  /* larger max read size for url as always longer than other fields */
  fullprojectdata->challengeurl = readto("the full url of the challenge (or leave blank to include later)", 200, 0);

  return fullprojectdata;
}

char* readto(char* prompt, size_t maxbuffersize, short int required) {

  if ( maxbuffersize < 8 ) { issue(1, "Maximum buffer to read is less than one character"); }

  char* userinput = malloc( sizeof( char* ) );
  
  while (1) {
    printf("Please enter %s: ", prompt);
    fgets(userinput, maxbuffersize, stdin);

    if ( strlen(userinput) == 1 && required ) {
      issue(0, "This field is required, please enter a valid input");
    } else {
      if ( *userinput == 'q' ) { printf("Exiting project creation...\n"); exit(0); }
      
      break;
    }
  }

  if ( !userinput ) { issue(1, "User input is null after validation"); }

  return userinput;
}

projectstruct* getemptyproject() {

  projectstruct* emptyproject = malloc( sizeof( projectstruct* ) );

  emptyproject->devname = malloc( sizeof( char* ) );
  emptyproject->devdate = malloc( sizeof( char* ) );
  emptyproject->challengename = malloc( sizeof( char* ) );
  emptyproject->shortname = malloc( sizeof( char* ) );
  emptyproject->challengeurl = malloc( sizeof( char* ) );

  return emptyproject;
}

void freeproject(projectstruct* projectdata) {

  if ( !projectdata ) { issue(1, "Project structure null before intended"); }

  free(projectdata->devname);
  free(projectdata->devdate);
  free(projectdata->challengename);
  free(projectdata->shortname);
  free(projectdata->challengeurl);

  free(projectdata);
}


void makenewproject(projectstruct* projectdata, flagstruct* flags) {

  issue(1, "Not implemented yet");
}


char* gethelp() {

  char* help =
    "Usage: mkcc [OPTION] [PROJECT]\n"
    "Begin process of creating the template project PROJECT\n\n"
    "-t, --test\tinclude the default test.sh script to run automated testing\n"
    "-f, --files\tcreate challenge files directory to store additional files (e.g. for testing input)\n"
    "-u, --upgrade\tcheck for updates to mkcc and install\n"
    "-v, --version\toutput version information and exit\n\n"
    "Full documentation <https://www.github.com/noaburt/mkcc>";

  return help;
}

char* getversion() {

  FILE* versionfile = fopen("~/.mkcc/VERSION", "r");

  if ( !versionfile ) { issue(1, "Cannot read '~/.mkcc/VERSION': Try reinstalling the mkcc tool"); }

  char* versionnum = malloc( sizeof (char*) );
  char* vptr;
  char currentc;

  while ( 1 ) {
    currentc = fgetc(versionfile);
    if ( currentc == EOF ) { break; }

    *vptr = currentc;
    vptr++;
  }
  *vptr = '\0';

  fclose(versionfile);

  char* version =
    "mkcc v%s\n"
    "Copyright (C) 2024 Noa Burt\n"
    "This is a free software: you are free to change and redistribute it.\n"
    "There is NO WARRANTY, to the extent permitted by law\n\n"
    "Written by Noa Burt";

  sprintf(version, versionnum);

  return version;
}

char* getsuccess() {

  char* succmsg = "Project created successfully! Don't forget to add and commit to your git repo.\n";

  return succmsg;
}


