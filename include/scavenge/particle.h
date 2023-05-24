#ifndef PARTICLE_H
#define PARTICLE_H

#include "vec2.h"
#include <random>

class Particle {
  public:
    Particle();
    static std::default_random_engine gen_;
    static std::uniform_real_distribution<float> dist_;
    vec2 pos_;
    vec2 best_pos_;
    vec2 vel_;
    float best_fitness_;
};

#endif // PARTICLE_H