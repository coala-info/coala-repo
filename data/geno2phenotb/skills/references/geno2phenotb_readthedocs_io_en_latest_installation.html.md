latest

* [Overview](readme.html)
* Installation
  + [Bioconda / pip](#bioconda-pip)
  + [Sources](#sources)
* [Command Line Interface](cli.html)
* [Python Interface](api/modules.html)
* [Contributing & Help](contributing.html)
* [Acknowledgments](acknowledgments.html)
* [Authors](authors.html)
* [Release Notes](changelog.html)
* [License](license.html)
* [References](references.html)

[geno2phenoTB](index.html)

* Installation
* [Edit on GitHub](https://github.com/msmdev/geno2phenoTB/blob/main/docs/installation.rst)

---

# Installation[](#installation "Permalink to this heading")

There are several ways to install geno2phenoTB.
Directly from the bioconda channel, from PyPI using pip, or from the sources.

## Bioconda / pip[](#bioconda-pip "Permalink to this heading")

To install geno2phenoTB 1.0.1 and above from the bioconda channel, a clean conda environment is
required:

```
# Required clean environment
conda create -n g2p-tb
conda activate g2p-tb

# Installation
conda install -c bioconda geno2phenoTB
```

**Caution**: geno2phenoTB 1.0.0 is broken on bioconda - so **don’t use it**.

While we recommend to install geno2phenoTB from bioconda, it can be installed using pip as well.
If you prefer to install using pip, you need to make sure that all requirements are fulfilled.
The simplest and recommended way in doing so is to create a conda environment containing all
dependencies (using the conda environment file located in [tests/g2p-test.yaml](https://github.com/msmdev/geno2phenoTB/blob/main/tests/g2p-test.yaml)) before
installing geno2phenoTB via pip:

```
# Required environment with all dependencies
conda env create -f tests/g2p-test.yaml
conda rename -n g2p-test g2p-tb
conda activate g2p-tb

# Installation
pip install geno2phenoTB
```

## Sources[](#sources "Permalink to this heading")

To install geno2phenoTB from the sources you need to:

* Download the repository.
* Install all dependencies into a new conda environment.
  They can be found in [tests/g2p-test.yaml](https://github.com/msmdev/geno2phenoTB/blob/main/tests/g2p-test.yaml).
* Install the module using pip:

```
# Download sources
git clone https://github.com/msmdev/geno2phenoTB
cd geno2phenoTB

# Install dependencies and rename environment
conda env create -f tests/g2p-test.yaml
conda rename -n g2p-test g2p-tb
conda activate g2p-tb

# Install module using pip
pip install .
```

[Previous](readme.html "geno2phenoTB")
[Next](cli.html "Command Line Interface")

---

© Copyright 2023, Bernhard Reuter, Jules Kreuer.
Revision `d0de6e0a`.