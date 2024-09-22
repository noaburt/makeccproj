
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

typedef struct PROJECTSTRUCT {

  /* structure to store project data from user */

  char* devname;
  char* devdate;
  
  char* challengename;
  char* shortname;
  char* challengeurl;
  
} projectstruct;


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
 * Free space allocated by flag struct
 * @param flag struct to deallocate (free)
 */
void freeflags(flagstruct* flags);


/*
 * Recieve user input for project creation
 * @return full project structure
 */
projectstruct* getprojectdata();

/*
 * Allocate space for project info struct and initialise data
 * @return empty project structure
 */
projectstruct* getemptyproject();

/*
 * Free space allocated by project struct
 * @param project structure to deallocate (free)
 */
void freeproject(projectstruct* projectdata);
  

/*
 * @return formatted usage message to display when -h / --help flag present
 */
char* gethelp();

/*
 * @return formatted version message to display when -v / --version flag present
 */
char* getversion();

