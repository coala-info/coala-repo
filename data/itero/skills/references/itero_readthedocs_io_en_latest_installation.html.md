[itero](index.html)

latest

Contents:

* [Purpose](purpose.html)
* Installation
  + [Python Modules](#python-modules)
  + [3rd-party programs](#rd-party-programs)
  + [Why conda?](#why-conda)
  + [Install Process (using conda/bioconda)](#install-process-using-conda-bioconda)
    - [Install Anaconda or miniconda](#install-anaconda-or-miniconda)
      * [anaconda](#id4)
      * [miniconda](#id5)
      * [Checking your $PATH](#checking-your-path)
    - [Configure Bioconda](#configure-bioconda)
    - [Install itero](#install-itero)
    - [Test itero install](#test-itero-install)
  + [Install Process (Alternative / HPC)](#install-process-alternative-hpc)
    - [Test itero install](#id6)
* [Running itero](running.html)

* [License](license.html)
* [Changelog](changelog.html)
* [Funding](funding.html)

[itero](index.html)

* [Docs](index.html) »
* Installation
* [Edit on GitHub](https://github.com/faircloth-lab/itero/blob/master/docs/installation.rst)

---

# Installation[¶](#installation "Permalink to this headline")

[itero](https://github.com/faircloth-lab/itero) uses a number of [Python](http://www.python.org) tools that allow it to assemble raw reads into contigs. [itero](https://github.com/faircloth-lab/itero) also wraps a number of third-party programs. These include:

## Python Modules[¶](#python-modules "Permalink to this headline")

* [numpy](http://www.numpy.org)
* [biopython](http://biopython.org)
* [mpi4py](http://mpi4py.scipy.org/docs/)
* [schwimmbad](https://github.com/adrn/schwimmbad)
* [six](https://pythonhosted.org/six/)

## 3rd-party programs[¶](#rd-party-programs "Permalink to this headline")

* [bedtools](http://bedtools.readthedocs.io/en/latest/)
* [bwa](http://bio-bwa.sourceforge.net/)
* [gawk](https://www.gnu.org/software/gawk/)
* [samtools](http://www.htslib.org/)
* [spades](http://bioinf.spbau.ru/spades)

To ensure that these dependencies are easy to install, we have created a [conda](http://docs.continuum.io/conda/) package for [itero](https://github.com/faircloth-lab/itero) that is available as part of [bioconda](https://bioconda.github.io/). This is the easiest way to get itero up and running on your system. [itero](https://github.com/faircloth-lab/itero) can also be run outside of [conda](http://docs.continuum.io/conda/), and we include some installation suggestions for these types of systems, below. However, because many HPC systems are configured differently, we cannot provide extensive support for [itero](https://github.com/faircloth-lab/itero) on HPC platforms.

Note

We build and test the binaries available through [conda](http://docs.continuum.io/conda/) using
64-bit operating systems that include:

* Apple OSX 10.9.x
* CentOS 7.x

## Why conda?[¶](#why-conda "Permalink to this headline")

It may seem odd to impose a particular distribution on users, and we largely
agree. However, [conda](http://docs.continuum.io/conda/) makes it very easy for us to distribute both [Python](http://www.python.org) and
non-Python packages, setup identical environments
across very heterogenous platforms (linux, osx), make sure all the $PATHs are
correct, and have things run largely as expected. Using [conda](http://docs.continuum.io/conda/) has several other
benefits, including environment separation similar to [virtualenv](http://www.virtualenv.org/).

In short, using [conda](http://docs.continuum.io/conda/) gets us as close to a “one-click” install that we will probably
ever get.

## Install Process (using conda/bioconda)[¶](#install-process-using-conda-bioconda "Permalink to this headline")

Attention

We do not support [itero](https://github.com/faircloth-lab/itero) on Windows.

Note

We build and test the binaries available through using
64-bit operating systems that include:

* Apple OSX 10.9.x
* CentOS 7.x

The installation process is a 3-step process. You need to:

1. Install [conda](http://docs.continuum.io/conda/) (either [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/))
2. Configure [conda](http://docs.continuum.io/conda/) to use [bioconda](https://bioconda.github.io/)
3. Install [itero](https://github.com/faircloth-lab/itero)

Installing [itero](https://github.com/faircloth-lab/itero) using [conda](http://docs.continuum.io/conda/) will install all of the required binaries, libraries, and
[Python](http://www.python.org) dependencies.

### Install Anaconda or miniconda[¶](#install-anaconda-or-miniconda "Permalink to this headline")

You first need to install [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/). Which
one you choose is up to you, your needs, how much disk space you have, and if
you are on a fast/slow connection.

Attention

You can easily install [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/) in your $HOME,
although you should be aware that this setup can cause problems in some
HPC setups.

Tip

Do I want [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/)?

The major difference between the two python distributions is that [anaconda](http://docs.continuum.io/anaconda/install.html)
comes with many, many packages pre-installed, while [miniconda](http://repo.continuum.io/miniconda/) comes with
almost zero packages pre-installed. As such, the beginning [anaconda](http://docs.continuum.io/anaconda/install.html)
distribution is roughly 500 MB in size while the beginning [miniconda](http://repo.continuum.io/miniconda/)
distribution is 15-30 MB in size.

#### anaconda[¶](#id4 "Permalink to this headline")

Follow the instructions here for your platform:
<http://docs.continuum.io/anaconda/install.html>

#### miniconda[¶](#id5 "Permalink to this headline")

Find the correct miniconda-x.x.x file for your platform from
<http://repo.continuum.io/miniconda/> and download that file. Be sure you **do
not** get one of the packages that has a name starting with miniconda3-. When
that has completed, run one of the following:

```
bash Miniconda-x.x.x-Linux-x86_64.sh  [linux]
bash Miniconda-x.x.x-MacOSX-x86_64.sh [osx]
```

Note

Once you have installed Miniconda, we will refer to it as **anaconda**
throughout the remainder of this documentation.

#### Checking your $PATH[¶](#checking-your-path "Permalink to this headline")

Regardless of whether you install [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/), you need to check
that you’ve installed the package correctly. To ensure that the correct
location for [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/) are added to your $PATH (this occurs
automatically on the $BASH shell), run the following:

```
$ python -V
```

The output should look similar to (x will be replaced by a version):

```
Python 2.7.x :: Anaconda x.x.x (x86_64)
```

Notice that the output shows we’re using the Anaconda x.x.x version of
[Python](http://www.python.org). If you do not see the expected output (or something similar), then you
likely need to edit your $PATH variable to add [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/).

The easiest way to edit your path, if needed is to open `~/.bashrc` with a
text editor (if you are using ZSH, this will be `~/.zshrc`) and add, as the
last line:

```
export PATH=$HOME/path/to/conda/bin:$PATH
```

where `$HOME/path/to/conda/bin` is the location of anaconda/miniconda on your
system (usually `$HOME/anaconda/bin` or `$HOME/miniconda/bin`).

Warning

If you have previously set your `$PYTHONPATH` elsewhere in your
configuration, it may cause problems with your [anaconda](http://docs.continuum.io/anaconda/install.html) or [miniconda](http://repo.continuum.io/miniconda/)
installation of [phyluce](https://github.com/faircloth-lab/phyluce). The solution is to remove the offending library
(-ies) from your `$PYTHONPATH`.

### Configure Bioconda[¶](#configure-bioconda "Permalink to this headline")

Once you have installed [anaconda](http://docs.continuum.io/anaconda/install.html) (or [miniconda](http://repo.continuum.io/miniconda/)), you need to configure [conda](http://docs.continuum.io/conda/) to use the [bioconda](https://bioconda.github.io/) channel. More information on this process can be found on the [bioconda](https://bioconda.github.io/) website, but the gist of the process is that you need to run:

```
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```

### Install [itero](https://github.com/faircloth-lab/itero)[¶](#install-itero "Permalink to this headline")

Once [bioconda](https://bioconda.github.io/) is installed, you should be able to install [itero](https://github.com/faircloth-lab/itero) by running:

```
conda install itero
```

This will install everything that you need to run the program.

### Test [itero](https://github.com/faircloth-lab/itero) install[¶](#test-itero-install "Permalink to this headline")

You can check to make sure all of the binaries are installed correctly by running:

```
itero check binaries
```

## Install Process (Alternative / HPC)[¶](#install-process-alternative-hpc "Permalink to this headline")

On some systems (particularly HPC systems), [conda](http://docs.continuum.io/conda/) can cause problems. You can [itero](https://github.com/faircloth-lab/itero) the “old” way by downloading the package tarball (<https://github.com/faircloth-lab/itero/releases>) and running:

```
python setup.py install
```

in the main directory. This should install all of the [Python](http://www.python.org) dependencies, **but you still need to install and configure the 3rd-party dependencies**.

Attention

You will need to install 3rd-party dependencies on your own
if you are using the python setup.py install method of installing [itero](https://github.com/faircloth-lab/itero)

You can build and install these dependencies where you like. To configure [itero](https://github.com/faircloth-lab/itero) to use the dependencies you have build and installed, you need to create a `$HOME/.itero.conf` that gives the paths to each program and looks like:

```
[executables]
bedtools:/path/to/bin/bedtools
bwa:/path/to/bin/bwa
gawk:/path/to/bin/gawk
samtools:/path/to/bin/samtools
spades:/path/to/bin/spades.py
```

### Test [itero](https://github.com/faircloth-lab/itero) install[¶](#id6 "Permalink to this headline")

You can check to make sure all of the binaries are installed correctly by running:

```
itero check binaries
```

[Next](running.html "Running itero")
 [Previous](purpose.html "Purpose")

---

© Copyright 2018, Brant C. Faircloth
Revision `25c7fb69`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).