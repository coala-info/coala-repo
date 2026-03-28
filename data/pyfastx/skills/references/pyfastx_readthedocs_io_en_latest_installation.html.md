[pyfastx](index.html)

Contents:

* Installation
  + [Install from PyPI](#install-from-pypi)
  + [Install from source](#install-from-source)
* [FASTX](usage.html)
* [FASTA](usage.html#fasta)
* [Sequence](usage.html#sequence)
* [FASTQ](usage.html#fastq)
* [Read](usage.html#read)
* [FastaKeys](usage.html#fastakeys)
* [FastqKeys](usage.html#fastqkeys)
* [Command line interface](commandline.html)
* [Multiple processes](advance.html)
* [Drawbacks](drawbacks.html)
* [Changelog](changelog.html)
* [API Reference](api_reference.html)
* [Acknowledgements](acknowledgements.html)

[pyfastx](index.html)

* Installation
* [View page source](_sources/installation.rst.txt)

---

# Installation[](#installation "Link to this heading")

You can install pyfastx via the Python Package Index (PyPI) (**recommended**) or from source.

Make sure you have installed both [pip](https://pip.pypa.io/en/stable/installing/) and Python before starting.

Currently, `pyfastx` supports Python 3.8, 3.9, 3.10, 3.11, 3.12, 3.13, 3.14 and can work on Windows, Linux, MacOS.

## Install from PyPI[](#install-from-pypi "Link to this heading")

```
pip install pyfastx
```

Update pyfastx using `pip`

```
pip install -U pyfastx
```

## Install from source[](#install-from-source "Link to this heading")

`pyfastx` depends on [zlib](https://zlib.net/), [sqlite3](https://www.sqlite.org/index.html) and [indexed\_gzip](https://github.com/pauldmccarthy/indexed_gzip). In latest version, pyfastx will automatically download these libraries to build.

First, clone pyfastx using `git` or download latest [release](https://github.com/lmdu/pyfastx/releases):

```
git clone https://github.com/lmdu/pyfastx.git
```

Then, `cd` to the pyfastx folder and run install command:

```
cd pyfastx
python setup.py install
```

Or just build:

```
cd pyfastx
python setup.py build_ext -i
```

[Previous](index.html "Welcome to pyfastx’s documentation!")
[Next](usage.html "FASTX")

---

© Copyright 2023, Lianming Du.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).