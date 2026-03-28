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
  + [Cookbook](../examples.html#cookbook)
  + [In-depth](../examples.html#in-depth)
    - [Coordinate systems used in genomics](coordinates.html)
    - Categories and formats of genomics data
      * [Types of data](#types-of-data)
      * [Formats of data](#formats-of-data)
      * [Why are there so many formats?](#why-are-there-so-many-formats)
      * [Which annotation format should I use?](#which-annotation-format-should-i-use)
      * [Getting the most out of your time & data](#getting-the-most-out-of-your-time-data)
      * [See also](#see-also)
    - [Working with GFF files](gff3.html)
    - [Read mapping functions](mapping_rules.html)
    - [Ambiguous read alignments](multimappers.html)
* [Module documentation](../generated/plastid.html)
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
* [Tutorials](../examples.html) »
* Categories and formats of genomics data
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/concepts/data.rst)

---

# Categories and formats of genomics data[¶](#categories-and-formats-of-genomics-data "Permalink to this headline")

This document contains very, very brief overviews of the types of data
encountered in genomics, and of some common file formats. It is divided into
the following sections:

* [Types of data](#types-of-data)
* [Formats of data](#formats-of-data)
* [Why are there so many formats?](#why-are-there-so-many-formats)
* [Which annotation format should I use?](#which-annotation-format-should-i-use)

  + [BED, [Extended BED](../glossary.html#term-Extended-BED), & BigBed](#bed-extended-bed-bigbed)
  + [GTF2 & GFF3](#gtf2-gff3)
  + [In summary](#in-summary)
* [Getting the most out of your time & data](#getting-the-most-out-of-your-time-data)
* [See also](#see-also)

## [Types of data](#id6)[¶](#types-of-data "Permalink to this headline")

Generally speaking, genomics data comes in four categories:

> Sequence
> :   The nucleotide sequence of a chromosome, contig, transcript,
>     or a set of these. These are typically maintained by public databases,
>     such as [UCSC](UCSCgenomebrowser), [Ensembl](http://www.ensembl.org), and [RefSeq](http://www.ncbi.nlm.nih.gov/refseq/). The
>     genome sequence for a given organism frequently is available in several
>     editions, called [builds](../glossary.html#term-genome-build) or [assemblies](../glossary.html#term-genome-build).
>
> [Annotations](../glossary.html#term-annotation)
> :   Descriptions of features – e.g. genes, transcripts, SNPs, start codons
>     – that appear in genomes or transcripts. Annotations typically include
>     coordinates (chromosome name, chromosome positions, and a chromosome
>     strand), as well as properties (gene name, function, GO terms, et c) of
>     a given feature.
>
>     [Annotations](../glossary.html#term-annotation) are maintained by the same public
>     databases that maintain sequence information, because the coordinates
>     in each annotation are specific to the [genome build](../glossary.html#term-genome-build) upon which
>     it is based. In other words, annotations and sequences must be matched!
>     Pay particular attention to this when downloading annotations as
>     supplemental data from a journal article.
>
> Quantitative data
> :   Any kind of numerical value associated with a chromosomal
>     position. For example, the degree of phylogenetic conservation between a
>     set of organisms, at each position in the genome. Or, the strength of
>     transcription factor binding to a chromosomal position in a ChIP-seq dataset.
>
>     Because quantitative data associates values with chromosomal coordinates,
>     it can be considered an [annotation](../glossary.html#term-annotation) of sorts. It is therefore
>     important again to make sure that the coordinates in your data file
>     match the [genome build](../glossary.html#term-genome-build) used by your feature [annotation](../glossary.html#term-annotation)
>     and/or [read alignments](../glossary.html#term-read-alignments).
>
> [Read alignments](../glossary.html#term-read-alignments)
> :   A record matching a short sequence of DNA to a region of identical or similar
>     sequence in a genome. In a [high-throughput sequencing](../glossary.html#term-high-throughput-sequencing) experiment,
>     alignment of short reads identifies the genomic coordinates from which
>     each read presumably derived.
>
>     [Read alignments](../glossary.html#term-read-alignments) can be produced by running
>     sequencing data through alignment programs, such as [Bowtie](http://bowtie-bio.sourceforge.net/manual.shtml), [Tophat](http://tophat.cbcb.umd.edu/),
>     or [BWA](http://bio-bwa.sourceforge.net).
>
>     [Read alignments](../glossary.html#term-read-alignments)
>     can be converted to quantitative data by applying a [mapping rule](../glossary.html#term-mapping-rule),
>     that uses various properties of the read to assign genomic position(s)
>     at which the read should be counted. For example, one could map reads
>     to their 5’ ends, or to sites within the read where nucleotides mismatch
>     the reference genome. For
>     an in-depth discussion, see
>     [Read mapping functions](mapping_rules.html).

## [Formats of data](#id7)[¶](#formats-of-data "Permalink to this headline")

One of the design goals of [`plastid`](../generated/plastid.html#module-plastid "plastid") is to insulate users from the esoterica
of the various file formats used in genomics. But, two points are relevant:

> 1. It is important for users to recognize the file types names in order to
>    identify the files they have or need to download.
> 2. Some file formats are *indexed* and others are not. Indexed files are
>    memory-efficient, because computer programs don’t need to read the entire
>    file to find the data of interest; instead, they can read the index and
>    just fetch the desired portion of the data.
>
>    However, indexed files are frequently compressed, which can make reading them
>    slower to parse. For small genomes that don’t use much memory in the first
>    place (e.g. yeast, *E. coli*), the meager memory savings aren’t worth this
>    speed cost. The exception is for short [read alignments](../glossary.html#term-read-alignments), where indexed
>    [BAM](http://samtools.github.io/hts-specs/) files are universally recommended.

Below is a table of commonly used file formats. At present, [`plastid`](../generated/plastid.html#module-plastid "plastid") handles
all of these either natively or via [Pysam](http://pysam.readthedocs.io/en/latest/) ([BAM](http://samtools.github.io/hts-specs/) files), [Biopython](http://biopython.org/wiki/Biopython) ([FASTA](https://en.wikipedia.org/wiki/FASTA_format)),
or [twobitreader](https://pythonhosted.org/twobitreader/) ([2bit](twobit)).

> |  |  |  |
> | --- | --- | --- |
> | **Data type** | **Unindexed formats** | **Indexed formats** |
> | Sequence | [FASTA](https://en.wikipedia.org/wiki/FASTA_format) | [2bit](twobit) |
> | Annotations | [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1), [GTF2](http://mblab.wustl.edu/GTF22.html), [GFF3](http://www.sequenceontology.org/gff3.shtml), [PSL](http://genome.ucsc.edu/FAQ/FAQformat.html#format2) | [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html) |
> | Quantitative data | [bedGraph](http://genome.ucsc.edu/goldenpath/help/bedgraph.html), [wiggle](http://genome.ucsc.edu/goldenpath/help/wiggle.html) | [BigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) |
> | Read alignments | [bowtie](http://bowtie-bio.sourceforge.net/manual.shtml), [SAM](http://samtools.github.io/hts-specs/), [PSL](http://genome.ucsc.edu/FAQ/FAQformat.html#format2) | [BAM](http://samtools.github.io/hts-specs/) |

In addition, [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1), [GTF2](http://mblab.wustl.edu/GTF22.html), [GFF3](http://www.sequenceontology.org/gff3.shtml), and [PSL](http://genome.ucsc.edu/FAQ/FAQformat.html#format2) files can be indexed via [tabix](http://samtools.github.io/hts-specs/).
[`plastid`](../generated/plastid.html#module-plastid "plastid") supports (via [pysam](http://pysam.readthedocs.io/en/latest/)) reading of [tabix](http://samtools.github.io/hts-specs/)-compressed files too.

## [Why are there so many formats?](#id8)[¶](#why-are-there-so-many-formats "Permalink to this headline")

There are a number of answers to this:

1. Genomics is a young science, and for a long time there was no consensus
   on how best to store data. This dialogue is, in fact, still ongoing.
2. It became apparent that file formats that work well with small genomes
   become very onerous for mammalian-sized genomes. This is why, for example,
   the [2bit](twobit), [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html), and [BigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) formats were created.
3. The various file formats have their own strengths and weaknesses. These
   are detailed in [Which annotation format should I use?](#data-annotation-format)

## [Which annotation format should I use?](#id9)[¶](#which-annotation-format-should-i-use "Permalink to this headline")

When choosing a feature annotation format, consider the following questions:

> * Will the annotation contain features that are not transcripts?
> * Will multiple types of features be stored in the same file?
> * Does rich attribute information need to be saved in the file?
> * Are features discontinuous?
> * Is the computing environment limited for processing power or memory and/or
>   is the feature annotation very large?

### [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1), [Extended BED](../glossary.html#term-Extended-BED), & [BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html)[¶](#bed-extended-bed-bigbed "Permalink to this headline")

[BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1)-family files contain a single record per line. And, in contrast
to [GTF2](http://mblab.wustl.edu/GTF22.html) or [GFF3](http://www.sequenceontology.org/gff3.shtml) files, single records – like transcripts – can
be discontinuous. This makes [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) files computationally
cheap to parse, because each line is a complete record. In contrast,
in [GTF2](http://mblab.wustl.edu/GTF22.html) and [GFF3](http://www.sequenceontology.org/gff3.shtml) files, discontinuous features like transcripts need
to be assembled from multiple continuous records (e.g. records describing
individual exons).

[BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) files contain columns that describe only the following attributes:

> * feature name
> * feature coordinates (feature can be discontinuous, like a multi-exon transcript)
> * feature coding region start & stop
> * a score for the feature
> * a color for rendering the feature in a genome browser

Note that *there is no attribute for feature type:* typically all records
in a [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) file are of the same type (e.g. every record is a transcript
or an alignment or a ChIP binding site, et c).

[BigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html) and [Extended BED](../glossary.html#term-Extended-BED) formats can include additional attributes in additional
columns, but every entry in each column must be the same type of attribute
(e.g. a “gene id” column can only contain gene IDs).

### [GTF2](http://mblab.wustl.edu/GTF22.html) & [GFF3](http://www.sequenceontology.org/gff3.shtml)[¶](#gtf2-gff3 "Permalink to this headline")

Unlike [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1)-family files, [GTF2](http://mblab.wustl.edu/GTF22.html) and [GFF3](http://www.sequenceontology.org/gff3.shtml) files are hierarchical:
features have parents and children, which themselves are other features. Continuous
features are represented on a single line. Discontinuous features – like
transcripts – are represented on multiple lines – for example, one
line per exon, one line per intron, and one line per continous portion
of a coding region. These sub-features are linked together via parent-child
attributes (‘Parent’ in for [GFF3](http://www.sequenceontology.org/gff3.shtml); ‘gene\_id’ and ‘transcript\_id’ in
[GTF2](http://mblab.wustl.edu/GTF22.html)), which associate them with the discontinuous feature they represent.

This has several important implications:

1. Sub-features in [GTF2](http://mblab.wustl.edu/GTF22.html) & [GFF3](http://www.sequenceontology.org/gff3.shtml) can have their own attributes,
   which differ from the attributes of their parent features.
2. In order to reconstruct a discontinuous feature like a transcript,
   [GTF2](http://mblab.wustl.edu/GTF22.html) & [GFF3](http://www.sequenceontology.org/gff3.shtml) parsers need to collect all of the required subfeatures.
   However, parsers only know when they have collected all of the required features
   if they receive information indicating this is so. This information could be:

   > * In a [GFF3](http://www.sequenceontology.org/gff3.shtml) file, the special line ‘###’:
   >
   >   ```
   >   ###
   >   # the line above is not a comment, but a GFF3 instruction!
   >   # this line and the line above it are comments.
   >   ```
   >
   >   which indicates all features in memory may be assembled.
   > * In a sorted [GTF2](http://mblab.wustl.edu/GTF22.html) or [GFF3](http://www.sequenceontology.org/gff3.shtml) file, a change in chromosomes, indicating
   >   :   all features on the previous chromosome may safely be assembled.
   > * The end of the annotation file

   In all cases, a [GTF2](http://mblab.wustl.edu/GTF22.html) or [GFF3](http://www.sequenceontology.org/gff3.shtml) parser has to hold a potentially large
   set of subfeatures in memory until it it receives some signal that all related
   subfeatures have been collected. This costs memory, time, and disk space, and
   can become unwieldy for large genomes.

However,
a major advantage of [GTF2](http://mblab.wustl.edu/GTF22.html) and [GFF3](http://www.sequenceontology.org/gff3.shtml) files is that they contain a column (column 9)
for arbitrary key-value pairs of attributes (such as GO terms, descriptive paragraphs,
IDs that cross-reference different databases). This allows different features to have
different types