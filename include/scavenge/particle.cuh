#ifndef SCAVENGE_PARTICLE_H
#define SCAVENGE_PARTICLE_H

#include "vec2.cuh"
#include <random>

SCAVENGE_NAMESPACE_BEGIN

class Particle {
  public:
    Particle();
    static std::default_random_engine gen_;
    static std::uniform_real_distribution<float> dist_;
    static float world_width_;
    static float world_height_;
    vec2 pos_;
    vec2 best_pos_;
    vec2 vel_;
    float best_fitness_;
};

SCAVENGE_NAMESPACE_END

#endif // SCAVENGE_PARTICLE_H