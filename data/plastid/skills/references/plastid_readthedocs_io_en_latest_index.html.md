plastid

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* [Installation](installation.html)
* [Demo dataset](test_dataset.html)
* [List of command-line scripts](scriptlist.html)

User manual

* [Tutorials](examples.html)
* [Module documentation](generated/plastid.html)
* [Frequently asked questions](FAQ.html)
* [Glossary of terms](glossary.html)
* [References](zreferences.html)

Developer info

* [Contributing](devinfo/contributing.html)
* [Entrypoints](devinfo/entrypoints.html)

Other information

* [Citing `plastid`](citing.html)
* [License](license.html)
* [Change log](CHANGES.html)
* [Related resources](related.html)
* [Contact](contact.html)

plastid

* »
* Welcome!
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/index.rst)

---

[`plastid`](generated/plastid.html#module-plastid "plastid") 0.6.1

---

# Welcome![¶](#welcome "Permalink to this headline")

[`plastid`](generated/plastid.html#module-plastid "plastid") is a [Python](https://www.python.org/) library for genomics and sequencing. It includes
[tools for exploratory data analysis](tour.html#tour-data-structures) (EDA)
as well as a handful of [scripts](scriptlist.html) that implement common tasks.

[`plastid`](generated/plastid.html#module-plastid "plastid") differs from other packages in its design goals. Namely:

> * its intended audience includes both **bench and computational biologists**.
>   We tried to make it easy to use, and wrote lots of [Tutorials](examples.html)
> * It is designed for analyses in which data at each position
>   **within a gene or transcript** are of interest, such as analysis of
>   [ribosome profiling](glossary.html#term-ribosome-profiling) data. To this end, [`plastid`](generated/plastid.html#module-plastid "plastid")
>
>   > + uses [Read mapping functions](concepts/mapping_rules.html) to **extract the biology of interest**
>   >   from [read alignments](glossary.html#term-read-alignments) – e.g. in the case of
>   >   [ribosome profiling](glossary.html#term-ribosome-profiling), a ribosomal P-site, in [DMS-seq](glossary.html#term-DMS-seq),
>   >   sites of nucleotide modification, et c. –
>   >   and turn these into quantitative data, usually
>   >   [`numpy arrays`](https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html#numpy.ndarray "(in NumPy v1.22)") of counts at each nucleotide
>   >   position in a transcript.
>   > + **encapsulates multi-segment features**, such as spliced transcripts,
>   >   as [single objects](tour.html#tour-segment-chain). This facilitates many common
>   >   tasks, such as converting coordinates between genome and feature-centric
>   >   spaces.
> * It **separates data from its representation** on disk by providing consistent
>   interfaces to many of the various [file formats](concepts/data.html#file-format-table),
>   found in the wild.
> * It is **designed for expansion** to new or unknown assays. Frequently,
>   [writing a new mapping rule](concepts/mapping_rules.html#mapping-rules-roll-your-own) is sufficient
>   to enable all of [`plastid`](generated/plastid.html#module-plastid "plastid")’s tools to interpret data coming from a new
>   assay.

[`plastid`](generated/plastid.html#module-plastid "plastid") was written by Joshua Dunn in
[Jonathan Weissman’s lab](http://weissmanlab.ucsf.edu) at
[UCSF](http://ucsf.edu). Versions of it have been used in several publications
([[DFB+13](zreferences.html#id2 "Joshua G Dunn, Catherine K Foo, Nicolette G Belletier, Elizabeth R Gavis, and Jonathan S Weissman. Ribosome profiling reveals pervasive and regulated stop codon readthrough in drosophila melanogaster. Elife, 2(0):e01179, 2013. URL: http://view.ncbi.nlm.nih.gov/pubmed/24302569, doi:10.7554/elife.01179."), [FRJ+15](zreferences.html#id3 "Alexander P. Fields, Edwin H. Rodriguez, Marko Jovanovic, Noam Stern-Ginossar, Brian J. Haas, Philipp Mertins, Raktima Raychowdhury, Nir Hacohen, Steven A. Carr, Nicholas T. Ingolia, Aviv Regev, and Jonathan S. Weissman. A Regression-Based Analysis of Ribosome-Profiling Data Reveals a Conserved Complexity to Mammalian Translation. Molecular Cell, 60(5):816-827, Mar 2015. URL: http://www.cell.com/article/S1097276515009053/abstract (visited on 2015-12-08), doi:10.1016/j.molcel.2015.11.013.")]).

# Where to go next[¶](#where-to-go-next "Permalink to this headline")

> * **Those new to sequencing and/or bioinformatics**, and those who are
>   [ribosome profiling](glossary.html#term-ribosome-profiling) should start with [Getting started](quickstart.html), and then
>   continue to the [Tour](tour.html) and [Tutorials](examples.html). The
>   [`description of command-line scripts`](generated/plastid.bin.html#module-plastid.bin "plastid.bin") may also be helpful.
> * **Advanced users** might be more interested in a quick [Tour](tour.html) of
>   the primary data structures and the
>   [module documentation](generated/plastid.html).

---

# Site map[¶](#site-map "Permalink to this headline")

> * [Index](genindex.html)
> * [Module Index](py-modindex.html)

[Next](quickstart.html "Getting started")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).