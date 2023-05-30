#include "config.cuh"

SCAVENGE_NAMESPACE_BEGIN

int globals::device_count = 0;
unsigned int globals::block_size = 256;

Config::Config() {
  cudaGetDeviceCount(&globals::device_count);
  use_gpu_ = globals::device_count;
}

SCAVENGE_NAMESPACE_END