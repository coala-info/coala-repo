# Importing & Modifying Annotations

#### 28 August 2020

#### Package

BRGenomics 1.0.3

# 1 Importing Annotations with rtracklayer

Importing genomics files is accomplished using the `rtracklayer` package, which
contains a variety of functions and options for importing and exporting.

```
# import bed file
genelist <- import.bed("~/data/genelists/genes.bed")

# import gff
genelist <- import.gff("~/data/genelists/genes.gff")

# export a bed file after modifying
export.bed(genelist, "~/data/genelists/filtered_genes.bed")
```

# 2 Defining Regions Using the genebodies Function

One of the more useful `GenomicRanges` functions is the `promoters()` function,
which returns ranges centered on the strand-specific start of the input ranges:

```
library(BRGenomics)
```

```
data("txs_dm6_chr4")
tx4 <- txs_dm6_chr4[c(1, 10, 200, 300)]
tx4
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4        879-5039      + | FBtr0346692 FBgn0267363
##   [2]     chr4    69326-110059      + | FBtr0308615 FBgn0085432
##   [3]     chr4   184225-193489      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1009895-1027101      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

```
tx4_pr <- promoters(tx4, upstream = 50, downstream = 100)
tx4_pr
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4         829-978      + | FBtr0346692 FBgn0267363
##   [2]     chr4     69276-69425      + | FBtr0308615 FBgn0085432
##   [3]     chr4   193390-193539      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1027002-1027151      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

```
width(tx4_pr)
```

```
## [1] 150 150 150 150
```

BRGenomics ships with a more flexible alternative function called
`genebodies()`. While `promoters()` has the arguments `upstream` and
`downstream`, which take only positive values, the `genebodies()` function uses
`start` and `end` arguments that can be positive or negative, and arguments
`fix.start` and `fix.end` for determining whether to define the positions in
relation to the (strand-specific) beginning or ends of genes.

Below, we demonstrate several uses of the `genebodies()` function, using a list
of transcripts which start at a transcription start site (TSS) and end at a
cleavage and polyadenylation site (CPS).

---

Original regions:

```
tx4
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4        879-5039      + | FBtr0346692 FBgn0267363
##   [2]     chr4    69326-110059      + | FBtr0308615 FBgn0085432
##   [3]     chr4   184225-193489      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1009895-1027101      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Genebody regions from 300 bp downstream of the TSS to 300 bp upstream of the
CPS:

```
genebodies(tx4, start = 300, end = -300)
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4       1179-4739      + | FBtr0346692 FBgn0267363
##   [2]     chr4    69626-109759      + | FBtr0308615 FBgn0085432
##   [3]     chr4   184525-193189      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1010195-1026801      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

By default, `fix.start = "start"` and `fix.end = "end"`. But we can change
either of them to define ranges based solely on the beginnings or ends of the
input regions.

Get promoter regions from 50 bp upstream to 100 bp downstream of the TSS:

```
genebodies(tx4, -50, 100, fix.end = "start")
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4         829-979      + | FBtr0346692 FBgn0267363
##   [2]     chr4     69276-69426      + | FBtr0308615 FBgn0085432
##   [3]     chr4   193389-193539      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1027001-1027151      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Regions from 100 bp upstream of to 50 bp upstream of the TSS:

```
genebodies(tx4, -100, -50, fix.end = "start")
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4         779-829      + | FBtr0346692 FBgn0267363
##   [2]     chr4     69226-69276      + | FBtr0308615 FBgn0085432
##   [3]     chr4   193539-193589      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1027151-1027201      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Regions from 1kb upstream of the CPS to 1kb downstream of the CPS

```
genebodies(tx4, -1000, 1000, fix.start = "end")
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames          ranges strand |     tx_name     gene_id
##          <Rle>       <IRanges>  <Rle> | <character> <character>
##   [1]     chr4       4039-6039      + | FBtr0346692 FBgn0267363
##   [2]     chr4   109059-111059      + | FBtr0308615 FBgn0085432
##   [3]     chr4   183225-185225      - | FBtr0089150 FBgn0039890
##   [4]     chr4 1008895-1010895      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Regions within the first 10kb downstream of the CPS:

```
genebodies(tx4, 0, 10000, fix.start = "end")
```

```
## GRanges object with 4 ranges and 2 metadata columns:
##       seqnames         ranges strand |     tx_name     gene_id
##          <Rle>      <IRanges>  <Rle> | <character> <character>
##   [1]     chr4     5039-15039      + | FBtr0346692 FBgn0267363
##   [2]     chr4  110059-120059      + | FBtr0308615 FBgn0085432
##   [3]     chr4  174225-184225      - | FBtr0089150 FBgn0039890
##   [4]     chr4 999895-1009895      - | FBtr0309865 FBgn0025741
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

# 3 Modify-By-Gene

The `reduceByGene()` and `intersectByGene()` are two other useful functions,
which perform two common tasks very efficiently.

## 3.1 reduceByGene

`reduceByGene()` takes all ranges that share the same gene name (e.g. different
transcript isoforms) and combines them such that all positions are represented.

```
txs <- txs_dm6_chr4[order(txs_dm6_chr4$gene_id)] # sort by gene_id
txs[1:10]
```

