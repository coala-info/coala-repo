[scHiCExplorer](../index.html)

latest

* Installation
  + [Requirements](#requirements)
  + [Command line installation using `conda`](#command-line-installation-using-conda)
  + [Command line installation with source code](#command-line-installation-with-source-code)
* [scHiCExplorer tools](list-of-tools.html)
* [News](News.html)
* [Analysis of single-cell Hi-C data](Example_analysis.html)

[scHiCExplorer](../index.html)

* [Docs](../index.html) »
* Installation
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/installation.rst)

---

# Installation[¶](#installation "Permalink to this headline")

* [Requirements](#requirements)
* [Command line installation using `conda`](#command-line-installation-using-conda)
* [Command line installation with source code](#command-line-installation-with-source-code)

## [Requirements](#id1)[¶](#requirements "Permalink to this headline")

* Python 3.6
* HiCExplorer 3.5
* cooler 0.8.9
* HiCMatrix 14
* sparse-neighbors-search 0.6

## [Command line installation using `conda`](#id2)[¶](#command-line-installation-using-conda "Permalink to this headline")

The fastest way to obtain **Python 3.6 together with numpy and scipy** is
via the [Anaconda Scientific Python
Distribution](https://store.continuum.io/cshop/anaconda/).
Just download the version that’s suitable for your operating system and
follow the directions for its installation. All of the requirements for scHiCExplorer can be installed in Anaconda with:

```
$ conda install schicexplorer python=3.6 -c bioconda -c conda-forge
```

We strongly recommended to use conda to install scHiCExplorer.

## [Command line installation with source code](#id3)[¶](#command-line-installation-with-source-code "Permalink to this headline")

1. Download source code

```
$ git clone https://github.com/joachimwolff/scHiCExplorer.git
```

2. Install dependencies:

```
$ cd scHiCExplorer
$ conda install --file requirements.txt -c bioconda -c conda-forge
```

3. Install the source code:

```
$ python setup.py install
```

[Next](list-of-tools.html "scHiCExplorer tools")
 [Previous](../index.html "scHiCExplorer")

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).