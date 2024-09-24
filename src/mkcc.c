
#include <mkcc.h>


int main(int argc, char** argv) {

  /* main body of program to carry out logic */

  /* deal with base case errors */
  if ( argc <= 1 ) { issue(1, "Missing operand"); }

  /* get version and flags */
  flagstruct* flags = parseflags(argc, argv);

  /* deal with help / version flags */
  if ( flags->help ) {
    printf("%s\n", gethelp());
    return 0;
  }

  if ( flags->version ) {
    printf("%s\n", getversion());
    return 0;
  }

  if ( flags->upgrade ) {
    /* execute install program from git */
    return system("bash <(curl -sS https://raw.githubusercontent.com/noaburt/mkcc/main/install.sh)");
  }

  /* get user info for creating project and create */
  projectstruct* newproject = getprojectdata(flags->projectname);
  makenewproject(newproject, flags);

  /* show user project was created successfully */
  printf("%s\n", getsuccess());

  /* garbage collection */
  freeproject(newproject);
  freeflags(flags);

  return 0;
}
