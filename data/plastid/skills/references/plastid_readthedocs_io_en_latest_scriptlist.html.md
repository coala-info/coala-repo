[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* [Tour](tour.html)
* [Installation](installation.html)
* [Demo dataset](test_dataset.html)
* List of command-line scripts

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
* Command-line scripts
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/scriptlist.rst)

---

# Command-line scripts[¶](#command-line-scripts "Permalink to this headline")

[`plastid`](generated/plastid.html#module-plastid "plastid") includes the following command-line scripts. Click on a name below for more information:

> |  |  |
> | --- | --- |
> | **Analysis of sequencing or quantitative data** | |
> | [`counts_in_region`](generated/plastid.bin.counts_in_region.html#module-plastid.bin.counts_in_region "plastid.bin.counts_in_region") | Count the number of [read alignments](glossary.html#term-alignment) covering arbitrary regions of interest in the genome, and calculate read densities (in reads per nucleotide and in [RPKM](glossary.html#term-RPKM)) over these regions |
> | [`cs`](generated/plastid.bin.cs.html#module-plastid.bin.cs "plastid.bin.cs") | Count the number of [read alignments](glossary.html#term-alignment) and calculate read densities (in [RPKM](glossary.html#term-RPKM)) specifically for genes and sub-regions (5’ UTR, CDS, 3’ UTR) |
> | [`get_count_vectors`](generated/plastid.bin.get_count_vectors.html#module-plastid.bin.get_count_vectors "plastid.bin.get_count_vectors") | Fetch vectors of [counts](glossary.html#term-counts) or other quantitative data at each nucleotide position in one or more regions of interest, saving each vector as its own line-delimited text file |
> | [`make_wiggle`](generated/plastid.bin.make_wiggle.html#module-plastid.bin.make_wiggle "plastid.bin.make_wiggle") | Create [wiggle](http://genome.ucsc.edu/goldenpath/help/wiggle.html) or [bedGraph](http://genome.ucsc.edu/goldenpath/help/bedgraph.html) files from alignment files after applying a read [mapping rule](glossary.html#term-mapping-rule) (e.g. to map [ribosome-protected footprints](glossary.html#term-footprint) at their [P-sites](glossary.html#term-P-site-offset)), for visualization in a [genome browser](glossary.html#term-genome-browser) |
> | [`metagene`](generated/plastid.bin.metagene.html#module-plastid.bin.metagene "plastid.bin.metagene") | Compute a [metagene](glossary.html#term-metagene) profile of [read alignments](glossary.html#term-read-alignments), [counts](glossary.html#term-counts), or quantitative data over one or more regions of interest, optionally applying a [mapping rule](glossary.html#term-mapping-rule) |
> | [`phase_by_size`](generated/plastid.bin.phase_by_size.html#module-plastid.bin.phase_by_size "plastid.bin.phase_by_size") | Estimate [sub-codon phasing](glossary.html#term-sub-codon-phasing) in [ribosome profiling](glossary.html#term-ribosome-profiling) data |
> | [`psite`](generated/plastid.bin.psite.html#module-plastid.bin.psite "plastid.bin.psite") | Estimate position of ribosomal P-site within [ribosome profiling](glossary.html#term-ribosome-profiling) [read alignments](glossary.html#term-read-alignments) as a function of read length |
> | **Generating or modifying genome annotations** | |
> | [`crossmap`](generated/plastid.bin.crossmap.html#module-plastid.bin.crossmap "plastid.bin.crossmap") | Generate a [mask file](glossary.html#term-mask-file) annotating regions of the genome that fail to produce uniquely mapping reads under various alignment criteria, so that they may be excluded from future analyses |
> | [`gff_parent_types`](generated/plastid.bin.gff_parent_types.html#module-plastid.bin.gff_parent_types "plastid.bin.gff_parent_types") | Examine parent-child relationships of features in a [GFF3](http://www.sequenceontology.org/gff3.shtml) file |
> | [`reformat_transcripts`](generated/plastid.bin.reformat_transcripts.html#module-plastid.bin.reformat_transcripts "plastid.bin.reformat_transcripts") | Convert transcripts between [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1), [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html), [GTF2](http://mblab.wustl.edu/GTF22.html), [GFF3](http://www.sequenceontology.org/gff3.shtml), and [PSL](http://genome.ucsc.edu/FAQ/FAQformat.html#format2) formats |
> | [`findjuncs`](generated/plastid.bin.findjuncs.html#module-plastid.bin.findjuncs "plastid.bin.findjuncs") | Find all unique splice junctions in one or more transcript annotations, and optionally export these in [Tophat](http://tophat.cbcb.umd.edu/)’s `.juncs` format |
> | [`slidejuncs`](generated/plastid.bin.slidejuncs.html#module-plastid.bin.slidejuncs "plastid.bin.slidejuncs") | Compare splice junctions discovered in data to those in an annotation of known splice junctions, and, if possible with equal sequence support, slide discovered junctions to compatible known junctions. |

[Previous](test_dataset.html "Demo dataset")
[Next](examples.html "Tutorials")

---

© Copyright 2014-2022, Joshua G. Dunn.
Revision `d97f239d`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).