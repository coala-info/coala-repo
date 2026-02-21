# diffUTR

Pierre-Luc Germain1,2

1D-HEST Institute for Neurosciences, ETH Zürich
2Laboratory of Statistical Bioinformatics, University Zürich

#### 29 October 2025

#### Abstract

Showcases the use of the diffUTR package for streamlining analyses of
differential exon usage and differential 3’ UTR usage.

#### Package

diffUTR 1.18.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Differential exon usage](#differential-exon-usage)
  + [1.2 Differential 3’ UTR usage](#differential-3-utr-usage)
* [2 Getting started](#getting-started)
  + [2.1 Package installation](#package-installation)
  + [2.2 Obtaining gene annotations](#obtaining-gene-annotations)
* [3 Workflow for differential exon usage (DEU) analysis](#workflow-for-differential-exon-usage-deu-analysis)
  + [3.1 Preparing the annotation](#preparing-the-annotation)
  + [3.2 Counting reads in bins](#counting-reads-in-bins)
  + [3.3 Differential analysis](#differential-analysis)
* [4 Workflow for differential 3’ UTR usage analysis](#workflow-for-differential-3-utr-usage-analysis)
  + [4.1 Obtaining alternative poly-adenlyation sites and preparing the bins](#obtaining-alternative-poly-adenlyation-sites-and-preparing-the-bins)
  + [4.2 Counting and differential analysis:](#counting-and-differential-analysis)
* [5 Exploring the results](#exploring-the-results)
  + [5.1 Top genes](#top-genes)
  + [5.2 Gene profiles](#gene-profiles)
    - [5.2.1 Overlaying with transcripts](#overlaying-with-transcripts)

# 1 Introduction

## 1.1 Differential exon usage

`diffUTR` wraps around three methods for different exon usage analysis:

* The *[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* package (see `?DEXSeqWrapper`)
* An improved version of *[limma](https://bioconductor.org/packages/3.22/limma)*’s `diffSplice` method
  (see `?diffSpliceWrapper`)
* *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*’s `diffSpliceDGE` method
  (see `?diffSpliceDGEWrapper`)

All three wrappers have been designed to use the same input (the
`RangedSummarizedExperiment` object created by `countFeatures` – see below)
and produce highly similar outputs, so that they can all be used with the same
downstream plotting functions (Figure 1A).

Based on various benchmarks (e.g.
[Sonenson et al. 2016](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0862-3);
see also [our paper](https://doi.org/10.1186/s12859-021-04114-7)),
*[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* is the most accurate of the three methods,
and should therefore be the method of choice. It is however very slow and does
not scale well to larger sample sizes. We therefore suggest our improved
*diffSplice2* method (`?diffSpliceWrapper`) when
*[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* is not an option.

![A: Overview of the diffUTR workflow. B: Bin creation scheme.](data:image/svg+xml;base64...)

Figure 1: A: Overview of the diffUTR workflow
B: Bin creation scheme.

## 1.2 Differential 3’ UTR usage

A chief difficulty in analyzing 3’ UTR usage is that most UTR variants are not
cataloged in standard transcript annotations, limiting the utility of standard
transcript-level quantification based on reference transcripts. `diffUTR`
leverages the differential exon usage methods for differential 3’ UTR analysis
using alternative poly-adenylation site databases to create additional UTR
bins (Figure 1B).

# 2 Getting started

## 2.1 Package installation

Install the package with:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("diffUTR")
```

We load diffUTR as well as the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*
package on which it depends:

```
suppressPackageStartupMessages({
  library(diffUTR)
  library(SummarizedExperiment)
})
```

## 2.2 Obtaining gene annotations

Prior to using `diffUTR` you will need a gene annotation. This can either be
provided as a `gtf` file (with relatively standard formatting), or as an
*[ensembldb](https://bioconductor.org/packages/3.22/ensembldb)* object. For example, an `EnsDb` object for
the latest mouse annotation can be fetched as follows:

```
library(AnnotationHub)
ah <- AnnotationHub()
# obtain the identifier of the latest mouse ensembl annotation:
ahid <- rev(query(ah, c("EnsDb", "Mus musculus"))$ah_id)[1]
ensdb <- ah[[ahid]]
```

This `ensdb` object could then be directly passed to the `prepareBins` function
(see below).

For the purpose of this vignette, we will use a reduced annotation containing
only 100 mouse genes:

```
data(example_gene_annotation, package="diffUTR")
g <- example_gene_annotation
head(g)
```

```
## GRanges object with 6 ranges and 6 metadata columns:
##                      seqnames            ranges strand | gene_name     type
##                         <Rle>         <IRanges>  <Rle> |  <factor> <factor>
##   ENSMUSE00000751848        1 36307733-36307836      + |    Arid5a     exon
##   ENSMUSG00000037447        1 36307733-36324029      + |    Arid5a     gene
##   ENSMUSE00001245300        1 36307754-36307836      + |    Arid5a     exon
##   ENSMUSE00001257314        1 36307754-36307836      + |    Arid5a     exon
##   ENSMUSE00001257314        1 36307754-36307836      + |    Arid5a     exon
##   ENSMUSE00001257314        1 36307754-36307836      + |    Arid5a     exon
##                        gene_biotype           tx_biotype                 tx
##                            <factor>             <factor>        <character>
##   ENSMUSE00000751848 protein_coding protein_coding       ENSMUST00000126413
##   ENSMUSG00000037447 NA             NA                                 <NA>
##   ENSMUSE00001245300 protein_coding protein_coding       ENSMUST00000142319
##   ENSMUSE00001257314 protein_coding retained_intron      ENSMUST00000150747
##   ENSMUSE00001257314 protein_coding processed_transcript ENSMUST00000145179
##   ENSMUSE00001257314 protein_coding retained_intron      ENSMUST00000124280
##                                    gene
##                                <factor>
##   ENSMUSE00000751848 ENSMUSG00000037447
##   ENSMUSG00000037447 ENSMUSG00000037447
##   ENSMUSE00001245300 ENSMUSG00000037447
##   ENSMUSE00001257314 ENSMUSG00000037447
##   ENSMUSE00001257314 ENSMUSG00000037447
##   ENSMUSE00001257314 ENSMUSG00000037447
##   -------
##   seqinfo: 118 sequences from GRCm38 genome
```

# 3 Workflow for differential exon usage (DEU) analysis

## 3.1 Preparing the annotation

Because exons partially overlap, they must be disjoined in non-overlapping bins
for the purpose of analysis. This is handled by the `prepareBins` function:

```
# If you know that your data will be stranded, use
# bins <- prepareBins(g, stranded=TRUE)
# Otherwise use
bins <- prepareBins(g)
```

```
## Preparing annotation
```

```
## Merging and disjoining bins
```

## 3.2 Counting reads in bins

Counting reads (or fragments) overlapping bins is done using the
`countFeatures` function, with a vector of paths to `bam` files as input. Under
the hood, this calls the `featureCounts` function of the
*[Rsubread](https://bioconductor.org/packages/3.22/Rsubread)* package, so any argument of that function
can be passed to `countFeatures`. For example:

```
bamfiles <- c("path/to/sample1.bam", "path/to/sample2.bam", ...)
rse <- countFeatures(bamfiles, bins, strandSpecific=2, nthreads=6, isPairedEnd=FALSE)
```

Note that `strandSpecific` should be set correctly (i.e. to 0 if the data is
unstranded, and to 1 or 2 if stranded – see `?Rsubread::featureCounts`), and
`isPairedEnd=TRUE` should be used if the data is paired-end.

For the purpose of this vignette, we load a pre-computed object containing data
from Whipple et al. (2020):

```
data(example_bin_se, package="diffUTR")
rse <- example_bin_se
rse
```

```
## class: RangedSummarizedExperiment
## dim: 920 6
## metadata(0):
## assays(1): counts
## rownames(920): ENSMUSG00000000552.1 ENSMUSG00000000552.11 ...
##   ENSMUSG00000098794.6 ENSMUSG00000098794.7
## rowData names(7): gene_name type ... meanLogDensity geneAmbiguous
## colnames(6): CTRL1 CTRL2 ... LTP2 LTP3
## colData names(1): condition
```

The output of `countFeatures` is a RangedSummarizedExperiment object (see
*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*) containing the samples’ counts
(as well as normalized assays) across bins, as well as all the bin information
in the `rowRanges(se)`:

```
head(rowRanges(rse))
```

```
## GRanges object with 6 ranges and 7 metadata columns:
##                         seqnames              ranges strand |       gene_name
##                            <Rle>           <IRanges>  <Rle> | <CharacterList>
##    ENSMUSG00000000552.1    chr15 103340057-103340086      - |         Zfp385a
##   ENSMUSG00000000552.11    chr15 103313895-103314997      - |         Zfp385a
##    ENSMUSG00000000552.2    chr15 103340047-103340056      - |         Zfp385a
##    ENSMUSG00000000552.3    chr15 103333065-103333201      - |         Zfp385a
##    ENSMUSG00000000552.4    chr15 103320290-103320400      - |         Zfp385a
##    ENSMUSG00000000552.5    chr15 103317949-103318111      - |         Zfp385a
##                             type               gene meanLogCPM  logWidth
##                         <factor>           <factor>  <numeric> <numeric>
##    ENSMUSG00000000552.1 UTR      ENSMUSG00000000552   0.134936   3.43399
##   ENSMUSG00000000552.11 UTR/3UTR ENSMUSG00000000552   0.454942   7.00670
##    ENSMUSG00000000552.2 CDS      ENSMUSG00000000552   0.136078   2.39790
##    ENSMUSG00000000552.3 CDS      ENSMUSG00000000552   0.233634   4.92725
##    ENSMUSG00000000552.4 CDS      ENSMUSG00000000552   0.206431   4.71850
##    ENSMUSG00000000552.5 CDS      ENSMUSG00000000552   0.211493   5.09987
##                         meanLogDensity geneAmbiguous
##                              <numeric>     <logical>
##    ENSMUSG00000000552.1     0.03746455         FALSE
##   ENSMUSG00000000552.11     0.00142892         FALSE
##    ENSMUSG00000000552.2     0.10854836         FALSE
##    ENSMUSG00000000552.3     0.00918315         FALSE
##    ENSMUSG00000000552.4     0.01102348         FALSE
##    ENSMUSG00000000552.5     0.00755899         FALSE
##   -------
##   seqinfo: 22 sequences from an unspecified genome; no seqlengths
```

In this example only a subset of information was retained, but the original
file stores any information present in the annotation (e.g. transcripts,
biotype, etc.)

## 3.3 Differential analysis

For the purpose of this example, we will use the improved diffSplice method:

```
rse <- diffSpliceWrapper(rse, design = ~condition)
```

```
## Testing coefficient conditionLTP
```

```
## Total number of exons:  920
## Total number of genes:  80
## Number of genes with 1 exon:  0
## Mean number of exons in a gene:  12
## Max number of exons in a gene:  45
```

The `~condition` formula indicates that the samples should be split according
to the `group` column of `colData(rse)`. Alternatively to the formula inferace,
a `model.matrix` can be directly passed. For more complex models involving
several terms, you will have to specify the coefficient to test using the
`coef` argument.

The bin-wise results of the the differential analysis have been saved in the
`rowData` of the object:

```
head(rowData(rse))
```

```
## DataFrame with 6 rows and 11 columns
##                             gene_name     type               gene meanLogCPM
##                       <CharacterList> <factor>           <factor>  <numeric>
## ENSMUSG00000000552.1          Zfp385a UTR      ENSMUSG00000000552   0.134936
## ENSMUSG00000000552.11         Zfp385a UTR/3UTR ENSMUSG00000000552   0.454942
## ENSMUSG00000000552.2          Zfp385a CDS      ENSMUSG00000000552   0.136078
## ENSMUSG00000000552.3          Zfp385a CDS      ENSMUSG00000000552   0.233634
## ENSMUSG00000000552.4          Zfp385a CDS      ENSMUSG00000000552   0.206431
## ENSMUSG00000000552.5          Zfp385a CDS      ENSMUSG00000000552   0.211493
##                        logWidth meanLogDensity geneAmbiguous logDensityRatio
##                       <numeric>      <numeric>     <logical>       <numeric>
## ENSMUSG00000000552.1    3.43399     0.03746455         FALSE        2.070401
## ENSMUSG00000000552.11   7.00670     0.00142892         FALSE       -1.214023
## ENSMUSG00000000552.2    2.39790     0.10854836         FALSE        3.170190
## ENSMUSG00000000552.3    4.92725     0.00918315         FALSE        0.650240
## ENSMUSG00000000552.4    4.71850     0.01102348         FALSE        0.833778
## ENSMUSG00000000552.5    5.09987     0.00755899         FALSE        0.454890
##                       coefficient bin.p.value   bin.FDR
##                         <numeric>   <numeric> <numeric>
## ENSMUSG00000000552.1   -0.3931489    0.370032         1
## ENSMUSG00000000552.11  -0.0953176    0.707897         1
## ENSMUSG00000000552.2   -0.4150765    0.343520         1
## ENSMUSG00000000552.3    0.0297215    0.928401         1
## ENSMUSG00000000552.4    0.2585032    0.465459         1
## ENSMUSG00000000552.5    0.2445081    0.485852         1
```

The gene-wise aggregation has been saved in the object’s metadata:

```
perGene <- metadata(rse)$geneLevel
head(perGene)
```

```
## DataFrame with 6 rows and 11 columns
##                           name   nb.bins    w.coef w.abs.coef w.sqWidth
##                    <character> <numeric> <numeric>  <numeric> <integer>
## ENSMUSG00000038290        Smg6        44     1.118   1.560760        33
## ENSMUSG00000038268       Ovca2         3     1.433   1.432721        68
## ENSMUSG00000038894        Irs2         4     0.557   0.851943        57
## ENSMUSG00000033730        Egr3        12     0.344   0.842130        67
## ENSMUSG00000071076        Jund         6     0.659   1.164951        26
## ENSMUSG00000022174        Dad1        11     0.393   0.843389        64
##                    w.density sizeScore abs.sizeScore geneMeanDensity
##                    <numeric> <numeric>     <numeric>       <numeric>
## ENSMUSG00000038290    -6.174     0.043         0.049           0.011
## ENSMUSG00000038268   -11.421     0.946         0.946           0.005
## ENSMUSG00000038894    -7.885     0.195         0.283           0.021
## ENSMUSG00000033730    -8.223     0.163         0.188           0.011
## ENSMUSG00000071076    -6.166     0.113         0.230           0.017
## ENSMUSG00000022174    -6.176     0.142         0.158           0.050
##                    density.ratio     q.value
##                        <numeric>   <numeric>
## ENSMUSG00000038290      60.84632 7.62087e-39
## ENSMUSG00000038268       0.10500 9.79932e-07
## ENSMUSG00000038894       1.52395 1.02697e-06
## ENSMUSG00000033730       3.65001 3.12321e-06
## ENSMUSG00000071076       1.94600 4.77593e-06
## ENSMUSG00000022174      44.30187 6.29738e-06
```

The results are described in more detail below.

# 4 Workflow for differential 3’ UTR usage analysis

## 4.1 Obtaining alternative poly-adenlyation sites and preparing the bins

The preparation of the bins is done as in the standard DEU case, except that an
additional argument should be given providing the alternative poly-adenylation
(APA) sites. These will be used to break and extend UTRs into further bins.
APA sites can be provided as a *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* object
or the path to a `bed` file containing the coordinates. For mouse, human and
C. elegans, an atlas of poly-A sites can be downloaded from
<https://polyasite.unibas.ch/atlas>
(). You can
download the mouse file:

```
download.file("https://polyasite.unibas.ch/download/atlas/2.0/GRCm38.96/atlas.clusters.2.0.GRCm38.96.bed.gz",
              destfile="apa.mm38.bed.gz")
bins <- prepareBins(g, "apa.mm38.bed.gz")
# (Again, if you know that your data will be stranded, use `stranded=TRUE`)
```

Unfortunately, the [polyASite](https://polyasite.unibas.ch/atlas) database
does not contain APA sites for the rat. A somewhat older similar database,
[PolyA\_DB](https://exon.apps.wistar.org/PolyA_DB/v3/), does include the rat,
however with an obsolete annotation; for convenience we lifted it over to Rno6,
and made it available in the package data:

```
data(rn6_PAS)
# bins <- prepareBins(g, rn6_PAS)
```

If there is no APA sites database that includes your species of interest, you
can still perform differential UTR analysis, however you will be limited to
bins defined by the UTRs ends included in the gene annotation.

Note that if the gene annotation and the APA sites use different chromosome
notation styles, you can enforce a given notation using the `chrStyle` argument
of `prepareBins`. Beware however that there is no internal check that the genome
builds match – be sure that they do!

For the purpose of this example, we’ll just use the same `bins` as in the first
example.

## 4.2 Counting and differential analysis:

Counting reads in bins works as in the standard DEU case:

```
bamfiles <- c("path/to/sample1.bam", "path/to/sample2.bam", ...)
se <- countFeatures(bamfiles, bins, strandSpecific=2, nthreads=6, isPairedEnd=TRUE)
```

Differential analysis also works in the same way as for DEU:

```
rse <- diffSpliceWrapper( rse, design = ~condition )
```

```
## Testing coefficient conditionLTP
```

```
## Total number of exons:  920
## Total number of genes:  80
## Number of genes with 1 exon:  0
## Mean number of exons in a gene:  12
## Max number of exons in a gene:  45
```

By default, this will look for changes in *any* bin type. To look specifically
for changes in certain types of bins, you can perform the gene-level
aggregation using different filters. This can be done using the
`geneLevelStats()` function, which accepts the arguments `excludeTypes` and
`includeTypes` to decide which bin types to include in the gene-level estimates.
For example:

```
# we can then only look for changes in CDS bins:
cds <- geneLevelStats(rse, includeTypes="CDS", returnSE=FALSE)
head(cds)
```

```
## DataFrame with 6 rows and 11 columns
##                           name   nb.bins    w.coef w.abs.coef w.sqWidth
##                    <character> <numeric> <numeric>  <numeric> <integer>
## ENSMUSG00000071076        Jund         6    -0.756   0.756300        31
## ENSMUSG00000079037        Prnp         8    -0.425   0.424744        27
## ENSMUSG00000039114        Nrn1        13     1.517   1.553416        10
## ENSMUSG00000038290        Smg6        44    -0.720   0.719592        13
## ENSMUSG00000018102   Hist1h2bc        12    -0.393   0.392935        19
## ENSMUSG00000019505         Ubb        11    -0.231   0.230893         9
##                    w.density sizeScore abs.sizeScore geneMeanDensity
##                    <numeric> <numeric>     <numeric>       <numeric>
## ENSMUSG00000071076    -5.238    -0.183         0.183           0.017
## ENSMUSG00000079037    -2.317    -0.048         0.048           0.062
## ENSMUSG00000039114    -4.983     0.086         0.088           0.094
## ENSMUSG00000038290    -5.881    -0.008         0.008           0.011
## ENSMUSG00000018102    -4.727    -0.038         0.038           0.082
## ENSMUSG00000019505     0.257    -0.008         0.008           0.333
##                    density.ratio     q.value
##                        <numeric>   <numeric>
## ENSMUSG00000071076       3.70700 4.77593e-06
## ENSMUSG00000079037      96.80200 2.65682e-05
## ENSMUSG00000039114       5.03992 1.45595e-04
## ENSMUSG00000038290      74.36553 4.05238e-04
## ENSMUSG00000018102      25.09800 2.40409e-02
## ENSMUSG00000019505     783.65594 3.13975e-02
```

```
# or only look for changes in UTR bins:
utr <- geneLevelStats(rse, includeTypes="UTR", returnSE=FALSE)
head(utr)
```

```
## DataFrame with 6 rows and 11 columns
##                           name   nb.bins    w.coef w.abs.coef w.sqWidth
##                    <character> <numeric> <numeric>  <numeric> <integer>
## ENSMUSG00000038894        Irs2         4     1.151   1.150899        59
## ENSMUSG00000022174        Dad1        11     0.358   0.887826        74
## ENSMUSG00000039114        Nrn1        13     1.248   1.247582         8
## ENSMUSG00000038290        Smg6        44    -0.886   0.886390        28
## ENSMUSG00000059991       Nptx2        12     0.436   0.785271        22
## ENSMUSG00000019505         Ubb        11    -0.227   0.227418         9
##                    w.density sizeScore abs.sizeScore geneMeanDensity
##                    <numeric> <numeric>     <numeric>       <numeric>
## ENSMUSG00000038894    -9.594     0.390         0.390           0.021
## ENSMUSG00000022174    -8.034     0.161         0.183           0.050
## ENSMUSG00000039114    -5.310     0.047         0.047           0.094
## ENSMUSG00000038290    -6.783    -0.013         0.013           0.011
## ENSMUSG00000059991    -7.576     0.078         0.102           0.031
## ENSMUSG00000019505     0.222    -0.008         0.008           0.333
##                    density.ratio     q.value
##                        <numeric>   <numeric>
## ENSMUSG00000038894       0.46500 1.02697e-06
## ENSMUSG00000022174      11.85709 6.29738e-06
## ENSMUSG00000039114       3.77004 1.51263e-03
## ENSMUSG00000038290      39.64076 8.05237e-03
## ENSMUSG00000059991       1.68613 1.05465e-02
## ENSMUSG00000019505     763.75279 3.13975e-02
```

```
# or only look for changes in bins that _could be_ UTRs:
# geneLevelStats(rse, excludeTypes=c("CDS","non-coding"), returnSE=FALSE)
```

# 5 Exploring the results

## 5.1 Top genes

`plotTopGenes()` provides gene-level statistic plots (similar to a ‘volcano
plot’), which come in two variations in terms of aggregated effect size
(x-axis). For standard DEU analysis, we take the weighted average of absolute
bin-level coefficients, using the bins’ `-log10(p-value)` as weights, to
produce gene-level estimates of effect sizes. For differential 3’ UTR usage,
where bins are expected to have consistent directions (i.e. lengthening or
shortening of the UTR) and where their size is expected to have a strong impact
on biological function, the signed bin-level coefficients are weighted both by
both size and significance to produce (signed) gene-level estimates of effect
sizes.

```
plotTopGenes(rse)
```

![](data:image/png;base64...)

By default, the size of the points reflects the relative expression of the
genes, and the colour the relative expression of the significant bins with
respect to the gene (density ratio). This enables the rapid identification of
changes occuring in highly-expressed genes, as well as discount changes
happening in bins which tend not to be included in transcripts from that gene
(low density ratio). Note that it is possible to use filter by density ratio
during gene-level aggregation (see `?geneLevelStats`).

The product is a `ggplot` object, and can be manipulated as such.

By default, the gene-level statistics computed use all bin types. However,
`plotTopGenes` also accepts directly the gene-level stats, as outputted by
`geneLevelStats` (see above), enabling the visualization of top genes
separately for CDS and UTRs, for instance:

```
# `utr` being the output of the above
# geneLevelStats(rse, includeTypes="UTR", returnSE=FALSE)
plotTopGenes(utr, diffUTR = TRUE)
```

![](data:image/png;base64...)

Here we also indicated that we are in differential UTR mode, to use signed and
width-weighted aggregation.

Note that when there are too many gene labels to be plotted nearby, `ggrepel`
will omit them and produce the warning above. To plot them nevertheless, you
can pass the argument `max.overlaps` with a higher value (see
`?ggrepel::geom_text_repel`).

## 5.2 Gene profiles

The package also offers two functions for plotting bin-level profiles for a
specific gene. Before doing so, we generate normalized assays if this was not
already done:

```
rse <- addNormalizedAssays(rse)
```

`deuBinPlot` provides plots similar to those produced by
*[DEXSeq](https://bioconductor.org/packages/3.22/DEXSeq)* and *[limma](https://bioconductor.org/packages/3.22/limma)*, but
offering more flexibility. They can be plotted as overall bin statistics, per
condition, or per sample, and can plot various types of values. Importantly,
since all data and annotation is contained in the object, these can easily be
included in the plots, mapping for instance to colour or shape:

```
deuBinPlot(rse,"Jund")
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the diffUTR package.
##   Please report the issue at <https://github.com/ETHZ-INS/diffUTR>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the diffUTR package.
##   Please report the issue at <https://github.com/ETHZ-INS/diffUTR>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
## ggplot2 3.3.4.
## ℹ Please use "none" instead.
## ℹ The deprecated feature was likely used in the diffUTR package.
##   Please report the issue at <https://github.com/ETHZ-INS/diffUTR>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
deuBinPlot(rse,"Jund", type="condition", colour="condition")
```

![](data:image/png;base64...)

```
deuBinPlot(rse,"Jund", type="sample", colour="condition") # shows separate samples
```

![](data:image/png;base64...)

And since the output is a `ggplot`, we can modify it at will:

```
library(ggplot2)
deuBinPlot(rse,"Jund",type="condition",colour="condition") +
  guides(colour = guide_legend(override.aes = list(size = 3))) +
  scale_colour_manual(values=c(CTRL="darkblue", LTP="red"))
```

![](data:image/png;base64...)

Finally, `geneBinHeatmap` provides a compact, bin-per-sample heatmap
representation of a gene, allowing the simultaneous visualization of various
information:

```
geneBinHeatmap(rse, "Smg6")
```

![](data:image/png;base64...)

Bins that are overlapping multiple genes will be flagged as such (here there
are none).

We found these representations particularly useful to prioritize candidates
from differential bin usage analyses. For example, many genes show differential
usage of bins which are generally not included in most transcripts of that gene
(low count density), and are therefore less likely to be relevant (note that
it is possible to use filter by density ratio during gene-level aggregation –
see `?geneLevelStats`). On the other hand, some genes show massive expression
of a single bin which might (or might not) represent a different, unannotated
transcript.

### 5.2.1 Overlaying with transcripts

The *[ggbio](https://bioconductor.org/packages/3.22/ggbio)* package has functionalities enabling to plot
bin-level information along side transcript tracks. While wrappers for this are
not included in the `diffUTR` package so as to keep dependencies low, the
function below would be one way of using this with `rse` objects from `diffUTR`
as well as the `EnsDb` object used to create the bins:

```
#' binTxPlot
#'
#' @param se A bin-wise SummarizedExperiment as produced by
#' \code{\link{countFeatures}} and including bin-level tests (i.e. having been
#' passed through one of the DEU wrappers such as
#' \code{\link{diffSpliceWrapper}} or \code{\link{DEXSeqWrapper}})
#' @param ensdb The `EnsDb` which was used to create the bins
#' @param gene The gene of interest
#' @param by The colData column of `se` used to split the samples
#' @param assayName The assay to plot
#' @param removeAmbiguous Logical; whether to remove bins that are
#' gene-ambiguous (i.e. overlap multiple genes).
#' @param size Size of the lines
#' @param ... Passed to `plotRangesLinkedToData`
#'
#' @return A `ggbio` `Tracks`
#' @importFrom AnnotationFilter GeneNameFilter GeneIdFilter
#' @importFrom ensembldb getGeneRegionTrackForGviz
#' @importFrom ggbio plotRangesLinkedToData autoplot
#' @export
binTxPlot <- function(se, ensdb, gene, by=NULL, assayName=c("logNormDensity"),
                      removeAmbiguous=TRUE, size=3, threshold=0.05, ...){
  w <- diffUTR:::.matchGene(se, gene)
  se <- sort(se[w,])
  if(removeAmbiguous) se <- se[!rowData(se)$geneAmbiguous,]
  if(length(w)==0) return(NULL)
  if(!is.null(by)) by <- match.arg(by, colnames(colData(se)))
  assayName <- match.arg(assayName, assayNames(se))
  if(rowData(se)$gene[[1]]==gene){
    filt <- GeneIdFilter(gene)
  }else{
    filt <- GeneNameFilter(gene)
  }
  gr <- ggbio::autoplot(ensdb, filt)
  gr2 <- rowRanges(se)
  if(!is.null(by)){
    sp <- split(seq_len(ncol(se)), se[[by]])
    for(f in names(sp))
      mcols(gr2)[[f]] <- rowMeans(assays(se)[[assayName]][,sp[[f]],drop=FALSE])
    y <- names(sp)
  }else{
    mcols(gr2)[[assayName]] <- rowMeans(assays(se)[[assayName]])
    y <- assayName
  }
  ggbio::plotRangesLinkedToData(gr2, stat.y=y, stat.ylab=assayName,
                                annotation=list(gr),
                                size=size, ...) + ggtitle(gene)
}

# example usage (not run):
# binTxPlot(rse, ensdb, gene="Arid5a", by="condition")
```

(Additionally requires the *[ggbio](https://bioconductor.org/packages/3.22/ggbio)* package)

\*\*\*

```
sessionInfo()
```

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
##  [1] ggplot2_4.0.0               SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              GenomicRanges_1.62.0
##  [5] Seqinfo_1.0.0               IRanges_2.44.0
##  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
##  [9] generics_0.1.4              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           diffUTR_1.18.0
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3       jsonlite_2.0.0           shape_1.4.6.1
##   [4] magrittr_2.0.4           magick_2.9.0             GenomicFeatures_1.62.0
##   [7] farver_2.1.2             rmarkdown_2.30           GlobalOptions_0.1.2
##  [10] BiocIO_1.20.0            vctrs_0.6.5              Cairo_1.7-0
##  [13] memoise_2.0.1            Rsamtools_2.26.0         RCurl_1.98-1.17
##  [16] tinytex_0.57             htmltools_0.5.8.1        S4Arrays_1.10.0
##  [19] progress_1.2.3           curl_7.0.0               SparseArray_1.10.0
##  [22] sass_0.4.10              bslib_0.9.0              httr2_1.2.1
##  [25] cachem_1.1.0             GenomicAlignments_1.46.0 lifecycle_1.0.4
##  [28] iterators_1.0.14         pkgconfig_2.0.3          Matrix_1.7-4
##  [31] R6_2.6.1                 fastmap_1.2.0            clue_0.3-66
##  [34] digest_0.6.37            colorspace_2.1-2         AnnotationDbi_1.72.0
##  [37] DESeq2_1.50.0            geneplotter_1.88.0       RSQLite_2.4.3
##  [40] hwriter_1.3.2.1          filelock_1.0.3           labeling_0.4.3
##  [43] httr_1.4.7               abind_1.4-8              compiler_4.5.1
##  [46] bit64_4.6.0-1            withr_3.0.2              doParallel_1.0.17
##  [49] S7_0.2.0                 BiocParallel_1.44.0      DBI_1.2.3
##  [52] biomaRt_2.66.0           rappdirs_0.3.3           DelayedArray_0.36.0
##  [55] rjson_0.2.23             tools_4.5.1              glue_1.8.0
##  [58] restfulr_0.0.16          grid_4.5.1               cluster_2.1.8.1
##  [61] gtable_0.3.6             ensembldb_2.34.0         hms_1.1.4
##  [64] XVector_0.50.0           ggrepel_0.9.6            foreach_1.5.2
##  [67] pillar_1.11.1            stringr_1.5.2            limma_3.66.0
##  [70] genefilter_1.92.0        circlize_0.4.16          splines_4.5.1
##  [73] dplyr_1.1.4              BiocFileCache_3.0.0      lattice_0.22-7
##  [76] survival_3.8-3           rtracklayer_1.70.0       bit_4.6.0
##  [79] annotate_1.88.0          tidyselect_1.2.1         ComplexHeatmap_2.26.0
##  [82] locfit_1.5-9.12          Biostrings_2.78.0        knitr_1.50
##  [85] bookdown_0.45            ProtGenerics_1.42.0      edgeR_4.8.0
##  [88] xfun_0.53                DEXSeq_1.56.0            statmod_1.5.1
##  [91] stringi_1.8.7            UCSC.utils_1.6.0         lazyeval_0.2.2
##  [94] yaml_2.3.10              evaluate_1.0.5           codetools_0.2-20
##  [97] cigarillo_1.0.0          tibble_3.3.0             BiocManager_1.30.26
## [100] cli_3.6.5                xtable_1.8-4             jquerylib_0.1.4
## [103] Rsubread_2.24.0          dichromat_2.0-0.1        Rcpp_1.1.0
## [106] GenomeInfoDb_1.46.0      dbplyr_2.5.1             png_0.1-8
## [109] XML_3.99-0.19            parallel_4.5.1           blob_1.2.4
## [112] prettyunits_1.2.0        AnnotationFilter_1.34.0  bitops_1.0-9
## [115] viridisLite_0.4.2        scales_1.4.0             crayon_1.5.3
## [118] GetoptLong_1.0.5         rlang_1.1.6              KEGGREST_1.50.0
```