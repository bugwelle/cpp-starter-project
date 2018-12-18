#define CATCH_CONFIG_RUNNER
#include "catch2/catch.hpp"

#include <vector>

TEST_CASE("Test framework works", "[unit]")
{
    CHECK('a' < 'b');
}

int main(int argc, char** argv)
{
    Catch::Session session;
    const int res = session.run(argc, argv);
    return res;
}
