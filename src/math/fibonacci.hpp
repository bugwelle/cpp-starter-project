#pragma once

#include <concepts>

namespace CppStarter::Math {

/**
 * @brief Calculate fibonacci numbers.
 *
 * @param nums nth's fibonacci number
 */
template <std::integral T>
[[nodiscard]] T fibonacci(T num)
{
    if (num == 0) {
        return 0;
    }
    if (num == 1) {
        return 1;
    }

    return fibonacci(num - 1) + fibonacci(num - 2);
}

} // namespace CppStarter::Math
