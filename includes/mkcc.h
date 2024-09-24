
/* includes */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>


/* structures */

/*
 * Structure to store flags selected by user
 */
typedef struct {

  short int help;
  short int version;
  short int upgrade;
  short int test;
  short int files;

  char* projectname;
  
} flagstruct;

/*
 * Stucture to store project data from user
 */
typedef struct {

  char* devname;
  char* devdate;
  
  char* challengename;
  char* shortname;
  char* challengeurl;
  
} projectstruct;


/* functions */

/*
 * Produces error or warning message and suggests --help flag
 * @param exit on message display or not
 * @param message to display
 */
void issue(short int toexit, char* msg);


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
 * @param project name selected by user
 * @return full project structure
 */
projectstruct* getprojectdata(char* projectname);

/*
 * Helper function to read user input and validate
 * @param prompt shown to user to get input
 * @param maximum size of buffer to read (used by fgets)
 * @param if validation is required or not
 * @return validated input
 */
char* readto(char* prompt, size_t maxbuffersize, short int required);

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
 * Run functions to create project
 * @param project data used to create project
 * @param flags to decide to include files, test.sh, etc
 */
void makenewproject(projectstruct* projectdata, flagstruct* flags);

/*
 * @return formatted usage message to display when -h / --help flag present
 */
char* gethelp();

/*
 * @return formatted version message to display when -v / --version flag present
 */
char* getversion();

/*
 * @return formatted success message to display when project has been completed
 */
char* getsuccess();
