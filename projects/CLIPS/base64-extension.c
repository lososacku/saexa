#include <stdlib.h>
#include "clips.h"
#include "base64.h"


char * base64_encode () {

  char *       tempUnencodedData   = NULL;
  unsigned int unencodedDataLength = 0;
  char *       unencodedData       = NULL;

  unsigned int base64Length = 0;
  char *       base64       = NULL;

  void * retVal = NULL;

  
  tempUnencodedData   = RtnLexeme (1);
  unencodedDataLength = strlen    (tempUnencodedData) + 1;
  unencodedData       = calloc    (unencodedDataLength, sizeof(char));

  strncpy (unencodedData, tempUnencodedData, unencodedDataLength);

  // subtract the trailing zero to give the actual data length to Base64encode_len and add it
  // back for the buffer allocation

  base64Length = Base64encode_len (unencodedDataLength - 1) + 1;
  base64       = calloc (base64Length, sizeof (char));

  Base64encode(base64, unencodedData, unencodedDataLength - 1);

  retVal = AddSymbol (base64);

  free (base64);
  free (unencodedData);

  return retVal;
}


char * base64_decode () {

  char * tempEncodedData   = NULL;
  int    encodedDataLength = 0;
  char * encodedData       = NULL;

  int    unencodedLength = 0;
  char * unencoded       = NULL;

  void * retVal = NULL;

  
  tempEncodedData   = RtnLexeme (1);
  encodedDataLength = strlen    (tempEncodedData) + 1;
  encodedData       = calloc    (encodedDataLength, sizeof(char));

  strncpy (encodedData, tempEncodedData, encodedDataLength);

  unencodedLength = Base64decode_len (encodedData) + 1;
  unencoded       = calloc (unencodedLength, sizeof (char));

  Base64decode(unencoded, encodedData);

  retVal = AddSymbol (unencoded);

  free (unencoded);
  free (encodedData);

  return retVal;
}
