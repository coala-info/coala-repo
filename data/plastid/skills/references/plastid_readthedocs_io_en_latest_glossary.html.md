[plastid](index.html)

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
* Glossary of terms
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
* Glossary of terms
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/glossary.rst)

---

# Glossary of terms[¶](#glossary-of-terms "Permalink to this headline")

0-indexed[¶](#term-0-indexed "Permalink to this term")

0-indexed coordinates[¶](#term-0-indexed-coordinates "Permalink to this term")
:   In [0-indexed](#term-0-indexed) coordinate systems, the first position or coordinate
    is labeled 0. [0-indexed coordinates](#term-0-indexed-coordinates) are typical in Python,
    where all slicing and indexing of lists, strings, and all other sliceable
    objects occurs in [0-indexed](#term-0-indexed) and [half-open](#term-half-open) coordinate
    representation.

    In contrast, see [1-indexed coordinates](#term-1-indexed-coordinates). For a detailed discussion
    with examples, see [Coordinate systems used in genomics](concepts/coordinates.html).

1-indexed[¶](#term-1-indexed "Permalink to this term")

1-indexed coordinates[¶](#term-1-indexed-coordinates "Permalink to this term")
:   In [1-indexed](#term-1-indexed) coordinate systems, the first position or coordinate
    is labeled 1. In contrast, see [0-indexed coordinates](#term-0-indexed-coordinates). For
    a detailed discussion with examples, see [Coordinate systems used in genomics](concepts/coordinates.html).

alignment[¶](#term-alignment "Permalink to this term")

read alignments[¶](#term-read-alignments "Permalink to this term")
:   A record matching a short sequence of DNA or RNA to a region of identical or similar
    sequence in a genome. In a [high-throughput sequencing](#term-high-throughput-sequencing) experiment,
    alignment of short reads identifies the genomic coordinates from which
    each read presumably derived.

    These are produced by running sequencing
    data through alignment programs, such as [Bowtie](http://bowtie-bio.sourceforge.net/manual.shtml), [Tophat](http://tophat.cbcb.umd.edu/), or [BWA](http://bio-bwa.sourceforge.net).
    The most common format for short read alignments is [BAM](http://samtools.github.io/hts-specs/).

annotation[¶](#term-annotation "Permalink to this term")
:   A file that describes locations and properties of [features](#term-feature)
    (e.g. genes, mRNAs, SNPs, start codons) in a genome. Annotation files
    come in various formats, such as [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1), [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html), [GTF2](http://mblab.wustl.edu/GTF22.html), [GFF3](http://www.sequenceontology.org/gff3.shtml),
    and [PSL](http://genome.ucsc.edu/FAQ/FAQformat.html#format2), among others. In a [high-throughput sequencing](#term-high-throughput-sequencing)
    experiment, it is essential to make sure that the coordinates in the
    [annotation](#term-annotation) correspond to the [genome build](#term-genome-build) used
    to generate the alignments.

count file[¶](#term-count-file "Permalink to this term")
:   A file that assigns quantitative data – for example, read alignment
    counts, or conservation scores – to genomic coordinates. Strictly
    speaking, these include [bedGraph](http://genome.ucsc.edu/goldenpath/help/bedgraph.html) or [wiggle](http://genome.ucsc.edu/goldenpath/help/wiggle.html) files but [`plastid`](generated/plastid.html#module-plastid "plastid")
    can also treat [alignment](#term-alignment) files in [bowtie](http://bowtie-bio.sourceforge.net/manual.shtml) or [BAM](http://samtools.github.io/hts-specs/) format
    as count files, if a [mapping rule](#term-mapping-rule) is applied.

counts[¶](#term-counts "Permalink to this term")
:   Colloquially, the number of [read alignments](#term-read-alignments) overlapping a region
    of interest, or mapped to a nucleotide.

crossmap[¶](#term-crossmap "Permalink to this term")
:   A [mask file](#term-mask-file) that annotates regions of the genome that give rise to
    multimapping reads under given alignment criteria. Crossmaps may be made
    using the [`crossmap`](generated/plastid.bin.crossmap.html#module-plastid.bin.crossmap "plastid.bin.crossmap") script

deep sequencing[¶](#term-deep-sequencing "Permalink to this term")

high-throughput sequencing[¶](#term-high-throughput-sequencing "Permalink to this term")
:   A group of experimental techniques that produce as output millions of
    reads (strings) of short DNA sequences.

DMS-seq[¶](#term-DMS-seq "Permalink to this term")
:   An RNA structure probing technique using [high-throughput sequencing](#term-high-throughput-sequencing).
    See [[RZW+14](zreferences.html#id7 "Silvi Rouskin, Meghan Zubradt, Stefan Washietl, Manolis Kellis, and Jonathan S Weissman. Genome-wide probing of rna structure reveals active unfolding of mrna structures in vivo. Nature, 505(7485):701-5, Jan 2014. URL: http://view.ncbi.nlm.nih.gov/pubmed/24336214, doi:10.1038/nature12894.")] for details.

Extended BED[¶](#term-Extended-BED "Permalink to this term")

BED X+Y[¶](#term-BED-X-Y "Permalink to this term")
:   Extended [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) files contain 3-12 columns of [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1)-formatted data (x),
    plus additional (y) tab-delimited columns of arbitrary data.
    The [ENCODE](https://www.encodeproject.org/) project has created several such formats (for a complete
    list, see the [UCSC file format FAQ](http://genome.ucsc.edu/FAQ/FAQformat.html)), including:

    > * [Broad peak](https://genome.ucsc.edu/FAQ/FAQformat.html#format13) (BED 6+3)
    > * [Narrow peak](https://genome.ucsc.edu/FAQ/FAQformat.html#format12) (BED 6+4)
    > * [tagAlign](https://genome.ucsc.edu/FAQ/FAQformat.html#format15) (BED 3+3)

    [`plastid`](generated/plastid.html#module-plastid "plastid") supports reading BED X+Y formats via the extra\_columns keyword that can be
    passed to [`BED_Reader`](generated/plastid.readers.bed.html#plastid.readers.bed.BED_Reader "plastid.readers.bed.BED_Reader"), or the
    [`from_bed()`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain.from_bed "plastid.genomics.roitools.SegmentChain.from_bed") method of [`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain")
    and [`Transcript`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript"). It also supports writing BED 12+Y formats via the same keyword
    passed to the [`as_bed()`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain.as_bed "plastid.genomics.roitools.SegmentChain.as_bed").

factory function[¶](#term-factory-function "Permalink to this term")
:   A function that produces functions

FDR[¶](#term-FDR "Permalink to this term")

false discovery rate[¶](#term-false-discovery-rate "Permalink to this term")
:   The [false discovery rate](#term-false-discovery-rate) is defined as the fraction
    of positive results that are false positives ([[BH95](zreferences.html#id18 "Yoav Benjamini and Yosef Hochberg. Controlling the false discovery rate: a practical and powerful approach to multiple testing. Journal of the Royal Statistical Society. Series B (Methodological), 57(1):289-300, 1995.")]):

    \[FDR = \frac{FP}{FP + TP}\]

    For example, at a 5% [false discovery rate](#term-false-discovery-rate), a set of
    20 positive results would contain approximately 1 false positive.

feature[¶](#term-feature "Permalink to this term")
:   A region of the genome with interesting or specific properties, such
    as a gene, an mRNA, an exon, a centromere, et c.

footprint[¶](#term-footprint "Permalink to this term")

ribosome-protected footprint[¶](#term-ribosome-protected-footprint "Permalink to this term")
:   A fragment of mRNA protected from nuclease digestion by a ribosome
    during ribosome profiling or other molecular biology assays.

fully-closed[¶](#term-fully-closed "Permalink to this term")

end-inclusive[¶](#term-end-inclusive "Permalink to this term")
:   In [fully-closed](#term-fully-closed) coordinate systems, the end coordinate of a
    [feature](#term-feature) is defined as the last position included in the feature.
    So, in this representation, the end coordinate of a 3-nucleotide
    [feature](#term-feature) that starts at position 3 would be 5.

    In contrast, see [half-open](#term-half-open) coordinates. For a detailed discussion,
    with examples, see [Coordinate systems used in genomics](concepts/coordinates.html).

genome assembly[¶](#term-genome-assembly "Permalink to this term")

genome build[¶](#term-genome-build "Permalink to this term")
:   A specific edition of a genome sequence for a given organism. These
    are updated over time as sequence data is added and/or corrected.
    When an assembly is updated, frequently the lengths of the chromosomes or
    contigs change as sequences are corrected.

genome browser[¶](#term-genome-browser "Permalink to this term")
:   Software used for visualizing genomic sequence, [feature](#term-feature)
    annotations, [read alignments](#term-read-alignments), and other quantitative data
    (e.g. nucleotide-wise sequence conservation). Popular genome browsers
    include [IGV](https://www.broadinstitute.org/igv/) and the [UCSC genome browser](https://genome.ucsc.edu).

half-open[¶](#term-half-open "Permalink to this term")
:   In [half-open](#term-half-open) coordinate systems, the end coordinate of a
    [feature](#term-feature) is defined as the first position **NOT** included in
    the feature. So, in this representation, the end coordinate of a
    3-nucleotide [feature](#term-feature) that starts at position 3 would be 6.

    > [half-open](#term-half-open) coordinates are typical in Python,

    where all slicing and indexing of lists, strings, or other sliceable
    objects use [0-indexed](#term-0-indexed) and [half-open](#term-half-open) coordinate representation.

    In contrast, see [fully-closed](#term-fully-closed) coordinates. For a detailed discussion
    with examples, see [Coordinate systems used in genomics](concepts/coordinates.html).

indexed file format[¶](#term-indexed-file-format "Permalink to this term")
:   A file that indexes its own data, enabling readers to selectively load
    only the portions of data that are needed. This substantially saves
    memory. Indexed data formats include [BAM](http://samtools.github.io/hts-specs/), [BigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html), [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html) and
    [tabix](http://samtools.github.io/hts-specs/)-compressed [GTF2](http://mblab.wustl.edu/GTF22.html), [GFF3](http://www.sequenceontology.org/gff3.shtml), and [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) files.
    See [Formats of data](concepts/data.html#concepts-data-formats) for further discussion.

k-mer[¶](#term-k-mer "Permalink to this term")
:   A sequence *k* nucleotides long.

mapping rule[¶](#term-mapping-rule "Permalink to this term")

mapping function[¶](#term-mapping-function "Permalink to this term")
:   A function that describes how a read alignment is mapped
    to the genome for positional analyses. Reads typically are mapped
    to their fiveprime or threeprime ends, with an offset of 0 or more
    nucleotides that can optionally depend on the read length.

    For example, ribosome-protected mRNA fragments are frequently mapped
    to their [P-site offset](#term-P-site-offset) by using a 15 nucleotide offset
    from the threeprime end of the fragment.

    See [Read mapping functions](concepts/mapping_rules.html) for an in-depth discusion, with examples.

mask file[¶](#term-mask-file "Permalink to this term")

mask annotation file[¶](#term-mask-annotation-file "Permalink to this term")
:   An [annotation](#term-annotation) file that identifies regions of the genome to
    exclude from analysis, such as repetitive regions.

    See [Excluding (masking) regions of the genome](examples/using_masks.html) for information on creating and using
    mask files.

maximal spanning window[¶](#term-maximal-spanning-window "Permalink to this term")
:   The largest possible window over which a group of regions (for example,
    transcripts) share corresponding genomic positions.

    For example,
    if a gene has a single start codon, the [maximal spanning window](#term-maximal-spanning-window)
    surrounding that start codon can be made by growing a window along the
    transcripts in the 5’ and 3’ directions, starting at the start codon,
    and stopping in each direction as soon as the next coordinate no longer
    corresponds to the same genomic position in all transcripts:

    ![Metagene - maximal spanning window](_images/metagene_maximal_spanning_window.png)

    [Maximal spanning window](#term-maximal-spanning-window) surrounding a start codon over
    a family of transcripts.[¶](#id6 "Permalink to this image")

    [Maximal spanning windows](#term-maximal-spanning-window) are often
    used in [metagene](#term-metagene) analyses.

metagene[¶](#term-metagene "Permalink to this term")

metagene average[¶](#term-metagene-average "Permalink to this term")
:   An average of quantitative data over one or more
    genomic regions (often genes or transcripts) aligned at some internal feature.
    For example, a [metagene](#term-metagene) profile could be built around:

    > * the average of ribosome density surrounding the start codons of all
    >   transcripts in a [ribosome profiling](#term-ribosome-profiling) dataset
    > * an average phylogenetic conservation score surounding the 5’ splice
    >   site of the first introns of all transcripts

    See [Performing metagene analyses](examples/metagene.html) and/or the module documentation for the
    [`metagene`](generated/plastid.bin.metagene.html#module-plastid.bin.metagene "plastid.bin.metagene") script for more explanation.

multimap[¶](#term-multimap "Permalink to this term")

multimapping[¶](#term-multimapping "Permalink to this term")
:   A read that aligns equally well (or nearly-equally well) to multiple
    regions in a genome or transcriptome is said to be [multimapping](#term-multimapping)
    in that genome or transcriptome.

    [Multimap