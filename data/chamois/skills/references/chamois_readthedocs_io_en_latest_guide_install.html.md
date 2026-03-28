[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[![](../_static/logo.png)
![](../_static/logo.png)

CHAMOIS](../index.html)

* [User Guide](index.html)
* [Examples](../examples/index.html)
* [Figures](../figures/index.html)
* [CLI Reference](../cli/index.html)
* [API Reference](../api/index.html)
* More
  + [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Search
`Ctrl`+`K`

* [User Guide](index.html)
* [Examples](../examples/index.html)
* [Figures](../figures/index.html)
* [CLI Reference](../cli/index.html)
* [API Reference](../api/index.html)
* [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Section Navigation

Getting Started

* Installation

Resources

* [Publications](publications.html)
* [Contribution Guide](contributing.html)
* [Changelog](changes.html)
* [Copyright Notice](copyright.html)

* [User Guide](index.html)
* Installation

# Installation[#](#installation "Link to this heading")

Important

Since release `v0.10.2`, CHAMOIS can now run on Windows! This uses
the PyHMMER `v0.12.0` experimental [MinGW-w64](https://www.mingw-w64.org/)
build which supports Windows 10 and later. See the PyHMMER
documentation for more information about
[Windows support](https://pyhmmer.readthedocs.io/en/stable/guide/windows.html).

## Local Setup[#](#local-setup "Link to this heading")

### PyPi[#](#pypi "Link to this heading")

CHAMOIS is hosted on GitHub, but the easiest way to install it is to download
the latest release from its [PyPi repository](https://pypi.python.org/pypi/chamois-tool).
It will install all dependencies, then install CHAMOIS and its required data:

```
$ pip install --user chamois-tool
```

### Conda[#](#conda "Link to this heading")

CHAMOIS is also available as a [recipe](https://anaconda.org/bioconda/chamois)
in the [bioconda](https://bioconda.github.io/) channel. To install, simply
use the `conda` installer:

```
$ conda install bioconda::chamois
```

### GitHub + `pip`[#](#github-pip "Link to this heading")

If, for any reason, you prefer to download the library from GitHub, you can clone
and install the repository with `pip` by running (with the admin rights):

```
$ pip install -U git+https://github.com/zellerlab/CHAMOIS
```

Caution

Keep in mind this will install always try to install the latest commit,
which may not even build, so consider using a versioned release instead.

### GitHub + `build`[#](#github-build "Link to this heading")

If you do not want to use `pip`, you can still clone the repository and
use `build` and `installer` manually:

```
$ git clone https://github.com/zellerlab/CHAMOIS
$ cd CHAMOIS
$ python -m build .
# python -m installer dist/*.whl
```

Danger

Installing packages without `pip` is strongly discouraged, as they can
only be uninstalled manually, and may damage your system.

## Containers[#](#containers "Link to this heading")

### Docker[#](#docker "Link to this heading")

CHAMOIS is also distributed in a Docker container for reproducibility. An image
is built for every release. To get the latest image, run:

```
$ docker pull ghcr.io/zellerlab/chamois
```

Then, to run the image and analyze files in the local directory, make sure
to mount the currend working directory to the `/io` volume, enable terminal
emulation with `-t` to get a nice output, and run the rest of the command
line interface normally:

```
$ docker run -v $(pwd):/io -t ghcr.io/zellerlab/chamois predict -i tests/data/BGC0000703.4.gbk -o tests/data/BGC0000703.4.hdf5
```

### Singularity / Apptainer[#](#singularity-apptainer "Link to this heading")

A recipe for Singularity / Apptainer containers is available in the project
repository. Clone the repository and then build the image with:

```
$ git clone https://github.com/zellerlab/CHAMOIS
$ cd CHAMOIS
$ singularity build --fakeroot chamois.sif pkg/singularity/chamois.def
```

Then run the image and analyze the files in the local directory:

```
$ singularity run chamois.sif predict -i tests/data/BGC0000703.4.gbk -o tests/data/BGC0000703.4.hdf5
```

[previous

User Guide](index.html "previous page")
[next

Publications](publications.html "next page")

On this page

* [Local Setup](#local-setup)
  + [PyPi](#pypi)
  + [Conda](#conda)
  + [GitHub + `pip`](#github-pip)
  + [GitHub + `build`](#github-build)
* [Containers](#containers)
  + [Docker](#docker)
  + [Singularity / Apptainer](#singularity-apptainer)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/guide/install.rst)

### This Page

* [Show Source](../_sources/guide/install.rst.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.