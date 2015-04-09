   /*******************************************************/
   /*      "C" Language Integrated Production System      */
   /*                                                     */
   /*               CLIPS Version 6.24  04/21/06          */
   /*                                                     */
   /*                USER FUNCTIONS MODULE                */
   /*******************************************************/

/*************************************************************/
/* Purpose:                                                  */
/*                                                           */
/* Principal Programmer(s):                                  */
/*      Gary D. Riley                                        */
/*                                                           */
/* Contributing Programmer(s):                               */
/*                                                           */
/* Revision History:                                         */
/*                                                           */
/*      6.24: Created file to seperate UserFunctions and     */
/*            EnvUserFunctions from main.c.                  */
/*                                                           */
/*************************************************************/

/***************************************************************************/
/*                                                                         */
/* Permission is hereby granted, free of charge, to any person obtaining   */
/* a copy of this software and associated documentation files (the         */
/* "Software"), to deal in the Software without restriction, including     */
/* without limitation the rights to use, copy, modify, merge, publish,     */
/* distribute, and/or sell copies of the Software, and to permit persons   */
/* to whom the Software is furnished to do so.                             */
/*                                                                         */
/* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS */
/* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF              */
/* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT   */
/* OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY  */
/* CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES */
/* WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN   */
/* ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF */
/* OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.          */
/*                                                                         */
/***************************************************************************/

#include "setup.h"
#include "extnfunc.h"

void UserFunctions(void);
void EnvUserFunctions(void *);

extern char * call_curl             ();
extern char * get_nlp_results       ();
extern void   put_exposure_results  ();
extern void   system_sleep          ();
extern char * base64_encode         ();
extern char * base64_decode         ();
extern void   extract_clips_actions ();
extern void * get_uuid              ();

  
/*********************************************************/
/* UserFunctions: Informs the expert system environment  */
/*   of any user defined functions. In the default case, */
/*   there are no user defined functions. To define      */
/*   functions, either this function must be replaced by */
/*   a function with the same name within this file, or  */
/*   this function can be deleted from this file and     */
/*   included in another file.                           */
/*********************************************************/
void UserFunctions () {

  DefineFunction ("curl",                  's', PTIF call_curl,             "call_curl");
  DefineFunction ("get-nlp-results",       's', PTIF get_nlp_results,       "get_nlp_results");
  DefineFunction ("put-exposure-results",  'v', PTIF put_exposure_results,  "put_exposure_results");
  DefineFunction ("sleep",                 'v', PTIF system_sleep,          "system_sleep");
  DefineFunction ("base64-encode",         's', PTIF base64_encode,         "base64_encode");
  DefineFunction ("base64-decode",         's', PTIF base64_decode,         "base64_decode");
  DefineFunction ("extract-clips-actions", 's', PTIF extract_clips_actions, "extract_clips_actions");
  DefineFunction ("get-uuid",              'w', PTIF get_uuid,              "get_uuid");
}
  
/***********************************************************/
/* EnvUserFunctions: Informs the expert system environment */
/*   of any user defined functions. In the default case,   */
/*   there are no user defined functions. To define        */
/*   functions, either this function must be replaced by   */
/*   a function with the same name within this file, or    */
/*   this function can be deleted from this file and       */
/*   included in another file.                             */
/***********************************************************/
#if IBM_TBC
#pragma argsused
#endif
void EnvUserFunctions(
  void *theEnv)
  {
#if MAC_MCW || IBM_MCW || MAC_XCD
#pragma unused(theEnv)
#endif
  }

