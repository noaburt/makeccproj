
#include <mkcc.h>


void issue(char* msg) {

  errx(1, "%s", msg);
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
	errx(1, "unknown argument %s", *(argv+currentindex));
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

  emptyflags->projectname = (char*) '\0';

  return emptyflags;
}

void freeflags(flagstruct* flags) {

  if ( !flags ) { errx(1, "Flag structure null before intended"); }

  free(flags->projectname);
  free(flags);  
}


projectstruct* getprojectdata() {

  projectstruct* fullprojectdata = getemptyproject();

  return fullprojectdata;
}

projectstruct* getemptyproject() {

  projectstruct* emptyproject = malloc( sizeof( projectstruct* ) );

  emptyproject->devname = (char*) '\0';
  emptyproject->devdate = (char*) '\0';
  emptyproject->challengename = (char*) '\0';
  emptyproject->shortname = (char*) '\0';
  emptyproject->challengeurl = (char*) '\0';

  return emptyproject;
}

void freeproject(projectstruct* projectdata) {

  if ( !projectdata ) { errx(1, "Project structure null before intended"); }

  free(projectdata->devname);
  free(projectdata->devdate);
  free(projectdata->challengename);
  free(projectdata->shortname);
  free(projectdata->challengeurl);

  free(projectdata);
}


void makenewproject(projectstruct* projectdata, flagstruct* flags) {

  errx(1, "Not implemented yet");
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

  if ( !versionfile ) { errx(1, "Cannot read '~/.mkcc/VERSION': Try reinstalling the mkcc tool"); }

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
