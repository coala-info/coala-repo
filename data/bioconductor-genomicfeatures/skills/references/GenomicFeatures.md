# Obtaining and Utilizing TxDb Objects

Marc Carlson, Patrick Aboyoun, Hervé Pagès, Seth Falcon and Martin Morgan

#### Thursday, October 30, 2025

#### Package

GenomicFeatures 1.62.0

# Contents

* [1 Introduction](#introduction)
* [2 Installing the `GenomicFeatures` package](#installing-the-genomicfeatures-package)
* [3 Obtaining a `TxDb` object](#obtaining-a-txdb-object)
* [4 Retrieving Data from a `TxDb` object](#retrieving-data-from-a-txdb-object)
  + [4.1 Pre-filtering data based on Chromosomes](#pre-filtering-data-based-on-chromosomes)
  + [4.2 Retrieving data using the `select()` method](#retrieving-data-using-the-select-method)
  + [4.3 Methods for returning `GRanges` objects](#methods-for-returning-granges-objects)
  + [4.4 Working with Grouped Features](#working-with-grouped-features)
  + [4.5 Predefined grouping functions](#predefined-grouping-functions)
* [5 Getting the actual sequence data](#getting-the-actual-sequence-data)
* [6 Session Information](#session-information)

# 1 Introduction

The `GenomicFeatures` package implements the `TxDb` container for
storing transcript metadata for a given organism. A `TxDb` object
stores the genomic positions of the 5’ and 3’ untranslated regions
(UTRs), protein coding sequences (CDSs), and exons for a set of mRNA
transcripts. The genomic positions are stored and reported with respect
to a given genome assembly. `TxDb` objects have numerous accessors
functions to allow such features to be retrieved individually or grouped
together in a way that reflects the underlying biology.

All `TxDb` objects are backed by a SQLite database that stores
the genomic positions and relationships between pre-processed mRNA
transcripts, exons, protein coding sequences, and their related
gene identifiers.

# 2 Installing the `GenomicFeatures` package

Install the package with:

```
if (!require("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

BiocManager::install("GenomicFeatures")
```

Then load it with:

```
suppressPackageStartupMessages(library(GenomicFeatures))
```

# 3 Obtaining a `TxDb` object

There are three ways that users can obtain a `TxDb` object.

One way is to use the `loadDb` method to load the object directly
from an appropriate `.sqlite` database file.

Here we are loading a previously created `TxDb` object
based on UCSC known gene data. This database only contains a small
subset of the possible annotations for human and is only included to
demonstrate and test the functionality of the
`GenomicFeatures` package as a demonstration.

```
samplefile <- system.file("extdata", "hg19_knownGene_sample.sqlite",
                          package="GenomicFeatures")
txdb <- loadDb(samplefile)
txdb
```

```
## TxDb object:
## # Db type: TxDb
## # Supporting package: GenomicFeatures
## # Data source: UCSC
## # Genome: hg19
## # Organism: Homo sapiens
## # UCSC Table: knownGene
## # Resource URL: http://genome.ucsc.edu/
## # Type of Gene ID: Entrez Gene ID
## # Full dataset: no
## # miRBase build ID: NA
## # transcript_nrow: 178
## # exon_nrow: 620
## # cds_nrow: 523
## # Db created by: GenomicFeatures package from Bioconductor
## # Creation time: 2014-10-08 10:31:15 -0700 (Wed, 08 Oct 2014)
## # GenomicFeatures version at creation time: 1.17.21
## # RSQLite version at creation time: 0.11.4
## # DBSCHEMAVERSION: 1.0
```

In this case, the `TxDb` object has been returned by
the `loadDb` method.

More commonly however, we expect that users will just load a
TxDb annotation package like this:

```
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
hg19_txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene  # shorthand (for convenience)
hg19_txdb
```

```
## TxDb object:
## # Db type: TxDb
## # Supporting package: GenomicFeatures
## # Data source: UCSC
## # Genome: hg19
## # Organism: Homo sapiens
## # Taxonomy ID: 9606
## # UCSC Table: knownGene
## # UCSC Track: GENCODE V48lift37
## # Resource URL: https://genome.ucsc.edu/
## # Type of Gene ID: Entrez Gene ID
## # Full dataset: yes
## # Nb of transcripts: 381987
## # Db created by: txdbmaker package from Bioconductor
## # Creation time: 2025-10-13 16:17:01 -0700 (Mon, 13 Oct 2025)
## # txdbmaker version at creation time: 1.5.6
## # RSQLite version at creation time: 2.4.3
## # DBSCHEMAVERSION: 1.2
```

Loading the package like this will also create a `TxDb`
object, and by default that object will have the same name as the
package itself.

Finally, the third way to obtain a `TxDb` object is to use one of
the numerous tools defined in the `txdbmaker` package. `txdbmaker`
provides a set of tools for making `TxDb` objects from genomic
annotations from various sources (e.g. UCSC, Ensembl, and GFF files).
See the vignette in the `txdbmaker` package for more information.

# 4 Retrieving Data from a `TxDb` object

## 4.1 Pre-filtering data based on Chromosomes

It is possible to filter the data that is returned from a
`TxDb` object based on it’s chromosome. This can be a
useful way to limit the things that are returned if you are only
interested in studying a handful of chromosomes.

To determine which chromosomes are currently active, use the
`seqlevels` method. For example:

```
head(seqlevels(hg19_txdb))
```

```
## [1] "chr1" "chr2" "chr3" "chr4" "chr5" "chr6"
```

Will tell you all the chromosomes that are active for the
TxDb.Hsapiens.UCSC.hg19.knownGene `TxDb` object (by
default it will be all of them).

If you then wanted to only set Chromosome 1 to be active you could do
it like this:

```
seqlevels(hg19_txdb) <- "chr1"
```

So if you ran this, then from this point on in your R session only
chromosome 1 would be consulted when you call the various retrieval
methods… If you need to reset back to the original seqlevels (i.e.
to the seqlevels stored in the db), then set the seqlevels to
`seqlevels0(hg19_txdb)`.

```
seqlevels(hg19_txdb) <- seqlevels0(hg19_txdb)
```

**Exercise:**
Use `seqlevels` to set only chromsome 15 to be active. BTW,
the rest of this vignette will assume you have succeeded at this.

**Solution:**

```
seqlevels(hg19_txdb) <- "chr15"
seqlevels(hg19_txdb)
```

```
## [1] "chr15"
```

## 4.2 Retrieving data using the `select()` method

The `TxDb` objects inherit from `AnnotationDb`
objects (just as the `ChipDb` and `OrgDb` objects do).
One of the implications of this relationship is that these object
ought to be used in similar ways to each other. Therefore we have
written supporting `columns`, `keytypes`, `keys`
and `select` methods for `TxDb` objects.

These methods can be a useful way of extracting data from a
`TxDb` object. And they are used in the same way that
they would be used to extract information about a `ChipDb` or
an `OrgDb` object. Here is a simple example of how to find the
UCSC transcript names that match with a set of gene IDs.

```
keys <- c("100033416", "100033417", "100033420")
columns(hg19_txdb)
```

```
##  [1] "CDSCHROM"   "CDSEND"     "CDSID"      "CDSNAME"    "CDSPHASE"
##  [6] "CDSSTART"   "CDSSTRAND"  "EXONCHROM"  "EXONEND"    "EXONID"
## [11] "EXONNAME"   "EXONRANK"   "EXONSTART"  "EXONSTRAND" "GENEID"
## [16] "TXCHROM"    "TXEND"      "TXID"       "TXNAME"     "TXSTART"
## [21] "TXSTRAND"   "TXTYPE"
```

```
keytypes(hg19_txdb)
```

```
## [1] "CDSID"    "CDSNAME"  "EXONID"   "EXONNAME" "GENEID"   "TXID"     "TXNAME"
```

```
select(hg19_txdb, keys = keys, columns="TXNAME", keytype="GENEID")
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##      GENEID            TXNAME
## 1 100033416              <NA>
## 2 100033417 ENST00000384462.1
## 3 100033420 ENST00000384365.1
```

**Exercise:**
For the genes in the example above, find the chromosome and strand
information that will go with each of the transcript names.

**Solution:**

```
columns(hg19_txdb)
```

```
##  [1] "CDSCHROM"   "CDSEND"     "CDSID"      "CDSNAME"    "CDSPHASE"
##  [6] "CDSSTART"   "CDSSTRAND"  "EXONCHROM"  "EXONEND"    "EXONID"
## [11] "EXONNAME"   "EXONRANK"   "EXONSTART"  "EXONSTRAND" "GENEID"
## [16] "TXCHROM"    "TXEND"      "TXID"       "TXNAME"     "TXSTART"
## [21] "TXSTRAND"   "TXTYPE"
```

```
cols <- c("TXNAME", "TXSTRAND", "TXCHROM")
select(hg19_txdb, keys=keys, columns=cols, keytype="GENEID")
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##      GENEID            TXNAME TXCHROM TXSTRAND
## 1 100033416              <NA>    <NA>     <NA>
## 2 100033417 ENST00000384462.1   chr15        +
## 3 100033420 ENST00000384365.1   chr15        +
```

## 4.3 Methods for returning `GRanges` objects

Retrieving data with select is useful, but sometimes it is more
convenient to extract the result as a `GRanges` object. This is
often the case when you are doing counting or specialized overlap
operations downstream. For these use cases there is another family of
methods available.

Perhaps the most common operations for a `TxDb` object
is to retrieve the genomic coordinates or *ranges* for exons,
transcripts or coding sequences. The functions
`transcripts`, `exons`, and `cds` return
the coordinate information as a `GRanges` object.

As an example, all transcripts present in a `TxDb` object
can be obtained as follows:

```
GR <- transcripts(hg19_txdb)
GR[1:3]
```

```
## GRanges object with 3 ranges and 2 metadata columns:
##       seqnames            ranges strand |     tx_id             tx_name
##          <Rle>         <IRanges>  <Rle> | <integer>         <character>
##   [1]    chr15 20083808-20093067      + |    271447 ENST00000524329.1_3
##   [2]    chr15 20088867-20088969      + |    271448   ENST00000364371.1
##   [3]    chr15 20104587-20104812      + |    271449 ENST00000553634.1_3
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

The `transcripts` function returns a `GRanges` class
object. You can learn a lot more about the manipulation of these
objects by reading the `GenomicRanges` introductory
vignette. The `show` method for a `GRanges` object
will display the ranges, seqnames (a chromosome or a contig), and
strand on the left side and then present related metadata on the right
side.

The `strand` function is used to obtain the strand
information from the transcripts. The sum of the Lengths of the
`Rle` object that `strand` returns is equal to the
length of the `GRanges` object.

```
tx_strand <- strand(GR)
tx_strand
```

```
## factor-Rle of length 14372 with 2 runs
##   Lengths: 7135 7237
##   Values :    +    -
## Levels(3): + - *
```

```
sum(runLength(tx_strand))
```

```
## [1] 14372
```

```
length(GR)
```

```
## [1] 14372
```

In addition, the `transcripts` function can also be used to
retrieve a subset of the transcripts available such as those on the
`+`-strand of chromosome 1.

```
GR <- transcripts(hg19_txdb, filter=list(tx_chrom = "chr15", tx_strand = "+"))
length(GR)
```

```
## [1] 7135
```

```
unique(strand(GR))
```

```
## [1] +
## Levels: + - *
```

The `exons` and `cds` functions can also be used
in a similar fashion to retrive genomic coordinates for exons and
coding sequences.

The `promoters` function computes a `GRanges` object
that spans the promoter region around the transcription start site
for the transcripts in a `TxDb` object. The `upstream`
and `downstream` arguments define the number of bases upstream
and downstream from the transcription start site that make up the
promoter region.

```
PR <- promoters(hg19_txdb, upstream=2000, downstream=400)
PR
```

```
## GRanges object with 14372 ranges and 2 metadata columns:
##                       seqnames              ranges strand |     tx_id
##                          <Rle>           <IRanges>  <Rle> | <integer>
##   ENST00000524329.1_3    chr15   20081808-20084207      + |    271447
##     ENST00000364371.1    chr15   20086867-20089266      + |    271448
##   ENST00000553634.1_3    chr15   20102587-20104986      + |    271449
##   ENST00000728686.1_1    chr15   20158777-20161176      + |    271450
##   ENST00000728685.1_2    chr15   20158786-20161185      + |    271451
##                   ...      ...                 ...    ... .       ...
##   ENST00000559159.5_1    chr15 102518897-102521296      - |    285814
##   ENST00000818397.1_1    chr15 102518921-102521320      - |    285815
##   ENST00000818389.1_1    chr15 102519345-102521744      - |    285816
##   ENST00000818392.1_1    chr15 102518948-102521347      - |    285817
##   ENST00000560040.1_5    chr15 102518595-102520994      - |    285818
##                                   tx_name
##                               <character>
##   ENST00000524329.1_3 ENST00000524329.1_3
##     ENST00000364371.1   ENST00000364371.1
##   ENST00000553634.1_3 ENST00000553634.1_3
##   ENST00000728686.1_1 ENST00000728686.1_1
##   ENST00000728685.1_2 ENST00000728685.1_2
##                   ...                 ...
##   ENST00000559159.5_1 ENST00000559159.5_1
##   ENST00000818397.1_1 ENST00000818397.1_1
##   ENST00000818389.1_1 ENST00000818389.1_1
##   ENST00000818392.1_1 ENST00000818392.1_1
##   ENST00000560040.1_5 ENST00000560040.1_5
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

A similar function (`terminators`) is provided to compute the
terminator region around the transcription end site for the
transcripts in a `TxDb` object.

**Exercise:**
Use `exons` to retrieve all the exons from chromosome 15.
How does the length of this compare to the value returned by
`transcripts`?

**Solution:**

```
EX <- exons(hg19_txdb)
EX[1:4]
```

```
## GRanges object with 4 ranges and 1 metadata column:
##       seqnames            ranges strand |   exon_id
##          <Rle>         <IRanges>  <Rle> | <integer>
##   [1]    chr15 20083808-20083921      + |    627444
##   [2]    chr15 20084084-20084257      + |    627445
##   [3]    chr15 20086454-20086560      + |    627446
##   [4]    chr15 20087530-20087692      + |    627447
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

```
length(EX)
```

```
## [1] 34226
```

```
length(GR)
```

```
## [1] 7135
```

## 4.4 Working with Grouped Features

Often one is interested in how particular genomic features relate to
each other, and not just their genomic positions. For example, it might
be of interest to group transcripts by gene or to group exons by transcript.
Such groupings are supported by the `transcriptsBy`,
`exonsBy`, and `cdsBy` functions.

The following call can be used to group transcripts by genes:

```
GRList <- transcriptsBy(hg19_txdb, by = "gene")
length(GRList)
```

```
## [1] 996
```

```
names(GRList)[10:13]
```

```
## [1] "100033422" "100033423" "100033424" "100033425"
```

```
GRList[11:12]
```

```
## GRangesList object of length 2:
## $`100033423`
## GRanges object with 1 range and 2 metadata columns:
##       seqnames            ranges strand |     tx_id           tx_name
##          <Rle>         <IRanges>  <Rle> | <integer>       <character>
##   [1]    chr15 25321076-25321167      + |    271930 ENST00000383882.1
##   -------
##   seqinfo: 1 sequence from hg19 genome
##
## $`100033424`
## GRanges object with 1 range and 2 metadata columns:
##       seqnames            ranges strand |     tx_id           tx_name
##          <Rle>         <IRanges>  <Rle> | <integer>       <character>
##   [1]    chr15 25322198-25322289      + |    271935 ENST00000384468.1
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

The `transcriptsBy` function returns a `GRangesList`
class object. As with `GRanges` objects, you can learn more
about these objects by reading the `GenomicRanges`
introductory vignette. The `show` method for a
`GRangesList` object will display as a list of `GRanges`
objects. And, at the bottom the seqinfo will be displayed once for
the entire list.

For each of these three functions, there is a limited set of options
that can be passed into the `by` argument to allow grouping.
For the `transcriptsBy` function, you can group by gene,
exon or cds, whereas for the `exonsBy` and `cdsBy`
functions can only be grouped by transcript (tx) or gene.

So as a further example, to extract all the exons for each transcript
you can call:

```
GRList <- exonsBy(hg19_txdb, by = "tx")
length(GRList)
```

```
## [1] 14372
```

```
names(GRList)[10:13]
```

```
## [1] "271456" "271457" "271458" "271459"
```

```
GRList[[12]]
```

```
## GRanges object with 6 ranges and 3 metadata columns:
##       seqnames            ranges strand |   exon_id   exon_name exon_rank
##          <Rle>         <IRanges>  <Rle> | <integer> <character> <integer>
##   [1]    chr15 20487925-20488227      + |    627477        <NA>         1
##   [2]    chr15 20488749-20488912      + |    627492        <NA>         2
##   [3]    chr15 20489380-20489495      + |    627493        <NA>         3
##   [4]    chr15 20490504-20490588      + |    627497        <NA>         4
##   [5]    chr15 20495366-20495446      + |    627508        <NA>         5
##   [6]    chr15 20496597-20496861      + |    627517        <NA>         6
##   -------
##   seqinfo: 1 sequence from hg19 genome
```

As you can see, the `GRangesList` objects returned from each
function contain genomic positions and identifiers grouped into a
list-like object according to the type of feature specified in the `by`
argument. The object returned can then be used by functions like
`findOverlaps` to contextualize alignments from
high-throughput sequencing.

The identifiers used to label the `GRanges` objects depend upon
the data source used to create the `TxDb` object. So
the list identifiers will not always be Entrez Gene IDs, as they were
in the first example. Furthermore, some data sources do not provide a
unique identifier for all features. In this situation, the group
label will be a synthetic ID created by `GenomicFeatures` to
keep the relations between features consistent in the database this
was the case in the 2nd example. Even though the results will
sometimes have to come back to you as synthetic IDs, you can still
always retrieve the original IDs.

**Exercise:**
Starting with the tx\_ids that are the names of the GRList object we
just made, use `select` to retrieve that matching transcript
names. Remember that the list used a `by` argument = “tx”, so
the list is grouped by transcript IDs.

**Solution:**

```
GRList <- exonsBy(hg19_txdb, by = "tx")
tx_ids <- names(GRList)
head(select(hg19_txdb, keys=tx_ids, columns="TXNAME", keytype="TXID"))
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
##     TXID              TXNAME
## 1 271447 ENST00000524329.1_3
## 2 271448   ENST00000364371.1
## 3 271449 ENST00000553634.1_3
## 4 271450 ENST00000728686.1_1
## 5 271451 ENST00000728685.1_2
## 6 271452 ENST00000611556.1_3
```

Finally, the order of the results in a `GRangesList` object can
vary with the way in which things were grouped. In most cases the
grouped elements of the `GRangesList` object will be listed in
the order that they occurred along the chromosome. However, when
exons or CDS parts are grouped by transcript, they will instead be
grouped according to their position along the transcript itself.
This is important because alternative splicing can mean that the
order along the transcript can be different from that along the
chromosome.

## 4.5 Predefined grouping functions

The `intronsByTranscript`, `fiveUTRsByTranscript`
and `threeUTRsByTranscript` are convenience functions that
provide behavior equivalent to the grouping functions, but in
prespecified form. These functions return a `GRangesList`
object grouped by transcript for introns, 5’ UTR’s, and 3’ UTR’s,
respectively. Below are examples of how you can call these methods.

```
length(intronsByTranscript(hg19_txdb))
```

```
## [1] 14372
```

```
length(fiveUTRsByTranscript(hg19_txdb))
```

```
## [1] 3089
```

```
length(threeUTRsByTranscript(hg19_txdb))
```

```
## [1] 2935
```

# 5 Getting the actual sequence data

The `GenomicFeatures` package also provides functions for
converting from ranges to actual sequence (when paired
with an appropriate `BSgenome` package).

```
suppressPackageStartupMessages(library(BSgenome.Hsapiens.UCSC.hg19))
genome <- BSgenome.Hsapiens.UCSC.hg19  # shorthand (for convenience)
tx_seqs1 <- extractTranscriptSeqs(genome, hg19_txdb, use.names=TRUE)
```

And, once these sequences have been extracted, you can translate them
into proteins with `translate`:

```
suppressWarnings(translate(tx_seqs1))
```

```
## AAStringSet object of length 14372:
##         width seq                                           names
##     [1]   238 TALHWVCANGHAEVVTPLVDR...GCTLGGKNT*HG*KLGGKNT* ENST00000524329.1_3
##     [2]    34 WLQWFI**N*NNVEKISMVPTQG*HRNP*SVAYF            ENST00000364371.1
##     [3]    75 MHRAALHAEAMGEKKEGGGRG...LCSKCAVSNDLTQQEIGTLEV ENST00000553634.1_3
##     [4]   154 KESRHSTGGGQCLRASWVLDL...ID*FPYVGPSLNHWDKLNLVM ENST00000728686.1_1
##     [5]   132 RHSTGGGQCLRASWVLDLTPA...NGGYVRTSTSFEKYRFV*TNA ENST00000728685.1_2
##     ...   ... ...
## [14368]   496 LAVSLFFDLFFLFMCICCLLA...PETFASCTARDPLLKAHCWFL ENST00000559159.5_1
## [14369]   556 IHHFSFR*LAVSLFFDLFFLF...TPRRLHPAQLEILY*KHTVGF ENST00000818397.1_1
## [14370]   587 DTAGPSCSNSTGGL*GNTRSI...PRDVCILHS*RSFIKSTLLVS ENST00000818389.1_1
## [14371]   517 *TRLPAPGV*LPATAGLCQGA...LTPRRLHPAQLEILY*KHTVG ENST00000818392.1_1
## [14372]   191 RLEER*VRASTSLTT*ASVW*...CCQDPGTGISARWRKQGNPEE ENST00000560040.1_5
```

**Exercise:**
But of course this is not a meaningful translation, because the call
to `extractTranscriptSeqs` will have extracted all
the transcribed regions of the genome regardless of whether or not
they are translated. Look at the manual page for
`extractTranscriptSeqs` and see how you can use cdsBy
to only translate only the coding regions.

**Solution:**

```
cds_seqs <- extractTranscriptSeqs(Hsapiens,
                                  cdsBy(hg19_txdb, by="tx", use.names=TRUE))
translate(cds_seqs)
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[16]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[17]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[24]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[37]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[38]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[44]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[49]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[57]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[60]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[62]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[63]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[68]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[69]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[76]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[81]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[82]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[107]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[111]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[113]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[120]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[130]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[131]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[132]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[133]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[135]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[146]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[160]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[161]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[162]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[163]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[164]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[165]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[167]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[175]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[181]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[187]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[194]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[200]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[201]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[208]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[211]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[217]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[218]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[222]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[226]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[227]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[232]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[236]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[239]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[248]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[250]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[251]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[254]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[260]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[261]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[262]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[264]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[265]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[275]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[276]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[279]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[281]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[291]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[304]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[305]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[307]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[308]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[309]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[313]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[314]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[315]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[317]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[318]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[331]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[341]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[344]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[349]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[350]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[352]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[353]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[357]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[359]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[365]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[371]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[374]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[376]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[377]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[378]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[393]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[395]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[415]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[419]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[420]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[423]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[425]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[428]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[442]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[444]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[445]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[446]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[460]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[462]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[466]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[468]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[483]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[487]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[494]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[497]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[498]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[508]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[515]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[549]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[552]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[556]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[557]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[559]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[562]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[563]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[565]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[569]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[570]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[586]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[589]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[603]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[604]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[606]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[609]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[610]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[614]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[617]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[623]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[624]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[632]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[634]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[635]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[636]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[639]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[649]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[650]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[651]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[659]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[662]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[673]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[683]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[690]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[696]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[698]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[701]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[706]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[708]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[713]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[721]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[730]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[735]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[739]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[743]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[753]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[755]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[759]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[777]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[784]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[785]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[802]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[820]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[822]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[831]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[834]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[836]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[837]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[839]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[840]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[841]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[844]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[883]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[886]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[890]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[892]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[901]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[907]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[910]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[911]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[927]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[935]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[936]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[958]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[965]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[967]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[971]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[976]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[978]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[997]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1014]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1015]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1031]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1039]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1050]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1052]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1053]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1054]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1084]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1097]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1100]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1110]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1111]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1112]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1121]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1146]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1149]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1153]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1155]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1156]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1158]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1160]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1161]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1181]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1182]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1183]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1185]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1196]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1200]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1206]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1214]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1215]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1216]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1219]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1221]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1225]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1226]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1228]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1234]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1236]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1237]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1238]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1239]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1248]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1251]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1254]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1255]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1258]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1260]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1263]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1264]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1265]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1269]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1272]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1275]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1281]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1291]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1295]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1296]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1298]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1299]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1301]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1304]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1306]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1309]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1315]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1321]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1322]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1323]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1333]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1334]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1341]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1345]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1346]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1348]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1352]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1353]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1354]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1360]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1361]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1368]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1373]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1374]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1385]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1386]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1392]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1401]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1403]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1406]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1408]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1409]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1410]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1414]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1415]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1424]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1429]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1430]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1431]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1445]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1448]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1453]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1454]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1455]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1457]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1460]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1468]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1479]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1480]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1483]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1484]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1493]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1496]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1499]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1511]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1512]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1522]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1524]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1527]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1550]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1556]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1557]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1561]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1562]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1563]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1581]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1582]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1583]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1584]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1589]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1593]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1594]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1599]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1601]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1604]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1613]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1614]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1619]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1622]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1623]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1624]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1636]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1641]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1645]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1646]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1654]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1670]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1675]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1678]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1681]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1682]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1683]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1689]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1691]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1692]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1693]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1695]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1696]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1697]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1706]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1713]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1715]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1718]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1731]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1733]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1734]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1735]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1736]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1737]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1740]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1748]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1754]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1755]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1756]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1758]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1759]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1760]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1767]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1768]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1775]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1780]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1785]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1789]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1794]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1799]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1802]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1803]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1804]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1805]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1806]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1807]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1808]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1809]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1812]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1813]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1814]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1815]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1816]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1822]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1823]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1824]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1825]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1836]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1839]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1843]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1860]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1865]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1866]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1867]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1869]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1870]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1875]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1879]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1885]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1892]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1895]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1899]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1913]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1919]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1923]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1943]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1948]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1949]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1950]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1954]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1956]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1960]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1962]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1963]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1964]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1966]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1982]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[1983]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2009]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2011]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2015]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2035]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2053]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2054]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2055]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2057]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2072]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2075]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2082]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2094]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2099]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2101]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2116]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2121]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2130]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2138]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2139]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2140]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2167]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2168]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2175]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2180]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2185]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2193]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2198]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2199]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2205]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2209]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2210]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2224]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2227]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2229]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2230]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2231]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2241]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2243]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2244]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2245]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2246]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2247]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2252]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2257]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2260]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2261]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2262]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2263]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2265]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2266]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2270]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2277]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2309]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2310]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2319]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2321]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2322]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2323]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2324]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2325]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2326]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2332]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2333]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2335]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2336]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2337]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2345]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2347]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2353]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2355]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2367]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2368]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2374]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2377]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2383]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2387]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2397]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2400]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2401]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2404]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2408]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2413]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2414]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2420]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2431]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2433]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2440]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2444]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2450]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2455]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2474]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2494]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2498]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2522]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2523]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2525]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2529]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2532]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2553]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2554]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2556]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2557]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2560]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2561]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2565]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2566]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2569]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2570]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2584]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2585]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2586]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2592]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2593]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2599]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2608]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2610]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2622]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2623]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2624]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2625]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2632]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2633]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2637]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2639]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2644]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2645]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2652]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2656]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2678]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2681]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2687]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2688]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2691]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2692]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2696]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2701]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2707]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2708]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2714]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2727]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2728]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2733]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2742]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2766]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2767]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2770]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2773]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2777]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2795]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2796]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2797]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2798]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2814]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2816]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2828]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2832]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2833]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2846]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2847]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2851]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2855]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2861]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2862]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2863]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2866]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2867]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2868]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2886]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2898]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2899]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2903]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2910]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2912]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2938]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2944]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2945]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2947]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2949]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2951]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2953]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2954]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2958]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2959]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2960]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2963]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2977]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2978]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2979]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2981]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2982]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2985]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2986]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2989]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2992]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2993]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2994]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[2996]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3040]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3044]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3046]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3052]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3055]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3056]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3065]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3066]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3067]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3078]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3081]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3086]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3088]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3089]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3094]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3100]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3101]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3107]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3108]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3111]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3112]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3113]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3114]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3115]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3116]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3117]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3144]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3145]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3146]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3148]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3158]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3178]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3179]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3181]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3185]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3194]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3196]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3206]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3208]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3209]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3223]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3254]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3256]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3257]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3258]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3260]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3262]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3263]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3274]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3279]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3280]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3282]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3283]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3284]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3285]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3287]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3290]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3297]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3299]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3300]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3306]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3307]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3308]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3310]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3320]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3361]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3367]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3372]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3399]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3400]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3405]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3406]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3422]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3423]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3433]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3438]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3439]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3449]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3455]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3456]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3459]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3460]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3464]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3473]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3474]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3475]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3485]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3493]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3499]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3500]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3501]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3515]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3529]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3531]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3537]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3539]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3543]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3544]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3545]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3546]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3547]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3549]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3553]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3556]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3582]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3583]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3588]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3600]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3605]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3606]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3608]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3610]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3611]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3620]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3621]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3632]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3641]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3642]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3645]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3649]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3656]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3660]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3665]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3666]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3667]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3671]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3672]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3673]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3681]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3687]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3690]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3691]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3692]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3694]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3695]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3696]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3697]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3698]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3699]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3700]]': last base was ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3701]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3702]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3705]]': last 2 bases were ignored
```

```
## Warning in .Call2("DNAStringSet_translate", x, skip_code,
## dna_codes[codon_alphabet], : in 'x[[3710]]': last 2 bases were ignored
```

```
## AAStringSet object of length 3715:
##        width seq                                            names
##    [1]   227 QWDPRPAVVSGTGGHLQRRALD...LGSGLLHQRTPALPHPGHLH* ENST00000595502.1
##    [2]   317 MKIANNTVVTEFILLGLTQSQD...SMKRLLSRHVVCQVDFIIRN* ENST00000639059.1_4
##    [3]   317 MKIANNTVVTEFILLGLTQSQD...SMKRLLSRHVVCQVDFIIRN* ENST00000628444.1_6
##    [4]   285 METANYTKVTEFVLTGLSQTPE...KEVKAAMRKLVTKYILCKEK* ENST00000332663.3_5
##    [5]   314 METANYTKVTEFVLTGLSQTPE...KEVKAAMRKLVTKYILCKEK* ENST00000614722.3_5
##    ...   ... ...
## [3711]   803 MAAEALAAEAVASRLERQEEDI...AIDKLKNLRKTRTLNAEEAF* ENST00000335968.8_9
## [3712]   149 EVSKEILLEMFKYNKFKCRILN...RGAFIYNTLTDFIRMQDRCG* ENST00000558533.5_8
## [3713]   767 MAAEALAAEAVASRLERQEEDI...AQYNFILDRFLPSVWQEAWL* ENST00000539112.5_4
## [3714]   767 MAAEALAAEAVASRLERQEEDI...AQYNFILDRFLPSVWQEAWL* ENST00000615656.1_7
## [3715]   324 VTAEAISWNESTSETNNSMVTE...DMKTAIRRLRKWDAHSSVKF* ENST00000650172.1_7
```

# 6 Session Information

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [2] BSgenome_1.78.0
##  [3] rtracklayer_1.70.0
##  [4] BiocIO_1.20.0
##  [5] Biostrings_2.78.0
##  [6] XVector_0.50.0
##  [7] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [8] GenomicFeatures_1.62.0
##  [9] AnnotationDbi_1.72.0
## [10] Biobase_2.70.0
## [11] GenomicRanges_1.62.0
## [12] Seqinfo_1.0.0
## [13] IRanges_2.44.0
## [14] S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0
## [16] generics_0.1.4
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
##  [3] rjson_0.2.23                xfun_0.53
##  [5] bslib_0.9.0                 lattice_0.22-7
##  [7] vctrs_0.6.5                 tools_4.5.1
##  [9] bitops_1.0-9                curl_7.0.0
## [11] parallel_4.5.1              RSQLite_2.4.3
## [13] blob_1.2.4                  pkgconfig_2.0.3
## [15] Matrix_1.7-4                cigarillo_1.0.0
## [17] lifecycle_1.0.4             compiler_4.5.1
## [19] Rsamtools_2.26.0            codetools_0.2-20
## [21] htmltools_0.5.8.1           sass_0.4.10
## [23] RCurl_1.98-1.17             yaml_2.3.10
## [25] crayon_1.5.3                jquerylib_0.1.4
## [27] BiocParallel_1.44.0         cachem_1.1.0
## [29] DelayedArray_0.36.0         abind_1.4-8
## [31] digest_0.6.37               restfulr_0.0.16
## [33] bookdown_0.45               fastmap_1.2.0
## [35] grid_4.5.1                  cli_3.6.5
## [37] SparseArray_1.10.0          S4Arrays_1.10.0
## [39] XML_3.99-0.19               bit64_4.6.0-1
## [41] rmarkdown_2.30              httr_1.4.7
## [43] matrixStats_1.5.0           bit_4.6.0
## [45] png_0.1-8                   memoise_2.0.1
## [47] evaluate_1.0.5              knitr_1.50
## [49] rlang_1.1.6                 DBI_1.2.3
## [51] BiocManager_1.30.26         jsonlite_2.0.0
## [53] R6_2.6.1                    MatrixGenerics_1.22.0
## [55] GenomicAlignments_1.46.0
```