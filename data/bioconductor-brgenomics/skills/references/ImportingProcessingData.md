# Importing & Processing Data

#### 28 August 2020

#### Package

BRGenomics 1.0.3

BRGenomics provides several functions for conveniently importing and processing
BAM, bigWig, bedGraph files.

# 1 Importing BAM Files

The `import_bam()` function provides a number of options for filtering and
processing bam files. BRGenomics includes an example BAM file with a small
number of reads from the included PRO-seq data. The file’s local location can
be found (on your computer) as follows:

```
library(BRGenomics)
```

```
bfile <- system.file("extdata", "PROseq_dm6_chr4.bam",
                     package = "BRGenomics")
```

Because PRO-seq data is sequenced in the 3’-to-5’ direction of the original RNA
molecule, we’ll use the `revcomp` option to reverse-complement all the input
reads. We’ll also set a minimum MAPQ score of 20:

```
ps_reads <- import_bam(bfile, mapq = 20, revcomp = TRUE, paired_end = FALSE)
ps_reads
```

```
## GRanges object with 164 ranges and 1 metadata column:
##         seqnames          ranges strand |     score
##            <Rle>       <IRanges>  <Rle> | <integer>
##     [1]     chr4       1270-1296      + |         1
##     [2]     chr4     41411-41429      + |         1
##     [3]     chr4     42556-42591      + |         1
##     [4]     chr4     42559-42589      + |         1
##     [5]     chr4     42559-42594      + |         3
##     ...      ...             ...    ... .       ...
##   [160]     chr4 1307741-1307776      - |         1
##   [161]     chr4 1316536-1316563      - |         1
##   [162]     chr4 1318959-1318994      - |         1
##   [163]     chr4 1319003-1319038      - |         1
##   [164]     chr4 1319368-1319403      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```

By default, `import_bam()` combines identical reads into the same range, and
the `score` metadata column indicates the number of perfectly-overlapping
alignments. This means that the total number of alignments (reads) is equal to
the sum of the score:

```
sum(score(ps_reads))
```

```
## [1] 190
```

Alternatively, you can import each read as its own range by setting `field = NULL`:

```
reads_expanded <- import_bam(bfile, mapq = 20, revcomp = TRUE,
                             field = NULL, paired_end = FALSE)
ps_reads[1:8]
```

```
## GRanges object with 8 ranges and 1 metadata column:
##       seqnames      ranges strand |     score
##          <Rle>   <IRanges>  <Rle> | <integer>
##   [1]     chr4   1270-1296      + |         1
##   [2]     chr4 41411-41429      + |         1
##   [3]     chr4 42556-42591      + |         1
##   [4]     chr4 42559-42589      + |         1
##   [5]     chr4 42559-42594      + |         3
##   [6]     chr4 42560-42594      + |         2
##   [7]     chr4 42560-42595      + |         2
##   [8]     chr4 42561-42596      + |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```

```
reads_expanded[1:8]
```

```
## GRanges object with 8 ranges and 0 metadata columns:
##       seqnames      ranges strand
##          <Rle>   <IRanges>  <Rle>
##   [1]     chr4   1270-1296      +
##   [2]     chr4 41411-41429      +
##   [3]     chr4 42556-42591      +
##   [4]     chr4 42559-42589      +
##   [5]     chr4 42559-42594      +
##   [6]     chr4 42559-42594      +
##   [7]     chr4 42559-42594      +
##   [8]     chr4 42560-42594      +
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```

Notice that reads 5-7 are now identical, rather than combined into a single
range with a score = 3.

```
length(reads_expanded) == sum(score(ps_reads))
```

```
## [1] TRUE
```

Many BRGenomics function have a `field` argument, and setting `field = NULL`
will treat each range has a single read.

## 1.1 Example: Importing PRO-seq BAM files at Basepair Resolution

We can use the `import_bam()` function to extract the positions of interest
from BAM files. Below, we construct an import function for PRO-seq data that
returns a basepair-resolution GRanges object.

In PRO-seq, a “run-on” reaction is performed in which actively engaged RNA
polymerases incorporate a biotinylated nucleotide at the 3’ end of a nascent
RNA. Our base of interest is therefore the base immediately preceding the RNA 3’
end, as this was the original position of a polymerase active site.

