//consult(pcurl, [cc_opts('-O2 -I/Users//XSB/emu -I/home/ec2-user/interzone/XSB/config/i386-apple-darwin13.3.0')]).
//consult(pcurl, [cc_opts('-O2 -I/home/ec2-user/interzone/XSB/emu -I/Users/sparrow/XSB/config/x86_64-unknown-linux-gnu')]).




/*

  debug time!@!@!@!@!@!@

 */


#include "xsb_config.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>


//#include "/Users/sparrow/src/curl-7.37.0/include/curl/curl.h"
#include "/usr/include/curl/curl.h"


#ifdef WIN_NT
#define XSB_DLL
#endif

#include "auxlry.h"
/* context.h is necessary for the type of a thread context. */
#include "context.h"
#include "cinterf.h"


//#########################################################################
//####################taken from the cURL expamples########################
//#########################################################################
struct MemoryStruct {
  char *memory;
  size_t size;
};
 
 
static size_t
WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp)
{
  size_t realsize = size * nmemb;
  struct MemoryStruct *mem = (struct MemoryStruct *)userp;
 
  mem->memory = realloc(mem->memory, mem->size + realsize + 1);
  if(mem->memory == NULL) {
    /* out of memory! */ 
    //printf("not enough memory (realloc returned NULL)\n");
    return 0;
  }
 
  memcpy(&(mem->memory[mem->size]), contents, realsize);
  mem->size += realsize;
  mem->memory[mem->size] = 0;
 
  return realsize;
}
//#########################################################################
//#########################################################################
//#########################################################################


DllExport int call_conv get_uuid (CTXTdecl) {

  char *       host         = NULL;
  char *       relativePath = "/get-uuid";

  unsigned int urlLength    = 0;
  char *       url          = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;

  struct MemoryStruct chunk;


  xsb_query_save(CTXTc 1);
  c2p_functor(CTXTc "host", 1, reg_term(CTXTc 1));

  if (!xsb_query(CTXT)) {

    char * tempHost       = p2c_string(p2p_arg(reg_term(1),1));
    int    tempHostLength = strlen (tempHost);


    host = (char *) calloc (tempHostLength+1, sizeof (char));

    strncpy(host, tempHost, tempHostLength);
  }
  else {

    printf ("call failed\n");

    return FALSE;
  }

  xsb_close_query(CTXT);
  xsb_query_restore(CTXT);

  urlLength = strlen (host) + strlen (relativePath) + 1;
  url       = calloc (urlLength, sizeof(char));

  snprintf (url, urlLength, "%s%s", host, relativePath);

  chunk.memory = calloc(1, sizeof(char));
  chunk.size   = 0;
  curl_handle  = curl_easy_init();

  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *) &chunk);
 
  // just in case a user agent is required
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");
 
  result = curl_easy_perform(curl_handle);

  if (result != CURLE_OK) {
    
    fprintf (stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(result));
    extern_ctop_string(CTXTc 1, "curl_easy_perform() failed");
  }
  else {

    extern_ctop_string(CTXTc 1, chunk.memory);
  }

  free (url);
 
  curl_easy_cleanup(curl_handle);

  return TRUE;
}

DllExport int call_conv get_post_lines (CTXTdecl) {

  char *       host         = NULL;
  char *       relativePath = "/get-post-processing-lines";

  unsigned int urlLength    = 0;
  char *       url          = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;

  struct MemoryStruct chunk;


  xsb_query_save(CTXTc 1);
  c2p_functor(CTXTc "host", 1, reg_term(CTXTc 1));

  if (!xsb_query(CTXT)) {

    char * tempHost       = p2c_string(p2p_arg(reg_term(1),1));
    int    tempHostLength = strlen (tempHost);


    host = (char *) calloc (tempHostLength+1, sizeof (char));

    strncpy(host, tempHost, tempHostLength);
  }
  else {

    printf ("call failed\n");

    return FALSE;
  }

  xsb_close_query(CTXT);
  xsb_query_restore(CTXT);

  urlLength = strlen (host) + strlen (relativePath) + 1;
  url       = calloc (urlLength, sizeof(char));

  snprintf (url, urlLength, "%s%s", host, relativePath);

  chunk.memory = calloc(1, sizeof(char));
  chunk.size   = 0;
  curl_handle  = curl_easy_init();

  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *) &chunk);
 
  // just in case a user agent is required
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");
 
  result = curl_easy_perform(curl_handle);

  if (result != CURLE_OK) {
    
    fprintf (stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(result));
    extern_ctop_string(CTXTc 1, "curl_easy_perform() failed");
  }
  else {

    extern_ctop_string(CTXTc 1, chunk.memory);
  }

  free (host);
  free (url);
 
  curl_easy_cleanup(curl_handle);

  return TRUE;
}


