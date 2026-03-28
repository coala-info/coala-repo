[Fiona](index.html)

stable

* [Project Information](README.html)
* Installation
  + [Easy installation](#easy-installation)
  + [Advanced installation](#advanced-installation)
* [User Manual](manual.html)
* [API Documentation](modules.html)
* [CLI Documentation](cli.html)

[Fiona](index.html)

* Installation
* [Edit on GitHub](https://github.com/Toblerity/Fiona/blob/f285ccb45a3769b28aff0282b84475b93a153cf7/docs/install.rst)

---

# Installation[](#installation "Link to this heading")

Installation of the Fiona package is complicated by its dependency on libgdal
and other C libraries. There are easy installations paths and an advanced
installation path.

## Easy installation[](#easy-installation "Link to this heading")

Fiona has several [extension modules](https://docs.python.org/3/extending/extending.html) which link against
libgdal. This complicates installation. Binary distributions (wheels)
containing libgdal and its own dependencies are available from the Python
Package Index and can be installed using pip.

```
pip install fiona
```

These wheels are mainly intended to make installation easy for simple
applications, not so much for production. They are not tested for compatibility
with all other binary wheels, conda packages, or QGIS, and omit many of GDAL’s
optional format drivers. If you need, for example, GML support you will need to
build and install Fiona from a source distribution.

Many users find Anaconda and conda-forge a good way to install Fiona and get
access to more optional format drivers (like GML).

Fiona 1.9 (coming soon) requires Python 3.7 or higher and GDAL 3.2 or higher.

## Advanced installation[](#advanced-installation "Link to this heading")

Once GDAL and its dependencies are installed on your computer (how to do this
is documented at <https://gdal.org>) Fiona can be built and installed using
setuptools or pip. If your GDAL installation provides the `gdal-config`
program, the process is simpler.

Without pip:

```
GDAL_CONFIG=/path/to/gdal-config python setup.py install
```

With pip (version >= 22.3 is required):

```
python -m pip install --user -U pip
GDAL_CONFIG=/path/to/gdal-config python -m pip install --user .
```

These are pretty much equivalent. Pip will use setuptools as the build backend.
If the gdal-config program is on your executable path, then you don’t need to
set the environment variable.

Without gdal-config you will need to configure header and library locations for
the build in another way. One way to do this is to create a setup.cfg file in
the source directory with content like this:

```
[build_ext]
include_dirs = C:/vcpkg/installed/x64-windows/include
libraries = gdal
library_dirs = C:/vcpkg/installed/x64-windows/lib
```

This is the approach taken by Fiona’s [wheel-building workflow](https://github.com/sgillies/fiona-wheels/blob/master/.github/workflows/win-wheels.yaml#L67-L74).
With this file in place you can run either `python setup.py install` or `python
-m pip install --user .`.

You can also pass those three values on the command line following the
[setuptools documentation](https://setuptools.pypa.io/en/latest/userguide/ext_modules.html#compiler-and-linker-options).
However, the setup.cfg approach is easier.

[Previous](README.html "Fiona")
[Next](manual.html "1 The Fiona User Manual")

---

© Copyright 2011, Sean Gillies.
Revision `f285ccb4`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).