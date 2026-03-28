[hicstuff](index.html)

latest

* Installation
* [Quickstart](#id1)
* [hicstuff command line interface demo](notebooks/demo_cli.html)
* [hicstuff API demo](notebooks/demo_api.html)

* [hicstuff package](api/hicstuff.html)

[hicstuff](index.html)

* [Docs](index.html) »
* Installation
* [Edit on GitHub](https://github.com/koszullab/hicstuff/blob/master/doc/quickstart.rst)

---

# Installation[¶](#installation "Permalink to this headline")

First, make sure you have the third party dependencies:

* [samtools](https://www.htslib.org/)
* [minimap2](https://github.com/lh3/minimap2)
* [bowtie2](https://github.com/BenLangmead/bowtie2)

You can then install hicstuff latest stable version using pip:

```
pip3 install --user hicstuff
```

Or the latest development (unstable) version using:

```
pip3 install -e git+https://github.com/koszullab/hicstuff.git@master#egg=hicstuff
```

# Quickstart[¶](#id1 "Permalink to this headline")

The fastest way to generate Hi-C matrices is to use the hicstuff pipeline command:

```
hicstuff pipeline -g bt2_index for.fq rev.fq
```

However, you most likely want to have a look at [the command line help](https://hicstuff.readthedocs.io/en/latest/api/hicstuff.html#hicstuff.commands.Pipeline) to select appropriate options, such as the enzyme used in the experiment. The help can be displayed using:

```
hicstuff pipeline --help
```

Matrices generated in the default coordinate format can then be visualised using the [view](https://hicstuff.readthedocs.io/en/latest/api/hicstuff.html#hicstuff.commands.View) command, modified using the [rebin](https://hicstuff.readthedocs.io/en/latest/api/hicstuff.html#hicstuff.commands.Rebin) and [convert](https://hicstuff.readthedocs.io/en/latest/api/hicstuff.html#hicstuff.commands.Convert) commands, or used as input for other softwares.

[Next](notebooks/demo_cli.html "hicstuff command line interface demo")
 [Previous](index.html "Welcome to hicstuff’s documentation!")

---

© Copyright 2018, Cyril Matthey-Doret
Revision `b44fbed8`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).