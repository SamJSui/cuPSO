#ifndef VEC2_H
#define VEC2_H

#ifdef __CUDACC__
#define CUDA_HOSTDEV __host__ __device__
#else
#define CUDA_HOSTDEV
#endif

class vec2 {
  public:
    CUDA_HOSTDEV vec2();
    CUDA_HOSTDEV vec2(const float, const float);
    CUDA_HOSTDEV void operator=(const vec2&);
    CUDA_HOSTDEV void operator+=(const vec2&);
    CUDA_HOSTDEV void operator-=(const vec2&);
    CUDA_HOSTDEV vec2 operator+(const vec2&);
    CUDA_HOSTDEV vec2 operator-(const vec2&);
    float x, y;
};

#endif // VEC2_H