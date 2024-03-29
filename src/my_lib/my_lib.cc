#include <iostream>

#include <fmt/format.h>
#include <nlohmann/json.hpp>
#include <spdlog/spdlog.h>


/*
@breif prints hello and test json lib
- parse this json and see it in browser
*/
void print_hello_world()
{
    std::cout << "Hello, World!" << std::endl;
}

std::uint32_t factorial(unsigned int number)
{
    return number <= 1 ? number : factorial(number - 1) * number;
}
