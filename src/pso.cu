#include "pso.cuh"

SCAVENGE_NAMESPACE_BEGIN

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
  
  if (globals::device_count > 0) 
    device_init();
  else 
    settings_.use_gpu_ = false;
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
  settings_.epochs_ = epochs;
  if (globals::device_count && settings_.use_gpu_);
  else;
}

void PSO::set_gpu(bool gpu) {
  settings_.use_gpu_ = gpu;
}

void PSO::device_init() {
  unsigned int grid_size;
  ssize_t particles_bytes;
  curandState *state;

  settings_.use_gpu_ = true;
  particles_bytes = sizeof(Particle) * num_particles_;

  cudaMalloc((void **) &d_particles_, particles_bytes);
  cudaMalloc(&state, sizeof(curandState) * globals::block_size);
  cudaMemcpy(d_particles_, particles_, particles_bytes, cudaMemcpyHostToDevice);

  grid_size = (num_particles_ + globals::block_size - 1) / globals::block_size;
  kernel_curand_setup<<<grid_size, globals::block_size>>>(state, rand() % INT_MAX);
}

SCAVENGE_NAMESPACE_END