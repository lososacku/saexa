#include <stdlib.h>
#include "clips.h"

#include "/Users/sparrow/src/curl-7.37.0/include/curl/curl.h"


//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// should get rid of the old router code and make the curl
// memory chunk local
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

char * call_curl () {

  char *       tempUrl   = NULL;
  unsigned int urlLength = 0;
  char *       url       = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;
  struct MemoryStruct chunk;

  void * retVal = NULL;

  tempUrl   = RtnLexeme (1);
  urlLength = strlen    (tempUrl) + 1;
  url       = calloc    (urlLength, sizeof(char));

  strncpy (url, tempUrl, urlLength);

 
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

    retVal = AddSymbol ("curl_error");
  }
  else {

    retVal = AddSymbol (chunk.memory);
  }

  free (url);
 
  curl_easy_cleanup(curl_handle);
 
  if (chunk.memory) {
    
    free (chunk.memory);
  }

  return retVal;
}

struct MemoryStruct g_chunk;
int                 g_currentOffset = 0;


int getCurlResultsQueryFunction (char * logicalName) {

  int retVal = 0;

  
  if (0 == strcmp (logicalName, "curl-results")) {

      retVal = 1;
  }

  return retVal;
}


int getCurlResultsPrintFunction (char * logicalName, char * str) {

  return 0;
}


int getCurlResultsGetcFunction (char * logicalName) {

  int retVal = EOF;

  if (0 == strcmp (logicalName, "curl-results")) {

    if (g_currentOffset < g_chunk.size) {

      retVal = (int) g_chunk.memory [g_currentOffset];

      ++g_currentOffset;
    }
  }
  
  return retVal;
}


int getCurlResultsUngetcFunction (int ch, char * logicalName) {

  int retVal = EOF;

  if (0 == strcmp (logicalName, "curl-results")) {

    if (g_currentOffset > 0) {

      retVal = (int) ch;

      --g_currentOffset;
    }
  }
  
  return retVal;
}


int getCurlResultsExitFunction (int exitCode) {

  return 0;
}

char * get_nlp_results () {

  DATA_OBJECT data_object;
    
  char *       host         = NULL;
  char *       relativePath = "/get-nlp-results";
  unsigned int urlLength    = 0;
  char *       url          = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;

  static int initialized = 0;

  char * retVal = 0;

  
  if (initialized && g_chunk.memory) {

    free (g_chunk.memory);
  }

  GetDefglobalValue ("host", &data_object);

  host = DOToString(data_object);

  urlLength = strlen (host) + strlen (relativePath) + 1;
  url       = calloc (urlLength, sizeof(char));

  snprintf (url, urlLength, "%s%s", host, relativePath);

  g_currentOffset = 0;
  
  g_chunk.memory = calloc(1, sizeof(char));
  g_chunk.size   = 0;
  curl_handle  = curl_easy_init();

  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *) &g_chunk);
 
  // just in case a user agent is required
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");
 
  result = curl_easy_perform(curl_handle);
 

  if (result != CURLE_OK) {
    
    fprintf (stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(result));
  }

  retVal = AddSymbol (g_chunk.memory);

  free (url);
 
  curl_easy_cleanup(curl_handle);

  if (0 == initialized) {

    initialized = 1;
  }

  return retVal;
}


