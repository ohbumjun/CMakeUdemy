
#include <iostream>

#include "my_lib.h"
#include "config.hpp"

int main() {
    std::cout << project_name << std::endl;
    print_hello_world();

    int x[2];
    x[2] = 1337;

    std::cout << x << std::endl;
    return 0;
}