The processing options in `import_bam()` are applied in the same order that
they’re listed in the documentation page. Following this order, we will apply
the options:

1. Filter reads by a minimum MAPQ score
2. Take the reverse complement
3. Shift reads upstream by 1 base
4. Extract the 3’ base

```
ps <- import_bam(bfile,
                 mapq = 20,
                 revcomp = TRUE,
                 shift = -1,
                 trim.to = "3p",
                 paired_end = FALSE)
ps
```

```
## GRanges object with 150 ranges and 1 metadata column:
##         seqnames    ranges strand |     score
##            <Rle> <IRanges>  <Rle> | <integer>
##     [1]     chr4      1295      + |         1
##     [2]     chr4     41428      + |         1
##     [3]     chr4     42588      + |         1
##     [4]     chr4     42590      + |         2
##     [5]     chr4     42593      + |         5
##     ...      ...       ...    ... .       ...
##   [146]     chr4   1307742      - |         1
##   [147]     chr4   1316537      - |         1
##   [148]     chr4   1318960      - |         1
##   [149]     chr4   1319004      - |         1
##   [150]     chr4   1319369      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```

*Note that for paired-end data, `import_bam()` will automatically filter
unmatched read pairs.*

Notice that the number of ranges in `ps` is not the same as for `ps_reads`, in
which we imported the entire read lengths:

```
length(ps_reads)
## [1] 164
length(ps)
## [1] 150
```

This is because identical positions are collapsed together after applying the
processing options. However, we can check that all of the same reads are
represented:

```
sum(score(ps)) == sum(score(ps_reads))
## [1] TRUE
```

And we can check that collapsing identical positions has created a
basepair-resolution GRanges object:

```
isBRG(ps)
## [1] TRUE
```

## 1.2 Pre-formatted Input Functions

For convenience, we’ve included several functions with default options for
several kinds of data, including `import_bam_PROseq()`, `import_bam_PROcap()`,
and `import_bam_ATACseq()`, the latter of which corrects for the 9 bp offset
between Tn5 insertion sites.111 Jason D. Buenrostro, Paul G. Giresi, Lisa C.
Zaba, Howard Y. Chang, William J. Greenleaf (2013). Transposition of native
chromatin for fast and sensitive epigenomic profiling of open chromatin,
dna-binding proteins and nucleosome position. 10:
1213–1218.

## 1.3 Example: Converting BAMs to bigWigs

