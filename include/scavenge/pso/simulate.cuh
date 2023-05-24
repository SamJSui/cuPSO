#ifndef CUDA_SIMULATE_CUH
#define CUDA_SIMULATE_CUH

#ifdef __CUDACC__
#define CUDA_HOSTDEV __host__ __device__
#else
#define CUDA_HOSTDEV
#endif

#ifdef __CUDACC__
#define CUDA_GLOBAL __global__
#else
#define CUDA_GLOBAL
#endif

#include "../particle.h"
#include <curand_kernel.h>

namespace config {
  const unsigned int block_size = 256;
};

extern CUDA_GLOBAL void g_kernel_setup(curandState *, unsigned int, unsigned int);
extern CUDA_GLOBAL void g_pso_simulate(Particle *, unsigned int);
extern CUDA_HOSTDEV void d_pso_update_init();

#endif // CUDA_SIMULATE_CUH