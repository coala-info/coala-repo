[plastid](../index.html)

latest

Getting started

* [Getting started](../quickstart.html)
* [Tour](../tour.html)
* [Installation](../installation.html)
* [Demo dataset](../test_dataset.html)
* [List of command-line scripts](../scriptlist.html)

User manual

* [Tutorials](../examples.html)
* Module documentation
  + [Package overview](#package-overview)
  + [Subpackages](#subpackages)
    - [plastid.bin package](plastid.bin.html)
    - [plastid.genomics package](plastid.genomics.html)
    - [plastid.plotting package](plastid.plotting.html)
    - [plastid.readers package](plastid.readers.html)
    - [plastid.util package](plastid.util.html)
* [Frequently asked questions](../FAQ.html)
* [Glossary of terms](../glossary.html)
* [References](../zreferences.html)

Developer info

* [Contributing](../devinfo/contributing.html)
* [Entrypoints](../devinfo/entrypoints.html)

Other information

* [Citing `plastid`](../citing.html)
* [License](../license.html)
* [Change log](../CHANGES.html)
* [Related resources](../related.html)
* [Contact](../contact.html)

[plastid](../index.html)

* »
* plastid package
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/generated/plastid.rst)

---

# plastid package[¶](#module-plastid "Permalink to this headline")

Welcome to plastid!

This package contains various utilities for analyzing high-throughput sequencing
data, with an emphasis on simplicity for users. To this end, this package provides:

> 1. A set of command-line scripts that implement common sequencing workflows
>    (see [`plastid.bin`](plastid.bin.html#module-plastid.bin "plastid.bin")).
> 2. Readers that abstract data from various file formats into a minimal set of
>    object types. These object types define APIs that easily interface with
>    existing scientific tools, such as the [SciPy](http://docs.scipy.org/doc/scipy/reference/) stack (see [`plastid.genomics`](plastid.genomics.html#module-plastid.genomics "plastid.genomics") and
>    [`plastid.readers`](plastid.readers.html#module-plastid.readers "plastid.readers"))
> 3. Tools to facilitate writing command-line scripts (see [`plastid.util.scriptlib`](plastid.util.scriptlib.html#module-plastid.util.scriptlib "plastid.util.scriptlib"))

## Package overview[¶](#package-overview "Permalink to this headline")

plastid is divided into the following subpackages:

> |  |  |
> | --- | --- |
> | Package | Contents |
> | [`plastid.bin`](plastid.bin.html#module-plastid.bin "plastid.bin") | Command-line scripts |
> | [`plastid.genomics`](plastid.genomics.html#module-plastid.genomics "plastid.genomics") | Classes and functions to manipulate genome annotations, alignments, and quantitative data |
> | [`plastid.plotting`](plastid.plotting.html#module-plastid.plotting "plastid.plotting") | Tools for plotting |
> | [`plastid.readers`](plastid.readers.html#module-plastid.readers "plastid.readers") | Parsers for various file formats |
> | [`plastid.util`](plastid.util.html#module-plastid.util "plastid.util") | Utilities (e.g. function decorators, exceptions, argument parsers) |
> | `plastid.test` | Unit and functional tests (requires download of test datasets) |

## Subpackages[¶](#subpackages "Permalink to this headline")

* [plastid.bin package](plastid.bin.html)
  + [Submodules](plastid.bin.html#submodules)
    - [plastid.bin.counts\_in\_region module](plastid.bin.counts_in_region.html)
      * [See also](plastid.bin.counts_in_region.html#see-also)
    - [plastid.bin.crossmap module](plastid.bin.crossmap.html)
      * [Output files](plastid.bin.crossmap.html#output-files)
      * [Considerations for large genomes](plastid.bin.crossmap.html#considerations-for-large-genomes)
    - [plastid.bin.cs module](plastid.bin.cs.html)
      * [See also](plastid.bin.cs.html#see-also)
    - [plastid.bin.findjuncs module](plastid.bin.findjuncs.html)
      * [See also](plastid.bin.findjuncs.html#see-also)
    - [plastid.bin.get\_count\_vectors module](plastid.bin.get_count_vectors.html)
      * [Output files](plastid.bin.get_count_vectors.html#output-files)
    - [plastid.bin.gff\_parent\_types module](plastid.bin.gff_parent_types.html)
    - [plastid.bin.make\_wiggle module](plastid.bin.make_wiggle.html)
      * [Output files](plastid.bin.make_wiggle.html#output-files)
      * [See also](plastid.bin.make_wiggle.html#see-also)
    - [plastid.bin.metagene module](plastid.bin.metagene.html)
    - [plastid.bin.phase\_by\_size module](plastid.bin.phase_by_size.html)
      * [Output files](plastid.bin.phase_by_size.html#output-files)
    - [plastid.bin.psite module](plastid.bin.psite.html)
      * [Notes](plastid.bin.psite.html#notes)
      * [Output files](plastid.bin.psite.html#output-files)
    - [plastid.bin.reformat\_transcripts module](plastid.bin.reformat_transcripts.html)
    - [plastid.bin.slidejuncs module](plastid.bin.slidejuncs.html)
      * [Output files](plastid.bin.slidejuncs.html#output-files)
    - [plastid.bin.test\_table\_equality module](plastid.bin.test_table_equality.html)
* [plastid.genomics package](plastid.genomics.html)
  + [Package overview](plastid.genomics.html#package-overview)
  + [Submodules](plastid.genomics.html#submodules)
    - [plastid.genomics.c\_common module](plastid.genomics.c_common.html)
    - [plastid.genomics.c\_common module](plastid.genomics.c_common.html)
    - [plastid.genomics.c\_common module](plastid.genomics.c_common.html)
    - [plastid.genomics.genome\_array module](plastid.genomics.genome_array.html)
      * [Summary](plastid.genomics.genome_array.html#summary)
      * [Module contents](plastid.genomics.genome_array.html#module-contents)
      * [Extended summary & examples](plastid.genomics.genome_array.html#extended-summary-examples)
    - [plastid.genomics.genome\_hash module](plastid.genomics.genome_hash.html)
      * [Summary](plastid.genomics.genome_hash.html#summary)
      * [Module contents](plastid.genomics.genome_hash.html#module-contents)
      * [Examples](plastid.genomics.genome_hash.html#examples)
    - [plastid.genomics.map\_factories module](plastid.genomics.map_factories.html)
      * [Summary](plastid.genomics.map_factories.html#summary)
      * [Extended summary](plastid.genomics.map_factories.html#extended-summary)
      * [Examples](plastid.genomics.map_factories.html#examples)
      * [Implementation](plastid.genomics.map_factories.html#implementation)
      * [See also](plastid.genomics.map_factories.html#see-also)
    - [plastid.genomics.map\_factories module](plastid.genomics.map_factories.html)
      * [Summary](plastid.genomics.map_factories.html#summary)
      * [Extended summary](plastid.genomics.map_factories.html#extended-summary)
      * [Examples](plastid.genomics.map_factories.html#examples)
      * [Implementation](plastid.genomics.map_factories.html#implementation)
      * [See also](plastid.genomics.map_factories.html#see-also)
    - [plastid.genomics.map\_factories module](plastid.genomics.map_factories.html)
      * [Summary](plastid.genomics.map_factories.html#summary)
      * [Extended summary](plastid.genomics.map_factories.html#extended-summary)
      * [Examples](plastid.genomics.map_factories.html#examples)
      * [Implementation](plastid.genomics.map_factories.html#implementation)
      * [See also](plastid.genomics.map_factories.html#see-also)
    - [plastid.genomics.roitools module](plastid.genomics.roitools.html)
      * [Summary](plastid.genomics.roitools.html#summary)
      * [Examples](plastid.genomics.roitools.html#examples)
    - [plastid.genomics.roitools module](plastid.genomics.roitools.html)
      * [Summary](plastid.genomics.roitools.html#summary)
      * [Examples](plastid.genomics.roitools.html#examples)
    - [plastid.genomics.roitools module](plastid.genomics.roitools.html)
      * [Summary](plastid.genomics.roitools.html#summary)
      * [Examples](plastid.genomics.roitools.html#examples)
    - [plastid.genomics.seqtools module](plastid.genomics.seqtools.html)
      * [Contents](plastid.genomics.seqtools.html#contents)
    - [plastid.genomics.splicing module](plastid.genomics.splicing.html)
* [plastid.plotting package](plastid.plotting.html)
  + [Submodules](plastid.plotting.html#submodules)
    - [plastid.plotting.colors module](plastid.plotting.colors.html)
    - [plastid.plotting.plots module](plastid.plotting.plots.html)
      * [General plots](plastid.plotting.plots.html#general-plots)
      * [Plots for genomics](plastid.plotting.plots.html#plots-for-genomics)
    - [plastid.plotting.plotutils module](plastid.plotting.plotutils.html)
* [plastid.readers package](plastid.readers.html)
  + [Package overview](plastid.readers.html#package-overview)
  + [Submodules](plastid.readers.html#submodules)
    - [plastid.readers.autosql module](plastid.readers.autosql.html)
      * [Summary](plastid.readers.autosql.html#summary)
      * [Module contents](plastid.readers.autosql.html#module-contents)
      * [Notes](plastid.readers.autosql.html#notes)
      * [See Also](plastid.readers.autosql.html#see-also)
    - [plastid.readers.bbifile module](plastid.readers.bbifile.html)
      * [See also](plastid.readers.bbifile.html#see-also)
    - [plastid.readers.bbifile module](plastid.readers.bbifile.html)
      * [See also](plastid.readers.bbifile.html#see-also)
    - [plastid.readers.bbifile module](plastid.readers.bbifile.html)
      * [See also](plastid.readers.bbifile.html#see-also)
    - [plastid.readers.bed module](plastid.readers.bed.html)
      * [Module contents](plastid.readers.bed.html#module-contents)
      * [Examples](plastid.readers.bed.html#examples)
      * [See Also](plastid.readers.bed.html#see-also)
    - [plastid.readers.bigbed module](plastid.readers.bigbed.html)
      * [Summary](plastid.readers.bigbed.html#summary)
      * [Module Contents](plastid.readers.bigbed.html#module-contents)
      * [Examples](plastid.readers.bigbed.html#examples)
      * [See also](plastid.readers.bigbed.html#see-also)
    - [plastid.readers.bigbed module](plastid.readers.bigbed.html)
      * [Summary](plastid.readers.bigbed.html#summary)
      * [Module Contents](plastid.readers.bigbed.html#module-contents)
      * [Examples](plastid.readers.bigbed.html#examples)
      * [See also](plastid.readers.bigbed.html#see-also)
    - [plastid.readers.bigbed module](plastid.readers.bigbed.html)
      * [Summary](plastid.readers.bigbed.html#summary)
      * [Module Contents](plastid.readers.bigbed.html#module-contents)
      * [Examples](plastid.readers.bigbed.html#examples)
      * [See also](plastid.readers.bigbed.html#see-also)
    - [plastid.readers.bigwig module](plastid.readers.bigwig.html)
      * [Summary](plastid.readers.bigwig.html#summary)
      * [Module Contents](plastid.readers.bigwig.html#module-contents)
      * [Examples](plastid.readers.bigwig.html#examples)
      * [See also](plastid.readers.bigwig.html#see-also)
    - [plastid.readers.bigwig module](plastid.readers.bigwig.html)
      * [Summary](plastid.readers.bigwig.html#summary)
      * [Module Contents](plastid.readers.bigwig.html#module-contents)
      * [Examples](plastid.readers.bigwig.html#examples)
      * [See also](plastid.readers.bigwig.html#see-also)
    - [plastid.readers.bigwig module](plastid.readers.bigwig.html)
      * [Summary](plastid.readers.bigwig.html#summary)
      * [Module Contents](plastid.readers.bigwig.html#module-contents)
      * [Examples](plastid.readers.bigwig.html#examples)
      * [See also](plastid.readers.bigwig.html#see-also)
    - [plastid.readers.bowtie module](plastid.readers.bowtie.html)
      * [See also](plastid.readers.bowtie.html#see-also)
    - [plastid.readers.common module](plastid.readers.common.html)
      * [Functions & classes](plastid.readers.common.html#functions-classes)
    - [plastid.readers.gff module](plastid.readers.gff.html)
      * [Summary](plastid.readers.gff.html#summary)
      * [Module contents](plastid.readers.gff.html#module-contents)
      * [Examples](plastid.readers.gff.html#examples)
      * [See Also](plastid.readers.gff.html#see-also)
    - [plastid.readers.gff\_tokens module](plastid.readers.gff_tokens.html)
      * [Important methods](plastid.readers.gff_tokens.html#important-methods)
      * [See also](plastid.readers.gff_tokens.html#see-also)
    - [plastid.readers.psl module](plastid.readers.psl.html)
    - [plastid.readers.wiggle module](plastid.readers.wiggle.html)
      * [See also](plastid.readers.wiggle.html#see-also)
* [plastid.util package](plastid.util.html)
  + [Package overview](plastid.util.html#package-overview)
  + [Subpackages](plastid.util.html#subpackages)
    - [plastid.util.io package](plastid.util.io.html)
      * [Package overview](plastid.util.io.html#package-overview)
      * [Submodules](plastid.util.io.html#submodules)
    - [plastid.util.scriptlib package](plastid.util.scriptlib.html)
      * [Package overview](plastid.util.scriptlib.html#package-overview)
      * [Submodules](plastid.util.scriptlib.html#submodules)
    - [plastid.util.services package](plastid.util.services.html)
      * [Package overview](plastid.util.services.html#package-overview)
      * [Submodules](plastid.util.services.html#submodules)
  + [Submodules](plastid.util.html#submodules)
    - [plastid.util.unique\_fifo module](plastid.util.unique_fifo.html)

[Previous](../concepts/multimappers.html "Ambiguous read alignments")
[Next](plastid.bin.html "plastid.bin package")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).