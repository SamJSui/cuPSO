#include "particle.cuh"

SCAVENGE_NAMESPACE_BEGIN

/* Initialize the static random number generators for the float interval [-1.0, 1.0 ] */

std::default_random_engine Particle::gen_ = std::default_random_engine(time(0));
std::uniform_real_distribution<float> Particle::dist_ = std::uniform_real_distribution<float>(-1.0, 1.0);

/* Default values for static world values for the simulation */

float Particle::world_width_ = 100.0f;
float Particle::world_height_ = 100.0f;

Particle::Particle() {
  pos_ = vec2(dist_(gen_) * world_width_, dist_(gen_) * world_height_);
  best_pos_ = pos_;
  vel_ = vec2(0.0f, 0.0f);
}

SCAVENGE_NAMESPACE_END