#include "vec2.cuh"

SCAVENGE_NAMESPACE_BEGIN

__host__ __device__ 
vec2::vec2()
  : x(0.0f),
    y(0.0f) {}

__host__ __device__
vec2::vec2(const float a, const float b)
  : x(a),
    y(b) {}

__host__ __device__
void vec2::operator=(const vec2& vec2_operand) {
  x = vec2_operand.x;
  y = vec2_operand.y;
}

__host__ __device__
void vec2::operator+=(const vec2& vec2_operand) {
  x += vec2_operand.x;
  y += vec2_operand.y;
}

__host__ __device__
void vec2::operator-=(const vec2& vec2_operand) {
  x -= vec2_operand.x;
  y -= vec2_operand.y;
}

__host__ __device__
vec2 vec2::operator+(const vec2& vec2_operand) {
  return vec2(x + vec2_operand.x, y + vec2_operand.y);
}


__host__ __device__
vec2 vec2::operator-(const vec2& vec2_operand) {
  return vec2(x - vec2_operand.x, y - vec2_operand.y);
}

SCAVENGE_NAMESPACE_END