DllExport int call_conv put_nlp_results (CTXTdecl) {

  char *       host             = NULL;
  char *       relativeBasePath = "/put-nlp-results";

  char *       tempUuid         = NULL;
  unsigned int uuidLength       = 0;
  char *       uuid             = NULL;

  unsigned int urlLength        = 0;
  char *       url              = NULL;

  char *       tempNlpResults   = NULL;
  unsigned int nlpResultsLength = 0;
  char *       nlpResults       = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;
  struct MemoryStruct chunk;
  
  
  tempUuid   = extern_ptoc_string(1);
  uuidLength = strlen (tempUuid);
  uuid       = (char *) calloc (uuidLength+1, sizeof (char));

  strncpy(uuid, tempUuid, uuidLength);

  tempNlpResults   = extern_ptoc_string(2);
  nlpResultsLength = strlen (tempNlpResults);
  nlpResults       = (char *) calloc (nlpResultsLength+1, sizeof (char));

  strncpy(nlpResults, tempNlpResults, nlpResultsLength);

  xsb_query_save(CTXTc 2);
  c2p_functor(CTXTc "host", 1, reg_term(CTXTc 1));

  if (!xsb_query(CTXT)) {

    char * tempHost       = p2c_string(p2p_arg(reg_term(1),1));
    int    tempHostLength = strlen (tempHost);


    host = (char *) calloc (tempHostLength+1, sizeof (char));

    strncpy(host, tempHost, tempHostLength);
  }
  else {

    printf ("prolog call failed\n");

    return FALSE;
  }

  xsb_close_query(CTXT);
  xsb_query_restore(CTXT);

  urlLength = strlen (host) + strlen (relativeBasePath) + 1 /*the path separator*/ + strlen (uuid) + 1;
  url       = calloc (urlLength, sizeof(char));
  
  snprintf (url, urlLength, "%s%s/%s", host, relativeBasePath, uuid);

  chunk.memory = calloc(1, sizeof(char));
  chunk.size   = 0;
  curl_handle  = curl_easy_init();
 
  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_CUSTOMREQUEST, "POST");
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *) &chunk);

  curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDS, nlpResults);
 
  // just in case a user agent is required
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");
 
  result = curl_easy_perform(curl_handle);
 
  if (result != CURLE_OK) {
    
    fprintf (stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(result));
    extern_ctop_string(CTXTc 1, "curl_easy_perform() failed");
  }
  
  free (nlpResults);
  free (url);
  free (uuid);

  curl_easy_cleanup(curl_handle);
 
  if (chunk.memory) {
    
    free (chunk.memory);
  }
  
  return TRUE;
}

DllExport int call_conv extract_prolog_actions (CTXTdecl) {

  char *       host             = NULL;
  char *       relativeBasePath = "/extract-prolog-actions";

  char *       tempActions      = NULL;
  unsigned int actionsLength    = 0;
  char *       actions          = NULL;

  unsigned int urlLength        = 0;
  char *       url              = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;
  struct MemoryStruct chunk;

  
  tempActions   = extern_ptoc_string(1);
  actionsLength = strlen (tempActions);
  actions       = (char *) calloc (actionsLength+1, sizeof (char));

  strncpy(actions, tempActions, actionsLength);

  xsb_query_save(CTXTc 2);
  c2p_functor(CTXTc "host", 1, reg_term(CTXTc 1));

  if (!xsb_query(CTXT)) {

    char * tempHost       = p2c_string(p2p_arg(reg_term(1),1));
    int    tempHostLength = strlen (tempHost);


    host = (char *) calloc (tempHostLength+1, sizeof (char));

    strncpy(host, tempHost, tempHostLength);
  }
  else {

    printf ("prolog call failed\n");

    return FALSE;
  }

  xsb_close_query(CTXT);
  xsb_query_restore(CTXT);

  urlLength = strlen (host) + strlen (relativeBasePath) + 1;
  url       = calloc (urlLength, sizeof(char));
  
  snprintf (url, urlLength, "%s%s", host, relativeBasePath);

  chunk.memory = calloc(1, sizeof(char));
  chunk.size   = 0;
  curl_handle  = curl_easy_init();
 
  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_CUSTOMREQUEST, "POST");
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *) &chunk);

  curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDS, actions);
 
  // just in case a user agent is required
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");
 
  result = curl_easy_perform(curl_handle);
 
  if (result != CURLE_OK) {
    
    fprintf (stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(result));
    extern_ctop_string(CTXTc 1, "curl_easy_perform() failed");
  }
  else {

    extern_ctop_string(CTXTc 2, chunk.memory);
  }
  
  free (actions);
  free (url);

  curl_easy_cleanup(curl_handle);
 
  if (chunk.memory) {
    
    free (chunk.memory);
  }
  
  return TRUE;
}
