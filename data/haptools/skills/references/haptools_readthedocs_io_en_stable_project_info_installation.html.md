[haptools](../index.html)

Overview

* Installation
  + [Using pip](#using-pip)
  + [Using conda](#using-conda)
  + [Installing the latest, unreleased version](#installing-the-latest-unreleased-version)
  + [Development installation](#development-installation)
* [Example files](example_files.html)
* [Contributing](contributing.html)

File Formats

* [Genotypes](../formats/genotypes.html)
* [Haplotypes](../formats/haplotypes.html)
* [Phenotypes and Covariates](../formats/phenotypes.html)
* [Linkage disequilibrium](../formats/ld.html)
* [Summary Statistics](../formats/linear.html)
* [Causal SNPs](../formats/snplist.html)
* [Breakpoints](../formats/breakpoints.html)
* [Sample Info](../formats/sample_info.html)
* [Models](../formats/models.html)
* [Maps](../formats/maps.html)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* Installation
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/project_info/installation.rst)

---

# Installation[](#installation "Link to this heading")

## Using pip[](#using-pip "Link to this heading")

You can install `haptools` from PyPI using `pip`.

Note

We recommend using `pip >= 20.3`.

```
pip install 'pip>=20.3'
```

```
pip install haptools
```

## Using conda[](#using-conda "Link to this heading")

We also support installing `haptools` from bioconda using `conda`.

```
conda install -c conda-forge -c bioconda haptools
```

## Installing the latest, unreleased version[](#installing-the-latest-unreleased-version "Link to this heading")

Can’t wait for us to tag and release our most recent updates? You can install `haptools` directly from the `main` branch of our Github repository using `pip`.

```
pip install --upgrade --force-reinstall git+https://github.com/cast-genomics/haptools.git
```

## Development installation[](#development-installation "Link to this heading")

If you would like to edit and work with the source code, please refer to [these instructions](contributing.html#dev-setup-instructions) for a different installation setup.

[Previous](../index.html "haptools")
[Next](example_files.html "Example files")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).