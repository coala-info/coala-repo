[genomepy](../index.html)

* [Home](../index.html)
* Installation
  + [Installation](#id1)
    - [Bioconda](#id2)
    - [Pip](#pip)
    - [Git](#git)
* [Command line documentation](command_line.html)
* [Python API documentation (core)](api_core.html)
* [Python API documentation (full)](../_autosummary/genomepy.html)
* [Configuration](config.html)
* [FAQ](help_faq.html)
* [About](about.html)

[genomepy](../index.html)

* Installation
* [Edit on GitHub](https://github.com/vanheeringen-lab/genomepy/blob/develop/docs/content/installation.rst)

---

# Installation[](#installation "Permalink to this heading")

## Installation[](#id1 "Permalink to this heading")

genomepy requires Python 3.9+

You can install genomepy via [bioconda](https://bioconda.github.io/), pip or git.

### Bioconda[](#id2 "Permalink to this heading")

```
$ conda install -c conda-forge -c bioconda 'genomepy>=0.16'
```

### Pip[](#pip "Permalink to this heading")

```
$ pip install genomepy
```

With the Pip installation, you will have to install additional dependencies, and make them available in your PATH.

To read/write bgzipped genomes you will have to install `pysam`.

If you want to use gene annotation features, you will have to install the following utilities:

* `genePredToBed`
* `genePredToGtf`
* `bedToGenePred`
* `gtfToGenePred`
* `gff3ToGenePred`

You can find the binaries [here](http://hgdownload.cse.ucsc.edu/admin/exe/).

### Git[](#git "Permalink to this heading")

[``](#id3)[`](#id5)bash
$ git clone <https://github.com/vanheeringen-lab/genomepy.git>
$ conda env create -n genomepy -f genomepy/environment.yml
$ conda activate genomepy

[Previous](../index.html "genomepy: genes and genomes at your fingertips!")
[Next](command_line.html "Command line documentation")

---

© Copyright Siebren Frölich, Maarten van der Sande, Tilman Schäfers and Simon van Heeringen.
Last updated on 2025-09-30, 12:32 (UTC).

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).