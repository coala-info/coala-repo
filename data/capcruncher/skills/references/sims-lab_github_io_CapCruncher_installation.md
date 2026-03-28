[ ]
[ ]

[Skip to content](#installation)

CapCruncher Documentation

Installation

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [Home](..)
* [ ]

  Installation

  [Installation](./)

  Table of contents
  + [Setup](#setup)
  + [Dependencies](#dependencies)

    - [Install all dependencies using conda](#install-all-dependencies-using-conda)

      * [Direct Installation](#direct-installation)
      * [Two-step installation using conda and pip](#two-step-installation-using-conda-and-pip)
    - [Install CapCruncher in a minimal conda environment and use singularity to run the pipeline](#install-capcruncher-in-a-minimal-conda-environment-and-use-singularity-to-run-the-pipeline)
  + [Manual Installation (Not Recommended)](#manual-installation-not-recommended)

    - [Install Dependencies](#install-dependencies)
    - [Install CapCruncher from GitHub](#install-capcruncher-from-github)
  + [Detailed Conda Installation Instructions](#detailed-conda-installation-instructions)

    - [Download and run the installer for your system (only Linux is supported at the moment)](#download-and-run-the-installer-for-your-system-only-linux-is-supported-at-the-moment)
    - [Initialise MambaForge in your shell](#initialise-mambaforge-in-your-shell)
    - [Refresh your shell](#refresh-your-shell)
    - [Setup conda channels](#setup-conda-channels)
* [Pipeline](../pipeline/)
* [Cluster Setup](../cluster_config/)
* [Hints and Tips](../tips/)
* [Plotting CapCruncher output](../plotting/)
* [CLI Reference](../cli/)
* [ ]

  API Reference

  API Reference
  + [ ]

    capcruncher

    capcruncher
    - [ ]

      api

      api
      * [annotate](../reference/capcruncher/api/annotate/)
      * [deduplicate](../reference/capcruncher/api/deduplicate/)
      * [filter](../reference/capcruncher/api/filter/)
      * [io](../reference/capcruncher/api/io/)
      * [pileup](../reference/capcruncher/api/pileup/)
      * [plotting](../reference/capcruncher/api/plotting/)
      * [statistics](../reference/capcruncher/api/statistics/)
      * [storage](../reference/capcruncher/api/storage/)

Table of contents

* [Setup](#setup)
* [Dependencies](#dependencies)

  + [Install all dependencies using conda](#install-all-dependencies-using-conda)

    - [Direct Installation](#direct-installation)
    - [Two-step installation using conda and pip](#two-step-installation-using-conda-and-pip)
  + [Install CapCruncher in a minimal conda environment and use singularity to run the pipeline](#install-capcruncher-in-a-minimal-conda-environment-and-use-singularity-to-run-the-pipeline)
* [Manual Installation (Not Recommended)](#manual-installation-not-recommended)

  + [Install Dependencies](#install-dependencies)
  + [Install CapCruncher from GitHub](#install-capcruncher-from-github)
* [Detailed Conda Installation Instructions](#detailed-conda-installation-instructions)

  + [Download and run the installer for your system (only Linux is supported at the moment)](#download-and-run-the-installer-for-your-system-only-linux-is-supported-at-the-moment)
  + [Initialise MambaForge in your shell](#initialise-mambaforge-in-your-shell)
  + [Refresh your shell](#refresh-your-shell)
  + [Setup conda channels](#setup-conda-channels)

# Installation[¶](#installation "Permanent link")

Warning

CapCruncher is currently only availible for linux. MacOS support is planned for the future.

## Setup[¶](#setup "Permanent link")

It is highly recommended to install CapCruncher in a conda environment. If you do not have conda installed, see the detailed [conda installation section](#detailed-conda-installation).

## Dependencies[¶](#dependencies "Permanent link")

There are two main ways to obtain the dependencies required to run CapCruncher:

### Install all dependencies using conda[¶](#install-all-dependencies-using-conda "Permanent link")

#### Direct Installation[¶](#direct-installation "Permanent link")

The easiest way to install these dependencies is to use conda. Run the following command to install CapCruncher and all dependencies:

```
mamba install -c bioconda capcruncher
```

Warning

The latest version of CapCruncher is not yet available on conda. Please install the latest version from PyPI using the command below.

#### Two-step installation using conda and pip[¶](#two-step-installation-using-conda-and-pip "Permanent link")

Alternatively, create a new conda environment and install CapCruncher using pip (currently the recommended method):

```
wget https://raw.githubusercontent.com/sims-lab/CapCruncher/master/environment.yml
conda env create -f environment.yml
conda activate cc

# Install CapCruncher using pip
pip install capcruncher
s
# Optional - highly recommended to install the optional dependencies
# Installs dependencies for:
# * plotting,
# * differential interaction analysis
# * speeding up the pipeline using experimental features (capcruncher-tools)
pip install capcruncher[full]
```

### Install CapCruncher in a minimal conda environment and use singularity to run the pipeline[¶](#install-capcruncher-in-a-minimal-conda-environment-and-use-singularity-to-run-the-pipeline "Permanent link")

Note

Singularity must be installed on your system to use this method. See the [pipeline guide](../pipeline/) for more information. The pipeline will only function correctly if using the --use-singularity option. This is because the pipeline uses singularity containers to run the pipeline steps. See the [pipeline guide](../pipeline/) for more information.

Create a minimal conda environment and install CapCruncher using pip:

```
mamba create -n cc "python>=3.10"
conda activate cc
# Optional - highly recommended to install the optional dependencies
pip install capcruncher[stats,plotting,experimental]
```

## Manual Installation (Not Recommended)[¶](#manual-installation-not-recommended "Permanent link")

### Install Dependencies[¶](#install-dependencies "Permanent link")

See the dependencies in the [environment.yml](https://raw.githubusercontent.com/sims-lab/CapCruncher/master/environment.yml) and [requirements.txt](https://raw.githubusercontent.com/sims-lab/CapCruncher/master/requirements.txt) files. All dependencies can be installed using conda or pip.

### Install CapCruncher from GitHub[¶](#install-capcruncher-from-github "Permanent link")

Clone the repository and install CapCruncher using pip:

```
git clone https://github.com/sims-lab/CapCruncher.git
cd CapCruncher
pip install .

# Optional - highly recommended to install the optional dependencies
pip install .[stats,plotting,experimental]
```

## Detailed Conda Installation Instructions[¶](#detailed-conda-installation-instructions "Permanent link")

Download and install MambaForge from [here](https://github.com/conda-forge/miniforge#mambaforge) for your system (You will typically need the x86\_64 version for most Linux systems).

### Download and run the installer for your system (only Linux is supported at the moment)[¶](#download-and-run-the-installer-for-your-system-only-linux-is-supported-at-the-moment "Permanent link")

```
# Download the installer for your system
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh

# Allow the installer to be executed
chmod +x Mambaforge-Linux-x86_64.sh

# Run the installer
./Mambaforge-Linux-x86_64.sh
```

Follow the instructions to install MambaForge. It is advised to install MambaForge in a location with a reasonable amount of free space (>2GB) as it will be used to install all dependencies for CapCruncher.

### Initialise MambaForge in your shell[¶](#initialise-mambaforge-in-your-shell "Permanent link")

```
conda init bash
```

### Refresh your shell[¶](#refresh-your-shell "Permanent link")

```
source ~/.bashrc
```

### Setup conda channels[¶](#setup-conda-channels "Permanent link")

```
conda config --set channel_priority strict
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

Now the installation installation of CapCruncher can be completed using the instructions [above](#dependencies).

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)