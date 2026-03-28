[changeo
![Logo](_static/changeo.png)](index.html)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* [Overview](overview.html)
* Download
* [Installation](#installation)
  + [Requirements](#requirements)
  + [Linux](#linux)
  + [Mac OS X](#mac-os-x)
  + [Windows](#windows)
* [Contributing](contributing.html)
* [Data Standards](standard.html)
* [Release Notes](news.html)

Usage Documentation

* [Commandline Usage](usage.html)
* [API](api.html)

Examples

* [Using IgBLAST](examples/igblast.html)
* [Parsing IMGT output](examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](examples/10x.html)
* [Filtering records](examples/filtering.html)
* [Clustering sequences into clonal groups](examples/cloning.html)
* [Reconstructing germline sequences](examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](examples/genbank.html)

Methods

* [Clonal clustering methods](methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](methods/germlines.html)

About

* [Contact](info.html)
* [Citation](info.html#citation)
* [License](info.html#license)

[changeo](index.html)

* Download
* [View page source](_sources/install.rst.txt)

---

# Download[](#download "Link to this heading")

The latest stable release of Change-O may be downloaded from
[PyPI](https://pypi.python.org/pypi/changeo) or
[GitHub](https://github.com/immcantation/changeo/tags).

Development versions and source code are available on
[GitHub](https://github.com/immcantation/changeo).

# Installation[](#installation "Link to this heading")

The simplest way to install the latest stable release of Change-O is via pip:

```
> pip3 install changeo --user
```

The current development build can be installed using pip and git in similar fashion:

```
> pip3 install git+https://github.com/immcantation/changeo@master --user
```

If you currently have a development version installed, then you will likely
need to add the arguments `--upgrade --no-deps --force-reinstall` to the
pip3 command.

## Requirements[](#requirements "Link to this heading")

The minimum dependencies for installation are:

* [Python 3.10.0](http://python.org)
* [setuptools 65.5](http://bitbucket.org/pypa/setuptools)
* [NumPy 1.23.2](http://numpy.org)
* [SciPy 1.9.3](http://scipy.org)
* [pandas 1.5.0](http://pandas.pydata.org)
* [Biopython 1.81](http://biopython.org)
* [presto 0.7.1](http://presto.readthedocs.io)
* [airr 1.3.1](https://docs.airr-community.org)
* [PyYAML 6.0](http://pyyaml.org)
* [packaging 21.3](https://packaging.pypa.io)
* [importlib-resoures 6.4.0](https://pypi.org/project/importlib-resources)

Some tools wrap external applications that are not required for installation.
Those tools require minimum versions of:

* AlignRecords requires [MUSCLE 3.8](http://www.drive5.com/muscle)
* ConvertDb-genbank requires [tbl2asn](https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2)
* AssignGenes requires [IgBLAST 1.6](https://ncbi.github.io/igblast), but
  version 1.11 or higher is strongly recommended.
* BuildTrees requires [IgPhyML 1.0.5](https://github.com/immcantation/igphyml)

## Linux[](#linux "Link to this heading")

1. The simplest way to install all Python dependencies is to install the
   full SciPy stack using the
   [instructions](http://scipy.org/install.html), then install
   Biopython according to its
   [instructions](http://biopython.org/DIST/docs/install/Installation.html).
2. Install [presto 0.7.0](http://presto.readthedocs.io) or greater.
3. Download the [Change-O bundle](https://github.com/immcantation/changeo/tags)
   and run:

   ```
   > pip3 install changeo-x.y.z.tar.gz --user
   ```

## Mac OS X[](#mac-os-x "Link to this heading")

1. Install Xcode. Available from the Apple store or
   [developer downloads](http://developer.apple.com/downloads).
2. Older versions Mac OS X will require you to install XQuartz 2.7.5. Available
   from the [XQuartz project](http://xquartz.macosforge.org/landing).
3. Install Homebrew following the installation and post-installation
   [instructions](http://brew.sh).
4. Install Python 3.4.0+ and set the path to the python3 executable:

   ```
   > brew install python3
   > echo 'export PATH=/usr/local/bin:$PATH' >> ~/.profile
   ```
5. Exit and reopen the terminal application so the PATH setting takes effect.
6. You may, or may not, need to install gfortran (required for SciPy). Try
   without first, as this can take an hour to install and is not needed on
   newer releases. If you do need gfortran to install SciPy, you can install it
   using Homebrew:

   ```
   > brew install gfortran
   ```

   If the above fails run this instead:

   ```
   > brew install --env=std gfortran
   ```
7. Install NumPy, SciPy, pandas and Biopython using the Python package
   manager:

   ```
   > pip3 install numpy scipy pandas biopython
   ```
8. Install [presto 0.7.0](http://presto.readthedocs.io) or greater.
9. Download the [Change-O bundle](https://github.com/immcantation/changeo/tags),
   open a terminal window, change directories to the download folder, and run:

   ```
   > pip3 install changeo-x.y.z.tar.gz
   ```

## Windows[](#windows "Link to this heading")

1. Install Python 3.4.0+ from [Python](http://python.org/downloads),
   selecting both the options ‘pip’ and ‘Add python.exe to Path’.
2. Install NumPy, SciPy, pandas and Biopython using the packages
   available from the
   [Unofficial Windows binary](http://www.lfd.uci.edu/~gohlke/pythonlibs)
   collection.
3. Install [presto 0.7.0](http://presto.readthedocs.io) or greater.
4. Download the [Change-O bundle](https://github.com/immcantation/changeo/tags),
   open a Command Prompt, change directories to the download folder, and run:

   ```
   > pip install changeo-x.y.z.tar.gz
   ```
5. For a default installation of Python 3.4, the Change-0 scripts will be
   installed into `C:\Python34\Scripts` and should be directly
   executable from the Command Prompt. If this is not the case, then
   follow step 6 below.
6. Add both the `C:\Python34` and `C:\Python34\Scripts` directories
   to your `%Path%`. On both Windows 7 and Windows 10, the `%Path%` setting is located under Control Panel -> System and Security -> System -> Advanced System Settings -> Environment variables -> System variables -> Path.
7. If you have trouble with the `.py` file associations, try adding `.PY`
   to your `PATHEXT` environment variable. Also, try opening a
   Command Prompt as Administrator and run:

   ```
   > assoc .py=Python.File
   > ftype Python.File="C:\Python34\python.exe" "%1" %*
   ```

[Previous](overview.html "Overview")
[Next](contributing.html "Contributing")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).