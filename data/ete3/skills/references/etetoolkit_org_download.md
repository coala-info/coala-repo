[![](/static/logos/ETElogo.250x78.jpeg)](/)

* [Home](/)
* [Gallery](/gallery/)
* [Documentation](/docs/latest/index.html)
  + [Python API Tutorial](/docs/latest/tutorial/index.html)
  + [Python API Reference](/docs/latest/reference/index.html)
  + [Phylogenomic Tools Index](/documentation/tools/)
  + [Phylogenomic Tools Cookbook](/cookbook)
* [TreeView](/treeview/)
* [Support](/support/) * [About](/about/)
  * [Download](/download/)

    ![](https://img.shields.io/pypi/v/ete3.svg?label=latest)

[![Fork me on GitHub](https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67)](https://github.com/etetoolkit/ete)

## Download and Install

![](https://img.shields.io/pypi/v/ete3.svg?label=latest_version)

![](https://anaconda.org/etetoolkit/ete3/badges/downloads.svg)

#### Linux

#### Using Conda (no sudo required)

1. Installing ETE using [Conda](https://docs.conda.io/en/latest/miniconda.html)

```
$ conda create -n ete3 python=3
$ conda activate ete3
$ conda install -c etetoolkit ete3 ete_toolchain
$ ete3 build check
```

Then, just remember to activate your conda environment to use ete3

```
conda activate ete3
```

#### Native

1. Install dependencies: python-qt4, python-lxml, python-six and python-numpy

   *(PyQt4 and lxml are optional, required for tree drawing operations and PhyloXML/NexML format parsing respectively. You can still install ETE without them.)*

   * In Ubuntu, Mint and other Debian based distributions (APT)

   ```
   sudo apt-get install python-numpy python-qt4 python-lxml python-six
   ```

   * In CentOS, Fedora, etc (YUM)

   ```
   sudo yum install PyQt4.x86_64 numpy.x86_64 python-lxml.x86_64 python-six.noarch
   ```
2. Install/Upgrade ETE using PIP

   ```
   pip install --upgrade ete3
   ```

   or using EasyInstall

   ```
   easy_install -U ete3
   ```

   or from the sources: Download latest version from [PyPI](https://pypi.python.org/pypi/ete3/) and execute:

   ```
   python setup.py install
   ```
3. Compile external tools

   This is an optional step, required only by ete-build and ete-evol. The Python API does not require external tools.

   ```
   ete3 upgrade-external-tools
   ```

#### Mac OS X

#### Using Conda (recommended)

1. Installing ETE using [Conda](https://docs.conda.io/en/latest/miniconda.html)

```
$ conda create -n ete3 python=3
$ conda activate ete3
$ conda install -c etetoolkit ete3 ete_toolchain
$ ete3 build check
```

2. Then, just remember to activate your conda enviroment to use ete3

   ```
   conda activate ete3
   ```

#### XQuartz

Note that graphical features in ETE require [XQuartz](http://www.xquartz.org/) to be installed.

#### Older versions (ete2)

For compatibility and reproducibility reasons, the older `ete2` version of the API
is still available and can be installed independently from `ete3` (both
versions can coexist). Use `pip install --upgrade ete2` to
install it.

Citation:

*ETE 3: Reconstruction, analysis and visualization of phylogenomic data.*
Jaime Huerta-Cepas, Francois Serra and Peer Bork.
Mol Biol Evol 2016; [doi: 10.1093/molbev/msw046](http://mbe.oxfordjournals.org/content/early/2016/03/21/molbev.msw046)

* ETE is free software (GPL)
* [**Contact:** [email protected]](email)
* [![](/static/img/logo_embl.black.png)](embl.de)