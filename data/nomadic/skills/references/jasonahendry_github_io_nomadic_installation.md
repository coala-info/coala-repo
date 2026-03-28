[ ]
[ ]

[Skip to content](#compatibility)

[![logo](../img/little_logo.svg)](.. "Nomadic")

Nomadic

Installation

Initializing search

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

[![logo](../img/little_logo.svg)](.. "Nomadic")
Nomadic

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

* [Overview](..)
* [ ]

  Installation

  [Installation](./)

  Table of contents
  + [Compatibility](#compatibility)
  + [Requirements](#requirements)
  + [Steps](#steps)
  + [Test installation](#test-installation)
  + [Update nomadic](#update-nomadic)
* [ ]

  Usage

  Usage
  + [Quick Start](../quick_start/)
  + [Basic Usage](../basic/)
  + [Sharing and Backing up](../share_backup/)
  + [Advanced Usage](../advanced/)
* [Understanding the Dashboard](../understand/)
* [Output Files](../output_files/)
* [FAQ](../faq/)

Table of contents

* [Compatibility](#compatibility)
* [Requirements](#requirements)
* [Steps](#steps)
* [Test installation](#test-installation)
* [Update nomadic](#update-nomadic)

# Installation

### Compatibility

*Nomadic* runs on macOS or Linux. Windows is currently not supported.

### Requirements

To install *Nomadic*, you will need to install the package manager [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) or [mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html). *Mamba* is faster and is recommended.

To install *Mamba*, run:

```
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

or

```
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
```

Then run the script with:

```
bash Miniforge3-$(uname)-$(uname -m).sh
```

### Steps

Open a terminal window and type:

```
conda create -c bioconda -n nomadic nomadic
```

Or, if you are using *Mamba*:

```
mamba create -c bioconda -n nomadic nomadic
```

*Nomadic* should now be installed in it's own conda environment.

### Test installation

To test the installation, we will enter the conda environment:

```
conda activate nomadic
```

Then type:

```
nomadic --help
```

If `nomadic` has been installed successfully, you should see a set of available commands:

```
Usage: nomadic [OPTIONS] COMMAND [ARGS]...

  Mobile sequencing and analysis in real-time

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  start      Start a workspace.
  download   Download reference genomes.
  realtime   Run analysis in real-time.
  dashboard  Just run the dashboard.
```

### Update nomadic

To update *Nomadic* to the newest version, activate your conda environment, and then update nomadic as follows:

```
conda activate nomadic
conda update nomadic
```

You can check your installed version with

```
nomadic --version
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)