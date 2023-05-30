#include "cuda_interface.cuh"

__global__ 
void kernel_curand_setup(curandState *state, unsigned int seed) {
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  curand_init(seed, idx, 0, &state[idx]);
}