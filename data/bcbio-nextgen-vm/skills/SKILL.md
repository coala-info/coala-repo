---
name: bcbio-nextgen-vm
description: bcbio-nextgen-vm is a containerized wrapper that executes complex genomic analysis pipelines using Docker and virtual machines to ensure reproducibility. Use when user asks to install genomic tools and reference data, run local or distributed bioinformatics analyses, or update the bcbio-nextgen software environment.
homepage: https://github.com/chapmanb/bcbio-nextgen-vm
metadata:
  docker_image: "quay.io/biocontainers/bcbio-nextgen-vm:0.1.6--py37_0"
---

# bcbio-nextgen-vm

## Overview

The bcbio-nextgen-vm tool is a specialized wrapper designed to execute complex genomic analysis pipelines while abstracting away the difficulties of software dependency management. By utilizing Docker containers and virtual machines, it ensures that the entire bioinformatics toolset—including aligners, variant callers, and system libraries—is isolated from the host operating system. This approach guarantees that analyses are fully reproducible across different platforms and prevents version conflicts with existing local software.

## Core CLI Operations

### Installation and Setup

The primary entry point is the `bcbio_vm.py` script. Initial setup requires installing the wrapper and then provisioning the necessary containerized tools and genomic data.

- **Install tools and data**: Use the `install` command to download the Docker image and specific reference genomes.
  `bcbio_vm.py --datadir=/path/to/data install --data --tools --genomes GRCh37 --aligners bwa`
- **Configure data defaults**: To avoid specifying the data directory in every command, save the configuration for the current user.
  `bcbio_vm.py --datadir=/path/to/data saveconfig`

### Running Analyses

The command structure mirrors the standard `bcbio_nextgen.py` but routes execution through the container.

- **Local execution**: Run a pipeline using a specified number of cores.
  `bcbio_vm.py run -n 8 sample_config.yaml`
- **Distributed execution**: Use IPython parallel to scale across a cluster (e.g., using Torque or SGE).
  `bcbio_vm.py ipython sample_config.yaml torque your_queue -n 64`

### Maintenance and Upgrades

The tool allows for modular updates of the wrapper, the underlying software containers, and the biological data.

- **Update wrapper code**: `bcbio_vm.py install --wrapper`
- **Update software tools**: `bcbio_vm.py install --tools` (This pulls the latest Docker image)
- **Update genomic data**: `bcbio_vm.py install --data`

## Expert Tips and Best Practices

- **Permissions**: On Linux, ensure the `bcbio_vm.py` script has the setgid bit set to the `docker` group. This allows non-root users to execute the pipeline safely while the script handles input sanitization.
- **Storage Management**: Genomic data and Docker images are large. Always verify available disk space at the `--datadir` location before initiating a `--data` or `--tools` install.
- **Existing Data**: If you have a local installation of bcbio-nextgen data, you can avoid redundant downloads by symlinking the `genomes` and `gemini_data` directories into your `bcbio-vm` data directory.
- **Platform Limitations**: While AWS usage is supported on macOS, local Docker execution is primarily optimized for Linux. For macOS users, running via a Vagrant-managed virtual machine is the recommended path for local development.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_bcbio_bcbio-nextgen-vm.md)
- [bcbio-nextgen-vm Wiki](./references/github_com_bcbio_bcbio-nextgen-vm_wiki.md)