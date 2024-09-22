
/* includes */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>


/* structures */

typedef struct FLAGSTRUCT {

  /* structure to store flags selected by user */

  short int help;
  short int version;
  short int files;

  char* projectname;
  
} flagstruct;


/* functions */

/*
 * Produces errx message and suggests --help flag
 * @param error message to display
 */
void issue(char* msg);

/*
 * Parse arguments into flag structure
 * @param amount of arguments
 * @param array of arguments
 * @return parsed flag structure
 */
flagstruct* parseflags(int argc, char** argv);

/*
 * Allocate space for flag struct and initialise data
 * @return empty flag structure
 */
flagstruct* getemptyflags();

/*
 * @return formatted usage message to display when -h / --help flag present
 */
char* gethelp();

/*
 * @return formatted version message to display when -v / --version flag present
 */
char* getversion();

