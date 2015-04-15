// Copyright 2015 Ryan B. Hicks

#include <unistd.h>
#include "clips.h"


void system_sleep () {

  int sleepTime = 0;


  sleepTime = RtnLong (1);

  sleep (sleepTime);
}
