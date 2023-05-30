#ifndef SCAVENGE_CUDA_INTERFACE_CUH
#define SCAVENGE_CUDA_INTERFACE_CUH

#include "config.cuh"

#include <curand_kernel.h>

extern __global__ void kernel_curand_setup(curandState *, unsigned int);

#endif // SCAVENGE_CUDA_INTERFACE_CUH