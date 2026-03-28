[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

PANORAMA just released!

[![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)
![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)

PANORAMA](../index.html)

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* More
  + [PANORAMA](https://github.com/labgem/PANORAMA)
  + [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
  + [LABGeM](https://labgem.genoscope.cns.fr/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Search
`Ctrl`+`K`

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* [PANORAMA](https://github.com/labgem/PANORAMA)
* [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
* [LABGeM](https://labgem.genoscope.cns.fr/)

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Section Navigation

Get Started:

* Installation Guide 🦮
* [Quick usage 🦅](quick_usage.html)
  + [Complete Biological Systems Prediction Workflow](pansystems.html)
  + [Pangenome Comparison Analysis](quick_compare.html)
* [Reporting Issues and Suggesting Features 💬](issues.html)

Biological system Prediction:

* [Gene Family annotation](annotation.html)
* [System Detection Based on Models](detection.html)
* [Systems analysis output 📊](write_systems.html)
  + [System Projection on Genomes](projection.html)
  + [System Association with Pangenome Elements](association.html)
  + [System Partition Analysis](partition.html)

Pangenomes comparison:

* [Conserved Spots Comparison Across Pangenomes](compare_spots.html)
* [Systems Comparison Across Pangenomes](compare_systems.html)

PANORAMA utilities:

* [Extract and Visualize Pangenome Information ℹ️](info.html)
* [Gene Family Alignment Across Pangenomes](align.html)
* [Gene Family Clustering Across Pangenomes](clustering.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* Installation Guide 🦮

# Installation Guide 🦮[#](#installation-guide "Link to this heading")

Important

Supported Python versions are 3.10, 3.11 and 3.12

## Latest version[#](#latest-version "Link to this heading")

### Installation via Conda (recommended) 🐍[#](#installation-via-conda-recommended "Link to this heading")

The recommended way to install PANORAMA is via [Conda](https://docs.conda.io/en/latest/miniconda.html)
from the [Bioconda](https://bioconda.github.io/) channel.
We recommend creating a new Conda environment for PANORAMA to prevent any conflicts with other packages.

```
# Create a new Conda environment and install PANORAMA in one line:
conda create -n panorama -c conda-forge -c bioconda panorama

# Activate the environment
conda activate panorama

# Check the install
panorama --version
```

If you want to use a specific version of PANORAMA, you can install it with:

```
# X.X.X is the version number
conda create -n panorama -c conda-forge -c bioconda panorama==X.X.X
```

To use a specific python version:

```
# X.X.X is the version number
conda create -n panorama -c conda-forge -c bioconda panorama python=X.X
```

---

### Installing from source code (GitHub) 🐙[#](#installing-from-source-code-github "Link to this heading")

#### Within a Conda environment 🐍[#](#within-a-conda-environment "Link to this heading")

##### 1. Clone the GitHub Repository[#](#clone-the-github-repository "Link to this heading")

```
git clone https://github.com/labgem/PANORAMA.git
cd PANORAMA
```

##### 2. Create and Configure the Conda Environment[#](#create-and-configure-the-conda-environment "Link to this heading")

```
conda create -n panorama
conda config --add channels bioconda
conda config --add channels conda-forge
conda env update -n panorama --file panorama.yml
conda activate panorama
```

Alternatively, in one line:

```
conda env create -f panorama.yml # -n panorama ## if you want to name the environment differently
conda activate panorama
```

##### 3. Install PANORAMA[#](#install-panorama "Link to this heading")

```
pip install .
```

##### 4. Test the Installation[#](#test-the-installation "Link to this heading")

```
panorama --help
panorama --version
```

#### Manual Installation (without Conda) 🛠️[#](#manual-installation-without-conda "Link to this heading")

Important

PANOARMA requires Python 3.10 or higher.

##### 1. Clone the Repository[#](#clone-the-repository "Link to this heading")

```
git clone https://github.com/labgem/PANORAMA.git
cd PANORAMA
```

##### 2. Install PANORAMA Dependencies[#](#install-panorama-dependencies "Link to this heading")

Install **MMSeqs2 (≥ 13.45111)** manually:

* With [Homebrew](https://github.com/Homebrew/brew): `brew install mmseqs2`
* On Debian-based systems: `sudo apt install mmseqs2`

Note

Here is the complete installation guide of MMSeqs2:
[soedinglab/MMseqs2](https://github.com/soedinglab/MMseqs2/wiki#installation)

##### 3. Install PANORAMA and Python Dependencies[#](#install-panorama-and-python-dependencies "Link to this heading")

Dependencies are declared in the `pyproject.toml` file:

```
pip install --upgrade pip setuptools build wheel
pip install .
```

Warning

geckodriver is not compatible with pip, so the feature that generate png image from bokeh is not supported.

---

## Development Version[#](#development-version "Link to this heading")

### 1. Get the Development branch[#](#get-the-development-branch "Link to this heading")

To clone the `dev` Branch

```
git clone --branch dev https://github.com/labgem/PANORAMA.git
```

### 2. Install Dependencies[#](#install-dependencies "Link to this heading")

Follow the same steps as in the standard installation.
With a [conda environment](#with-conda-env) or with a [manual installation](#manual-installation-without-conda).

### 3. Install the Development Version[#](#install-the-development-version "Link to this heading")

```
pip install .
```

---

## Troubleshooting[#](#troubleshooting "Link to this heading")

If you encounter any problems, please check the known issues below.
If you still can’t solve your problem, please [open an issue on GitHub](https://github.com/labgem/PANORAMA/issues).

[previous

User Documentation](user_guide.html "previous page")
[next

Quick usage 🦅](quick_usage.html "next page")

On this page

* [Latest version](#latest-version)
  + [Installation via Conda (recommended) 🐍](#installation-via-conda-recommended)
  + [Installing from source code (GitHub) 🐙](#installing-from-source-code-github)
    - [Within a Conda environment 🐍](#within-a-conda-environment)
      * [1. Clone the GitHub Repository](#clone-the-github-repository)
      * [2. Create and Configure the Conda Environment](#create-and-configure-the-conda-environment)
      * [3. Install PANORAMA](#install-panorama)
      * [4. Test the Installation](#test-the-installation)
    - [Manual Installation (without Conda) 🛠️](#manual-installation-without-conda)
      * [1. Clone the Repository](#clone-the-repository)
      * [2. Install PANORAMA Dependencies](#install-panorama-dependencies)
      * [3. Install PANORAMA and Python Dependencies](#install-panorama-and-python-dependencies)
* [Development Version](#development-version)
  + [1. Get the Development branch](#get-the-development-branch)
  + [2. Install Dependencies](#install-dependencies)
  + [3. Install the Development Version](#install-the-development-version)
* [Troubleshooting](#troubleshooting)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/install.md)

### This Page

* [Show Source](../_sources/user/install.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.