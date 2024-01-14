
#include <iostream>

#include "config.hpp"
#include "my_lib.h"
#include <nlohmann/json.hpp>

int main()
{
    std::cout << project_name << std::endl;
    std::cout << "JSON LIB Verision : " << NLOHMANN_JSON_VERSION_MAJOR << "."
              << NLOHMANN_JSON_VERSION_MINOR << "."
              << NLOHMANN_JSON_VERSION_PATCH << std::endl;
    print_hello_world();

    int x[2];
    x[2] = 1337;

    int *n = new int;

    std::cout << x << std::endl;
    return 0; ///
}