[SIDR](index.html)

latest

* Installing SIDR
  + [Dependencies](#dependencies)
  + [OSX](#osx)
  + [Using a Virtualenv](#using-a-virtualenv)
  + [Installing from PyPI](#installing-from-pypi)
  + [Installing from Source with pip](#installing-from-source-with-pip)
  + [Installing from Source with Setup.py](#installing-from-source-with-setup-py)
* [Data Preparation](dataprep.html)
* [Running With Raw Input](rundefault.html)
* [Running With a Runfile](runfilerun.html)
* [Runfile Example](runfileexample.html)

[SIDR](index.html)

* [Docs](index.html) »
* Installing SIDR
* [Edit on GitHub](https://github.com/damurdock/SIDR/blob/master/docs/install.rst)

---

# Installing SIDR[¶](#installing-sidr "Permalink to this headline")

SIDR can be installed either using pip–the python package manager–or manually using the included setup.py file.

## Dependencies[¶](#dependencies "Permalink to this headline")

SIDR is able to install all of its dependencies from PyPI automatically. This should work in most cases. If you are installing under Python 3, you may need to manually install Cython with:

```
pip install cython
```

If you have a locally installed version of HTSLib, you can include it by using the commands:

```
export HTSLIB_LIBRARY_DIR=/usr/local/lib
export HTSLIB_INCLUDE_DIR=/usr/local/include
```

before installing SIDR.

## OSX[¶](#osx "Permalink to this headline")

Users running a recent version of OSX may need to install an alternative python distribution like that provided by [Homebrew](https://docs.brew.sh/Homebrew-and-Python.html). If SIDR installation fails with permission errors, this is the most likely solution.

## Using a Virtualenv[¶](#using-a-virtualenv "Permalink to this headline")

Some cluster users may need to setup a Python virtualenv due to the nature of working with a cluster environment. A virtualenv can be setup with the commands:

```
virtualenv venv
. venv/bin/activate
```

If necessary, virtualenv can be installed in the user’s home directory (~/.local/bin must be in $PATH) with the following command:

```
pip install --user virtualenv
```

## Installing from PyPI[¶](#installing-from-pypi "Permalink to this headline")

Installing from PyPI is the easiest method, and thus the recommended one. To install SIDR:

```
pip install sidr
```

## Installing from Source with pip[¶](#installing-from-source-with-pip "Permalink to this headline")

Note

When installing from source, setuptools will attempt to contact PyPI to install dependencies. If this is not an option then dependencies will need to be manually installed.

If PyPI is not an option or if you’d like to run the latest development version, SIDR can be installed by running the following command:

```
pip install git+https://github.com/damurdock/SIDR.git
```

If you’re installing SIDR in order to develop it, download the source from [GitHub](https://github.com/damurdock/SIDR.git) and install it by running the following command in the unzipped source directory:

```
pip install --editable .
```

## Installing from Source with Setup.py[¶](#installing-from-source-with-setup-py "Permalink to this headline")

If for some reason pip is completely unavailable, SIDR can be installed by downloading the source from [GitHub](https://github.com/damurdock/SIDR.git) and running the following command command in the unzipped source directory:

```
python setup.py install
```

[Next](dataprep.html "Data Preparation")
 [Previous](index.html "Welcome to SIDR’s documentation!")

---

© Copyright 2017, Duncan Murdock.
Revision `37d56e54`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).