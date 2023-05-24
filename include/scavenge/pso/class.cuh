#ifndef PSO_CLASS_CUH
#define PSO_CLASS_CUH

#include "../particle.h"
#include "../vec2.h"

class PSO {
  public:
    PSO(unsigned int=40, float=0.5, float=1.0, float=1.0);
    ~PSO();
    Particle operator[](unsigned int);
    void run(unsigned int=1);
  private:
    void device_init();
    void simulate_cpu();
    void simulate_gpu();
    vec2 best_pos_;
    Particle *particles_;
    Particle *d_particles_;
    int gpu_device_count_;
    unsigned int num_particles_;
    unsigned int length_;
    unsigned int epochs_;
    float inertia_;
    float cognition_;
    float social_;
    float best_fitness_;
    unsigned int best_idx_;
    bool use_gpu_;
};

#endif // PSO_CLASS_CUH