In conjunction with export functions from the *[rtracklayer](https://bioconductor.org/packages/3.11/rtracklayer)*
package, we can use the functions described above to write a post-alignment
pipeline for generating bigWig files for PRO-seq data:

```
# import bam, automatically applying processing steps for PRO-seq
ps <- import_bam_PROseq(bfile, mapq = 30, paired_end = FALSE)

# separate strands, and make minus-strand scores negative
ps_plus <- subset(ps, strand == "+")
ps_minus <- subset(ps, strand == "-")
score(ps_minus) <- -score(ps_minus)

# use rtracklayer to export bigWig files
export.bw(ps_plus, "~/Data/PROseq_plus.bw")
export.bw(ps_minus, "~/Data/PROseq_minus.bw")
```

## 1.4 Performance Considerations

For single-ended bam files, import is much faster if the bam files are sorted
and indexed (i.e. by `samtools index`).

For paired-end files, we assume that collating (`samtools collate`) or sorting
by name is faster.

Additionally, while single-ended files can often be imported “all at once”
(particularly if sorted and indexed), processing paired-end data is more memory
intensive, and requires breaking up the file into chunks for processing. For
this, use the `yieldSize` argument.

For example, to process 500 thousands reads at a time, set the
`yieldSize = 5e5`.

# 2 Importing bedGraphs and bigWigs

bedGraph and bigWig files are efficient and portable, but unstranded
representations of basepair-resolution genomics data.

As compared to `rtracklayer::import.bedGraph()`, the BRGenomics function
`import_bedGraph()` imports both plus-strand and minus-strand files as a single
object, and has options for filtering out odd chromosomes, mitochondrial
chromosomes, and sex chromosomes.

```
# local paths to included bedGraph files
bg.p <- system.file("extdata", "PROseq_dm6_chr4_plus.bedGraph",
                    package = "BRGenomics")
bg.m <- system.file("extdata", "PROseq_dm6_chr4_minus.bedGraph",
                    package = "BRGenomics")

import_bedGraph(bg.p, bg.m, genome = "dm6")
```

```
## GRanges object with 164 ranges and 1 metadata column:
##         seqnames          ranges strand |     score
##            <Rle>       <IRanges>  <Rle> | <integer>
##     [1]     chr4       1270-1295      + |         1
##     [2]     chr4     41411-41428      + |         1
##     [3]     chr4     42556-42590      + |         1
##     [4]     chr4     42559-42588      + |         1
##     [5]     chr4     42559-42593      + |         3
##     ...      ...             ...    ... .       ...
##   [160]     chr4 1307742-1307776      - |         1
##   [161]     chr4 1316537-1316563      - |         1
##   [162]     chr4 1318960-1318994      - |         1
##   [163]     chr4 1319004-1319038      - |         1
##   [164]     chr4 1319369-1319403      - |         1
##   -------
##   seqinfo: 1 sequence from dm6 genome; no seqlengths
```

The `import_bigWig()` function provides the same added functionality as
compared to `rtracklayer::import.bw()`, but also removes run-length compression
and returns a basepair-resolution GRanges object by default.

```
# local paths to included bigWig files
bw.p <- system.file("extdata", "PROseq_dm6_chr4_plus.bw",
                    package = "BRGenomics")
bw.m <- system.file("extdata", "PROseq_dm6_chr4_minus.bw",
                    package = "BRGenomics")

import_bigWig(bw.p, bw.m, genome = "dm6")
```

```
## GRanges object with 150 ranges and 1 metadata column:
##         seqnames    ranges strand |     score
##            <Rle> <IRanges>  <Rle> | <integer>
##     [1]     chr4      1295      + |         1
##     [2]     chr4     41428      + |         1
##     [3]     chr4     42588      + |         1
##     [4]     chr4     42590      + |         2
##     [5]     chr4     42593      + |         5
##     ...      ...       ...    ... .       ...
##   [146]     chr4   1307742      - |         1
##   [147]     chr4   1316537      - |         1
##   [148]     chr4   1318960      - |         1
##   [149]     chr4   1319004      - |         1
##   [150]     chr4   1319369      - |         1
##   -------
##   seqinfo: 1 sequence from dm6 genome
```

Conversion to a basepair-resolution GRanges object can be turned off by setting
`makeBRG = FALSE`.

# 3 Merging GRanges Data

Biological replicates are best used to independently reproduce and measure
effects, and therefore we often want to handle them separately. However, there
are times when combining replicates can allow for more sensitive measurements,
assuming that the replicates are highly concordant.

The `mergeGRangesData()` function can be used to combine basepair-resolution
GRanges objects.

We’ll break up the included PRO-seq data into a list of toy datasets:

```
ps_list <- lapply(1:6, function(i) ps[seq(i, length(ps), 6)])
names(ps_list) <- c("A_rep1", "A_rep2",
                    "B_rep1", "B_rep2",
                    "C_rep1", "C_rep2")
```

```
ps_list[1:2]
```

```
## $A_rep1
## GRanges object with 25 ranges and 1 metadata column:
##        seqnames    ranges strand |     score
##           <Rle> <IRanges>  <Rle> | <integer>
##    [1]     chr4      1295      + |         1
##    [2]     chr4     42595      + |         1
##    [3]     chr4     42622      + |         2
##    [4]     chr4     42718      + |         1
##    [5]     chr4     42789      + |         1
##    ...      ...       ...    ... .       ...
##   [21]     chr4   1280795      - |         1
##   [22]     chr4   1306469      - |         1
##   [23]     chr4   1306713      - |         1
##   [24]     chr4   1307115      - |         2
##   [25]     chr4   1307301      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
##
## $A_rep2
## GRanges object with 25 ranges and 1 metadata column:
##        seqnames    ranges strand |     score
##           <Rle> <IRanges>  <Rle> | <integer>
##    [1]     chr4     41428      + |         1
##    [2]     chr4     42596      + |         1
##    [3]     chr4     42652      + |         3
##    [4]     chr4     42733      + |         1
##    [5]     chr4     42794      + |         2
##    ...      ...       ...    ... .       ...
##   [21]     chr4   1280936      - |         1
##   [22]     chr4   1306497      - |         2
##   [23]     chr4   1306888      - |         1
##   [24]     chr4   1307120      - |         1
##   [25]     chr4   1307742      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```

```
names(ps_list)
```

```
## [1] "A_rep1" "A_rep2" "B_rep1" "B_rep2" "C_rep1" "C_rep2"
```

We can pass a list of GRanges objects directly as an argument:

```
mergeGRangesData(ps_list, ncores = 1)
```

```
## GRanges object with 150 ranges and 1 metadata column:
##         seqnames    ranges strand |     score
##            <Rle> <IRanges>  <Rle> | <integer>
##     [1]     chr4      1295      + |         1
##     [2]     chr4     41428      + |         1
##     [3]     chr4     42588      + |         1
##     [4]     chr4     42590      + |         2
##     [5]     chr4     42593      + |         5
##     ...      ...       ...    ... .       ...
##   [146]     chr4   1307742      - |         1
##   [147]     chr4   1316537      - |         1
##   [148]     chr4   1318960      - |         1
##   [149]     chr4   1319004      - |         1
##   [150]     chr4   1319369      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```

Or we can pass any number of individual GRanges objects as arguments:

```
merge_ps <- mergeGRangesData(ps_list[[1]], ps_list[[2]], ps, ncores = 1)
merge_ps
```

```
## GRanges object with 150 ranges and 1 metadata column:
##         seqnames    ranges strand |     score
##            <Rle> <IRanges>  <Rle> | <integer>
##     [1]     chr4      1295      + |         2
##     [2]     chr4     41428      + |         2
##     [3]     chr4     42588      + |         1
##     [4]     chr4     42590      + |         2
##     [5]     chr4     42593      + |         5
##     ...      ...       ...    ... .       ...
##   [146]     chr4   1307742      - |         2
##   [147]     chr4   1316537      - |         1
##   [148]     chr4   1318960      - |         1
##   [149]     chr4   1319004      - |         1
##   [150]     chr4   1319369      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```

*Note that the output is also a basepair-resolution GRanges object:*

```
isBRG(merge_ps)
## [1] TRUE
```

## 3.1 Merging Replicates

The `mergeReplicates()` function makes combining replicates particularly
simple:

```
mergeReplicates(ps_list, ncores = 1)
```

```
## $A
## GRanges object with 50 ranges and 1 metadata column:
##        seqnames    ranges strand |     score
##           <Rle> <IRanges>  <Rle> | <integer>
##    [1]     chr4      1295      + |         1
##    [2]     chr4     41428      + |         1
##    [3]     chr4     42595      + |         1
##    [4]     chr4     42596      + |         1
##    [5]     chr4     42622      + |         2
##    ...      ...       ...    ... .       ...
##   [46]     chr4   1306888      - |         1
##   [47]     chr4   1307115      - |         2
##   [48]     chr4   1307120      - |         1
##   [49]     chr4   1307301      - |         1
##   [50]     chr4   1307742      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
##
## $B
## GRanges object with 50 ranges and 1 metadata column:
##        seqnames    ranges strand |     score
##           <Rle> <IRanges>  <Rle> | <integer>
##    [1]     chr4     42588      + |         1
##    [2]     chr4     42590      + |         2
##    [3]     chr4     42601      + |         1
##    [4]     chr4     42618      + |         1
##    [5]     chr4     42657      + |         1
##    ...      ...       ...    ... .       ...
##   [46]     chr4   1307032      - |         1
##   [47]     chr4   1307122      - |         1
##   [48]     chr4   1307126      - |         1
##   [49]     chr4   1316537      - |         1
##   [50]     chr4   1318960      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
##
## $C
## GRanges object with 50 ranges and 1 metadata column:
##        seqnames    ranges strand |     score
##           <Rle> <IRanges>  <Rle> | <integer>
##    [1]     chr4     42593      + |         5
##    [2]     chr4     42594      + |         2
##    [3]     chr4     42619      + |         2
##    [4]     chr4     42621      + |         1
##    [5]     chr4     42661      + |         1
##    ...      ...       ...    ... .       ...
##   [46]     chr4   1307114      - |         1
##   [47]     chr4   1307283      - |         1
##   [48]     chr4   1307300      - |         1
##   [49]     chr4   1319004      - |         1
##   [50]     chr4   1319369      - |         1
##   -------
##   seqinfo: 1870 sequences from an unspecified genome
```