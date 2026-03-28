Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[hictk documentation](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[hictk documentation](index.html)

Installation

* [Installation](installation.html)
* [Installation (source)](installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](faq.html)

Getting Started

* [Quickstart (CLI)](quickstart_cli.html)
* Quickstart (API)
* [Downloading test datasets](downloading_test_datasets.html)
* [File validation](file_validation.html)
* [File metadata](file_metadata.html)
* [Format conversion](format_conversion.html)
* [Reading interactions](reading_interactions.html)
* [Creating .cool and .hic files](creating_cool_and_hic_files.html)
* [Creating multi-resolution files (.hic and .mcool)](creating_multires_files.html)
* [Balancing Hi-C matrices](balancing_matrices.html)

How-Tos

* [Reorder chromosomes](tutorials/reordering_chromosomes.html)
* [Dump interactions to .cool or .hic file](tutorials/dump_interactions_to_cool_hic_file.html)

CLI and API Reference

* [CLI Reference](cli_reference.html)
* [C++ API Reference](cpp_api/index.html)[ ]
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](telemetry.html)

Back to top

[View this page](_sources/quickstart_api.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Quickstart (API)[¶](#quickstart-api "Link to this heading")

The C++ library component of hictk, libhictk, can be installed and configured in several ways.

If you are looking for the documentation for the Python or R API, please refer to:

* Python API: [hictkpy.readthedocs.io](https://hictkpy.readthedocs.io/en/stable/index.html)
* R API: [paulsengroup.github.io/hictkR](https://paulsengroup.github.io/hictkR/reference/index.html)

## Installing libhictk[¶](#installing-libhictk "Link to this heading")

### Installing using Conan[¶](#installing-using-conan "Link to this heading")

To install libhictk using Conan, first create a conanfile.txt like the following:

```
[requires]
hictk/2.2.0

[generators]
CMakeDeps

[layout]
cmake_layout
```

Next, install hictk as follows:

```
conan install conanfile.txt --build=missing --output-folder=conan_deps
```

Folder `conan_deps` will contain all CMake module and config files required to include hictk in an application using CMake as build generator.

Finally, add `find_package(hictk REQUIRED)` to your `CMakeLists.txt` and pass the full path to folder `conan_deps` to CMake through the `CMAKE_PREFIX_PATH` variable:

```
cmake -DCMAKE_PREFIX_PATH='/path/to/conan_deps' ... -B build/ -S .
```

For more options and details refer to hictk page on [ConanCenter](https://conan.io/center/recipes/hictk).

### Installing using CMake FetchContent[¶](#installing-using-cmake-fetchcontent "Link to this heading")

Before beginning, please ensure that all of hictk’s dependencies have been installed.
Refer to [conanfile.py](https://github.com/paulsengroup/hictk/blob/main/conanfile.py) for an up-to-date list of hictk dependencies.

To install and configure hictk using [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html), first write a `CMakeLists.txt` file like the following:

```
cmake_minimum_required(VERSION 3.25)

project(myproject LANGUAGES C CXX)

include(FetchContent)
FetchContent_Declare(
  hictk
  GIT_REPOSITORY  "https://github.com/paulsengroup/hictk.git"
  GIT_TAG         v2.2.0
  SYSTEM)

# Customize hictk build flags
set(HICTK_ENABLE_TESTING OFF)
set(HICTK_BUILD_EXAMPLES OFF)
set(HICTK_BUILD_BENCHMARKS OFF)
set(HICTK_BUILD_TOOLS OFF)
set(HICTK_INSTALL OFF)

FetchContent_MakeAvailable(hictk)

add_executable(main main.cpp)
target_link_libraries(main PRIVATE hictk::file)  # Add other targets as necessary
```

### Include hictk source using CMake add\_subdirectory[¶](#include-hictk-source-using-cmake-add-subdirectory "Link to this heading")

Simply add a copy of hictk source code to your source tree (e.g., under folder `myproject/external/hictk`), then add `add_subdirectory("external/hictk")` to your `CMakeLists.txt`.

### A quick tour of libhictk[¶](#a-quick-tour-of-libhictk "Link to this heading")

libhictk is a C++17 header-only library that provides the building blocks required to build complex applications operating on .hic and .cool files.

libhictk public API is organized in 5 main sections:

1. Classes [`cooler::File`](cpp_api/cooler.html#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File"), [`cooler::MultiResFile`](cpp_api/cooler.html#_CPPv4N5hictk6cooler12MultiResFileE "hictk::cooler::MultiResFile") and [`cooler::SingleCellFile`](cpp_api/cooler.html#_CPPv4N5hictk6cooler14SingleCellFileE "hictk::cooler::SingleCellFile"), which can be used to read and write .cool, .mcool and .scool files respectively.
2. Class [`hic::File`](cpp_api/hic.html#_CPPv4N5hictk3hic4FileE "hictk::hic::File") which can be used to read .hic files
3. Class [`File`](cpp_api/generic.html#_CPPv4N5hictk4FileE "hictk::File") which wraps [`cooler::File`](cpp_api/cooler.html#_CPPv4N5hictk6cooler4FileE "hictk::cooler::File") and [`hic::File`](cpp_api/hic.html#_CPPv4N5hictk3hic4FileE "hictk::hic::File") and provides a uniform interface to read .cool and .hic files
4. Various other classes used e.g., to model tables of bins, reference genomes and much more
5. Classes and free-standing functions to perform common operations on files or pixel iterators, such as coarsening and balancing.

The quick tour showcases basic functionality of the generic [`File`](cpp_api/generic.html#_CPPv4N5hictk4FileE "hictk::File") class. For more detailed examples refer to hictk [examples](https://github.com/paulsengroup/hictk/tree/main/examples) and [C++ API Reference](cpp_api/index.html).

```
#include <algorithm>
#include <cstdint>
#include <hictk/file.hpp>
#include <iostream>
#include <string>

int main() {
  // const std::string path = "interactions.cool";
  // const std::string path = "interactions.mcool::/resolutions/1000";
  const std::string path = "interactions.hic";
  const std::uint32_t resolution = 1000;

  const hictk::File f(path, resolution);

  const auto selector = f.fetch("chr1", "chr2");

  std::for_each(selector.template begin<std::int32_t>(), selector.template end<std::int32_t>(),
                [](const hictk::ThinPixel<std::int32_t>& p) {
                  std::cout << p.bin1_id << "\t";
                  std::cout << p.bin2_id << "\t";
                  std::cout << p.count << "\n";
                });
}
```

It is often the case that we need access to more information than just bin IDs and counts.
Joining genomic coordinates to pixel counts can be done as follows:

```
#include <cstdint>
#include <hictk/file.hpp>
#include <hictk/transformers.hpp>
#include <iostream>
#include <string>

int main() {
  const std::string path = "interactions.hic";
  const std::uint32_t resolution = 1000;

  const hictk::File f(path, resolution);

  const auto selector = f.fetch("chr1", "chr2");
  const hictk::transformers::JoinGenomicCoords jselector(
      selector.template begin<std::int32_t>(), selector.template end<std::int32_t>(), f.bins_ptr());

  for (const auto& p : jselector) {
    std::cout << p.coords.bin1.chrom().name() << "\t";
    std::cout << p.coords.bin1.start() << "\t";
    std::cout << p.coords.bin1.end() << "\t";
    std::cout << p.coords.bin2.chrom().name() << "\t";
    std::cout << p.coords.bin2.start() << "\t";
    std::cout << p.coords.bin2.end() << "\t";
    std::cout << p.count << "\n";
  }
}
```

The above examples work just fine.
However, using iterators returned by generic [`PixelSelector`](cpp_api/generic.html#_CPPv4N5hictk13PixelSelectorE "hictk::PixelSelector") is suboptimal. These iterators are implemented using [std::variant](https://en.cppreference.com/w/cpp/utility/variant) and require checking the type of the underlying `PixelSelector` every iteration. The overhead of this check is quite low but still noticeable.

We can avoid paying this overhead by using the format-specific file handles instead of the generic one, or by using [std::visit](https://en.cppreference.com/w/cpp/utility/variant/visit) as follows:

```
#include <algorithm>
#include <cstdint>
#include <hictk/file.hpp>
#include <iostream>
#include <string>
#include <variant>

int main() {
  const std::string path = "interactions.hic";
  const std::uint32_t resolution = 1000;

  const hictk::File f(path, resolution);

  const auto selector = f.fetch("chr1", "chr2");

  // std::visit applies the lambda function provided as first argument
  // to the variant returned by selector.get().
  // In this way, the type held by the std::variant is checked once
  // and the underlying PixelSelector and iterators are used for all operations
  std::visit(
      [&](const auto& sel) {
        std::for_each(sel.template begin<std::int32_t>(), sel.template end<std::int32_t>(),
                      [](const hictk::ThinPixel<std::int32_t>& p) {
                        std::cout << p.bin1_id << "\t";
                        std::cout << p.bin2_id << "\t";
                        std::cout << p.count << "\n";
                      });
      },
      selector.get());
}
```

[Next

Downloading test datasets](downloading_test_datasets.html)
[Previous

Quickstart (CLI)](quickstart_cli.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Quickstart (API)
  + [Installing libhictk](#installing-libhictk)
    - [Installing using Conan](#installing-using-conan)
    - [Installing using CMake FetchContent](#installing-using-cmake-fetchcontent)
    - [Include hictk source using CMake add\_subdirectory](#include-hictk-source-using-cmake-add-subdirectory)
    - [A quick tour of libhictk](#a-quick-tour-of-libhictk)