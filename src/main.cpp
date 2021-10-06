#include "math/fibonacci.hpp"
#include "version.hpp"

#include <clara/clara.hpp>
#include <range/v3/algorithm.hpp>
#include <range/v3/iterator.hpp>
#include <range/v3/numeric.hpp>

#include <iostream>
#include <optional>
#include <string>

struct CliOptions {
    std::optional<std::string> input_path;
    std::string command;
    bool print_help = false;
};

static void print_help(const clara::Parser& parser)
{
    std::cout << "Project:       " << Project::Config::Name << '\n';
    std::cout << "Version:       " << Project::Config::VersionStr << '\n';
    std::cout << "Version Major: " << Project::Config::VersionMajor << '\n';
    std::cout << "Version Minor: " << Project::Config::VersionMinor << '\n';
    std::cout << "Version Tweak: " << Project::Config::VersionPatch << '\n';
    std::cout << "Git Revision:  " << Project::Config::GitRevision << '\n';
    std::cout << "Website:       " << Project::Config::Website << '\n';
    std::cout << "Description:   " << Project::Config::Description << "\n\n";
    std::cout << parser << std::endl;
}

int main(int argc, char** argv)
{
    using namespace CppStarter;
    using namespace clara;
    CliOptions options;

    // clang-format off
    auto cli = Help(options.print_help)
        | Opt(options.input_path, "input path")
            ["-i"]["--input"]
            ("Prints [path] as Tokenstream")
        | Arg(options.command, "fibo|csv")
            ("which command to run");
    // clang-format on

    auto result = cli.parse(Args(argc, argv));
    if (!result) {
        std::cerr << "Error in command line: " << result.errorMessage() << std::endl;
        return 1;
    }

    if (options.print_help) {
        print_help(cli);
        return 0;
    }

    if (options.command.empty()) {
        std::cerr << "Missing command. Pass \"--help\" for help." << std::endl;
        return 1;
    }

    if (options.command == "fibo") {
        std::cout << Math::fibonacci(10ll) << std::endl;
        return 0;
    }

    if (options.command == "csv") {
        return 0;
    }

    std::cout << options.command;

    ranges::ostream_iterator<int> out_it(std::cout, ", ");
    ranges::fill_n(out_it, 100, 1);
    return 0;
}
