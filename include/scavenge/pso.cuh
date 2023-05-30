#ifndef SCAVENGE_PSO_H
#define SCAVENGE_PSO_H

#include "config.cuh"
#include "cuda_interface.cuh"
#include "particle.cuh"
#include "vec2.cuh"

SCAVENGE_NAMESPACE_BEGIN

class PSO {
  public:
    PSO(unsigned int=40, float=0.5, float=1.0, float=1.0);
    ~PSO();
    Particle operator[](unsigned int);
    void run(unsigned int=1);
    void set_gpu(bool);
  private:
    void device_init();
    void simulate_cpu();
    void simulate_gpu();
    Config settings_;
    vec2 best_pos_;
    Particle *particles_;
    Particle *d_particles_;
    unsigned int num_particles_;
    float inertia_;
    float cognition_;
    float social_;
    float best_fitness_;
    unsigned int best_idx_;
};

SCAVENGE_NAMESPACE_END

#endif // SCAVENGE_PSO_H