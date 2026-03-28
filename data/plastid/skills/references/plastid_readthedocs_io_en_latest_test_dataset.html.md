[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* [Installation](installation.html)
* Demo dataset
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

[plastid](index.html)

* »
* Demo dataset
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/test_dataset.rst)

---

# Demo dataset[¶](#demo-dataset "Permalink to this headline")

We have put together a small demo dataset that is used in the [Tour](tour.html)
and in [Tutorials](examples.html). It consists of feature annotations,
ribosome profiling data, and RNA-seq from the merlin
(laboratory) strain of human cytomegalovirus (hCMV).

Downloads:

> * [demo dataset part one](https://www.dropbox.com/s/abktvrngn1lnzpb/plastid_demo.tar.bz2?dl=0), for all of the tutorials
> * [demo dataset part two](https://www.dropbox.com/s/43xsvu7dz00k3q0/plastid_demo_part2.tar.bz2?dl=0), specifically used in
>   [Gene expression analysis](examples/gene_expression.html).

Part 1 includes the following files:

> |  |  |  |
> | --- | --- | --- |
> | **Filename** | **Contents** | **Source** |
> | `merlin_NC006273-2.fa` | Sequence of hCMV merlin strain | [GenBank, accession no. NC\_006273.2](http://www.ncbi.nlm.nih.gov/nuccore/NC_006273.2) |
> | `merlin_orfs.bed`, `merlin_orfs.gtf` | Coding region models for hCMV strain, plus estimated UTRs | [[SGWM+12](zreferences.html#id15 "Noam Stern-Ginossar, Ben Weisburd, Annette Michalski, Vu Thuy Khanh Le, Marco Y Hein, Sheng-Xiong Huang, Ming Ma, Ben Shen, Shu-Bing Qian, Hartmut Hengel, Matthias Mann, Nicholas T Ingolia, and Jonathan S Weissman. Decoding human cytomegalovirus. Science, 338(6110):1088-93, 2012. doi:10.1126/science.1227919.")] (CDS). 5’ UTRs estimated as 50 nt upstream of CDS. 3’ UTRs estimated as 100 nt downstream of CDS. |
> | `SRR609197_riboprofile_5hr_rep1.bam` | [Ribosome profiling](glossary.html#term-ribosome-profiling) data, 5 hours post hCMV infection, aligned to hCMV merlin strain genome sequence | [[SGWM+12](zreferences.html#id15 "Noam Stern-Ginossar, Ben Weisburd, Annette Michalski, Vu Thuy Khanh Le, Marco Y Hein, Sheng-Xiong Huang, Ming Ma, Ben Shen, Shu-Bing Qian, Hartmut Hengel, Matthias Mann, Nicholas T Ingolia, and Jonathan S Weissman. Decoding human cytomegalovirus. Science, 338(6110):1088-93, 2012. doi:10.1126/science.1227919.")], raw data available at [SRA, accession no. SRR609197](http://www.ncbi.nlm.nih.gov/sra/?term=SRR609197) |
> | `SRR592963_rnaseq_5hr_rep1.bam` | RNA-seq data, 5 hours post CMV infection, aligned to hCMV merlin strain genome sequence | [[SGWM+12](zreferences.html#id15 "Noam Stern-Ginossar, Ben Weisburd, Annette Michalski, Vu Thuy Khanh Le, Marco Y Hein, Sheng-Xiong Huang, Ming Ma, Ben Shen, Shu-Bing Qian, Hartmut Hengel, Matthias Mann, Nicholas T Ingolia, and Jonathan S Weissman. Decoding human cytomegalovirus. Science, 338(6110):1088-93, 2012. doi:10.1126/science.1227919.")], raw data available at [SRA, accession no. SRR592963](http://www.ncbi.nlm.nih.gov/sra/?term=SRR592963) |

Part 2 includes further replicates, as well as timepoint data from 24 hours
post-infection.

[Previous](installation.html "Installation")
[Next](scriptlist.html "Command-line scripts")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).