#include "test_helpers.hpp"

#include "math/fibonacci.hpp"

TEST_CASE("fibonacci numbers are computed", "[fibonacci]")
{
    using namespace CppStarter::Math;
    CHECK(fibonacci(0) == 0);
    CHECK(fibonacci(1) == 1);
    CHECK(fibonacci(2) == 1);
    CHECK(fibonacci(3) == 2);
    CHECK(fibonacci(10) == 55);
    CHECK(fibonacci(20) == 6765);
}
