
#include <mkcc.h>


int main(int argc, char** argv) {

  /* main body of program to carry out logic */

  /* deal with base case errors */
  if ( argc < 1 ) { issue("Missing operand"); }

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
    // RUN INSTALL SCRIPT
    // bash <(curl -sS https://raw.githubusercontent.com/noaburt/mkcc/main/install.sh)
  }

  /* get user info for creating project */

  /* garbage collection */
  freeflags(flags);

  return 0;
}