void put_exposure_results () {

  DATA_OBJECT data_object;
    
  char *       host             = NULL;
  char *       relativeBasePath = "/put-exposure-results";
  char *       uuidTemp         = NULL;
  unsigned int uuidLength       = 0;
  char *       uuid             = NULL;
  unsigned int urlLength        = 0;
  char *       url              = NULL;

  char *       tempExposureResults   = NULL;
  unsigned int exposureResultsLength = 0;
  char *       exposureResults       = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;
  struct MemoryStruct chunk;

  void * retVal = NULL;
  

  GetDefglobalValue ("host", &data_object);

  host = DOToString(data_object);

  uuidTemp   = RtnLexeme (1);
  uuidLength = strlen    (uuidTemp) + 1;
  uuid       = calloc    (uuidLength, sizeof(char));

  strncpy(uuid, uuidTemp, uuidLength);
  
  urlLength = strlen (host) + strlen (relativeBasePath) + 1 /*the path separator*/ + strlen (uuid) + 1;
  url       = calloc (urlLength, sizeof(char));

  snprintf (url, urlLength, "%s%s/%s", host, relativeBasePath, uuid);

  tempExposureResults   = RtnLexeme (2);
  exposureResultsLength = strlen    (tempExposureResults) + 1;
  exposureResults       = calloc    (exposureResultsLength, sizeof(char));

  strncpy (exposureResults, tempExposureResults, exposureResultsLength);
  
  chunk.memory = calloc(1, sizeof(char));
  chunk.size   = 0;
  curl_handle  = curl_easy_init();
 
  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_CUSTOMREQUEST, "POST");
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *) &chunk);

  curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDS, exposureResults);
 
  // just in case a user agent is required
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");
 
  result = curl_easy_perform(curl_handle);
 
  if (result != CURLE_OK) {
    
    fprintf (stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(result));
  }

  free (exposureResults);
  free (url);
  free (uuid);
 
  curl_easy_cleanup(curl_handle);
 
  if (chunk.memory) {
    
    free (chunk.memory);
  }
}

char * extract_clips_actions () {

  DATA_OBJECT data_object;
    
  char *       host         = NULL;
  char *       relativePath = "/extract-clips-actions";
  unsigned int urlLength    = 0;
  char *       url          = NULL;

  char *       tempResults   = NULL;
  unsigned int resultsLength = 0;
  char *       results       = NULL;

  CURL *   curl_handle = NULL;
  CURLcode result      = 0;

  static int initialized = 0;

  char * retVal = 0;

  
  if (initialized && g_chunk.memory) {

    free (g_chunk.memory);
  }

  GetDefglobalValue ("host", &data_object);

  host = DOToString(data_object);

  urlLength = strlen (host) + strlen (relativePath) + 1;
  url       = calloc (urlLength, sizeof(char));

  snprintf (url, urlLength, "%s%s", host, relativePath);

  tempResults   = RtnLexeme (1);
  resultsLength = strlen    (tempResults) + 1;
  results       = calloc    (resultsLength, sizeof(char));

  strncpy (results, tempResults, resultsLength);
  
  g_currentOffset = 0;
  
  g_chunk.memory = calloc(1, sizeof(char));
  g_chunk.size   = 0;
  curl_handle  = curl_easy_init();

  curl_easy_setopt(curl_handle, CURLOPT_URL, url);
  curl_easy_setopt(curl_handle, CURLOPT_CUSTOMREQUEST, "POST");
  curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
  curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *) &g_chunk);

  curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDS, results);
 
  // just in case a user agent is required
  curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");
 
  result = curl_easy_perform(curl_handle);

  if (result != CURLE_OK) {
    
    fprintf (stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(result));
  }

  retVal = AddSymbol (g_chunk.memory);

  free (results);
  free (url);
 
  curl_easy_cleanup(curl_handle);

  if (0 == initialized) {

    initialized = 1;
  }

  return retVal;
}

void * get_uuid () {

  DATA_OBJECT data_object;
    
  char *       host         = NULL;
  char *       relativePath = "/get-uuid";
  unsigned int urlLength    = 0;
  char *       url          = NULL;

  CURL *              curl_handle = NULL;
  CURLcode            result      = 0;
  struct MemoryStruct chunk;

  void * retVal = NULL;


  GetDefglobalValue ("host", &data_object);

  host = DOToString(data_object);

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
  }

  retVal = AddSymbol (chunk.memory);

  free (url);
 
  curl_easy_cleanup(curl_handle);

  if (chunk.memory) {
    
    free (chunk.memory);
  }

  return retVal;
}




