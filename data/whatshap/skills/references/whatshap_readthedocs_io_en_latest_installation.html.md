[whatshap](index.html)

* Installation
  + [Installation with Conda](#installation-with-conda)
  + [Installation with pip](#installation-with-pip)
  + [Installing an unreleased development version](#installing-an-unreleased-development-version)
* [User guide](guide.html)
* [Questions and Answers](faq.html)
* [Contributing](develop.html)
* [Various notes](notes.html)
* [How to cite](howtocite.html)
* [Changes](changes.html)

[whatshap](index.html)

* Installation
* [View page source](_sources/installation.rst.txt)

---

# Installation[](#installation "Link to this heading")

Installation of WhatsHap is easiest if you use Conda.

## Installation with Conda[](#installation-with-conda "Link to this heading")

First, follow [the Bioconda installation instructions](https://bioconda.github.io/).

Make sure you configured the `bioconda` and `conda-forge` channels as stated in
those instructions. Even if you have previously set up those channels, you can
repeat the `conda config add --channels ...` commands to ensure your
configuration is correct.

Note

It is *not* sufficient to only add `-c bioconda` to the `conda create`
or `conda install` commands as both the `bioconda` *and* the
`conda-forge` channels are required and must be listed in the correct
order. Refer to the [Bioconda instructions for using command-line options
instead of modifying the Conda
configuration](http://bioconda.github.io/#do-not-modify-condarc).

Then install WhatsHap into a new Conda environment (here named `whatshap-env`):

```
conda create -n whatshap-env whatshap
```

Then activate the environment. Whenever you start a new shell and want to use
WhatsHap, you need to repeat this step:

```
conda activate whatshap-env
```

Finally, check whether you got the most recent WhatsHap version:

```
whatshap --version
```

The most recent version is listed at the top of the [changelog](changes.html#changes).

## Installation with pip[](#installation-with-pip "Link to this heading")

Before you can `pip install`, you need to install dependencies that pip cannot
install for you. WhatsHap is implemented in C++ and Python. You need to have a
C++ compiler, Python 3.7 or later and the corresponding Python header files.
In Ubuntu, installing the packages `build-essential` and `python3-dev` will
take care of all required dependencies.

WhatsHap can then be installed with pip:

```
pip3 install --user whatshap
```

This installs WhatsHap into `$HOME/.local/bin`. Then add
`$HOME/.local/bin` to your `$PATH` and run the tool:

```
export PATH=$HOME/.local/bin:$PATH
whatshap --help
```

Alternatively, you can also install WhatsHap into a virtual environment if you
are familiar with that.

## Installing an unreleased development version[](#installing-an-unreleased-development-version "Link to this heading")

If you want to use the most recent development version of WhatsHap,
you can install it in the following way into a separate Conda environment.
This way, other WhatsHap versions you may have installed in other locations
remain unaffected. Make sure you have installed Conda. Then run:

```
conda create -n whatshap-tmp python pip gxx
conda activate whatshap-tmp
pip install git+https://github.com/whatshap/whatshap
```

Then check whether you are using the development:

```
whatshap --version
```

You should see a version number like `0.18.dev119+g5ba23de`, which means that
this is going to become version 0.18, with 119 commits ahead of the previous
version (0.17).

To get rid of the development installation, just run
`conda env remove -n whatshap-tmp`.

[Previous](index.html "WhatsHap")
[Next](guide.html "User guide")

---

© Copyright 2014.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).