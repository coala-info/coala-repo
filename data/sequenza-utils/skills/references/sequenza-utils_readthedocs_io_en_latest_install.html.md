[sequenza-utils](index.html)

latest

* Installation
  + [Latest release via PyPI](#latest-release-via-pypi)
  + [Development version](#development-version)
* [Command line interface](commands.html)
* [User cookbook](guide.html)

* [API library interface](api.html)

[sequenza-utils](index.html)

* [Docs](index.html) »
* Installation
* [Edit on Bitbucket](https://bitbucket.org/sequenzatools/sequenza-utils/src/master/docs/install.rst?mode=view)

---

# Installation[¶](#installation "Permalink to this headline")

The sequenza-utils code is hosted in [BitBucket](https://bitbucket.org/sequenzatools/sequenza-utils).

Supported Python version are 2.7+, including python3, and pypy.

Sequenza-utils can be installed either via the Python Package Index (PyPI)
or from the git repository.

The package uses the external command line tools [samtools](http://samtools.sourceforge.net) and [tabix](http://www.htslib.org/doc/tabix.html).
For the package to function correctly such programs need to be installed in the system

## Latest release via PyPI[¶](#latest-release-via-pypi "Permalink to this headline")

To install the latest release via PyPI using pip:

```
pip install sequenza-utils
```

## Development version[¶](#development-version "Permalink to this headline")

To use the test suite for the package is necessary to install also [bwa](http://bio-bwa.sourceforge.net)
Using the latest development version directly from the git repository:

```
git clone https://bitbucket.org/sequenzatools/sequenza-utils
cd sequenza-utils
python setup.py test
python setup.py install
```

[Next](commands.html "Command line interface")
 [Previous](index.html "Sequenza-utils")

---

© Copyright 2016, Francesco Favero
Revision `628964e0`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).