```
## GRanges object with 10 ranges and 2 metadata columns:
##        seqnames          ranges strand |     tx_name     gene_id
##           <Rle>       <IRanges>  <Rle> | <character> <character>
##    [1]     chr4 1172469-1181628      - | FBtr0089204 FBgn0002521
##    [2]     chr4 1172469-1181628      - | FBtr0089205 FBgn0002521
##    [3]     chr4   501810-538373      + | FBtr0332913 FBgn0004607
##    [4]     chr4   501810-539792      + | FBtr0089070 FBgn0004607
##    [5]     chr4   501810-540874      + | FBtr0307167 FBgn0004607
##    [6]     chr4     47710-56331      - | FBtr0089178 FBgn0004859
##    [7]     chr4     47710-56331      - | FBtr0308074 FBgn0004859
##    [8]     chr4     47710-57041      - | FBtr0306168 FBgn0004859
##    [9]     chr4   697689-721173      + | FBtr0089235 FBgn0005558
##   [10]     chr4   704651-721173      + | FBtr0089236 FBgn0005558
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

```
reduceByGene(txs, gene_names = txs$gene_id)
```

```
## GRanges object with 111 ranges and 0 metadata columns:
##               seqnames          ranges strand
##                  <Rle>       <IRanges>  <Rle>
##   FBgn0002521     chr4 1172469-1181628      -
##   FBgn0004607     chr4   501810-540874      +
##   FBgn0004859     chr4     47710-57041      -
##   FBgn0005558     chr4   697689-721173      +
##   FBgn0005561     chr4 1088798-1113317      +
##           ...      ...             ...    ...
##   FBgn0266727     chr4   776475-777146      -
##   FBgn0266728     chr4   959224-959434      -
##   FBgn0267363     chr4        879-5039      +
##   FBgn0267734     chr4   228576-229112      -
##   FBgn0283557     chr4   400703-400765      -
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

By default, the gene names are maintained as the names of the rows (ranges) in
the output. To set them into metadata again, we could run:

```
txs_redux <- reduceByGene(txs, gene_names = txs$gene_id)
txs_redux$gene_id <- names(txs_redux)
names(txs_redux) <- NULL
txs_redux
```

```
## GRanges object with 111 ranges and 1 metadata column:
##         seqnames          ranges strand |     gene_id
##            <Rle>       <IRanges>  <Rle> | <character>
##     [1]     chr4 1172469-1181628      - | FBgn0002521
##     [2]     chr4   501810-540874      + | FBgn0004607
##     [3]     chr4     47710-57041      - | FBgn0004859
##     [4]     chr4   697689-721173      + | FBgn0005558
##     [5]     chr4 1088798-1113317      + | FBgn0005561
##     ...      ...             ...    ... .         ...
##   [107]     chr4   776475-777146      - | FBgn0266727
##   [108]     chr4   959224-959434      - | FBgn0266728
##   [109]     chr4        879-5039      + | FBgn0267363
##   [110]     chr4   228576-229112      - | FBgn0267734
##   [111]     chr4   400703-400765      - | FBgn0283557
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Note that `reduceByGene()` is not guaranteed to produce a single range per
gene, but will produce the fewest number of ranges required to represent all
input positions.

Also note that while the output ranges for a given gene are disjoint, it is
possible for ranges from different genes to overlap one another.

To make all ranges disjoint (no position overlapped more than once), set
`disjoin = TRUE`.

## 3.2 intersectByGene

While `reduceByGene()` creates a comprehensive representation of all input
ranges (e.g. a “union” of the set of input ranges), `intersectByGene()` outputs
only the consensus region, i.e. the region that is shared across all the ranges
of a particular gene.

```
txs[1:10]
```

```
## GRanges object with 10 ranges and 2 metadata columns:
##        seqnames          ranges strand |     tx_name     gene_id
##           <Rle>       <IRanges>  <Rle> | <character> <character>
##    [1]     chr4 1172469-1181628      - | FBtr0089204 FBgn0002521
##    [2]     chr4 1172469-1181628      - | FBtr0089205 FBgn0002521
##    [3]     chr4   501810-538373      + | FBtr0332913 FBgn0004607
##    [4]     chr4   501810-539792      + | FBtr0089070 FBgn0004607
##    [5]     chr4   501810-540874      + | FBtr0307167 FBgn0004607
##    [6]     chr4     47710-56331      - | FBtr0089178 FBgn0004859
##    [7]     chr4     47710-56331      - | FBtr0308074 FBgn0004859
##    [8]     chr4     47710-57041      - | FBtr0306168 FBgn0004859
##    [9]     chr4   697689-721173      + | FBtr0089235 FBgn0005558
##   [10]     chr4   704651-721173      + | FBtr0089236 FBgn0005558
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

```
txs_insxt <- intersectByGene(txs, gene_names = txs$gene_id)
txs_insxt[order(names(txs_insxt))]
```

```
## GRanges object with 110 ranges and 0 metadata columns:
##               seqnames          ranges strand
##                  <Rle>       <IRanges>  <Rle>
##   FBgn0002521     chr4 1172469-1181628      -
##   FBgn0004607     chr4   501810-538373      +
##   FBgn0004859     chr4     47710-56331      -
##   FBgn0005558     chr4   707429-721173      +
##   FBgn0005561     chr4 1098525-1110974      +
##           ...      ...             ...    ...
##   FBgn0266727     chr4   776475-777146      -
##   FBgn0266728     chr4   959224-959434      -
##   FBgn0267363     chr4        879-5039      +
##   FBgn0267734     chr4   228576-229112      -
##   FBgn0283557     chr4   400703-400765      -
##   -------
##   seqinfo: 7 sequences from dm6 genome
```

Unlike `reduceByGene()`, `intersectByGene()` is guaranteed to return no more
than 1 range per gene. However, genes for which no consensus is possible (i.e.
no single range can overlap every input range) are dropped from the genelist.