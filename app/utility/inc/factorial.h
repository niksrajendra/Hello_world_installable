#ifndef FACT_H
#define FACT_H

#include <stdint.h>

#define MYDLL_EXPORTS

#ifdef MYDLL_EXPORTS
  #define MYDLL_API __declspec(dllexport)
#else
  #define MYDLL_API __declspec(dllimport)
#endif

MYDLL_API uint64_t factorial(uint8_t numer);

#endif