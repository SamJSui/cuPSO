#include "pso.cuh"

SCAVENGE_NAMESPACE_BEGIN

/* PSO Global (CUDA Kernel) / Device Helper Functions */

namespace pso {

  __global__
  void update_particle_position_gpu() {
    vec2 a(1.0, 2.0);
  }
  __global__
  void update_particle_velocity_gpu() {
    ;
  }
  __global__
  void update_global_best_gpu() {
    ;
  }

}

/* PSO Core Class Definitions */

PSO::PSO(
  unsigned int n_p, // aggregate init
  float i, 
  float c, 
  float s) 
  : num_particles_(n_p),
    inertia(i),
    cognition(c),
    social(s) {

  /* Allocate particles */

  particles_ = new Particle[num_particles_];
  dev_particles_ = nullptr;

  /* Simulation Global Best */

  best_idx_ = 0;
  
  /* CUDA */

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
  best_fitness_ = test_fn(particles_[0].pos_);
  printf("%f\n", best_fitness_);
  if (globals::device_count && settings_.use_gpu_)
    simulate_gpu();
  else
    simulate_cpu();
}

/* PSO Setters */

void PSO::set_gpu(const bool& gpu) {
  settings_.use_gpu_ = gpu;
}

/* CPU Simulation */

void PSO::simulate_cpu() {
  unsigned int iteration = 0;
  do {
    
    iteration++;
  } while(iteration < settings_.epochs_);
}

void PSO::update_particle_position() {
  for (unsigned int idx = 0; idx < num_particles_; idx++) {
    float new_fitness = test_fn(particles_[idx].pos_);
    if (new_fitness < particles_[idx].best_fitness_)
      particles_[idx].best_fitness_ = new_fitness;
  }
}

void PSO::update_particle_velocity() {
  for (unsigned int idx = 0; idx < num_particles_; idx++) {
    float rand_1 = Particle::dist_(Particle::gen_);
    float rand_2 = Particle::dist_(Particle::gen_);
    vec2 global_pos = particles_[best_idx_].best_pos_;

    particles_[idx].vel_.x = inertia * particles_[idx].vel_.x + // Calculate particle's velocity
      cognition * rand_1 * (particles_[idx].best_pos_.x - particles_[idx].best_pos_.x) + 
      social * rand_2 * (global_pos.x - particles_[idx].pos_.x);

    particles_[idx].vel_.y = inertia * particles_[idx].vel_.y +
      cognition * rand_1 * (particles_[idx].best_pos_.y - particles_[idx].best_pos_.y) + 
      social * rand_2 * (global_pos.y - particles_[idx].pos_.y);
  }
}

void PSO::update_global_best() {
  for (unsigned int idx = 0; idx < num_particles_; idx++) {
    
  }
}

void PSO::simulate_gpu() {
  unsigned int grid_size = (num_particles_ + globals::block_size - 1) / globals::block_size;
  unsigned int iteration = 0;
  do {
    pso::update_particle_position_gpu<<<grid_size, globals::block_size>>>();
    iteration++;
  } while(iteration < settings_.epochs_);
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

SCAVENGE_NAMESPACE_END