[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* Installation
  + [Requirements](#requirements)
    - [Python](#id1)
    - [Non-python](#non-python)
    - [Runtime dependencies](#runtime-dependencies)
  + [From Bioconda](#from-bioconda)
  + [From PyPi](#from-pypi)
    - [Install package](#install-package)
    - [Set `PATH` variable](#set-path-variable)
  + [Inside a virtualenv](#inside-a-virtualenv)
  + [Development versions](#development-versions)
    - [Install from git](#install-from-git)
    - [Rebuild source](#rebuild-source)
  + [Building the documentation](#building-the-documentation)
  + [Troubleshooting](#troubleshooting)
* [Demo dataset](test_dataset.html)
* [List of command-line scripts](scriptlist.html)

User manual

* [Tutorials](examples.html)
* [Module documentation](generated/plastid.html)
* [Frequently asked questions](FAQ.html)
* [Glossary of terms](glossary.html)
* [References](zreferences.html)

Developer info

* [Contributing](devinfo/contributing.html)
* [Entrypoints](devinfo/entrypoints.html)

Other information

* [Citing `plastid`](citing.html)
* [License](license.html)
* [Change log](CHANGES.html)
* [Related resources](related.html)
* [Contact](contact.html)

[plastid](index.html)

* »
* Installation
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/installation.rst)

---

# Installation[¶](#installation "Permalink to this headline")

* [Requirements](#requirements)

  + [Python](#id1)
  + [Non-python](#non-python)
  + [Runtime dependencies](#runtime-dependencies)
* [From Bioconda](#from-bioconda)
* [From PyPi](#from-pypi)

  + [Install package](#install-package)
  + [Set `PATH` variable](#set-path-variable)
* [Inside a virtualenv](#inside-a-virtualenv)
* [Development versions](#development-versions)

  + [Install from git](#install-from-git)
  + [Rebuild source](#rebuild-source)
* [Building the documentation](#building-the-documentation)
* [Troubleshooting](#troubleshooting)

## [Requirements](#id2)[¶](#requirements "Permalink to this headline")

### [Python](#id3)[¶](#id1 "Permalink to this headline")

Plastid requires Python 3.6 or 3.3 or greater.

### [Non-python](#id4)[¶](#non-python "Permalink to this headline")

Compiling `plastid` requires a standard C build system (e.g. GCC or clang,
plus the standard C library, and linking tools) as well as `zlib`,
`libcrypto`, and `libssl`. The good news is that these are already required
by `plastid`’s dependencies, so you probably already have them.

### [Runtime dependencies](#id5)[¶](#runtime-dependencies "Permalink to this headline")

[bowtie](http://bowtie-bio.sourceforge.net/manual.shtml) (not [bowtie 2](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml)) is required to un [`crossmap`](generated/plastid.bin.crossmap.html#module-plastid.bin.crossmap "plastid.bin.crossmap")

## [From Bioconda](#id6)[¶](#from-bioconda "Permalink to this headline")

[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat-square)](http://bioconda.github.io/recipes/plastid/README.html)

`Bioconda` is a channel for the conda package manager with a focus on
bioinformatics software. Once you have `Bioconda` installed, installing
`plastid` is as easy as running:

```
$ conda create -n plastid plastid
$ source activate plastid
```

This will install all of the necesary dependencies for `plastid` in an
isolated environment.

## [From PyPi](#id7)[¶](#from-pypi "Permalink to this headline")

### [Install package](#id8)[¶](#install-package "Permalink to this headline")

Releases of [`plastid`](generated/plastid.html#module-plastid "plastid") can be fetched from [PyPi](https://pypi.python.org) using [Pip](https://pypi.python.org/pypi/pip).
Simply type from the terminal:

```
$ pip install plastid
```

Test your installation within Python:

```
>>> from plastid import *
```

And then re-test the installation. If installation continues to fail, please see
[Installation fails in pip with no obvious error message](FAQ.html#faq-install-fails) for common errors or [our issue tracker](https://github.com/joshuagryphon/plastid/issues) to report a
new one.

### [Set `PATH` variable](#id9)[¶](#set-path-variable "Permalink to this headline")

Command-line scripts will be installed wherever system configuration dictates.
On OSX and many varities of linux, the install path for a single-user install is
`~/bin` or `~/.local/bin`. For system-wide installs, the path is typically
`/usr/local/bin`. Make sure the appropriate location is in your `PATH` by
adding to your `.bashrc`, `.bash_profile`, or `.profile`:

```
export PATH=~/bin:~/.local.bin:/usr/local/bin:$PATH
```

Also, type the line above in any open terminal (or login and out again) to apply
the changes.

## [Inside a virtualenv](#id10)[¶](#inside-a-virtualenv "Permalink to this headline")

Often users or systems administrators need to install multiple versions of the
same package for different scientific purposes. To do so they use *sandboxes*
that insulate packages from each other.

The easiest way to install `Plastid` inside a sandbox is to use
[virtualenv](https://virtualenv.pypa.io/en/latest/):

```
# install virtualenv if you don't have it.
$ pip install virtualenv

# With virtualenv installed, create & activate vanilla environment
# when prompted, do NOT give the virtualenv access to system packages

# create
$ virtualenv ~/some/path/to/venv

# activate
$ source ~/some/path/to/venv/bin/activate

# Fresh install of plastid.
# Note- no use of `sudo` here. It confuses the virtualenv
(venv) $ pip install --no-cache-dir plastid

# test
(venv) $ python -c "from plastid import *"
```

## [Development versions](#id11)[¶](#development-versions "Permalink to this headline")

### [Install from git](#id12)[¶](#install-from-git "Permalink to this headline")

To fetch the latest development versions, clone it from [our github repository](plastid_repo). From the terminal:

```
# get the source
$ git clone git://github.com/joshuagryphon/plastid.git

# Install in develop mode. Use `--recythonize` flag to regenerate C files
# if necessary (e.g. after upgrading pysam)
$ cd plastid
$ pip install --install-option='--recythonize' --user -e .
```

### [Rebuild source](#id13)[¶](#rebuild-source "Permalink to this headline")

If you make alterations to any of the cython sources, or if install fails,
you can build extensions or install using the `--recythonize` option:

```
# inside plastid folder
$ python setup.py build_ext --recythonize --inplace

# or
$ pip install --user -e . --install-option='--recythonize'
```

## [Building the documentation](#id14)[¶](#building-the-documentation "Permalink to this headline")

Building the documentation requires plastid to be installed. In addition,
`sphinx` and a few other dependencies are required. Install these:

```
$ pip install -r docs/requirements.txt
```

Then make the documentation and open it in a browser:

```
$ cd docs
$ make html
$ firefox build/html/index.html
```

## [Troubleshooting](#id15)[¶](#troubleshooting "Permalink to this headline")

[`plastid`](generated/plastid.html#module-plastid "plastid") installs fairly easily in most Linux and Macintosh setups. If
you run into issues running or installing, please see our FAQ section on
[installation](FAQ.html#faq-run) and then [our issue tracker](https://github.com/joshuagryphon/plastid/issues) to see if anybody
else has encountered your issue, and if instructions already exist.

Frequently, problems can be solved by installing [`plastid`](generated/plastid.html#module-plastid "plastid") in a clean
environment. For instructions, see [Inside a virtualenv](#install-inside-venv), above.

For other troubleshooting, please see our FAQ section on [installation](FAQ.html#faq-run).

[Previous](tour.html "Tour")
[Next](test_dataset.html "Demo dataset")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).