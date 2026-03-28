[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* [Installation](installation.html)
* [Demo dataset](test_dataset.html)
* [List of command-line scripts](scriptlist.html)

User manual

* Tutorials
  + [Cookbook](#cookbook)
    - [Setting up a genome for analysis](examples/a1_genome_setup.html)
    - [A simple alignment and quantitation workflow](examples/a2_sample_processing.html)
    - [Arrays of counts at each transcript position](examples/count_vector.html)
    - [Gene expression analysis](examples/gene_expression.html)
    - [Creating custom BED, BigBed, and GTF2 annotation files](examples/make_annotation.html)
    - [Performing metagene analyses](examples/metagene.html)
    - [Determine P-site offsets for ribosome profiling data](examples/p_site.html)
    - [Read phasing in ribosome profiling](examples/phasing.html)
    - [Manipulating feature sequences](examples/sequence.html)
    - [Excluding (masking) regions of the genome](examples/using_masks.html)
    - [Plotting tools](examples/z_plotting.html)
  + [In-depth](#in-depth)
    - [Coordinate systems used in genomics](concepts/coordinates.html)
    - [Categories and formats of genomics data](concepts/data.html)
    - [Working with GFF files](concepts/gff3.html)
    - [Read mapping functions](concepts/mapping_rules.html)
    - [Ambiguous read alignments](concepts/multimappers.html)
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
* Tutorials
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/examples.rst)

---

# Tutorials[¶](#tutorials "Permalink to this headline")

Tutorials are divided into two sections:

> * The [Cookbook](#examples-cookbook) contains step-by-step instructions for
>   performing common tasks, with detailed explanations of each step
> * [In-depth](#examples-concepts) includes longer discussions of issues that arise
>   in [high-throughput sequencing](glossary.html#term-high-throughput-sequencing) and genomics, and includes code
>   examples when appropriate.

We suggest downloading the [Demo dataset](test_dataset.html) and following along.

## Cookbook[¶](#cookbook "Permalink to this headline")

|  |  |
| --- | --- |
| **Tutorial** | **Contents** |
| [Setting up a genome for analysis](examples/a1_genome_setup.html) | Set up a genome for downstream analysis, using [`plastid`](generated/plastid.html#module-plastid "plastid") or other toolkits |
| [A simple alignment and quantitation workflow](examples/a2_sample_processing.html) | Simplified workflow of how to align sequencing data |
| [Arrays of counts at each transcript position](examples/count_vector.html) | Retrieve a vector of [high-throughput sequencing](glossary.html#term-high-throughput-sequencing) [counts](glossary.html#term-counts) at each position in a transcript |
| [Manipulating feature sequences](examples/sequence.html) | Fetch the sequences of regions of interest (e.g. transcripts) from a genome |
| [Gene expression & translation efficiency](examples/gene_expression.html) | Compute gene expression measurements and translation efficicency using RNA-seq & [ribosome profiling](glossary.html#term-ribosome-profiling), and prepare data for differential expression analysis |
| [Excluding (masking) regions of the genome](examples/using_masks.html) | Exclude specific regions – for example, repetitive genome sequence that gives rise to [multimapping](glossary.html#term-multimapping) reads – from analysis. Discussion of [mask files](glossary.html#term-mask-file). |
| [Creating custom BED, BigBed, and GTF2 annotation files](examples/make_annotation.html) | Make a [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1), [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html), [GTF2](http://mblab.wustl.edu/GTF22.html), or [GFF3](http://www.sequenceontology.org/gff3.shtml) file containing custom [features](glossary.html#term-feature). |
| [Metagene analysis](examples/metagene.html) | Perform [metagene analysis](glossary.html#term-metagene), using [ribosome profiling](glossary.html#term-ribosome-profiling) data at the start codon as an example. Then, develop metagene analysis around a custom landmark for use with other data types |
| [Ribosomal P-site offsets](examples/p_site.html) | Determine a [P-site offset](glossary.html#term-P-site-offset) from [ribosome profiling](glossary.html#term-ribosome-profiling) data |
| [Read phasing in ribosome profiling](examples/phasing.html) | Estimate [read phasing (triplet periodicity)](glossary.html#term-sub-codon-phasing) of [ribosome profiling](glossary.html#term-ribosome-profiling) data |
| [Plotting tools](examples/z_plotting.html) | Demos of plotting tools in [`plastid.plotting`](generated/plastid.plotting.html#module-plastid.plotting "plastid.plotting") |

## In-depth[¶](#in-depth "Permalink to this headline")

|  |  |
| --- | --- |
| **Tutorial** | **Contents** |
| [Categories and formats of genomics data](concepts/data.html) | Introduction & discussion to the types of data used in genomics, and the advantages and disadvantages of their various file formats |
| [Coordinate systems used in genomics](concepts/coordinates.html) | Primer on the various coordinate systems used in genomics |
| [Ambiguous read alignments](concepts/multimappers.html) | Issues arising when and strategies for handling [multimapping](glossary.html#term-multimapping) reads |
| [Read mapping functions](concepts/mapping_rules.html) | In-depth discussion of [mapping rules](glossary.html#term-mapping-rule), with code examples of how to write your own [mapping rule](glossary.html#term-mapping-rule) for your own sequencing data type |

[Previous](scriptlist.html "Command-line scripts")
[Next](examples/a1_genome_setup.html "Setting up a genome for analysis")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).