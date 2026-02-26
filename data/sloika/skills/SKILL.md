---
name: sloika
description: Sloika is a research tool for training and refining recurrent neural network models used in Nanopore basecalling. Use when user asks to train legacy basecalling models, reproduce older research results, or configure Theano-based deep learning pipelines for sequencing data.
homepage: https://github.com/nanoporetech/sloika
---


# sloika

## Overview
Sloika is a specialized research tool developed by Oxford Nanopore Technologies (ONT) for training neural network models used in basecalling. Built on the Theano deep learning library, it allows for the creation and refinement of RNN models specifically tailored to Nanopore sequencing data. While ONT now recommends the "bonito" framework for current basecaller training, sloika remains essential for working with legacy models, reproducing older research results, or maintaining pipelines built on Python 3.4+ and Theano.

## Installation and Environment Setup
Sloika requires specific system dependencies and a controlled Python environment to function correctly due to its reliance on Theano.

### System Dependencies
On Debian-based Linux distributions, install required system packages using the provided Makefile:
```bash
sudo make deps
```

### Development Environment
To ensure a clean environment and avoid dependency conflicts:
1. Create the virtual environment: `make cleanDevEnv`
2. Activate the environment: `source build/env/bin/activate`
3. Run unit tests to verify the installation: `make`

## Theano Configuration for Performance
The performance of sloika is heavily dependent on the `THEANO_FLAGS` environment variable. Proper configuration is required to enable GPU acceleration and optimize memory usage.

### Recommended Training Flags
For standard model training on a GPU, use the following export:
```bash
export THEANO_FLAGS=openmp=True,floatX=float32,warn_float64=warn,optimizer=fast_run,device=gpu0,scan.allow_gc=False,lib.cnmem=0.4
```

### Key Flag Descriptions
- **device**: Set to `gpuX` (e.g., `gpu0`) for hardware acceleration or `cpu` for standard processing.
- **floatX=float32**: Required for most GPU operations to ensure single-precision calculations.
- **lib.cnmem**: Controls GPU memory allocation. Use `0.4` for training (allows two concurrent runs on one GPU) or a smaller value like `0.05` for per-read operations like basecalling.
- **scan.allow_gc=False**: Disables garbage collection during recurrent operations to increase speed at the cost of higher memory consumption.
- **optimizer**: Use `fast_run` for production training. For faster startup during debugging, use `fast_compile`.

## Usage Best Practices
- **Deprecation Warning**: Always check if your task can be accomplished using the newer `bonito` framework before starting a new project in sloika.
- **Precision Monitoring**: Use `warn_float64=warn` or `warn_float64=raise` to detect accidental use of double-precision floats, which can significantly degrade GPU performance.
- **Multi-threading**: Ensure `openmp=True` is set in your flags to utilize multi-core CPUs for operations that cannot be offloaded to the GPU.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_nanoporetech_sloika.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sloika_overview.md)