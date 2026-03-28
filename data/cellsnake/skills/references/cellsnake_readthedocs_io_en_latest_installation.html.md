[Skip to main content](#main-content)
[ ]

[ ]

`Ctrl`+`K`

[![Logo image](_static/cellsnake-logo-blue-small.png)](index.html)

Getting Started

* Installation
* [Quick start example](quickstart.html)
* [Example run on Fetal Brain dataset](fetalbrain.html)
* [Example run on Fetal Liver dataset](fetalliver.html)
* [Metagenomics analysis](kraken.html)
* [How to draw marker plots](markers.html)
* [Config Files (Parameter Files)](configs.html)
* [Options and Arguments](options.html)
* [Downstream analysis](downstream.html)
* [Glossary](glossary.html)

* [.rst](_sources/installation.rst "Download source file")
* .pdf

# Installation

## Contents

* [How to use the Docker Image](#how-to-use-the-docker-image)
* [How to request higher memory and CPUs?](#how-to-request-higher-memory-and-cpus)

# Installation[#](#installation "Permalink to this headline")

To install this package with conda run:

```
conda install cellsnake -c bioconda -c conda-forge
```

You may want to install Mamba first, which will reduce installation time.

To install this package with Mamba run:

```
conda install mamba -c conda-forge
mamba install cellsnake -c bioconda -c conda-forge
```

```
#to install on Apple Silicon computers (M1 or newer)
conda install mamba -c conda-forge
CONDA_SUBDIR=osx-64 mamba create -n cellsnake -c bioconda -c conda-forge cellsnake
```

Check if the installation works by calling the main script.

```
cellsnake --help
```

then install and check if all the R packages are installed by typing:

```
cellsnake --install-packages
```

You should see this message if all the packages are available:

```
[1] "All packages were installed...OK"
```

Note: If installation of any R packages fail, you have to install them manually!

## How to use the Docker Image[#](#how-to-use-the-docker-image "Permalink to this headline")

Cellsnake has an official Docker image, located here: <https://hub.docker.com/r/sinanugur/cellsnake>

You can pull the latest build:

```
docker pull sinanugur/cellsnake:latest
```

You can start a standard run:

```
docker run -it --rm -v $PWD:/app sinanugur/cellsnake:latest cellsnake standard data
```

or you can also use Podman as well, Podman is useful when you are using on HPC platforms without admin access.

```
podman run -it --rm -v $PWD:/app sinanugur/cellsnake:latest cellsnake standard data
```

Note

It is not possible to run cellsnake natively on Apple Silicon (M1 or newer) for now. For example, Kraken2 is not compatible with this architecture and our Docker image is therefore AMD64-based. It is however possible to run without a Docker container using the Bioconda package. Yet still it has to be forced to use Osx-64 architecture and all the dependencies can be resolved. This offers a faster experience than Docker container for Apple laptops.

## How to request higher memory and CPUs?[#](#how-to-request-higher-memory-and-cpus "Permalink to this headline")

```
#for example request 5 CPUs and 20g ram
docker run -m 20g --cpus 5 -it --rm -v $PWD:/app sinanugur/cellsnake:latest cellsnake standard data --jobs 5
```

[previous

Welcome to **Cellsnake**’s Documentation!](index.html "previous page")
[next

Quick start example](quickstart.html "next page")

Contents

* [How to use the Docker Image](#how-to-use-the-docker-image)
* [How to request higher memory and CPUs?](#how-to-request-higher-memory-and-cpus)

By Sinan U. Umu

© Copyright 2023, Sinan U. Umu.