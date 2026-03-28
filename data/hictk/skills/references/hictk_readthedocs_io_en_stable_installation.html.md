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

* Installation
* [Installation (source)](installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](faq.html)

Getting Started

* [Quickstart (CLI)](quickstart_cli.html)
* [Quickstart (API)](quickstart_api.html)
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

[View this page](_sources/installation.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Installation[¶](#installation "Link to this heading")

## Conda (bioconda)[¶](#conda-bioconda "Link to this heading")

The hictk package for Linux and macOS is available on bioconda and can be installed as follows:

```
user@dev:/tmp$ conda create -n hictk -c conda-forge -c bioconda hictk

user@dev:/tmp$ conda activate hictk

(hictk) user@dev:/tmp$ whereis hictk
hictk: /home/user/.miniconda3/envs/hictk/bin/hictk

(hictk) user@dev:/tmp$ hictk --version
hictk-v2.2.0-bioconda
```

## Containers (Docker or Singularity/Apptainer)[¶](#containers-docker-or-singularity-apptainer "Link to this heading")

First, ensure you have followed the instructions on how to install Docker or Singularity/Apptainer on your OS.

Installing Docker

The following instructions assume you have root/admin permissions.

* [Linux](https://docs.docker.com/desktop/install/linux-install/)
* [macOS](https://docs.docker.com/desktop/install/mac-install/)
* [Windows](https://docs.docker.com/desktop/install/windows-install/)

On some Linux distributions, simply installing Docker is not enough.
You also need to start (and optionally enable) the appropriate service(s).
This is usually done with one of the following:

```
sudo systemctl start docker
sudo systemctl start docker.service
```

Refer to [Docker](https://docs.docker.com/engine/install/) or your OS/distribution documentation for more details.

### Pulling hictk Docker image[¶](#pulling-hictk-docker-image "Link to this heading")

hictk Docker images are available on [GHCR.io](https://github.com/paulsengroup/hictk/pkgs/container/hictk)
and [DockerHub](https://hub.docker.com/r/paulsengroup/hictk).

Downloading and running the latest stable release can be done as follows:

```
# Using Docker, may require sudo
user@dev:/tmp$ docker run ghcr.io/paulsengroup/hictk:2.2.0 --help

# Using Singularity/Apptainer
user@dev:/tmp$ singularity run ghcr.io/paulsengroup/hictk:2.2.0 --help

Blazing fast tools to work with .hic and .cool files.
Usage: hictk [OPTIONS] SUBCOMMAND
Options:
  -h,--help                   Print this help message and exit
  -V,--version                Display program version information and exit
Subcommands:
  balance                     Balance Hi-C files using ICE, SCALE, or VC.
  convert                     Convert Hi-C files between different formats.
  dump                        Read interactions and other kinds of data from .hic and Cooler files and write them to stdout.
  fix-mcool                   Fix corrupted .mcool files.
  load                        Build .cool and .hic files from interactions in various text formats.
  merge                       Merge multiple Cooler or .hic files into a single file.
  metadata                    Print file metadata to stdout.
  rename-chromosomes, rename-chroms
                              Rename chromosomes found in Cooler files.
  validate                    Validate .hic and Cooler files.
  zoomify                     Convert single-resolution Cooler and .hic files to multi-resolution by coarsening.
```

The above will print hictk’s help message, and is equivalent to running `hictk --help` from the command line (assuming hictk is available on your machine).

## Installing from source[¶](#installing-from-source "Link to this heading")

Please refer to hictk’s [build instructions](installation_src.html).

[Next

Installation (source)](installation_src.html)
[Previous

Home](index.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Installation
  + [Conda (bioconda)](#conda-bioconda)
  + [Containers (Docker or Singularity/Apptainer)](#containers-docker-or-singularity-apptainer)
    - [Pulling hictk Docker image](#pulling-hictk-docker-image)
  + [Installing from source](#installing-from-source)