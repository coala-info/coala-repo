---
name: setuptools_cython
description: This tool facilitates the packaging and distribution of Cython-based projects using modern setuptools workflows. Use when user asks to compile extensions in-place, build and install Cython packages, create source distributions, or configure complex build requirements like OpenMP support and AST-based versioning.
homepage: https://github.com/Technologicat/setup-template-cython
metadata:
  docker_image: "quay.io/biocontainers/setuptools_cython:0.2.1--py27_1"
---

# setuptools_cython

## Overview
This skill facilitates the packaging and distribution of Cython-based projects using `setuptools`. While Cython's official documentation often references the legacy `distutils`, this skill focuses on modern `setuptools` workflows which provide better dependency resolution and PyPI compatibility. It covers the creation of robust `setup.py` files that handle complex requirements like OpenMP support, AST-based versioning to avoid premature imports, and proper data file inclusion.

## Core CLI Patterns

Execute these commands from the project root where `setup.py` is located:

- **Compile Extensions In-Place**: Useful for development and testing without a full install.
  `python setup.py build_ext --inplace`
- **Standard Build**: Compiles extensions and prepares Python modules in the `build/` directory.
  `python setup.py build`
- **Install Package**: Builds and installs the package to the current environment.
  `python setup.py install`
- **User-Level Install**: Install without requiring administrative privileges.
  `python setup.py install --user`
- **Create Source Distribution**: Generates a `.tar.gz` archive for distribution.
  `python setup.py sdist`
- **Uninstall**: Since `setuptools` does not have a native uninstall command, use `pip`.
  `pip uninstall <package_name>`

## Expert Tips and Best Practices

### 1. Disable Zip Safety
Always set `zip_safe=False` in `setup()`. Cython cannot see `.pxd` headers inside installed `.egg` zip files, which prevents other libraries from `cimporting` your modules. Additionally, the OS dynamic loader typically requires unzipping `.so` files to a temporary directory anyway.

### 2. AST-Based Versioning
To follow DRY (Don't Repeat Yourself) principles without causing import errors during installation, use the `ast` module to parse `__version__` from your package's `__init__.py`. This avoids importing the package before its dependencies or extensions are built.

### 3. Compiler and Linker Flags
For scientific or numerical projects, optimize performance by configuring `Extension` objects with specific flags:
- **Math Optimization**: Use flags appropriate for your architecture (e.g., `-O3`, `-ffast-math`).
- **OpenMP Support**: To use `cython.parallel`, include `/openmp` (Windows/MSVC) or `-fopenmp` (Linux/GCC) in both `extra_compile_args` and `extra_link_args`.

### 4. Handling Data Files
- **Package Data**: Use the `package_data` keyword in `setup()` for files inside your Python packages (e.g., `.pxd` files, configuration).
- **Non-Package Data**: Use the `data_files` keyword for external files like documentation or examples. Note that `setuptools` handles these differently than `distutils`; ensure they are explicitly tracked in `MANIFEST.in` if they must be included in the source distribution.

### 5. Absolute Imports
For compatibility between Python 2.7 and 3.x in Cython projects, ensure `from __future__ import absolute_import` is used. This is critical for complex subpackage structures where Cython might otherwise struggle with name resolution.

## Reference documentation
- [Setuptools-based setup.py template for Cython projects](./references/github_com_Technologicat_setup-template-cython.md)