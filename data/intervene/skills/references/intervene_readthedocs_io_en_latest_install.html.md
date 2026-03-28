[Intervene](index.html)

latest

Table of contents

* [Introduction](introduction.html)
* Installation
  + [Quick installation](#quick-installation)
    - [Install uisng Conda](#install-uisng-conda)
    - [Install using pip](#install-using-pip)
  + [Prerequisites](#prerequisites)
    - [Install BEDTools](#install-bedtools)
    - [Install required R packages](#install-required-r-packages)
  + [Install Intervene from source](#install-intervene-from-source)
    - [Install development version from Bitbucket](#install-development-version-from-bitbucket)
    - [Install development version from GitHub](#install-development-version-from-github)
* [How to use Intervene](how_to_use.html)
* [Intervene modules](modules.html)
* [Example gallery](examples.html)
* [Interactive Shiny App](shinyapp.html)
* [Support](support.html)
* [Citation](cite.html)
* [Changelog](changelog.html)

[Intervene](index.html)

* [Docs](index.html) »
* Installation
* [Edit on GitHub](https://github.com/asntech/intervene/blob/master/docs/install.rst)

---

# Installation[¶](#installation "Permalink to this headline")

Intervene is available on [PyPi](https://pypi.python.org/pypi/intervene), through [Bioconda](https://bioconda.github.io/recipes/intervene/README.html), and source code available on [GitHub](https://github.com/asntech/intervene) and [Bitbucket](https://bitbucket.org/CBGR/intervene). Intervene takes care of the installation of all the required Python modules. If you already have a working installation of Python, the easiest way to install the required Python modules is by installing Intervene using `pip`.

If you’re setting up Python for the first time, we recommend to install it using the [Conda or Miniconda Python distribution](https://conda.io/docs/user-guide/install/index.html). This comes with several helpful scientific and data processing libraries, and available for platforms including Windows, Mac OSX and Linux.

You can use one of the following ways to install Intervene.

## Quick installation[¶](#quick-installation "Permalink to this headline")

### Install uisng Conda[¶](#install-uisng-conda "Permalink to this headline")

We highly recommend to install Intervene using Conda, this will take care of the dependencies. If you already have Conda or Miniconda installed, go ahead and use the below command.

```
conda install -c bioconda intervene
```

Note

This will install all the dependencies and you are ready to use **Intervene**.

### Install using pip[¶](#install-using-pip "Permalink to this headline")

You can install Intervene from PyPi using pip.

```
pip install intervene
```

Note

If you install using pip, make sure to install BEDTools and R packages listed below.

## Prerequisites[¶](#prerequisites "Permalink to this headline")

Intervene requires the following Python modules and R packages:

> * Python (=> 2.7 ): <https://www.python.org/>
> * BEDTools (Latest version): <https://github.com/arq5x/bedtools2>
> * pybedtools (>= 0.7.9): <https://daler.github.io/pybedtools/>
> * Pandas (>= 0.16.0): <http://pandas.pydata.org/>
> * Seaborn (>= 0.7.1): <http://seaborn.pydata.org/>
> * R (>= 3.0): <https://www.r-project.org/>
> * R packages including UpSetR, corrplot

### Install BEDTools[¶](#install-bedtools "Permalink to this headline")

Intervene is using [pybedtools](https://daler.github.io/pybedtools/main.html), which is a Python wrapper for the BEDTools. BEDTools should be installed before using Intervene. It is recomended to have the latest version of the tool. Please read the installation instructions at <https://github.com/arq5x/bedtools2> to install BEDTools, and make sure it is accessible through your PATH variable.

### Install required R packages[¶](#install-required-r-packages "Permalink to this headline")

Intervene rquires three R packages, [UpSetR](https://cran.r-project.org/package%3DUpSetR) , [corrplot](https://cran.r-project.org/package%3Dcorrplot) for visualization and [Cairo](https://cran.r-project.org/package%3DCairo) to generate high-quality vector and bitmap figures. To install these, open R/RStudio and use the following command.

```
install.packages(c("UpSetR", "corrplot","Cairo"))
```

## Install Intervene from source[¶](#install-intervene-from-source "Permalink to this headline")

You can install a development version by using `git` from our bitbucket repository at <https://bitbucket.org/CBGR/intervene> or Github.

### Install development version from Bitbucket[¶](#install-development-version-from-bitbucket "Permalink to this headline")

If you have git installed, use this:

```
git clone https://bitbucket.org/CBGR/intervene.git
cd intervene
python setup.py sdist install
```

### Install development version from GitHub[¶](#install-development-version-from-github "Permalink to this headline")

If you have git installed, use this:

```
git clone https://github.com/asntech/intervene.git
cd intervene
python setup.py sdist install
```

[Next](how_to_use.html "How to use Intervene")
 [Previous](introduction.html "Introduction")

---

© Copyright 2017, Aziz Khan.
Revision `d7c77661`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).