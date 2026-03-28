|  |
| --- |
| Raptor 4.0.0-rc.1  A fast and space-efficient pre-filter |

Loading...

Searching...

No Matches

Setup

### Table of Contents

* [Download and Installation](#autotoc_md28)
  + [Install with conda and bioconda (Linux)](#autotoc_md29)
  + [Compile from source](#autotoc_md30)
    - [Prerequisites](#autotoc_md31)
    - [Download current main branch](#autotoc_md32)
    - [Download specific version](#autotoc_md33)
    - [Building](#autotoc_md34)

# Download and Installation

There may be performance benefits when compiling from source as the build can be optimized for the host system.

## Install with conda and bioconda (Linux)

conda install -c bioconda -c conda-forge raptor

## Compile from source

### Prerequisites

* CMake >= 3.21
* GCC 12, 13 or 14 (most recent minor version)
* Clang 17 or 18 (most recent minor version)
* git

Refer to the [Seqan3 Setup Tutorial](https://docs.seqan.de/seqan/3-master-user/setup.html) for more in depth information.

### Download current main branch

git clone https://github.com/seqan/raptor

cd raptor

git submodule update --init

### Download specific version

E.g., for version `1.1.0`:

git clone --branch raptor-v1.1.0 --recurse-submodules https://github.com/seqan/raptor

Or from within an existing repository

git checkout raptor-v1.1.0

### Building

cd raptor

mkdir -p build

cd build

cmake ..

make

The binary can be found in `bin`.

You may want to add the Raptor executable to your PATH:

export PATH=$(pwd)/bin:$PATH

raptor --version

By default, Raptor will be built with host specific optimizations (`-march=native`). This behavior can be disabled by passing `-DHIBF_NATIVE_BUILD=OFF` to CMake.

[Hide me](doxygen_crawl.html)

* Version:* * Generated on Mon Mar 23 2026 14:04:40 for Raptor by [![doxygen](doxygen.svg)](https://www.doxygen.org/index.html) 1.10.0