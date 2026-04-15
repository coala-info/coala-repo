[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[SnapATAC2](index.html)

Choose version

* Installation
* [Tutorials](tutorials/index.html)
* [API reference](api/index.html)
* [Development](develop.html)
* [Release notes](changelog.html)
* [Learn](https://kzhang.org/epigenomics-analysis/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/scverse/SnapATAC2 "GitHub")

Search
`Ctrl`+`K`

Choose version

* Installation
* [Tutorials](tutorials/index.html)
* [API reference](api/index.html)
* [Development](develop.html)
* [Release notes](changelog.html)
* [Learn](https://kzhang.org/epigenomics-analysis/)

* [GitHub](https://github.com/scverse/SnapATAC2 "GitHub")

Section Navigation

* Installation

# Installation[#](#installation "Link to this heading")

## Stable version[#](#stable-version "Link to this heading")

Stable versions of SnapATAC2 are published on PyPI.
Precompiled binaries are available for x86\_64 Linux systems and macOS.
So installing it is as simple as running:

```
pip install snapatac2
```

If there are no precompiled binaries published for your system, you will have to
build the package from source.
Building the SnapATAC2 library requires `cmake >= 3.5.1` and
the [Rust](https://www.rust-lang.org/tools/install) compiler. You need to install
them first if they are not available on your system.
You can find the instructions for installing cmake [here](https://cmake.org/install/).
The Rust compiler can be installed using:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Once you have cmake and the Rust compiler properly installed,
running `pip install snapatac2` will build SnapATAC2 from the source package and
install it just as it would if there was a prebuilt binary available.

## Nightly build[#](#nightly-build "Link to this heading")

The nightly build is the build from the latest source codes, which includes the
latest features, enhancements, and bug fixes that haven’t been released.
The nightly build can be unstable and include some untested features.

The [nightly release](https://github.com/scverse/SnapATAC2/releases/tag/nightly) page
contains wheel files for the nightly build.
Please download the corresponding wheel file for your platform and use `pip install` to install it.
For example, if you are using a Linux system with Python 3.8, you can use the following command to install it:

```
pip install snapatac2-x.x.x-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
```

## Build from the latest source code[#](#build-from-the-latest-source-code "Link to this heading")

Building the SnapATAC2 library requires `cmake >= 3.5.1` and
the [Rust](https://www.rust-lang.org/tools/install) compiler. You need to install
them first if they are not available on your system.
You can find the instructions for installing cmake [here](https://cmake.org/install/).
The Rust compiler can be installed using:

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Once you have the Rust compiler properly installed, you can use pip to install the SnapATAC2 library:

```
pip install 'git+https://github.com/scverse/SnapATAC2.git#egg=snapatac2'
```

## Optional dependencies[#](#optional-dependencies "Link to this heading")

`pip install snapatac2` installs the essential dependencies needed for SnapATAC2.
For certain features, however, additional optional dependencies are necessary:

* harmonypy: For the `snapatac2.pp.harmony` function.
* scanorama: For the `snapatac2.pp.scanorama_integrate` function.
* xgboot: For network structure inference.

To install these optional dependencies, use `pip install snapatac2[recommend]`.

[previous

SnapATAC2: A Python/Rust package for single-cell epigenomics analysis](index.html "previous page")
[next

Tutorials](tutorials/index.html "next page")

On this page

* [Stable version](#stable-version)
* [Nightly build](#nightly-build)
* [Build from the latest source code](#build-from-the-latest-source-code)
* [Optional dependencies](#optional-dependencies)

© Copyright 2022-2025, Kai Zhang.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.