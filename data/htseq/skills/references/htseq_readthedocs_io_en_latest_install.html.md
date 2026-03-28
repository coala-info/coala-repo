[HTSeq](index.html)

latest

* [Home](index.html)
* [Overview](overview.html)
* Installation
* [A tour through HTSeq](tour.html)
* [Tutorials](tutorials.html)
* [Counting reads](counting.html)
* [Reference API](refoverview.html)
* [Sequences and FASTA/FASTQ files](sequences.html)
* [Positions, intervals and arrays](genomic.html)
* [Read alignments](alignments.html)
* [Features](features.html)
* [Other parsers](otherparsers.html)
* [Miscellaneous](misc.html)
* [`htseq-count`: counting reads within features](htseqcount.html)
* [`htseq-count-barcodes`: counting reads with cell barcodes and UMIs](htseqcount_with_barcodes.html)
* [Quality Assessment with `htseq-qa`](qa.html)
* [Version history](history.html)
* [Contributing](contrib.html)

[HTSeq](index.html)

* Installation
* [Edit on GitHub](https://github.com/htseq/htseq/blob/main/doc/install.rst)

---

# Installation[](#installation "Permalink to this heading")

HTSeq is available from the [Python Package Index (PyPI)](http://pypi.python.org/pypi/HTSeq):

To use HTSeq, you need [Python](http://www.python.org/) 3.7 or above with:

* [NumPy](http://numpy.scipy.org/), a commonly used Python package for numerical calculations
* [Pysam](https://github.com/pysam-developers/pysam), a Python interface to [samtools](http://www.htslib.org/).
* To make plots you will need [matplotlib](http://matplotlib.org/), a plotting library.

At the moment, HTSeq supports Linux and OSX but not Windows operating systems,
because one of the key dependencies, [Pysam](https://github.com/pysam-developers/pysam), lacks automatic support and none
of the HTSeq authors have access to such a machine. However, it *might* work
with some work, if you need support for this open an issue on our [Github](https://github.com/htseq/htseq) page.

HTSeq follows install conventions of many Python packages. In the best case, it
should install from PyPI like this:

```
pip install HTSeq
```

If this does not work, please open an issue on [Github](https://github.com/htseq/htseq) and also try the instructions
below.

Note

`pip` will occasionally try to build HTSeq from source. If that’s the case, you
need two additional dependencies: [Cython](https://cython.org/) and [SWIG](http://swig.org/). See the [Github](https://github.com/htseq/htseq) page for more info.

## Installation on Linux[](#installation-on-linux "Permalink to this heading")

You can choose to install HTSeq via your distribution packages or via pip. The former
is generally recommended but might be updated less often than the pip version.

### Distribution package manager[](#distribution-package-manager "Permalink to this heading")

* Ubuntu:

  ```
  sudo apt-get install build-essential python3.6-dev python-numpy python-matplotlib python-pysam python-htseq
  ```
* Arch (e.g. using `aura`, you can grab the AUR packages manually otherwise):

  ```
  sudo pacman -S python python-numpy python-matplotlib
  sudo aura -A python-pysam python-htseq
  ```

### PIP[](#pip "Permalink to this heading")

PIP should take care of the requirements for you:

```
pip install HTSeq
```

### Installing from GIT[](#installing-from-git "Permalink to this heading")

If you want to install a development version, just clone the git repository, switch to the branch/commit
you wish, and use `setuptools`:

```
python setup.py build
python setup.py install
```

Typical setuptools options are available (e.g. `--prefix`, `--user`).

To test the installation, change to another director than the build directory, start Python
(by typing `python` or `python2.7`) and then try whether typing `import HTSeq` causes an error meesage.

Remember that Python can only import from your `PYTHONPATH` list of folders and from direct subfolders of the current working directory: if you have a folder called `HTSeq` in the current directory, your import will likely fail: move somewhere else.

## Installation on MacOS X[](#installation-on-macos-x "Permalink to this heading")

### PIP[](#id1 "Permalink to this heading")

Try pip first:

```
pip install HTSeq
```

### Installing from source[](#installing-from-source "Permalink to this heading")

Mac users should install NumPy as explained [here](http://www.scipy.org/Installing_SciPy/Mac_OS_X) in the NumPy/SciPy documentation. Note that you need
to install Xcode to be able to compile NumPy. Due to the
mess that Apple recently made out of Xcode, the whole process may be a slight bit more cumbersome than necessary, especially if you work with OSX Lion, so read the instructions carefully.

If you want to produce plots or use htseq-qa, you will also need matplotlib. (For htseq-count, it
is not required.) There seems to be a binary package (a “Python egg”) available on the matplotlib
SourceForge page.

To install HTSeq itself, download the *source* package from the [HTSeq PyPI page](http://pypi.python.org/pypi/HTSeq), unpack the tarball,
go into the directory with the unpacked files and type there:

```
python setup.py build
```

to compile HTSeq. If you get an error regarding the availability of a C compiler, you may need to
set environment variables to point Python to it. The NumPy/SciPy installation instructions above cover this topic well and
apply here, too, so simply do the same as you did to install NumPy.

Once building has been successful, use:

```
python setup.py --user
```

to install HTSeq for the current users. To make HTSeq available to all users, use instead:

```
python setup.py build
sudo python setup.py install
```

To test the installation, change to another director than the build directory, start Python
(by typing `python`) and then try whether typing `import HTSeq` causes an error meesage.

## MS Windows[](#ms-windows "Permalink to this heading")

If you have not yet installed Python, do so first. You can find an automatic installer
for Windows on the [Python download page](http://www.python.org/getit/). Make sure to use Python 3.5 or above.

Then install the newest version of NumPy. Look on [NumPy’s PyPI page](https://pypi.python.org/pypi/numpy) for the automatic installer.

If you want to produce plots or use htseq-qa, you will also need matplotlib. (For htseq-count, it
is not required.) Follow the installation instructions on their web page.

### Installation from source[](#installation-from-source "Permalink to this heading")

**Installation on Windows is not currently supported.** The notes below are left as a historical
record in case a generous soul wants to help us bring back HTSeq to this OS.

### Old notes[](#old-notes "Permalink to this heading")

To install HTSeq itself, simply download the Windows installer from the [HTSeq download page](http://pypi.python.org/pypi/HTSeq)
and run it.

To test your installation, start Python and then try whether typing `import HTSeq`
causes an error meesage.

If you get the error message “ImportError: DLL load failed”, you are most likely
missing the file MSVCR110.DLL on your system, which you can get by downloading and
installing the file “vcredist\_x86.exe” from [this page](http://www.microsoft.com/en-us/download/details.aspx?id=30679).

[Previous](overview.html "Overview")
[Next](tour.html "A tour through HTSeq")

---

© Copyright 2010-2022, the HTSeq team.
Revision `726a1432`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).