#include "particle.h"

std::default_random_engine Particle::gen_ = std::default_random_engine(time(0));
std::uniform_real_distribution<float> Particle::dist_ = std::uniform_real_distribution<float>(-1.0, 1.0);

Particle::Particle() {
  pos_ = vec2(dist_(gen_) * 100.0f, dist_(gen_) * 100.0f);
  best_pos_ = pos_;
  vel_ = vec2(0.0f, 0.0f);
}
