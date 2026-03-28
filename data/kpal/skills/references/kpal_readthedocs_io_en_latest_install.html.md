[kPAL](index.html)

latest

* [Introduction](intro.html)
* Installation
  + [Dependencies](#dependencies)
  + [Latest kPAL release](#latest-kpal-release)
  + [kPAL development version](#kpal-development-version)
* [Methodology](method.html)
* [Tutorial](tutorial.html)
* [Using the Python library](library.html)

* [API reference](api.html)

* [Development](development.html)
* [*k*-mer profile file format](fileformat.html)
* [Changelog](changelog.html)
* [Copyright](copyright.html)

[kPAL](index.html)

* [Docs](index.html) »
* Installation
* [Edit on GitHub](https://github.com/LUMC/kPAL/blob/master/doc/install.rst)

---

# Installation[¶](#installation "Permalink to this headline")

The kPAL source code is [hosted on GitHub](https://github.com/LUMC/kPAL). Supported Python versions for running kPAL
are 2.6, 2.7, 3.3, and 3.4. kPAL can be installed either via the Python
Package Index (PyPI) or from the source code.

## Dependencies[¶](#dependencies "Permalink to this headline")

kPAL depends on the following Python libraries:

* [NumPy](http://www.numpy.org/)
* [h5py](http://www.h5py.org/)
* [biopython](http://biopython.org/)

The easiest way to use kPAL is with the [Anaconda distribution](https://store.continuum.io/cshop/anaconda/) which comes with these
libraries installed.

Alternatively, you can install them using their binary packages for your
operating system.

Although all dependencies will also be automatically installed if they aren’t
yet when installing kPAL, you may still want to have them installed
beforehand. Automatic installation requires compilation from source, which
takes a lot of time and needs several compilers and development libraries to
be available. The options noted above are often much more convenient.

## Latest kPAL release[¶](#latest-kpal-release "Permalink to this headline")

To install the latest release from [PyPI](https://pypi.python.org/pypi/kPAL)
using pip:

```
pip install kPAL
```

## kPAL development version[¶](#kpal-development-version "Permalink to this headline")

You can also clone and use the latest development version directly from the
GitHub repository:

```
git clone https://github.com/LUMC/kPAL.git
cd kPAL
pip install -e .
```

[Next](method.html "Methodology")
 [Previous](intro.html "Introduction")

---

© [Copyright](copyright.html) 2013-2014, LUMC, Jeroen F.J. Laros, Martijn Vermaat.
Revision `79b2ff97`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).