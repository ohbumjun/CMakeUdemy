// test library

// generate main function byitself. therefore should not define main function here
#define CATCH_CONFIG_MAIN

#include <catch2/catch.hpp>

#include "my_lib.h"

// testname, short name
TEST_CASE("Factorials are computed", "[factorial]")
{
    REQUIRE(factorial(1) == 1);
    REQUIRE(factorial(2) == 2);
    REQUIRE(factorial(3) == 6);
    REQUIRE(factorial(10) == 3628800);
}