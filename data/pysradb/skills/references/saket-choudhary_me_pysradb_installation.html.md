Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[pysradb 3.0.0.dev0 documentation](index.html)

[![Logo](_static/pysradb_v3.png)

pysradb 3.0.0.dev0 documentation](index.html)

* Installation
* [Quickstart](quickstart.html)
* [CLI](cmdline.html)
* [Python API](python-api-usage.html)
* [Case Studies](case_studies.html)
* [Tutorials & Notebooks](notebooks.html)
* [API Documentation](commands.html)
* [Contributing](contributing.html)
* [Credits](authors.html)
* [History](history.html)
* [pysradb](modules.html)[ ]

Back to top

[View this page](_sources/installation.md.txt "View this page")

# Installation[¶](#installation "Link to this heading")

## Stable release[¶](#stable-release "Link to this heading")

To install pysradb, run this command in your terminal:

```
$ pip install pysradb
```

This is the preferred method to install pysradb, as it will always
install the most recent stable release.

If you don’t have [pip](https://pip.pypa.io) installed, this [Python
installation
guide](http://docs.python-guide.org/en/latest/starting/installation/)
can guide you through the process.

Alternatively, you may use conda:

```
conda install -c bioconda pysradb
```

This step will install all the dependencies except aspera-client (which
is not required, but highly recommended). If you have an existing
environment with a lot of pre-installed packages, conda might be
[slow](https://github.com/bioconda/bioconda-recipes/issues/13774).
Please consider creating a new enviroment for `pysradb`:

```
conda create -c bioconda -n pysradb PYTHON=3 pysradb
```

## From sources[¶](#from-sources "Link to this heading")

The source files for pysradb can be downloaded from the [Github
repo](https://github.com/saketkc/pysradb).

You can either clone the public repository:

```
$ git clone git://github.com/saketkc/pysradb
```

Or download the
[tarball](https://github.com/saketkc/pysradb/tarball/master):

```
$ curl  -OL https://github.com/saketkc/pysradb/tarball/master
```

Once you have a copy of the source, you can install it with:

```
$ python setup.py install
```

[Next

Quickstart](quickstart.html)
[Previous

Home](index.html)

Copyright © 2023, Saket Choudhary

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Installation
  + [Stable release](#stable-release)
  + [From sources](#from-sources)