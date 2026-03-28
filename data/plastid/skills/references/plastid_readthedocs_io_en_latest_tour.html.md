[plastid](index.html)

latest

Getting started

* [Getting started](quickstart.html)
* Tour
  + [Command-line scripts](#command-line-scripts)
  + [Classes & data structures](#classes-data-structures)
    - [`GenomicSegment`](#genomicsegment)
    - [`SegmentChain` & `Transcript`](#segmentchain-transcript)
    - [`GenomeArray` & its subclasses](#genomearray-its-subclasses)
    - [`GenomeHash`, `BigBedGenomeHash`, and `TabixGenomeHash`](#genomehash-bigbedgenomehash-and-tabixgenomehash)
  + [See also](#see-also)
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

[plastid](index.html)

* »
* Tour
* [Edit on GitHub](https://github.com/joshuagryphon/plastid/blob/master/docs/source/tour.rst)

---

# Tour[¶](#tour "Permalink to this headline")

This document contains a brief overview of [`plastid`](generated/plastid.html#module-plastid "plastid") in the following
sections:

* [Command-line scripts](#command-line-scripts)
* [Classes & data structures](#classes-data-structures)

  + [[`GenomicSegment`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.GenomicSegment "plastid.genomics.roitools.GenomicSegment")](#genomicsegment)
  + [[`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") & [`Transcript`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript")](#segmentchain-transcript)
  + [[`GenomeArray`](generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.GenomeArray "plastid.genomics.genome_array.GenomeArray") & its subclasses](#genomearray-its-subclasses)
  + [[`GenomeHash`](generated/plastid.genomics.genome_hash.html#plastid.genomics.genome_hash.GenomeHash "plastid.genomics.genome_hash.GenomeHash"), [`BigBedGenomeHash`](generated/plastid.genomics.genome_hash.html#plastid.genomics.genome_hash.BigBedGenomeHash "plastid.genomics.genome_hash.BigBedGenomeHash"), and [`TabixGenomeHash`](generated/plastid.genomics.genome_hash.html#plastid.genomics.genome_hash.TabixGenomeHash "plastid.genomics.genome_hash.TabixGenomeHash")](#genomehash-bigbedgenomehash-and-tabixgenomehash)
* [See also](#see-also)

Detailed documentation of classes & functions may be found in the
[module documentation](generated/plastid.html).

## [Command-line scripts](#id4)[¶](#command-line-scripts "Permalink to this headline")

[`plastid`](generated/plastid.html#module-plastid "plastid") includes a handful of [`scripts`](generated/plastid.bin.html#module-plastid.bin "plastid.bin") for common
[high-throughput sequencing](glossary.html#term-high-throughput-sequencing) and [ribosome profiling](glossary.html#term-ribosome-profiling) analyses.
These include, among others:

> * [Measuring read counts or density density](generated/plastid.bin.cs.html)
>   in regions of interest (for example, to obtain gene expression values)
> * [Determining P-site offsets](generated/plastid.bin.psite.html) for
>   [ribosome profiling](glossary.html#term-ribosome-profiling) experiments
> * Performing [metagene analyses](generated/plastid.bin.metagene.html)
> * [Creating browser tracks](generated/plastid.bin.make_wiggle.html)
>   from [BAM](http://samtools.github.io/hts-specs/) or [bowtie](http://bowtie-bio.sourceforge.net/manual.shtml) files, after applying [Read mapping functions](concepts/mapping_rules.html)
>   to extract the biology of interst from the alignments (e.g. P-sites
>   in [ribosome profiling](glossary.html#term-ribosome-profiling) data)

For a complete list, see [Command-line scripts](scriptlist.html).

## [Classes & data structures](#id5)[¶](#classes-data-structures "Permalink to this headline")

[`plastid`](generated/plastid.html#module-plastid "plastid") defines a number of classes to facilitate sequencing analyses:

> |  |  |
> | --- | --- |
> | **Class** | **Purpose** |
> | [GenomicSegment](#tour-genomic-segment), [SegmentChain & Transcript](#tour-segment-chain) | Represent genomic [features](glossary.html#term-feature) (e.g. mRNAs, genes, SNPs, stop codons) as Python objects |
> | [GenomeArray](#tour-genome-array) & its subclasses | Map quantitative values or [read alignments](glossary.html#term-read-alignments) to genomic coordinates. |
> | [GenomeHash](#tour-genome-hash) & its subclasses | Index genomic [features](glossary.html#term-feature) by genomic coordinates, for quick lookup of [features](glossary.html#term-feature) that overlap or cover a region. |

In the examples below, we’ll be using a small [Demo dataset](test_dataset.html) covering the human cytomegalovirus (hCMV) genome ([[SGWM+12](zreferences.html#id15 "Noam Stern-Ginossar, Ben Weisburd, Annette Michalski, Vu Thuy Khanh Le, Marco Y Hein, Sheng-Xiong Huang, Ming Ma, Ben Shen, Shu-Bing Qian, Hartmut Hengel, Matthias Mann, Nicholas T Ingolia, and Jonathan S Weissman. Decoding human cytomegalovirus. Science, 338(6110):1088-93, 2012. doi:10.1126/science.1227919.")]).

---

### [[`GenomicSegment`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.GenomicSegment "plastid.genomics.roitools.GenomicSegment")](#id6)[¶](#genomicsegment "Permalink to this headline")

[`GenomicSegments`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.GenomicSegment "plastid.genomics.roitools.GenomicSegment") are the fundamental building block of genomic
[features](glossary.html#term-feature). They are defined by:

> * a chromosome name
> * a start coordinate
> * an end coordinate
> * a strand:
>
>   > + ‘+’ for forward-strand features
>   > + ‘-’ for reverse-strand features
>   > + ‘.’ for unstranded features

On their own, [`GenomicSegments`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.GenomicSegment "plastid.genomics.roitools.GenomicSegment") are not very interesting. However, they
can be used to build [SegmentChains](#tour-segment-chain), which are interesting.

---

### [[`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") & [`Transcript`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript")](#id7)[¶](#segmentchain-transcript "Permalink to this headline")

[`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") & its subclass [`Transcript`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript") model genomic features. They are
constructed from zero or more [`GenomicSegments`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.GenomicSegment "plastid.genomics.roitools.GenomicSegment"), and therefore can represent
even discontinuous genomic features, such as transcripts or gapped alignments,
in addition to continuous features (e.g. single exons).

[`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") and its subclasses provide methods for:

> * converting coordinates between the genome and the spliced space of the
>   [`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain")
> * fetching genomic sequence, read alignments, or count data over
>   the [`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain"), in its own 5’ to 3’ direction, automatically
>   accounting for splicing of the segments and, for reverse-strand
>   features, reverse-complementing the sequence
> * slicing or fetching sub-regions of a [`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain")
> * testing for equality, inequality, overlap, containment, or coverage
>   of other [`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") or [`GenomicSegment`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.GenomicSegment "plastid.genomics.roitools.GenomicSegment") objects
> * exporting to [BED](http://genome.ucsc.edu/FAQ/FAQformat.html#format1), [GTF2](http://mblab.wustl.edu/GTF22.html), or [GFF3](http://www.sequenceontology.org/gff3.shtml) formats, for use with other
>   software packages or within a genome browser

[`SegmentChains`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") and [`Transcripts`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript") can be constructed manually from zero or more
[`GenomicSegments`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.GenomicSegment "plastid.genomics.roitools.GenomicSegment") and any optional keywords, which will be stored in the
[`SegmentChain`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain")’s attr dictionary:

```
>>> from plastid import GenomicSegment, SegmentChain, Transcript
>>> exon1 = GenomicSegment("chrI",129237,130487,"+")
>>> exon2 = GenomicSegment("chrI",130531,130572,"+")
>>> SegmentChain(exon1,exon2,ID="YAL013W",alias="DEP1")
<SegmentChain segments=2 bounds=chrI:129237-130572(+) name=YAL013W>

>>> dep1 = Transcript(exon1,exon2,ID="YAL013W",alias="DEP1",cds_genome_start=129270,cds_genome_end=130484)
>>> dep1
<Transcript segments=2 bounds=chrI:129237-130572(+) name=YAL013W>

>>> dep1.attr
{'ID': 'YAL013W',
 'alias': 'DEP1',
 'cds_genome_end': 130484,
 'cds_genome_start': 129270,
 'type': 'mRNA'}
```

More often, [`SegmentChains`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") and [`Transcripts`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript") are loaded from [annotation](glossary.html#term-annotation)
files (see [`plastid.readers`](generated/plastid.readers.html#module-plastid.readers "plastid.readers")):

```
>>> from plastid import BED_Reader

>>> # get an iterator over transcripts in file
>>> reader = BED_Reader("merlin_orfs.bed",return_type=Transcript)

>>> # do something with transcripts. here we just look at their names & attribute dictionaries
>>> for transcript in reader:
>>>     print(transcript.get_name() + ":\t" + str(transcript.attr))
ORFL1W_(RL1):        {'cds_genome_end': 2299, 'color': '#000000', 'score': 0.0, 'cds_genome_start': 1366, 'type': 'mRNA', 'ID': 'ORFL1W_(RL1)'}
ORFL2C:      {'cds_genome_end': 2723, 'color': '#000000', 'score': 0.0, 'cds_genome_start': 2501, 'type': 'mRNA', 'ID': 'ORFL2C'}
ORFL3C:      {'cds_genome_end': 3015, 'color': '#000000', 'score': 0.0, 'cds_genome_start': 2934, 'type': 'mRNA', 'ID': 'ORFL3C'}
[rest of output omitted]
```

[`SegmentChains`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") and [`Transcripts`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript") can convert coordinates between the transcript
and the genome:

```
>>> # load transcripts into a dictionary keyed on transcript ID
>>> transcript_dict = { X.get_name() : X for X in BED_Reader("merlin_orfs.bed",return_type=Transcript) }

>>> # we'll use the two-exon, minus-strand gene ORFL83C as an example
>>> demo_tx = transcript_dict["ORFL83C_(UL29)"]
>>> demo_tx
<Transcript segments=2 bounds=merlin:35004-37402(-) name=ORFL83C_(UL29)>

>>> # get genomic coordinate of 1124th nucleotide from 5' end of ORFL83C
>>> # right before the splice junction
>>> demo_tx.get_genomic_coordinate(1124)
('merlin', 36277, '-')

>>> # get genomic coordinate of 1125th nucleotide from 5' end of ORFL83C
>>> # right after the splice junction
>>> demo_tx.get_genomic_coordinate(1125)
('merlin', 36130, '-')

>>> # and the inverse operation also works
>>> demo_tx.get_segmentchain_coordinate("merlin",36130,"-")
1126
```

[`SegmentChains`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain") can fetch vectors of data covering each position in the chain
from the 5’ to 3’ end (relative to the chain) from [`GenomeArrays`](generated/plastid.genomics.genome_array.html#plastid.genomics.genome_array.GenomeArray "plastid.genomics.genome_array.GenomeArray") (themselves
explained [below](#tour-genome-array)). For example, to count how many 5’
ends of sequencing reads appear at each position in a chain:

```
>>> from plastid import BAMGenomeArray, FivePrimeMapFactory

>>> # load read alignments, and map them to 5' ends
>>> alignments = BAMGenomeArray("SRR609197_riboprofile_5hr_rep1.bam")
>>> alignments.set_mapping(FivePrimeMapFactory())

>>> # fetch the number of 5' ends of alignments at positions 300-320
>>> demo_tx.get_counts(alignments)[320:340]
array([  23.,    3.,   17.,   67.,   22.,    5.,   15.,   14.,   99.,
         26.,   13.,   27.,  112.,   34.,    1.,   13.,    0.,    4.,
          2.,   11.])
```

It is also possible to fetch sub-sections of a [`Transcripts`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript") or [`SegmentChains`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain")
as new [`SegmentChains`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.SegmentChain "plastid.genomics.roitools.SegmentChain"):

```
>>> # take first 200 nucleotides of  mRNA
>>> subchain = demo_tx.get_subchain(0,200)
>>> subchain
<SegmentChain intervals=1 bounds=merlin:37202-37402(-) name=ORFL83C_(UL29)_subchain>
```

[`Transcript`](generated/plastid.genomics.roitools.html#plastid.genomics.roitools.Transcript "plastid.genomics.roitools.Transcript") includes several convenience methods to fetch 5’ UTRs, coding regions,
and 3’UTRs from coding transcripts:

```
>>> demo_tx.get_utr5()
<SegmentChain intervals=1 bounds=merlin:37353-37402(-) name=ORFL83C_(UL29)_5UTR>

>>> demo_cds = demo_tx.get_cds()
>>> demo_cds
<Transcript intervals=2 bounds=merlin:35104-37353(-) name=ORFL83C_(UL29)_CDS>
```

[`SegmentChain`](ge