#include <factorial.h>

MYDLL_API uint64_t factorial(uint8_t number)
{
    uint64_t result = 1;
    if((number == 1)||(number == 0))
    {
        return result;
    }
    else
    {
        uint64_t iter = 1; 
        for(iter = 2; iter <= number; iter++)
        {
            result *= iter;
        }
        return result;
    }
}