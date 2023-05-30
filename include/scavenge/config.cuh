#ifndef SCAVENGE_CONFIG_H
#define SCAVENGE_CONFIG_H

/* Scavenge Namespaces */

#define SCAVENGE_NAMESPACE_BEGIN \
namespace scavenge { \

#define SCAVENGE_NAMESPACE_END \
} \

/* Cross-compatibility for .cu and .cpp files */

#ifndef __host__
#define __host__
#endif

#ifndef __device__
#define __device__
#endif

/* Test function utilities */

typedef float (*ScavengeTestFunction)(float, float);

SCAVENGE_NAMESPACE_BEGIN

namespace globals {

  extern int device_count;
  extern unsigned int block_size;

}

class Config {
  public:
    Config();
    unsigned int epochs_;
    bool use_gpu_;
};

SCAVENGE_NAMESPACE_END

#endif // SCAVENGE_CONFIG_H