#include "pso.h"

/// pso/class.cuh ///

PSO::PSO(
    unsigned int num_particles, // aggregate init
    float inertia, 
    float cognition, 
    float social) 
    : num_particles_(num_particles),
      inertia_(inertia),
      cognition_(cognition),
      social_(social) {
  particles_ = new Particle[num_particles_]; // particles
  d_particles_ = nullptr;
  best_idx_ = 0; // global best
  best_fitness_ = 0.0f;
  cudaGetDeviceCount(&gpu_device_count_); // cuda
  if (cudaGetDeviceCount > 0) 
    device_init();
  else 
    use_gpu_ = 0;
}

PSO::~PSO() {
  if (particles_)
    free(particles_);
  if (d_particles_)
    cudaFree(d_particles_);
}

Particle PSO::operator[](unsigned int idx) {
  return particles_[idx];
}

void PSO::run(unsigned int epochs) {
  if (gpu_device_count_ && use_gpu_)
    simulate_gpu();
  else
    simulate_cpu();
}

void PSO::device_init() {
  unsigned int grid_size;
  ssize_t particles_bytes;
  curandState *state;
  use_gpu_ = 1;
  particles_bytes = sizeof(Particle) * num_particles_;
  cudaMalloc((void **) &d_particles_, particles_bytes);
  cudaMalloc(&state, sizeof(curandState) * config::block_size);
  cudaMemcpy(d_particles_, particles_, particles_bytes, cudaMemcpyHostToDevice);
  printf("host x: %f\n", particles_[39].best_pos_.x);
  grid_size = (num_particles_ + config::block_size - 1) / config::block_size;
  g_kernel_setup<<<grid_size, config::block_size>>>(state, rand() % INT_MAX, num_particles_);
  g_pso_simulate<<<grid_size, config::block_size>>>(d_particles_, num_particles_);
}

void PSO::simulate_cpu() {

}

void PSO::simulate_gpu() {

}

//// pso/simulate.cuh ////

CUDA_GLOBAL void g_kernel_setup(
    curandState *state, 
    unsigned int seed, 
    unsigned int num_particles) {
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  if (idx >= num_particles) return;
  curand_init(seed, idx, 0, &state[idx]);
}

CUDA_GLOBAL void g_pso_simulate(Particle *d_particles, unsigned int num_particles) {
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  if (idx >= num_particles) return;
  if (idx == 0) {
    printf("dev x: %f\n", d_particles[39].best_pos_.x);
  }
}