#pragma once

#include <type_traits>

namespace CppStarter::Math {

/**
 * @brief Calculate fibonacci numbers.
 *
 * @param nums nth's fibonacci number
 */
template <typename T, typename = std::enable_if_t<std::is_integral_v<T>>>
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
