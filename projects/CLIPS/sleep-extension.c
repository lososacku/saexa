// Copyright 2015 Ryan B. Hicks

#ifdef _WIN32
#include <windows.h>
#else
#include <unistd.h>
#endif

#include "clips.h"


void system_sleep () {

  int sleepTime = 0;


  sleepTime = RtnLong (1);

#ifdef _WIN32
  Sleep (sleepTime * 1000);
#else
  sleep (sleepTime);
#endif

}
