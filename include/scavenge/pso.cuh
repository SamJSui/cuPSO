#ifndef SCAVENGE_PSO_H
#define SCAVENGE_PSO_H

#include "config.cuh"
#include "cuda_interface.cuh"
#include "particle.cuh"
#include "vec2.cuh"

SCAVENGE_NAMESPACE_BEGIN

extern __device__ __constant__ float sim_params[3]; // Simulation Parameters

/* PSO Core Class Declaration */

class PSO {

  public:

    PSO(const unsigned int=40, const float=0.5, const float=1.0, const float=1.0);
    ~PSO();

    /* Overloaded operators */

    Particle& operator[](const unsigned int&);
    
    /* Public PSO Simulation Functions*/

    void run(const unsigned int=1000);

    /* PSO Setters */
    
    void set_gpu(const bool&);

  private:

    /* Device-side Constructor */

    void device_init();

    /* CPU Simulation */

    void simulate_cpu();

    /* GPU Simulation */

    void simulate_gpu();

    ScavengeTestFunction test_fn_;
    ScavengeTestFunction dev_test_fn_;

    /* Maintains GPU settings and epochs */

    Config settings_;

    /* Particles */

    Particle *particles_;
    Particle *dev_particles_;

    /* Parameters for Simulation */

    const unsigned int num_particles_;
    const float inertia_;
    const float cognition_;
    const float social_;

    /* Global Best Particle for Simulation */

    float best_fitness_;
    unsigned int best_idx_;
};

/* Global (CUDA Kernel) / Device Helper Functions */

namespace pso {

  void update_particle_position();
  void update_particle_velocity();
  void update_global_best();
  
}

SCAVENGE_NAMESPACE_END

#endif // SCAVENGE_PSO_H