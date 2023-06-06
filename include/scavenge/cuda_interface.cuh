#ifndef SCAVENGE_CUDA_INTERFACE_CUH
#define SCAVENGE_CUDA_INTERFACE_CUH

#include "config.cuh"

#include <curand_kernel.h>

#define CUDA_CALL(x) do { if((x) != cudaSuccess) { \
    printf("Error at %s (line %d): %s\n",__FILE__,__LINE__, cudaGetErrorString(x)); \
    return EXIT_FAILURE;}} while(0)

extern __global__ void kernel_curand_setup(curandState *, unsigned int);

#endif // SCAVENGE_CUDA_INTERFACE_CUH