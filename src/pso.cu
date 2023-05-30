#include "pso.cuh"

SCAVENGE_NAMESPACE_BEGIN

/* PSO Core Class Definitions */

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
  dev_particles_ = nullptr;

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
  if (dev_particles_)
    cudaFree(dev_particles_);
}

Particle& PSO::operator[](const unsigned int& idx) {
  return particles_[idx];
}

void PSO::run(const unsigned int epochs) {
  settings_.epochs_ = epochs;
  if (globals::device_count && settings_.use_gpu_)
    simulate_gpu();
  else
    simulate_cpu();
}

void PSO::set_gpu(const bool& gpu) {
  settings_.use_gpu_ = gpu;
}

void PSO::simulate_cpu() {
  unsigned int iteration = 0;
  do {
    
    iteration++;
  } while(iteration < settings_.epochs_);
}

void PSO::simulate_gpu() {
  ;
}

void PSO::device_init() {
  unsigned int grid_size;
  unsigned int particles_bytes;
  curandState *state;

  settings_.use_gpu_ = true;
  particles_bytes = sizeof(Particle) * num_particles_;

  cudaMalloc((void **) &dev_particles_, particles_bytes);
  cudaMalloc(&state, sizeof(curandState) * globals::block_size);
  cudaMemcpy(dev_particles_, particles_, particles_bytes, cudaMemcpyHostToDevice);

  grid_size = (num_particles_ + globals::block_size - 1) / globals::block_size;
  kernel_curand_setup<<<grid_size, globals::block_size>>>(state, rand() % INT_MAX);
}

/* PSO Global (CUDA Kernel) / Device Helper Functions */

namespace pso {

  void update_particle_position() {
    ;
  }

  void update_particle_velocity() {
    ;
  }

  void update_global_best() {
    ;
  }

}

SCAVENGE_NAMESPACE_END