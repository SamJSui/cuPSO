#ifndef SCAVENGE_CONFIG_H
#define SCAVENGE_CONFIG_H

#include "utils_namespace.h"

#include <iostream>

/* Cross-compatibility for .cu and .cpp files */

#ifndef __host__
#define __host__
#endif

#ifndef __device__
#define __device__
#endif

SCAVENGE_NAMESPACE_BEGIN

/* Project-wide global variables */

namespace globals {

  extern int device_count;
  extern unsigned int block_size;

}

/* Config class to maintain settings for each object */

class Config {
  public:
    Config();
    unsigned int epochs_; // Initialized by ALGORITHM's run()
    bool use_gpu_;
};

SCAVENGE_NAMESPACE_END

#endif // SCAVENGE_CONFIG_H