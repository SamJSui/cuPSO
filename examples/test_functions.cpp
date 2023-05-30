#include <math.h>
#include "v2.h"

typedef float (*TestFunction)(const v2& v);

static inline float booth_function(const v2& v) {
  return (v.x+2*v.y-7)*(v.x+2*v.y-7)+(2*v.x+v.y-5)*(2*v.x+v.y-5);
}

static inline float rosenbrock_function(const v2& v) {
  return (1-v.x)*(1-v.x)+100*(v.y-v.x*v.x)*(v.y-v.x*v.x);
}

static inline float beale_function(const v2& v) {
  return (1.5-v.x+v.x*v.y)*(1.5-v.x+v.x*v.y)+
         (2.25-v.x+v.x*v.y*v.y)*(2.25-v.x+v.x*v.y*v.y)+
         (2.625-v.x+v.x*v.y*v.y*v.y)*(2.625-v.x+v.x*v.y*v.y*v.y);
}

static inline float matyas_function(const v2& v) {
  return 0.26*(v.x*v.x+v.y*v.y)-0.48*v.x*v.y;
}

static inline float CamelFunction(const v2& v) {
  return 2*v.x*v.x-1.05*v.x*v.x*v.x*v.x+
         (v.x*v.x*v.x*v.x*v.x*v.x)*1.6667f+v.x*v.y+v.y*v.y;
}

static inline float BukinFunction(const v2& v) {
  return 100*sqrtf(abs(v.y-0.01*v.x*v.x))+0.01*abs(v.x+10);
}

static inline float LevyFunction(const v2& v) {
  return sinpif(3*v.x)*sinpif(3*v.x)+(v.x-1)*(v.x-1)*
         (1+sinpif(3*v.y)*sinpif(3*v.y))+(v.y-1)*(v.y-1)*
         (1+sinpif(2*v.y)*sinpif(2*v.y));
}