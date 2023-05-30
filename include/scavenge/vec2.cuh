#ifndef SCAVENGE_VEC2_CUH
#define SCAVENGE_VEC2_CUH

#include "config.cuh"

SCAVENGE_NAMESPACE_BEGIN

class vec2 {
  public:
    __host__ __device__ vec2();
    __host__ __device__ vec2(const float, const float);
    __host__ __device__ void operator=(const vec2&);
    __host__ __device__ void operator+=(const vec2&);
    __host__ __device__ void operator-=(const vec2&);
    __host__ __device__ vec2 operator+(const vec2&);
    __host__ __device__ vec2 operator-(const vec2&);
    float x, y;
};

SCAVENGE_NAMESPACE_END

#endif // SCAVENGE_VEC2_CUH