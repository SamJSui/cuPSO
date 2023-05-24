#include "vec2.h"

CUDA_HOSTDEV vec2::vec2() {
  x = 0.0f;
  y = 0.0f;
}

CUDA_HOSTDEV vec2::vec2(const float a, const float b) {
  x = a;
  y = b;
}

CUDA_HOSTDEV void vec2::operator=(const vec2& p) {
  x = p.x;
  y = p.y;
}

CUDA_HOSTDEV void vec2::operator+=(const vec2& p) {
  x += p.x;
  y += p.y;
}

CUDA_HOSTDEV void vec2::operator-=(const vec2& p) {
  x -= p.x;
  y -= p.y;
}

CUDA_HOSTDEV vec2 vec2::operator+(const vec2& p) {
  return vec2(x + p.x, y + p.y);
}

CUDA_HOSTDEV vec2 vec2::operator-(const vec2& p) {
  return vec2(x - p.x, y - p.y);
}