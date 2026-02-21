# Importing data

Haakon Tjeldnes & Kornel Labun

#### 22 December 2025

#### Package

ORFik 1.30.2

# Contents

* [1 Introduction](#introduction)
  + [1.1 Motivation](#motivation)
* [2 Importing Sequencing reads](#importing-sequencing-reads)
  + [2.1 Loading files (general)](#loading-files-general)
    - [2.1.1 Bam files](#bam-files)
    - [2.1.2 Other formats](#other-formats)
  + [2.2 Exporting to new formats](#exporting-to-new-formats)
    - [2.2.1 Files are not preload into R](#files-are-not-preload-into-r)
    - [2.2.2 Files are preload into R](#files-are-preload-into-r)
  + [2.3 Random access](#random-access)
* [3 Importing Annotation](#importing-annotation)
  + [3.1 Loading Genome index (fasta index)](#loading-genome-index-fasta-index)
  + [3.2 Loading Gene annotation (Txdb)](#loading-gene-annotation-txdb)
    - [3.2.1 Loading Transcript regions](#loading-transcript-regions)
    - [3.2.2 Loading Transcript regions (filtering)](#loading-transcript-regions-filtering)
    - [3.2.3 Loading Transcript regions (filtering by length requirements)](#loading-transcript-regions-filtering-by-length-requirements)
    - [3.2.4 Loading Transcript regions (filtering by canonical isoform)](#loading-transcript-regions-filtering-by-canonical-isoform)
    - [3.2.5 Loading uORF annotation](#loading-uorf-annotation)

# 1 Introduction

Welcome to the introduction of data management with ORFik experiment. This vignette will walk you through which data and how you import and export with ORFik, focusing on NGS library import and annotation.
`ORFik` is an R package containing various functions for analysis of RiboSeq, RNASeq, RCP-seq, TCP-seq, Chip-seq and Cage data, we advice you to read ORFikOverview vignette, before starting this one.

## 1.1 Motivation

There exists a myriad of formats in bioinformatics, ORFik focuses on NGS data anlysis and therefor
supports many functions to import that data. We will here learn how to use ORFik
effectivly in importing data (how to convert to the format you should use).
That is the format with optimal information content relative to load speed.

# 2 Importing Sequencing reads

Sequencing reads starts with fastq files. In the Annotation & Alignment vignette
we walk through how to acquire (download usually) and
map these reads into bam files. We here presume
that this is done and you have the bam files.

ORFik currently supports these formats:

* bam (only format with mismatch/full read sequence information)
* wig (supported by many downstream tools)
* bigwig (fastest for random access on single gene)
* bed5 (minimal bed format)
* bed12 (supports spliced regions, similar to gtf, also color coding)
* ofst (ORFik fst table format, very fast version of bam, bed or wig,
  contains chromosome, start, end (optional), strand, cigar (optional),
  all is saved with fst zstandard run length encoding, also writes/reads
  using multithreading)
* covRle (run length encoding of coverage, split by strand, fastest
  format for full genome calculations, formats: (.rds and .qs, rds to
  share easier to others, qs using the qs package which supports better
  compression and reading/writing with multithreading, through the zstandard compression))
* covRleList (a list covRles, split by read lengths, very fast
  for whole genome coverage, where you need each read length separate, formats
  save as covRle)

All these formats can be imported using the function `fimport`

ORFik also supports bam files that are collapsed, the number of duplicates
is stored in the header information per read (i.e. >seq1\_x150, for first read
duplicated 150 times). This is a very effective speed
up for short read sequencing like Ribo-seq. bigwig etc, internally supports
re-collapsing (different cigar for same read length) since it uses the ‘score’ column
of GAlignments object.

## 2.1 Loading files (general)

We advice you always to create an ORFik experiment of your data,
to make it simpler to code (see Data management vignette).

But here we will show you how to do direct import of files.
To load a file, usually it is sufficient to use fimport.

### 2.1.1 Bam files

```
# Use bam file that exists in ORFik package
library(ORFik)
bam_file <- system.file("extdata/Danio_rerio_sample", "ribo-seq.bam", package = "ORFik")
footprints <- fimport(bam_file)
# This is identical to:
footprints <- readBam(bam_file)
```

Bam files are very cumbersome to read, so we should only do this once, and then
convert to something faster (described bellow)

### 2.1.2 Other formats

Other formats are loaded in the same way

```
# Use bam file that exists in ORFik package
ofst_file <- system.file("extdata/Danio_rerio_sample/ofst", "ribo-seq.ofst", package = "ORFik")
footprints <- fimport(ofst_file)
# This is identical to:
footprints <- import.ofst(ofst_file)
```

## 2.2 Exporting to new formats

Since bam files are cumbersome to load, we should convert files to more optimized formats.
Which formats to convert and export to,
depends on if you have the files loaded already or not.

### 2.2.1 Files are not preload into R

There are several converters in ORFik, here are some examples:

#### 2.2.1.1 BAM to OFST (keep cigar information)

```
ofst_out_dir <- file.path(tempdir(), "ofst/")
convert_bam_to_ofst(NULL, bam_file, ofst_out_dir)
# Find the file again
ofst_file <- list.files(ofst_out_dir, full.names = TRUE)[1]
# Load it
fimport(ofst_file)
```

```
## GAlignments object with 16649 alignments and 0 metadata columns:
##           seqnames strand       cigar    qwidth     start       end     width
##              <Rle>  <Rle> <character> <integer> <integer> <integer> <integer>
##       [1]    chr23      -         28M        28  17599129  17599156        28
##       [2]    chr23      -         28M        28  17599129  17599156        28
##       [3]    chr23      -         28M        28  17599129  17599156        28
##       [4]    chr23      -         28M        28  17599129  17599156        28
##       [5]    chr23      -         28M        28  17599129  17599156        28
##       ...      ...    ...         ...       ...       ...       ...       ...
##   [16645]     chr8      +         29M        29  24068894  24068922        29
##   [16646]     chr8      +         28M        28  24068907  24068934        28
##   [16647]     chr8      +         30M        30  24068919  24068948        30
##   [16648]     chr8      +         30M        30  24068919  24068948        30
##   [16649]     chr8      +         30M        30  24068939  24068968        30
##               njunc
##           <integer>
##       [1]         0
##       [2]         0
##       [3]         0
##       [4]         0
##       [5]         0
##       ...       ...
##   [16645]         0
##   [16646]         0
##   [16647]         0
##   [16648]         0
##   [16649]         0
##   -------
##   seqinfo: 1133 sequences from an unspecified genome; no seqlengths
```

#### 2.2.1.2 BAM to bigwig (do not keep cigar information or read lengths)

Bigwig is a bit special, in that it is very fast (and good compression),
but to make it failsafe we need the information about size for all chromosomes.
Bioconductor functions are very picky about correct chromosome sizes of GRanges
objects etc.

```
bigwig_out_dir <- file.path(tempdir(), "bigwig/")
convert_to_bigWig(NULL, bam_file, bigwig_out_dir,
                  seq_info = seqinfo(BamFile(bam_file)))
# Find the file again
bigwig_file <- list.files(bigwig_out_dir, full.names = TRUE)
# You see we have 2 files here, 1 for forward strand, 1 for reverse
# Load it
fimport(bigwig_file)
```

```
## GRanges object with 3104 ranges and 1 metadata column:
##            seqnames     ranges strand |     score
##               <Rle>  <IRanges>  <Rle> | <numeric>
##      [1]         MT    1-16596      + |         0
##      [2]    Zv9_NA1    1-22128      + |         0
##      [3]   Zv9_NA10    1-48062      + |         0
##      [4]  Zv9_NA100    1-26026      + |         0
##      [5] Zv9_NA1000      1-942      + |         0
##      ...        ...        ...    ... .       ...
##   [3100]       chr5 1-75682077      - |         0
##   [3101]       chr6 1-59938731      - |         0
##   [3102]       chr7 1-77276063      - |         0
##   [3103]       chr8 1-56184765      - |         0
##   [3104]       chr9 1-58232459      - |         0
##   -------
##   seqinfo: 1133 sequences from an unspecified genome
```

### 2.2.2 Files are preload into R

For preloaded files it is better to just convert it there and then, and not
convert through the filepath, because then you have just loaded the file twice.

For details, see ?convertLibs and ?convertToOneBasedRanges()

## 2.3 Random access

The really cool thing with bigwig is that it has very fast random access.

```
bigwig_file <- list.files(bigwig_out_dir, full.names = TRUE)
# Let us access a location without loading the full file.
random_point <- GRangesList(GRanges("chr24", 22711508, "-"))
# Getting raw vector (Then you need to know which strand it is on:)
bigwig_for_random_point <- bigwig_file[2] # the reverse strand file
rtracklayer::import.bw(bigwig_for_random_point, as = "NumericList",
                              which = random_point[[1]])
```

```
## NumericList of length 1
## [[1]] 4
```

```
# 4 reads were there
```

ORFik also has an automatic wrapper for spliced transcript coordinates: As data.table

```
dt <- coveragePerTiling(random_point, bigwig_file)
dt # Position is 1, because it is relative to first
```

```
##    count genes position
##    <int> <int>    <int>
## 1:     4     1        1
```

# 3 Importing Annotation

Annotation consists of 2 primary files:

* The full genome sequence (fasta genome + index, 2 individual files)
* The gtf (The location of genes on the genome etc.)

If you don’t have the annotation yet on your hard drive,
to get these two files for your organism, ORFik supports a direct downloader of
annotation from ENSEMBL/refseq, for yeast it would look like this:

```
library(ORFik)
organism <- "Saccharomyces cerevisiae" # Baker's yeast
# This is where you should usually store you annotation references ->
#output_dir <- file.path(ORFik::config()["ref"], gsub(" ", "_", organism))
output_dir <- tempdir()
annotation <- getGenomeAndAnnotation(
                    organism = organism,
                    output.dir = output_dir,
                    assembly_type = "toplevel"
                    )
```

```
## Warning in dir.create(output.dir, recursive = TRUE): '/tmp/RtmpMRMzjW' already
## exists
```

```
## Warning in .get_cds_IDX(mcols0$type, mcols0$phase): The "phase" metadata column contains non-NA values for features of type
##   stop_codon. This information was ignored.
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
genome <- annotation["genome"]
gtf <- annotation["gtf"]
```

The gtf is a very slow format and ORFik will almost never use this directly.
We therefor use a much faster format called TxDb (transcript database)
The nice thing with using getGenomeAndAnnotation is that it will do a lot of
important fixes for you related to import. It will make the fasta index and
txdb, and a lot more optimizations that for large species like human make
import time go from minutes to less than a second.

If you don’t want to use getGenomeAndAnnotation, you can do it for your own annotation
like this:

```
# Index fasta genome
indexFa(genome)
```

```
## [1] "/tmp/RtmpMRMzjW/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.fai"
```

```
# Make TxDb object for large speedup:
txdb <- makeTxdbFromGenome(gtf, genome, organism, optimize = TRUE, return = TRUE)
```

```
## Warning in .get_cds_IDX(mcols0$type, mcols0$phase): The "phase" metadata column contains non-NA values for features of type
##   stop_codon. This information was ignored.
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
```

The txdb is saved in the same as gtf with a “.db” extension.

## 3.1 Loading Genome index (fasta index)

```
# Access a FaFile
fa <- findFa(genome)
# Get chromosome information
seqinfo(findFa(genome))
```

```
## Seqinfo object with 17 sequences from an unspecified genome:
##   seqnames seqlengths isCircular genome
##   I            230218       <NA>   <NA>
##   II           813184       <NA>   <NA>
##   III          316620       <NA>   <NA>
##   IV          1531933       <NA>   <NA>
##   V            576874       <NA>   <NA>
##   ...             ...        ...    ...
##   XIII         924431       <NA>   <NA>
##   XIV          784333       <NA>   <NA>
##   XV          1091291       <NA>   <NA>
##   XVI          948066       <NA>   <NA>
##   Mito          85779       <NA>   <NA>
```

```
# Load a 10 first bases from chromosome 1
txSeqsFromFa(GRangesList(GRanges("I", 1:10, "+")), fa, TRUE)
```

```
## DNAStringSet object of length 1:
##     width seq
## [1]    10 CCACACCACA
```

```
# Load a 10 first bases from chromosome 1 and 2.
txSeqsFromFa(GRangesList(GRanges("I", 1:10, "+"), GRanges("II", 1:10, "+")), fa, TRUE)
```

```
## DNAStringSet object of length 2:
##     width seq
## [1]    10 CCACACCACA
## [2]    10 AAATAGCCCT
```

## 3.2 Loading Gene annotation (Txdb)

ORFik makes it very easy to load specific regions from a txdb.
We already have the txdb loaded, but let us load it again

```
  txdb_path <- paste0(gtf, ".db")
  txdb <- loadTxdb(txdb_path)
```

### 3.2.1 Loading Transcript regions

Lets get these regions of the transcripts:

* All transcripts
* All mRNAs (all transcripts with CDS)
* Leaders (5’ UTRs)
* CDS (Coding sequences, main ORFs)
* Trailers (3’ UTRs)

```
  loadRegion(txdb, "tx")[1]
```

```
## GRangesList object of length 1:
## $YAL069W_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames    ranges strand |   exon_id       exon_name exon_rank
##          <Rle> <IRanges>  <Rle> | <integer>     <character> <integer>
##   [1]        I   335-649      + |         1 YAL069W_mRNA-E1         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
  loadRegion(txdb, "mrna")[1]
```

```
## GRangesList object of length 1:
## $YAL069W_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames    ranges strand |   exon_id       exon_name exon_rank
##          <Rle> <IRanges>  <Rle> | <integer>     <character> <integer>
##   [1]        I   335-649      + |         1 YAL069W_mRNA-E1         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
  loadRegion(txdb, "leaders")[1]
```

```
## GRangesList object of length 1:
## $YIL111W_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames        ranges strand |   exon_id       exon_name exon_rank
##          <Rle>     <IRanges>  <Rle> | <integer>     <character> <integer>
##   [1]       IX 155311-155312      + |      3384 YIL111W_mRNA-E1         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
  loadRegion(txdb, "cds")[1]
```

```
## GRangesList object of length 1:
## $YAL069W_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames    ranges strand |    cds_id    cds_name exon_rank
##          <Rle> <IRanges>  <Rle> | <integer> <character> <integer>
##   [1]        I   335-649      + |         1        <NA>         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

```
  loadRegion(txdb, "trailers")
```

```
## GRangesList object of length 0:
## <0 elements>
```

These are output as GRangesList, which are list elements of GRanges
(1 list elements per transcript, which can contain multiple GRanges).
If the gene region is not spliced, it has only 1 GRanges object.

### 3.2.2 Loading Transcript regions (filtering)

Your annotations contains many transcripts, the 2022 human GTFs usually contain
around 200K transcripts, at least half of these are from non coding transcripts (they have no CDS).
So how to filter out what you do not need?

### 3.2.3 Loading Transcript regions (filtering by length requirements)

Let’s say you only want mRNAs, which have these properties:
- Leaders >= 1nt
- CDS >= 150nt
- Trailers >= 0nt

We can in ORFik get this with:

```
  tx_to_keep <- filterTranscripts(txdb, minFiveUTR = 1, minCDS = 150, minThreeUTR = 0)
  loadRegion(txdb, "mrna", names.keep = tx_to_keep)
```

```
## GRangesList object of length 4:
## $YIL111W_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames        ranges strand |   exon_id       exon_name exon_rank
##          <Rle>     <IRanges>  <Rle> | <integer>     <character> <integer>
##   [1]       IX 155311-155765      + |      3384 YIL111W_mRNA-E1         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $YJL041W_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames        ranges strand |   exon_id       exon_name exon_rank
##          <Rle>     <IRanges>  <Rle> | <integer>     <character> <integer>
##   [1]        X 365903-368373      + |      3722 YJL041W_mRNA-E1         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $YMR242C_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames        ranges strand |   exon_id       exon_name exon_rank
##          <Rle>     <IRanges>  <Rle> | <integer>     <character> <integer>
##   [1]     XIII 753225-753742      - |      5652 YMR242C_mRNA-E1         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $YOR312C_mRNA
## GRanges object with 1 range and 3 metadata columns:
##       seqnames        ranges strand |   exon_id       exon_name exon_rank
##          <Rle>     <IRanges>  <Rle> | <integer>     <character> <integer>
##   [1]       XV 900250-900767      - |      6799 YOR312C_mRNA-E1         1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
```

But what if you do this?

```
  # This fails!
  filterTranscripts(txdb, minFiveUTR = 10, minCDS = 150, minThreeUTR = 0)
```

You see the SacCer3 Yeast gtf does not have any defined leaders at size 10, because
the annotation is incomplete. Luckily ORFik supports creating pseudo 5’ UTRs
for txdb objects (NOTE: using function below, the gtf is not changed).

```
  txdb <- makeTxdbFromGenome(gtf, genome, organism, optimize = TRUE, return = TRUE,
                             pseudo_5UTRS_if_needed = 100)
```

```
## Warning in .get_cds_IDX(mcols0$type, mcols0$phase): The "phase" metadata column contains non-NA values for features of type
##   stop_codon. This information was ignored.
```

```
## Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
## is not available for this TxDb object
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##       2       2       2       2       2       2
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 1 out-of-bound range located on sequence VI. Note
##   that ranges located on a sequence whose length is unknown (NA) or on a
##   circular sequence are not considered out-of-bound (use seqlengths() and
##   isCircular() to get the lengths and circularity flags of the underlying
##   sequences). You can use trim() to trim these ranges. See
##   ?`trim,GenomicRanges-method` for more information.
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): genome version information is not available for this TxDb object
```

```
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
```

```
  filterTranscripts(txdb, minFiveUTR = 10, minCDS = 150, minThreeUTR = 0)[1:3]
```

```
## [1] "Q0010_mRNA" "Q0017_mRNA" "Q0032_mRNA"
```

Great, This now worked. For detailed access of single points like start sites or regions,
see the ‘working with transcripts vignette’.

### 3.2.4 Loading Transcript regions (filtering by canonical isoform)

To get canonical mRNA isoform (primary isoform defined e.g. by Ensembl)

```
  filterTranscripts(txdb, minFiveUTR = 0, minCDS = 1, minThreeUTR = 0,
                    longestPerGene = TRUE)[1:3]
```

```
## [1] "Q0010_mRNA" "Q0017_mRNA" "Q0032_mRNA"
```

You here get all canonical isoform mRNAs (cds exists since minCDS >= 1)

### 3.2.5 Loading uORF annotation

You can also add in a uORF annotation defined by ORFik, like this:
Here we needed the pseudo leaders (5’ UTRs), because the yeast SacCer3 genome
has no proper leader definitions.

```
  findUORFs_exp(txdb, findFa(genome), startCodon = "ATG|CTG", save_optimized = TRUE)
```

```
## Warning in qs2::qs_save(object, file, nthread = nthread): nthreads > 1
## requested but TBB not available; using nthreads = 1
```

```
## GRangesList object of length 6796:
## $YAL069W_mRNA_1
## GRanges object with 1 range and 1 metadata column:
##                seqnames    ranges strand |          names
##                   <Rle> <IRanges>  <Rle> |    <character>
##   YAL069W_mRNA        I   300-323      + | YAL069W_mRNA_1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $YAL069W_mRNA_2
## GRanges object with 1 range and 1 metadata column:
##                seqnames    ranges strand |          names
##                   <Rle> <IRanges>  <Rle> |    <character>
##   YAL069W_mRNA        I   248-286      + | YAL069W_mRNA_2
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL067W-A_mRNA_1`
## GRanges object with 1 range and 1 metadata column:
##                  seqnames    ranges strand |            names
##                     <Rle> <IRanges>  <Rle> |      <character>
##   YAL067W-A_mRNA        I 2380-2406      + | YAL067W-A_mRNA_1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## ...
## <6793 more elements>
```

```
  loadRegion(txdb, "uorfs") # For later use, output like this
```

```
## Warning in qs2::qs_read(file, nthread = nthread): nthreads > 1 requested but
## TBB not available; using nthreads = 1
```

```
## GRangesList object of length 6796:
## $YAL069W_mRNA_1
## GRanges object with 1 range and 1 metadata column:
##                seqnames    ranges strand |          names
##                   <Rle> <IRanges>  <Rle> |    <character>
##   YAL069W_mRNA        I   300-323      + | YAL069W_mRNA_1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $YAL069W_mRNA_2
## GRanges object with 1 range and 1 metadata column:
##                seqnames    ranges strand |          names
##                   <Rle> <IRanges>  <Rle> |    <character>
##   YAL069W_mRNA        I   248-286      + | YAL069W_mRNA_2
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## $`YAL067W-A_mRNA_1`
## GRanges object with 1 range and 1 metadata column:
##                  seqnames    ranges strand |            names
##                     <Rle> <IRanges>  <Rle> |      <character>
##   YAL067W-A_mRNA        I 2380-2406      + | YAL067W-A_mRNA_1
##   -------
##   seqinfo: 17 sequences (1 circular) from an unspecified genome
##
## ...
## <6793 more elements>
```