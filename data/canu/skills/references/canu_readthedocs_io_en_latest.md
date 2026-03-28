canu

latest

* [Canu Quick Start](quick-start.html)
* [Canu FAQ](faq.html)
* [Canu Tutorial](tutorial.html)
* [Canu Pipeline](pipeline.html)
* [Canu Parameter Reference](parameter-reference.html)
* [Software Background](history.html)

canu

* Docs »
* Canu
* [Edit on GitHub](https://github.com/marbl/canu/blob/master/documentation/source/index.rst)

---

# Canu[¶](#canu "Permalink to this headline")

[Canu](http://github.com/marbl/canu) is a fork of the [Celera Assembler](http://wgs-assembler.sourceforge.net)
designed for high-noise single-molecule sequencing (such as
the PacBio RSII or Oxford Nanopore MinION).

# Publications[¶](#publications "Permalink to this headline")

Canu
:   Koren S, Walenz BP, Berlin K, Miller JR, Phillippy AM.
    [Canu: scalable and accurate long-read assembly via adaptive k-mer weighting and repeat separation](http://doi.org/10.1101/gr.215087.116). Genome Research. (2017).

TrioCanu
:   Koren S, Rhie A, Walenz BP, Dilthey AT, Bickhart DM, Kingan SB, Hiendleder S, Williams JL, Smith TPL, Phillippy AM.
    [De novo assembly of haplotype-resolved genomes with trio binning](http://doi.org/10.1038/nbt.4277). Nature Biotechnology. (2018).

HiCanu
:   Nurk S, Walenz BP, Rhiea A, Vollger MR, Logsdon GA, Grothe R, Miga KH, Eichler EE, Phillippy AM, Koren S.
    [HiCanu: accurate assembly of segmental duplications, satellites, and allelic variants from high-fidelity long reads](https://doi.org/10.1101/gr.263566.120). Genome Research. (2020).

# Install[¶](#install "Permalink to this headline")

The easiest way to get started is to download a [release](https://github.com/marbl/canu/releases). If you encounter
any issues, please report them using the [github issues](http://github.com/marbl/canu/issues) page.

Alternatively, you can also build the latest unreleased from github:

```
git clone https://github.com/marbl/canu.git
cd canu/src
make -j <number of threads>
```

# Learn[¶](#learn "Permalink to this headline")

* [Quick Start](quick-start.html#quickstart) - no experience or data required, download and assemble *Escherichia coli* today!
* [FAQ](faq.html#faq) - Frequently asked questions
* [Canu tutorial](tutorial.html#tutorial) - a gentle introduction to the complexities of canu.
* [Canu pipeline](pipeline.html#pipeline) - what, exactly, is canu doing, anyway?
* [Canu Parameter Reference](parameter-reference.html#parameter-reference) - all the parameters, grouped by function.
* [Canu History](history.html#history) - the history of the Canu project.

[Next](quick-start.html "Canu Quick Start")

---

© Copyright 2015-2020, Adam Phillippy, Sergey Koren, Brian Walenz
Revision `f265325f`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).