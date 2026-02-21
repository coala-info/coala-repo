# ORFik Overview

Haakon Tjeldnes & Kornel Labun

#### 22 December 2025

#### Package

ORFik 1.30.2

# Contents

* [1 Introduction](#introduction)
* [2 Finding Open Reading Frames](#finding-open-reading-frames)
  + [2.1 Example of finding ORFs in on 5’ UTR of hg19](#example-of-finding-orfs-in-on-5-utr-of-hg19)
  + [2.2 Saving coordinates of ORFs to disc](#saving-coordinates-of-orfs-to-disc)
  + [2.3 Getting sequences from ORFs](#getting-sequences-from-orfs)
    - [2.3.1 Getting DNA fasta sequences of ORFs](#getting-dna-fasta-sequences-of-orfs)
    - [2.3.2 Amino acid sequences of ORFs](#amino-acid-sequences-of-orfs)
* [3 New GRanges and GRangesList utilities for ORFs](#new-granges-and-grangeslist-utilities-for-orfs)
  + [3.1 Grouping ORFs](#grouping-orfs)
  + [3.2 Filtering example](#filtering-example)
  + [3.3 ORF interest regions](#orf-interest-regions)
* [4 When to use which ORF-finding function](#when-to-use-which-orf-finding-function)
  + [4.1 Finding ORFs in spliced transcripts](#finding-orfs-in-spliced-transcripts)
  + [4.2 Prokaryote/Circular Genomes and fasta transcriptomes.](#prokaryotecircular-genomes-and-fasta-transcriptomes.)
  + [4.3 Filter on strand](#filter-on-strand)
* [5 CAGE data for 5’ UTR re-annotation](#cage-data-for-5-utr-re-annotation)
* [6 RiboSeq footprints automatic shift detection and shifting](#riboseq-footprints-automatic-shift-detection-and-shifting)
* [7 Gene identity functions for ORFs or genes](#gene-identity-functions-for-orfs-or-genes)
* [8 Calculating Kozak sequence score for ORFs](#calculating-kozak-sequence-score-for-orfs)
* [9 Using ORFik in your package or scripts](#using-orfik-in-your-package-or-scripts)
* [10 Coverage plots made easy with ORFik](#coverage-plots-made-easy-with-orfik)
  + [10.1 Multiple data sets in one plot](#multiple-data-sets-in-one-plot)
* [11 Conclusion](#conclusion)

# 1 Introduction

Welcome to the `ORFik` package.
`ORFik` is an R package for analysis of transcript and translation features through manipulation of sequence data and NGS data like Ribo-Seq, RNA-Seq, TCP-Seq and CAGE. It is generalized in the sense that any transcript region can be analysed,
as the name hints to, it was made with investigation of ribosomal patterns over Open Reading Frames (ORFs) as it’s primary use case.

This vignette will walk you through our detailed package usage with examples.

`ORFik` currently supports:

1. Finding Open Reading Frames (very fast) in the genome of interest or on the
   set of transcripts/sequences.
2. Hundreds of functions helping your analysis of either: sequence data, RNA-seq data, CAGE data, Ribo-seq data, TCP-seq data or RCP-seq data.
3. Automatic estimations of RiboSeq footprint shift.
4. Utilities for metaplots of RiboSeq coverage over gene START and STOP codons
   allowing to spot the shift.
5. Shifting functions for the RiboSeq data.
6. Annotation / re-annotation of 5’ UTR Transcription Start Sites using CAGE data.
7. Various measurements of gene identity, more than 30 functions. e.g. FLOSS, coverage, ORFscore,
   entropy that are recreated based on scientific publications.
8. Utility functions to extend GenomicRanges for faster grouping, splitting, filtering etc. Included c++ function for speed.
9. Extensive implemented syntax for coverage and metacoverage of NGS data, including smart grouping functions for easier prototyping.
10. Automatic download of genome annotation from any species supported by ensembl.
11. Automatic download and metadata extraction of NGS files from SRA, ERA, DRA and GEO.
12. Full NGS alignment pipeline: Trimming data using fastp and alignment using STAR (with optional contaminant removals)
13. Simplifying working with massive amounts of datasets using the ORFik experiment class.

The basics for the first 9 points on this list is described here, for more advanced use (point 10-13) check out the other vignettes.
This overview vignette shows simplified analysis on single libraries (to make the examples simple). So for more
complex analysis on multiple libraries, continue with the other vignettes when you have finish this one.

# 2 Finding Open Reading Frames

In molecular genetics, an Open Reading Frame (ORF) is the part of a reading
frame that has the ability to be translated. Although not every ORF has the potential to be translated or to be functional, to find novel genes we must first be able to identify potential ORFs.

To find all Open Reading Frames (ORFs) and possibly map them to genomic
coordinates,`ORFik` gives you three main functions:

* `findORFs` - find ORFs in sequences of interest (local sequence search),
* `findMapORFs` - find ORFs and map them to their respective genomic coordinates (for spliced transcriptomes)
* `findORFsFasta` - find all ORFs in Fasta file or entire `BSGenome` (supports circular genomes!)

## 2.1 Example of finding ORFs in on 5’ UTR of hg19

Load libraries we need for examples

```
library(ORFik)                        # This package
library(GenomicFeatures)              # For basic transcript operations
library(data.table)                   # For fast table operations
library(BSgenome.Hsapiens.UCSC.hg19)  # Human genome
```

After loading libraries, load human genome sample annotation from `GenomicFeatures`.

```
txdbFile <- system.file("extdata", "hg19_knownGene_sample.sqlite",
                        package = "GenomicFeatures")
```

We load gtf file as txdb (transcript database).
We will then extract the 5’ leaders to find all upstream open reading
frames.

```
txdb <- loadTxdb(txdbFile)
fiveUTRs <- loadRegion(txdb, "leaders")
fiveUTRs[1]
```

```
## GRangesList object of length 1:
## $uc001bum.2
## GRanges object with 1 range and 3 metadata columns:
##       seqnames            ranges strand |   exon_id   exon_name exon_rank
##          <Rle>         <IRanges>  <Rle> | <integer> <character> <integer>
##   [1]     chr1 32671236-32671282      + |         1        <NA>         1
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

As we can see we have extracted 5’ UTRs for hg19 annotations. Now we can load
`BSgenome` version of human genome (hg19).

Either import fasta or BSgenome file to get sequences.

```
# Extract sequences of fiveUTRs.
tx_seqs <- extractTranscriptSeqs(BSgenome.Hsapiens.UCSC.hg19::Hsapiens,
                                 fiveUTRs)
tx_seqs[1]
```

```
## DNAStringSet object of length 1:
##     width seq                                               names
## [1]    47 AATGACGTACTTCGCAGGCGCGCGGGCGGGCCTGGCAGTTGGCGCCC   uc001bum.2
```

Find all ORFs on those transcripts and get their genomic coordinates.

```
fiveUTR_ORFs <- findMapORFs(fiveUTRs, tx_seqs, groupByTx = FALSE)
fiveUTR_ORFs[1:2]
```

```
## GRangesList object of length 2:
## $uc010ogz.1_1
## GRanges object with 2 ranges and 1 metadata column:
##              seqnames            ranges strand |        names
##                 <Rle>         <IRanges>  <Rle> |  <character>
##   uc010ogz.1     chr1 32671314-32671324      + | uc010ogz.1_1
##   uc010ogz.1     chr1 32671755-32671902      + | uc010ogz.1_1
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
##
## $uc010ogz.1_2
## GRanges object with 1 range and 1 metadata column:
##              seqnames            ranges strand |        names
##                 <Rle>         <IRanges>  <Rle> |  <character>
##   uc010ogz.1     chr1 32672038-32672076      + | uc010ogz.1_2
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

In the example above, you can see that fiveUTR\_ORFs are grouped by ORF.
That means each group in the GRangesList is 1 ORF, that can have multiple exons.
To get the transcript the ORF came from, do this:

```
txNames(fiveUTR_ORFs[1:2]) # <- Which transcript
```

```
## [1] "uc010ogz.1" "uc010ogz.1"
```

You see that both ORFs are from transcript “uc010ogz.1”

Meta-column names contains name
of the transcript and identifier of the ORF separated by "\_“. When a ORF is
separated into two exons you see it twice, as the first ORF with name”uc010ogz.1\_1". The first ORF will always be the one most upstream for +
strand, and the least upstream for - strand.

```
names(fiveUTR_ORFs[1:2]) # <- Which ORF
```

```
## [1] "uc010ogz.1_1" "uc010ogz.1_2"
```

## 2.2 Saving coordinates of ORFs to disc

We recommend two options for storing ORF ranges:

1. If you want to reuse only in R:
   Save as R object

```
saveRDS(fiveUTR_ORFs[1:2], "save/path/uorfs.rds")
```

2. If you want to use in IGV, UCSC genome browser etc:
   Save as bed12 format, that is a bed format with 1 row per ORF, that contains
   splicing information and even possible color coding for visualizing groups of ORFs:

```
export.bed12(fiveUTR_ORFs[1:2], "save/path/uorfs.bed12")
```

## 2.3 Getting sequences from ORFs

Now lets see how easy it is to get fasta sequences from the ranges.

### 2.3.1 Getting DNA fasta sequences of ORFs

Lets start with the case of getting the DNA sequences.

```
orf_seqs <- extractTranscriptSeqs(BSgenome.Hsapiens.UCSC.hg19::Hsapiens,
                                  fiveUTR_ORFs[1:3])
orf_seqs
```

```
## DNAStringSet object of length 3:
##     width seq                                               names
## [1]   159 CTGCATTGCAGGCCTGCGTCCGG...GCCGCGATTCCTCCCAGAGGTAG uc010ogz.1_1
## [2]    39 CTGCTAGATCATGGTGCCCAGATACTTGGAAGGGTTTAG           uc010ogz.1_2
## [3]   141 ATGACGTACTTCGCAGGCGCGCG...CAGTTCCAGAGCCTGCGAGCTGA uc010ogz.1_3
```

You can see ORF 1 named (uc010ogz.1\_1) has a CTG start codon, a TAG stop codon and 159/3 = 53 codons.

To save as .fasta do

```
writeXStringSet(orf_seqs, filepath = "uorfs.fasta")
```

### 2.3.2 Amino acid sequences of ORFs

Now lets do the case of getting the amino acid sequences. We start with the DNA sequences already done from previous step.

To translate to amino acids, following the standard genetic code, do:

```
orf_aa_seq <- Biostrings::translate(orf_seqs)
orf_aa_seq
```

```
## AAStringSet object of length 3:
##     width seq                                               names
## [1]    53 MHCRPASGASWSDASSRACELSM...RATWARFSGPRAAFPGRDSSQR* uc010ogz.1_1
## [2]    13 MLDHGAQILGRV*                                     uc010ogz.1_2
## [3]    47 MTYFAGARAGLAVGAHGARAAGSEGVCIAGLRPGLLGPTPVPEPAS*   uc010ogz.1_3
```

save amino acid sequences as .fasta do

```
writeXStringSet(orf_aa_seq, filepath = "uorfs_AA.fasta")
```

We will now look on ORFik functions to get startcodons and stopcodon etc.

# 3 New GRanges and GRangesList utilities for ORFs

We will now go through utilities to group, subset and filter on interesting regions of ORFs in transcripts.

## 3.1 Grouping ORFs

There are 2 main ways of grouping ORFs.
- Group by ORF (Each group are all exons per ORF)
- Group by transcript (Each group are all ORFs from transcript)

To do this more easily, you can use the function `groupGRangesBy`.

1. Grouped by transcript:
   We use the names() to group,

```
unlisted_ranges <- unlistGrl(fiveUTR_ORFs)
test_ranges <- groupGRangesBy(unlisted_ranges) # <- defualt is tx grouping by names()
test_ranges[1]
```

```
## GRangesList object of length 1:
## $uc010ogz.1
## GRanges object with 10 ranges and 1 metadata column:
##              seqnames            ranges strand |        names
##                 <Rle>         <IRanges>  <Rle> |  <character>
##   uc010ogz.1     chr1 32671314-32671324      + | uc010ogz.1_1
##   uc010ogz.1     chr1 32671755-32671902      + | uc010ogz.1_1
##   uc010ogz.1     chr1 32672038-32672076      + | uc010ogz.1_2
##   uc010ogz.1     chr1 32671237-32671324      + | uc010ogz.1_3
##   uc010ogz.1     chr1 32671755-32671807      + | uc010ogz.1_3
##   uc010ogz.1     chr1 32671934-32672044      + | uc010ogz.1_4
##   uc010ogz.1     chr1 32672048-32672152      + | uc010ogz.1_5
##   uc010ogz.1     chr1 32671274-32671324      + | uc010ogz.1_6
##   uc010ogz.1     chr1 32671755-32671913      + | uc010ogz.1_6
##   uc010ogz.1     chr1 32672034-32672192      + | uc010ogz.1_7
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

All orfs within a transcript grouped together as one group, the names column seperates the orfs.

2. Grouped by ORF:
   we use the orfs meta column called ($names) to group, it is made by ORFik.

```
unlisted_ranges <- unlistGrl(fiveUTR_ORFs)
test_ranges <- groupGRangesBy(unlisted_ranges, unlisted_ranges$names)
test_ranges[1:2]
```

```
## GRangesList object of length 2:
## $uc010ogz.1_1
## GRanges object with 2 ranges and 1 metadata column:
##              seqnames            ranges strand |        names
##                 <Rle>         <IRanges>  <Rle> |  <character>
##   uc010ogz.1     chr1 32671314-32671324      + | uc010ogz.1_1
##   uc010ogz.1     chr1 32671755-32671902      + | uc010ogz.1_1
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
##
## $uc010ogz.1_2
## GRanges object with 1 range and 1 metadata column:
##              seqnames            ranges strand |        names
##                 <Rle>         <IRanges>  <Rle> |  <character>
##   uc010ogz.1     chr1 32672038-32672076      + | uc010ogz.1_2
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

Here you see each group is one ORF only (this is the primary grouping)

## 3.2 Filtering example

Lets say you found some ORFs, and you want to filter out some of them.
ORFik provides several functions for filtering. A problem with the
original GenomicRanges container is that filtering on GRanges objects
are much easier than on a GRangesList object, ORFik tries to fix this.

In this example we will filter out all ORFs as following:

1. First group GRangesList by ORFs
2. width < 60
3. number of exons < 2
4. strand is negative

Lets use the fiveUTR\_ORFs from previous example:

1. Group by ORFs (primary grouping)

```
  unlisted_ranges <- unlistGrl(fiveUTR_ORFs)
  ORFs <- groupGRangesBy(unlisted_ranges, unlisted_ranges$names)
  length(ORFs) # length means how many ORFs left in set
```

```
## [1] 839
```

2. Remove widths < 60

```
  ORFs <- ORFs[widthPerGroup(ORFs) >= 60]
  length(ORFs)
```

```
## [1] 426
```

3. Keep only ORFs with at least 2 exons

```
  ORFs <- ORFs[numExonsPerGroup(ORFs) > 1]
  length(ORFs)
```

```
## [1] 120
```

4. Keep only + strand ORFs

```
  ORFs <- ORFs[strandPerGroup(ORFs) == "+"]
  # all remaining ORFs where on positive strand, so no change
  length(ORFs)
```

```
## [1] 85
```

## 3.3 ORF interest regions

Specific part of the ORF are usually of interest, as start and stop codons.
Here we run an example to show what ORFik can do for you.

1. Find the start and stop sites as GRanges

```
startSites(fiveUTR_ORFs, asGR = TRUE, keep.names = TRUE, is.sorted = TRUE)
```

```
## GRanges object with 839 ranges and 0 metadata columns:
##                      seqnames    ranges strand
##                         <Rle> <IRanges>  <Rle>
##   uc010ogz.1_1           chr1  32671314      +
##   uc010ogz.1_2           chr1  32672038      +
##   uc010ogz.1_3           chr1  32671237      +
##   uc010ogz.1_4           chr1  32671934      +
##   uc010ogz.1_5           chr1  32672048      +
##            ...            ...       ...    ...
##   uc011jox.1_3 chr6_ssto_hap7   3272624      -
##   uc011jox.1_4 chr6_ssto_hap7   3272420      -
##   uc011jox.1_5 chr6_ssto_hap7   3272731      -
##   uc011jox.1_6 chr6_ssto_hap7   3272521      -
##   uc011jox.1_7 chr6_ssto_hap7   3272198      -
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

```
stopSites(fiveUTR_ORFs, asGR = TRUE, keep.names = TRUE, is.sorted = TRUE)
```

```
## GRanges object with 839 ranges and 0 metadata columns:
##                      seqnames    ranges strand
##                         <Rle> <IRanges>  <Rle>
##   uc010ogz.1_1           chr1  32671902      +
##   uc010ogz.1_2           chr1  32672076      +
##   uc010ogz.1_3           chr1  32671807      +
##   uc010ogz.1_4           chr1  32672044      +
##   uc010ogz.1_5           chr1  32672152      +
##            ...            ...       ...    ...
##   uc011jox.1_3 chr6_ssto_hap7   3272448      -
##   uc011jox.1_4 chr6_ssto_hap7   3272200      -
##   uc011jox.1_5 chr6_ssto_hap7   3272522      -
##   uc011jox.1_6 chr6_ssto_hap7   3272456      -
##   uc011jox.1_7 chr6_ssto_hap7   3272169      -
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

2. Lets find the start and stop codons.
   This takes care of potential 1 base exons etc.

```
starts <- startCodons(fiveUTR_ORFs, is.sorted = TRUE)
stops <- stopCodons(fiveUTR_ORFs, is.sorted = TRUE)
starts[1:2]
```

```
## GRangesList object of length 2:
## $uc010ogz.1_1
## GRanges object with 1 range and 1 metadata column:
##              seqnames            ranges strand |        names
##                 <Rle>         <IRanges>  <Rle> |  <character>
##   uc010ogz.1     chr1 32671314-32671316      + | uc010ogz.1_1
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
##
## $uc010ogz.1_2
## GRanges object with 1 range and 1 metadata column:
##              seqnames            ranges strand |        names
##                 <Rle>         <IRanges>  <Rle> |  <character>
##   uc010ogz.1     chr1 32672038-32672040      + | uc010ogz.1_2
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
```

3. Lets get the bases of the start and stop codons from the fasta file
   It’s very important to check that ORFs are sorted here,

```
txSeqsFromFa(starts, BSgenome.Hsapiens.UCSC.hg19::Hsapiens, is.sorted = TRUE)
```

```
## DNAStringSet object of length 839:
##       width seq                                             names
##   [1]     3 CTG                                             uc010ogz.1_1
##   [2]     3 CTG                                             uc010ogz.1_2
##   [3]     3 ATG                                             uc010ogz.1_3
##   [4]     3 TTG                                             uc010ogz.1_4
##   [5]     3 ATG                                             uc010ogz.1_5
##   ...   ... ...
## [835]     3 TTG                                             uc011jox.1_3
## [836]     3 TTG                                             uc011jox.1_4
## [837]     3 CTG                                             uc011jox.1_5
## [838]     3 ATG                                             uc011jox.1_6
## [839]     3 ATG                                             uc011jox.1_7
```

```
"Stop codons"
```

```
## [1] "Stop codons"
```

```
txSeqsFromFa(stops, BSgenome.Hsapiens.UCSC.hg19::Hsapiens, is.sorted = TRUE)
```

```
## DNAStringSet object of length 839:
##       width seq                                             names
##   [1]     3 TAG                                             uc010ogz.1_1
##   [2]     3 TAG                                             uc010ogz.1_2
##   [3]     3 TGA                                             uc010ogz.1_3
##   [4]     3 TAG                                             uc010ogz.1_4
##   [5]     3 TAG                                             uc010ogz.1_5
##   ...   ... ...
## [835]     3 TAG                                             uc011jox.1_3
## [836]     3 TAG                                             uc011jox.1_4
## [837]     3 TGA                                             uc011jox.1_5
## [838]     3 TGA                                             uc011jox.1_6
## [839]     3 TAG                                             uc011jox.1_7
```

Many more operations are also supported for manipulation of ORFs

# 4 When to use which ORF-finding function

ORFik supports multiple ORF finding functions. Here we describe their specific
use cases:

Which function you will use depend on which organism the data is from, and
specific parameters, like circular or non circular genomes, will you use
a transcriptome etc.

There are 4 standard ways of finding ORFs:

1. You have some fasta file of the genome only. (For prokaryotes/circular genomes)
2. You have some fasta file of the genome and a spliced transcriptome annotation. (For eukaryotes with splicing)
3. You have a fasta file of transcripts (eukaryotes or prokaryotes)
4. You have a vector of transcripts preloaded in R.

Let’s start with the simplest case; a vector of preloaded transcripts.

Lets say you have some transcripts and want to find all ORFs on them.
findORFs() will give you only 5’ to 3’ direction, so if you want both directions,
you can do (for strands in both direction):

```
  library(Biostrings)
  # strand with ORFs in both directions
  seqs <- DNAStringSet("ATGAAATGAAGTAAATCAAAACAT")
  ######################>######################< (< > is direction of ORF)

  # positive strands
  pos <- findORFs(seqs, startCodon = "ATG", minimumLength = 0)
  # negative strands
  neg <- findORFs(reverseComplement(seqs),
                  startCodon = "ATG", minimumLength = 0)
```

Merge into a GRanges object, since we want strand information

```
  pos <- GRanges(pos, strand = "+")
  neg <- GRanges(neg, strand = "-")
  # as GRanges
  res <- c(pos, neg)
  # or merge together and make GRangesList
  res <- split(res, seq.int(1, length(pos) + length(neg)))
  res[1:2]
```

```
## GRangesList object of length 2:
## $`1`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]        1       1-9      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`2`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]        1      6-14      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Remember that these results are in transcript coordinates, sometimes you need to convert them to Genomic coordinates.

## 4.1 Finding ORFs in spliced transcripts

If you have a genome and a spliced transcriptome annotation, you must use findMapORFs().
It takes care of the potential problem from the last example,
that we really want our result in genomic coordinates in the end.

## 4.2 Prokaryote/Circular Genomes and fasta transcriptomes.

Use findORFsFasta(is.circular = TRUE).
Note that findORFsFasta automaticly finds (-) strand too, because that is
normally used for genomes.

## 4.3 Filter on strand

If you have fasta transcriptomes, you dont want the (-) strand. Since
all transcripts are in the direction in the fasta file.
If you get both (+/-) strand and only want (+) ORFs, do:

```
  res[strandBool(res)] # Keep only + stranded ORFs
```

```
## GRangesList object of length 2:
## $`1`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]        1       1-9      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $`2`
## GRanges object with 1 range and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]        1      6-14      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

See individual functions for more examples.

# 5 CAGE data for 5’ UTR re-annotation

In the previous example we used the reference annotation of the 5’ UTRs from Hg19.

Here we will use CAGE data to set new Transcription Start Sites (TSS) and re-annotate 5’ UTRs. This is useful to improve tissue specific transcripts. Since most eukaryotes usually have variance in TSS definitions.

```
# path to example CageSeq data from hg19 heart sample
cageData <- system.file("extdata", "cage-seq-heart.bed.bgz",
                        package = "ORFik")
# get new Transcription Start Sites using CageSeq dataset
newFiveUTRs <- reassignTSSbyCage(fiveUTRs, cageData)
newFiveUTRs
```

```
## GRangesList object of length 150:
## $uc001bum.2
## GRanges object with 1 range and 3 metadata columns:
##              seqnames            ranges strand |   exon_id   exon_name
##                 <Rle>         <IRanges>  <Rle> | <integer> <character>
##   uc001bum.2     chr1 32671236-32671282      + |         1        <NA>
##              exon_rank
##              <integer>
##   uc001bum.2         1
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
##
## $uc009vua.2
## GRanges object with 1 range and 3 metadata columns:
##              seqnames            ranges strand |   exon_id   exon_name
##                 <Rle>         <IRanges>  <Rle> | <integer> <character>
##   uc009vua.2     chr1 32671236-32671282      + |         2        <NA>
##              exon_rank
##              <integer>
##   uc009vua.2         1
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
##
## $uc010ogz.1
## GRanges object with 2 ranges and 3 metadata columns:
##              seqnames            ranges strand |   exon_id   exon_name
##                 <Rle>         <IRanges>  <Rle> | <integer> <character>
##   uc010ogz.1     chr1 32671236-32671324      + |         1        <NA>
##   uc010ogz.1     chr1 32671755-32672223      + |         4        <NA>
##              exon_rank
##              <integer>
##   uc010ogz.1         1
##   uc010ogz.1         2
##   -------
##   seqinfo: 93 sequences (1 circular) from hg19 genome
##
## ...
## <147 more elements>
```

You will now normally see a portion of the transcription start sites have changed.
Depending on the species, regular annotations might be incomplete or not
specific enough for your purposes.

* NOTE: IF you want to edit the whole txdb / gtf file, use reassignTxDbByCage. And save this to get the new gtf with reannotated leaders by CAGE.

# 6 RiboSeq footprints automatic shift detection and shifting

In RiboSeq data ribosomal footprints are restricted to their p-site positions
and shifted with respect to the shifts visible over the start and stop
codons. `ORFik` has multiple functions for processing of RiboSeq data.

Usually you would run detectRibosomeShifts to find shifts in a single function call,
but we will here go through a detailed example to better understand processing of RiboSeq data.

Example raw Ribo-Seq footprints (unshifted bam file, Organism: Danio rerio)

```
# Find path to a bam file
bam_file <- system.file("extdata/Danio_rerio_sample", "ribo-seq.bam", package = "ORFik")
footprints <- readBam(bam_file)
```

What footprint lengths are present in our data:

```
table(readWidths(footprints))
```

```
## Warning in call_new_fun_in_cigarillo("cigarWidthAlongQuerySpace", "cigar_extent_along_query", : cigarWidthAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigar_extent_along_query() function from the new
##   cigarillo package
```

```
##
##   28   29   30
## 5547 5576 5526
```

Lets look at how the reads distribute around the CDS per read length:
For that we need to prepare the transcriptome annotation (Organism: Danio rerio).

```
gtf_file <- system.file("extdata/references/danio_rerio", "annotations.gtf", package = "ORFik")
txdb <- loadTxdb(gtf_file)
tx <- loadRegion(txdb, part = "tx")
cds <- loadRegion(txdb, part = "cds")
trailers <- loadRegion(txdb, part = "trailers")
cds[1]
```

```
## GRangesList object of length 1:
## $ENSDART00000032996
## GRanges object with 4 ranges and 3 metadata columns:
##       seqnames            ranges strand |    cds_id    cds_name exon_rank
##          <Rle>         <IRanges>  <Rle> | <integer> <character> <integer>
##   [1]     chr8 24067789-24067843      + |         1        <NA>         2
##   [2]     chr8 24068170-24068247      + |         2        <NA>         3
##   [3]     chr8 24068353-24068449      + |         4        <NA>         4
##   [4]     chr8 24068538-24068661      + |         6        <NA>         5
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

Note in ORFik you can load full transcript annotation in one line (this is same as above):

```
loadRegions(gtf_file, parts = c("tx", "cds", "trailers"))
```

A note here is that “tx” are all transcripts (mRNA + ncRNA), if you write “mrna” you will only
get subset of tx that has a defined cds.

Restrict footprints to their 5’ starts (after shifting it will be a p-site).

```
footprintsGR <- convertToOneBasedRanges(footprints, addSizeColumn = TRUE)
```

```
## Warning in call_new_fun_in_cigarillo("cigarWidthAlongQuerySpace", "cigar_extent_along_query", : cigarWidthAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigar_extent_along_query() function from the new
##   cigarillo package
```

```
footprintsGR
```

```
## GRanges object with 16649 ranges and 1 metadata column:
##           seqnames    ranges strand |      size
##              <Rle> <IRanges>  <Rle> | <integer>
##       [1]    chr23  17599156      - |        28
##       [2]    chr23  17599156      - |        28
##       [3]    chr23  17599156      - |        28
##       [4]    chr23  17599156      - |        28
##       [5]    chr23  17599156      - |        28
##       ...      ...       ...    ... .       ...
##   [16645]     chr8  24068894      + |        29
##   [16646]     chr8  24068907      + |        28
##   [16647]     chr8  24068919      + |        30
##   [16648]     chr8  24068919      + |        30
##   [16649]     chr8  24068939      + |        30
##   -------
##   seqinfo: 1133 sequences from an unspecified genome
```

The function convertToOneBasedRanges gives you a size column, that contains
read length information. You can also choose to use the score column
for read information. But size has priority over score for deciding what
column defines read lengths.

In the figure below we see why we need to p-shift, see that per length the
start of the read are in different positions relative to the CDS start site.
The reads create a ladder going downwards, left to right. (see the blue steps)

```
  hitMap <- windowPerReadLength(cds, tx,  footprintsGR, pShifted = FALSE)
  coverageHeatMap(hitMap, scoring = "transcriptNormalized")
```

![](data:image/png;base64...)

If you only want to know how to run the function and no details,
skip down to after the 2 coming bar plots.

For the sake of this example we will focus only on most abundant length of 29.

```
footprints <- footprints[readWidths(footprints) == 29]
```

```
## Warning in call_new_fun_in_cigarillo("cigarWidthAlongQuerySpace", "cigar_extent_along_query", : cigarWidthAlongQuerySpace() is formally deprecated in GenomicAlignments >=
##   1.45.5 and replaced with the cigar_extent_along_query() function from the new
##   cigarillo package
```

```
footprintsGR <- footprintsGR[readWidths(footprintsGR) == 29]
footprints
```

```
## GAlignments object with 5576 alignments and 0 metadata columns:
##          seqnames strand       cigar    qwidth     start       end     width
##             <Rle>  <Rle> <character> <integer> <integer> <integer> <integer>
##      [1]    chr23      -         29M        29  17599129  17599157        29
##      [2]    chr23      -         29M        29  17599129  17599157        29
##      [3]    chr23      -         29M        29  17599129  17599157        29
##      [4]    chr23      -         29M        29  17599129  17599157        29
##      [5]    chr23      -         29M        29  17599129  17599157        29
##      ...      ...    ...         ...       ...       ...       ...       ...
##   [5572]     chr8      +         29M        29  24068755  24068783        29
##   [5573]     chr8      +         29M        29  24068755  24068783        29
##   [5574]     chr8      +         29M        29  24068769  24068797        29
##   [5575]     chr8      +         29M        29  24068802  24068830        29
##   [5576]     chr8      +         29M        29  24068894  24068922        29
##              njunc
##          <integer>
##      [1]         0
##      [2]         0
##      [3]         0
##      [4]         0
##      [5]         0
##      ...       ...
##   [5572]         0
##   [5573]         0
##   [5574]         0
##   [5575]         0
##   [5576]         0
##   -------
##   seqinfo: 1133 sequences from an unspecified genome
```

Filter the cds annotation to only those that have some minimum trailer and
leader lengths, as well as cds.
Then get start and stop codons with extra window of 30bp around
them.

```
txNames <- filterTranscripts(txdb) # <- get only transcripts that pass filter
tx <- tx[txNames]; cds <- cds[txNames]; trailers <- trailers[txNames];
windowsStart <- startRegion(cds, tx, TRUE, upstream = 30, 29)
windowsStop <- startRegion(trailers, tx, TRUE, upstream = 30, 29)
windowsStart
```

```
## GRangesList object of length 2:
## $ENSDART00000000070
## GRanges object with 1 range and 0 metadata columns:
##                      seqnames            ranges strand
##                         <Rle>         <IRanges>  <Rle>
##   ENSDART00000000070    chr24 22711351-22711410      -
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
##
## $ENSDART00000032996
## GRanges object with 1 range and 0 metadata columns:
##                      seqnames            ranges strand
##                         <Rle>         <IRanges>  <Rle>
##   ENSDART00000032996     chr8 24067759-24067818      +
##   -------
##   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

Calculate meta-coverage over start and stop windowed regions.

```
hitMapStart <- metaWindow(footprintsGR, windowsStart, withFrames = TRUE, fraction = 29)
hitMapStop <- metaWindow(footprintsGR, windowsStop, withFrames = TRUE, fraction = 29)
```

Plot start/stop windows for length 29.

```
  pSitePlot(hitMapStart)
```

![](data:image/png;base64...)

```
  pSitePlot(hitMapStop, region = "stop")
```

![](data:image/png;base64...)
From these shifts ORFik uses a fourier transform to detect signal change needed
to scale all read lengths of Ribo-seq to the start of the meta-cds.

We can also use automatic detection of RiboSeq shifts using the code below. As
we can see reasonable conclusion from the plots would be to shift length 29 by
12, it is in agreement with the automatic detection of the offsets.

```
shifts <- detectRibosomeShifts(footprints, txdb, stop = TRUE)
shifts
```

```
##    fraction offsets_start offsets_stop
##       <int>         <int>        <num>
## 1:       29           -12          -12
```

Fortunately `ORFik` has a function that can be used to shift footprints using
desired shifts. See documentation for more details.

```
shiftedFootprints <- shiftFootprints(footprints, shifts)
```

```
## Sorting shifted footprints...
```

```
shiftedFootprints
```

```
## GRanges object with 5576 ranges and 1 metadata column:
##          seqnames    ranges strand |      size
##             <Rle> <IRanges>  <Rle> | <integer>
##      [1]     chr8  24066297      + |        29
##      [2]     chr8  24066297      + |        29
##      [3]     chr8  24066297      + |        29
##      [4]     chr8  24066297      + |        29
##      [5]     chr8  24066330      + |        29
##      ...      ...       ...    ... .       ...
##   [5572]    chr24  22711491      - |        29
##   [5573]    chr24  22711503      - |        29
##   [5574]    chr24  22711503      - |        29
##   [5575]    chr24  22711503      - |        29
##   [5576]    chr24  22711503      - |        29
##   -------
##   seqinfo: 1133 sequences from an unspecified genome
```

To efficiently compute and store these ranges, a smart trick is to collapse duplicated reads:

```
shiftedFootprints <- collapseDuplicatedReads(shiftedFootprints, addSizeColumn = TRUE)
shiftedFootprints
```

```
## GRanges object with 680 ranges and 2 metadata columns:
##         seqnames    ranges strand |      size     score
##            <Rle> <IRanges>  <Rle> | <integer> <integer>
##     [1]     chr8  24066297      + |        29         4
##     [2]     chr8  24066330      + |        29         4
##     [3]     chr8  24066336      + |        29         1
##     [4]     chr8  24066378      + |        29         5
##     [5]     chr8  24066389      + |        29         1
##     ...      ...       ...    ... .       ...       ...
##   [676]    chr24  22711469      - |        29         5
##   [677]    chr24  22711472      - |        29         1
##   [678]    chr24  22711473      - |        29         2
##   [679]    chr24  22711491      - |        29         5
##   [680]    chr24  22711503      - |        29         4
##   -------
##   seqinfo: 1133 sequences from an unspecified genome
```

In advanced use cases for multiple libraries, the function `shiftFootprintsByExperiment` automatically detects p-sites, then shifts and finally stores them as collapsed reads (with optional verbose output for detecting outliers or errors).

# 7 Gene identity functions for ORFs or genes

`ORFik` contains functions of gene identity that can be used to predict
which ORFs are potentially coding and functional.

There are 2 main categories:

* Sequence features (kozak, gc-content, etc.)
* Read features (reads as: Ribo-seq, RNA-seq, TCP-seq, shape-seq etc)

Some important read features are:

* FLOSS `floss`
* coverage `coverage`
* ORFscore `orfScore`
* entropy `entropy`
* translational effiency `translationalEff`
* inside outside score `insideOutsideScore`
* distance between orfs and cds’ `distToCds`
* other

All of the features are implemented based on scientific article published in
peer reviewed journal. `ORFik` supports seamless calculation of all available
features. See example below.

Find ORFs:

```
fiveUTRs <- fiveUTRs[1:10]
faFile <- BSgenome.Hsapiens.UCSC.hg19::Hsapiens
tx_seqs <- extractTranscriptSeqs(faFile, fiveUTRs)

fiveUTR_ORFs <- findMapORFs(fiveUTRs, tx_seqs, groupByTx = FALSE)
```

Make some toy ribo seq and rna seq data:

```
starts <- unlist(ORFik:::firstExonPerGroup(fiveUTR_ORFs), use.names = FALSE)
RFP <- promoters(starts, upstream = 0, downstream = 1)
RFP$size <- rep(29, length(RFP)) # store read widths
# set RNA-seq seq to duplicate transcripts
RNA <- unlist(exonsBy(txdb, by = "tx", use.names = TRUE), use.names = TRUE)
```

Find features of sequence and library data

```
# transcript database
txdb <- loadTxdb(txdbFile)
dt <- computeFeatures(fiveUTR_ORFs[1:4], RFP, RNA, txdb, faFile,
                      sequenceFeatures = TRUE)
dt
```

```
##    countRFP    te   fpkmRFP fpkmRNA floss entropyRFP disengagementScores
##       <int> <num>     <num>   <num> <num>      <num>               <num>
## 1:        1   Inf  898472.6       0     0  0.0000000                 0.4
## 2:        2   Inf 7326007.3       0     0  0.2702382                 3.0
## 3:        3   Inf 3039513.7       0     0  0.2853429                 0.8
## 4:        3   Inf 3861003.9       0     0  0.3042474                 2.0
##          RRS       RSS ORFScores   ioScore startCodonCoverage
##        <num>     <num>     <num>     <num>              <int>
## 1:  7.610063 26.500000  1.584963 0.2500000                  1
## 2: 46.538462  4.333333  1.000000 0.4285714                  1
## 3: 17.163121 11.750000  0.000000 0.6666667                  1
## 4: 21.801802  9.250000  0.000000 0.6666667                  1
##    startRegionCoverage startRegionRelative     kozak        gc StartCodons
##                  <num>               <num>     <num>     <num>      <char>
## 1:                   0                   2 0.3390461 0.6477987         CTG
## 2:                   0                   2 0.1949422 0.4871795         CTG
## 3:                   0                   2 0.0000000 0.6666667         ATG
## 4:                   0                   2 0.7079892 0.5405405         TTG
##    StopCodons fractionLengths distORFCDS inFrameCDS isOverlappingCds rankInTx
##        <char>           <num>      <num>      <num>           <lgcl>    <int>
## 1:        TAG      0.07022968        322          0            FALSE        1
## 2:        TAG      0.01722615        148          0            FALSE        2
## 3:        TGA      0.06227915        417          2            FALSE        3
## 4:        TAG      0.04902827        180          2            FALSE        4
```

You will now get a data.table with one column per score, the columns are named after
the different scores, you can now go further with prediction, or making plots.

# 8 Calculating Kozak sequence score for ORFs

Instead of getting all features, we can also extract single features.

To understand how strong the binding affinitity of an ORF promoter region might be, we can use kozak sequence score. The kozak functions supports
several species. In the first example we use human kozak sequence,
then we make a self defined kozak sequence.

In this example we will find kozak score of cds’

```
cds <- cdsBy(txdb, by = "tx", use.names = TRUE)[1:10]
tx <- exonsBy(txdb, by = "tx", use.names = TRUE)[names(cds)]
faFile <- BSgenome.Hsapiens.UCSC.hg19::Hsapiens

kozakSequenceScore(cds, tx, faFile, species = "human")
```

```
##  [1] 0.6967712 0.6967712 0.6875293 0.6532747 0.6792100 0.6792100 0.6710977
##  [8] 0.4239905 0.7592302 0.6417780
```

A few species are pre supported, if not, make your own input pfm.

Here is an example where the human pfm is sent in again, even though it is already supported:

```
pfm <- t(matrix(as.integer(c(29,26,28,26,22,35,62,39,28,24,27,17,
                             21,26,24,16,28,32,5,23,35,12,42,21,
                             25,24,22,33,22,19,28,17,27,47,16,34,
                             25,24,26,25,28,14,5,21,10,17,15,28)),
                ncol = 4))

kozakSequenceScore(cds, tx, faFile, species = pfm)
```

```
##  [1] 0.5531961 0.5531961 0.6652532 0.6925763 0.6370870 0.6370870 0.4854677
##  [8] 0.4706279 0.6381237 0.6529909
```

As an example of the many plots you can make with ORFik, let’s make a scoring of Ribo-seq by kozak sequence.

```
seqs <- startRegionString(cds, tx, faFile, upstream = 5, downstream = 5)
rate <- fpkm(cds, RFP)
ORFik:::kozakHeatmap(seqs, rate)
```

```
## [1] "Distribution of observations per position per letter"
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   1.000   2.000   3.000   3.929   5.000  10.000
## [1] "Picking: >2 observations"
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the ORFik package.
##   Please report the issue at <https://github.com/Roleren/ORFik/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)
It will be a black boundary box around the strongest nucleotide per position
(what base at what position gives highest ribo-seq fpkm for the cds).
See at the start codon (position +1 to +3) you have A, T, G.
As known from the literature many C’s before start codon and a G after
the start codon. In a real example most of the nucleotides will be used for all positions.

# 9 Using ORFik in your package or scripts

The focus of ORFik for development is to be a Swiss army knife for
transcriptomics. If you need functions for splicing, getting windows of exons
per transcript, periodic windows of exons, speicific parts of exons etc,
ORFik can help you with this.

Let’s do an example where ORFik shines.
Objective: We have three transcripts, we also have a library of Ribo-seq.
This library was treated with cyclohexamide, so we know Ribo-seq reads can
stack up close to the stop codon of the CDS. Lets say we only want to keep
transcripts, where the cds stop region (defined as last 9 bases of cds), has
maximum 33% of the reads. To only keep transcripts with a good spread of reads
over the CDS. How would you make this filter ?

```
  # First make some toy example
  cds <- GRanges("chr1", IRanges(c(1, 10, 20, 30, 40, 50, 60, 70, 80),
                                 c(5, 15, 25, 35, 45, 55, 65, 75, 85)),
                 "+")
  names(cds) <- c(rep("tx1", 3), rep("tx2", 3), rep("tx3", 3))
  cds <- groupGRangesBy(cds)
  ribo <- GRanges("chr1", c(1, rep.int(23, 4), 30, 34, 34, 43, 60, 64, 71, 74),
                  "+")
  # We could do a simplification and use the ORFik entropy function
  entropy(cds, ribo) # <- spread of reads
```

```
## [1] 0.3270264 0.5802792 0.7737056
```

We see that ORF 1, has a low (bad) entropy, but we do not know where the reads
are stacked up.
So lets make a new filter by using more ORFiks utility functions:

```
tile <- tile1(cds, FALSE, FALSE) # tile them to 1 based positions
tails <- tails(tile, 9) # get 9 last bases per cds
stopOverlap <- countOverlaps(tails, ribo)
allOverlap <- countOverlaps(cds, ribo)
fractions <- (stopOverlap + 1) / (allOverlap + 1) # pseudocount 1
cdsToRemove <- fractions > 1 / 2 # filter with pseudocounts (1+1)/(3+1)
cdsToRemove
```

```
##   tx1   tx2   tx3
##  TRUE FALSE FALSE
```

We now easily made a stop codon filter for our coding sequences.

# 10 Coverage plots made easy with ORFik

In investigation of ORFs or other interest regions, ORFik can help you make
some coverage plots from reads of Ribo-seq, RNA-seq, CAGE-seq, TCP-seq etc.

Lets make 3 plots of Ribo-seq focused on CDS regions.

Load data as shown before and pshift the Ribo-seq:

```
# Get the annotation
txdb <- loadTxdb(gtf_file)
# Ribo-seq
bam_file <- system.file("extdata/Danio_rerio_sample", "ribo-seq.bam", package = "ORFik")
reads <- readGAlignments(bam_file)
shiftedReads <- shiftFootprints(reads, detectRibosomeShifts(reads, txdb))
```

Make meta windows of leaders, cds’ and trailers

```
# Lets take all valid transcripts, with size restrictions:
# leader > 100 bases, cds > 100 bases, trailer > 100 bases
txNames <- filterTranscripts(txdb, 100, 100, 100) # valid transcripts
loadRegions(txdb, parts = c("leaders", "cds", "trailers", "tx"),
            names.keep = txNames)

# Create meta coverage per part of transcript
leaderCov <- metaWindow(shiftedReads, leaders, scoring = NULL,
                        feature = "leaders")

cdsCov <- metaWindow(shiftedReads, cds, scoring = NULL,
                     feature = "cds")

trailerCov <- metaWindow(shiftedReads, trailers, scoring = NULL,
                         feature = "trailers")
```

Bind together and plot:

```
dt <- rbindlist(list(leaderCov, cdsCov, trailerCov))
dt[, `:=` (fraction = "Ribo-seq")] # Set info column
# zscore gives shape, a good starting plot
windowCoveragePlot(dt, scoring = "zscore", title = "Ribo-seq metaplot")
```

![](data:image/png;base64...)
Z-score is good at showing overall shape. You see from the windows each region;
leader, cds and trailer is scaled to 100. NOTE: we can use the function windowPerTranscript
to do all of this in one call.

Lets use a median scoring to find median counts per meta window per positions.

```
windowCoveragePlot(dt, scoring = "median", title = "Ribo-seq metaplot")
```

![](data:image/png;base64...)

We see a big spike close to start of CDS, called the TIS.
The median counts by transcript is close to 50 here.
Lets look at the TIS region using the pshifting plot, seperated into
the 3 frames.

```
if (requireNamespace("BSgenome.Hsapiens.UCSC.hg19")) {
  # size 100 window: 50 upstream, 49 downstream of TIS
  windowsStart <- startRegion(cds, tx, TRUE, upstream = 50, 49)
  hitMapStart <- metaWindow(shiftedReads, windowsStart, withFrames = TRUE)
  pSitePlot(hitMapStart, length = "meta coverage")
}
```

![](data:image/png;base64...)

Since these reads are p-shifted, the maximum
number of reads are on the 0 position. We also see a clear pattern in the
Ribo-seq.

To see how the different read lengths distribute over the region, we make
a heatmap. Where the colors represent the zscore of counts per position.

```
hitMap <- windowPerReadLength(cds, tx,  shiftedReads)
coverageHeatMap(hitMap, addFracPlot = TRUE)
```

![](data:image/png;base64...)
In the heatmap you can see that read length 30 has the strongest peak on the
TIS, while read length 28 has some reads in the leaders (the minus positions).

## 10.1 Multiple data sets in one plot

Often you have multiple data sets you want to compare (like ribo-seq).

ORFik has an extensive syntax for automatic grouping of data sets in plots.

The protocol is:
1. Load all data sets
2. Create a merged coverage data.table
3. Pass it into the plot you want.

Here is an easy example:

```
if (requireNamespace("BSgenome.Hsapiens.UCSC.hg19")) {
  # Load more files like above (Here I make sampled data from earlier Ribo-seq)
  dt2 <- copy(dt)
  dt2[, `:=` (fraction = "Ribo-seq2")]
  dt2$score <- dt2$score + sample(seq(-40, 40), nrow(dt2), replace = TRUE)

  dtl <- rbindlist(list(dt, dt2))
  windowCoveragePlot(dtl, scoring = "median", title = "Ribo-seq metaplots")
}
```

![](data:image/png;base64...)
You see that the fraction column is what seperates the rows. You can have unlimited datasets joined in this way. For more useful examples of multilibrary plotting continue with the vignette called ORFikExperiment (Data management).

# 11 Conclusion

Our hope is that by using ORFik, we can simplify your analysis when
you focus on ORFs / transcript features and especially in combination with
sequence libraries like RNA-seq and Ribo-seq.

If needed, you can move to the more advanced features of ORFik in the next vignettes, Happy coding!