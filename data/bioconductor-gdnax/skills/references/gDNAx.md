# The gDNAx package

Beatriz Calvo-Serra1\* and Robert Castelo1\*\*

1Dept. of Medicine and Life Sciences, Universitat Pompeu Fabra, Barcelona, Spain

\*beatriz.calvo@upf.edu
\*\*robert.castelo@upf.edu

#### 22 December 2025

#### Abstract

The `gDNAx` package provides functionality to diagnose the presence of genomic DNA (gDNA) contamination in RNA-seq data sets, and filter out reads of potential gDNA origin.

#### Package

gDNAx 1.8.2

# 1 What is genomic DNA contamination in a RNA-seq experiment

RNA sequencing (RNA-seq) libraries may contain genomic DNA (gDNA) contamination
due to an absent or inefficient gDNA digestion step (with DNase) during RNA
extraction or library preparation. In fact, some protocols do not include a
DNase treatment step, or they include it as optional.

While gDNA contamination is not a major issue in libraries built with poly(A)
selected RNA molecules, it can remarkably affect gene expression quantification
from libraries of total RNA. When present, gDNA contamination can lead to a
misleading attribution of expression to unannotated regions of the genome. For
this reason, it is important to check the levels of gDNA contamination during
quality control before performing further analyses, specially when total RNA
has been sequenced.

# 2 Diagnose gDNA contamination

Here we illustrate the use of the [gDNAx](https://bioconductor.org/packages/gDNAx)
package for producing different diagnostics and how do they reveal different
gDNA contamination levels. We use a subset of the data in (Li et al. [2022](#ref-li2022genes)), which
consists of 9 paired-end samples of total RNA-seq with increasing levels of gDNA
contamination: 0% (no contamination), 1% and 10%, with 3 replicates each. The
data is available through the Bioconductor experiment data package
[gDNAinRNAseqData](https://bioconductor.org/packages/gDNAinRNAseqData), which
allows one to download 9 BAM files, containing about 100,000 alignments, sampled
uniformly at random from the complete BAM files.

```
library(gDNAinRNAseqData)

# Retrieve BAM files
bamfiles <- LiYu22subsetBAMfiles()
bamfiles
[1] "/tmp/Rtmp2wKcSX/s32gDNA0.bam"  "/tmp/Rtmp2wKcSX/s33gDNA0.bam"
[3] "/tmp/Rtmp2wKcSX/s34gDNA0.bam"  "/tmp/Rtmp2wKcSX/s26gDNA1.bam"
[5] "/tmp/Rtmp2wKcSX/s27gDNA1.bam"  "/tmp/Rtmp2wKcSX/s28gDNA1.bam"
[7] "/tmp/Rtmp2wKcSX/s23gDNA10.bam" "/tmp/Rtmp2wKcSX/s24gDNA10.bam"
[9] "/tmp/Rtmp2wKcSX/s25gDNA10.bam"

# Retrieve information on the gDNA concentrations of each BAM file
pdat <- LiYu22phenoData(bamfiles)
pdat
          gDNA
s32gDNA0     0
s33gDNA0     0
s34gDNA0     0
s26gDNA1     1
s27gDNA1     1
s28gDNA1     1
s23gDNA10   10
s24gDNA10   10
s25gDNA10   10
```

Diagnosing the presence of gDNA contamination requires using an annotation
of genes and transcripts. The [gDNAx](https://bioconductor.org/packages/gDNAx)
package expects that we provide such an annotation using a so-called `TxDb`
package, either as a `TxDb` object, created once such a package is loaded into
the R session, or by specifying the name of the package. The Bioconductor
[website](https://www.bioconductor.org/packages/release/BiocViews.html#___TxDb)
provides a number of `TxDb` packages, but if the we do not find the one we are
looking for, we can build a `TxDb` object using the function `makeTxDbFromGFF()`
on a given [GFF](https://en.wikipedia.org/wiki/General_feature_format) or
[GTF](https://en.wikipedia.org/wiki/Gene_transfer_format) file, or any of the
other `makeTxDbFrom*()` functions, available in the
[GenomicFeatures](https://bioconductor.org/packages/GenomicFeatures) package.
Here we load the `TxDb` package corresponding to the GENCODE annotation provided
by the UCSC Genome Browser.

```
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
txdb
TxDb object:
# Db type: TxDb
# Supporting package: GenomicFeatures
# Data source: UCSC
# Genome: hg38
# Organism: Homo sapiens
# Taxonomy ID: 9606
# UCSC Table: knownGene
# UCSC Track: GENCODE V48
# Resource URL: https://genome.ucsc.edu/
# Type of Gene ID: Entrez Gene ID
# Full dataset: yes
# Nb of transcripts: 412044
# Db created by: txdbmaker package from Bioconductor
# Creation time: 2025-10-06 16:41:53 +0000 (Mon, 06 Oct 2025)
# txdbmaker version at creation time: 1.5.6
# RSQLite version at creation time: 2.4.3
# DBSCHEMAVERSION: 1.2
```

We can calculate diagnostics for gDNA contamination using the function
`gDNAdx()` as follows.

```
library(gDNAx)

gdnax <- gDNAdx(bamfiles, txdb)
class(gdnax)
[1] "gDNAx"
attr(,"package")
[1] "gDNAx"
gdnax
gDNAx object
# BAM files (9): s32gDNA0.bam, ..., s25gDNA10.bam
# Library layout: paired-end, 9 (2x50nt)
# Library protocol: unstranded (9 out of 9)
# Sequences: only assembled molecules
# Annotation pkg: TxDb.Hsapiens.UCSC.hg38.knownGene
# Alignments employed: first 100000
```

The previous call will show progress through its calculations unless we set
the argument `verbose=FALSE`, and return an object of class `gDNAx` once it has
finished. We have let the `gDNAdx()` function figure out the library layout
and protocol, but if we already knew those parameters from the data, we could
set them through the arguments `singleEnd` and `strandMode` and speed up
calculations. Another way to speed up calculations, which may be advantageous
specially when analysing a high number of BAM files, is to use the `BPPARAM`
argument to set a number of parallel threads of execution; see the help page
of `gDNAdx()` for full details on how to specify non-default values to all
these parameters.

Calling the `plot()` function with the resulting object `gDNAx` object as the
first argument will plot several diagnostics. Here below, we also use a
parameter called `group` to automatically color samples, in this case, by the
gDNA contamination levels included in the experimental design of the data; see
(Li et al. [2022](#ref-li2022genes)) for full details on it.

```
par(mar=c(4, 5, 2, 1))
plot(gdnax, group=pdat$gDNA, pch=19)
```

![Diagnostics. Default diagnostics obtained with the function `plot()` on a `gDNAx` object.](data:image/png;base64...)

Figure 1: Diagnostics
Default diagnostics obtained with the function `plot()` on a `gDNAx` object.

The previous figure contains three diagnostic plots, each one showing the
following values as a function of the percentage of read alignments fully
contained in **intergenic** regions (IGC):

* Percentage of **Splice-compatible junction** (SCJ) alignments. These are
  alignments compatible with a transcript in the given annotation, for which
  the aligned read, or at least one of the two aligned reads in the case of
  a paired-end layout, spans one or more exon-exon junctions over two or more
  exons of that transcript.
* Percentage of **splice compatible exonic** (SCE) alignments. These are
  alignments compatible with a transcript in the given annotation, but which
  differently to SCJ alignments, do not include an exon-exon junction in the
  alignment.
* Percentage of **intronic** (INT) alignments. These are alignments fully
  contained in intronic regions.

These data appear to come from an unstranded library, but if they would be
stranded, a fourth diagnostic plot would appear showing an estimated value of
the strandedness of each sample as function of the percentage of intergenic
alignments. In stranded RNA-seq data, we should expect strandedness values close
to 1, which imply that most reads align to the same strand than the annotated
transcripts. Lower strandedness values can be indicative of gDNA contamination
because reads sequenced from DNA are expected to align in equal proportions to
both strands.

Because IGC alignments mainly originate from gDNA contamination, we may expect
a negative correlation between the percentage of SCJ or SCE alignments and the
percentage of IGC alignments. On the other hand, INT alignments may originate
either from primary unprocessed transcripts in the nucleus, or from gDNA
contamination as well. Therefore, we may also expect some positive correlation
between the percentages of INT and IGC alignments, as it happens in this data.

Using the function `getDx()` on the `gDNAx` object, we obtain all the values
used in the diagnostics.

```
dx <- getDx(gdnax)
dx
                IGC      INT      SCJ      SCE      JNC  IGCFLM  SCJFLM  SCEFLM
s32gDNA0  0.7645996 11.80714 14.60265 39.45615 19.56452 170.390 159.954 158.724
s33gDNA0  0.8235200 11.85327 14.63278 39.78574 19.55383 181.105 161.775 159.806
s34gDNA0  0.8045262 12.30765 14.82956 39.65953 19.70788 174.077 151.565 156.049
s26gDNA1  1.0929948 12.31976 14.20292 38.23677 18.73132 185.308 165.660 161.977
s27gDNA1  1.0587597 12.51005 14.00117 37.68300 18.31765 173.782 162.489 167.999
s28gDNA1  1.1572841 12.56925 13.54756 37.19799 17.96053 189.000 166.856 162.202
s23gDNA10 2.8533336 13.53137 10.81540 30.71197 14.41110 180.235 163.819 164.294
s24gDNA10 3.0291399 14.09222 10.45301 29.72678 13.91748 186.528 159.730 158.650
s25gDNA10 2.7189479 13.89931 10.80217 30.41571 14.20691 175.507 155.065 159.028
           INTFLM STRAND
s32gDNA0  156.409     NA
s33gDNA0  156.765     NA
s34gDNA0  152.752     NA
s26gDNA1  157.314     NA
s27gDNA1  159.414     NA
s28gDNA1  159.236     NA
s23gDNA10 209.657     NA
s24gDNA10 163.689     NA
s25gDNA10 159.039     NA
```

The column `JNC` contains the percentage of alignments that include one or more
junctions, irrespective of whether those alignments are compatible with an
spliced transcript in the given annotation. The columns with the suffix `FLM`
contain an estimation of the fragment length mean in the alignments originating
in the corresponding region, and the column `STRAND` stores the strandedness
values, which in this case are `NA` because this dataset is not strand-specific.

We can directly plot the estimated fragments length distributions with the
function `plotFrgLength()`.

```
plotFrgLength(gdnax)
```

![Fragments length distributions. Density and location of the estimated fragments length distribution, by the origin of the alignments.](data:image/png;base64...)

Figure 2: Fragments length distributions
Density and location of the estimated fragments length distribution, by the origin of the alignments.

Another way to represent some of diagnostic measurements is to examine the
origin of the alignments per sample in percentages. Fluctuations of these
proportions across samples can help quantifying the amount of gDNA
contamination per sample.

```
plotAlnOrigins(gdnax, group=pdat$gDNA)
```

![Alignment origins.](data:image/png;base64...)

Figure 3: Alignment origins

In the previous plot, `OTH` indicates the percentage of read alignments that
do not fall fully within any of the other categories (`SCJ`, `SCE`, `INT` and
`IGC`), these may typically correspond to read alignments overlapping two of
these previous categories. If we are interested in knowing exactly which
annotations of intergenic and intronic regions have been used to compute these
diagnostics, we can retrieve them using the functions `getIgc()` and `getInt()`
on the output `gDNAx` object, respectively.

```
igcann <- getIgc(gdnax)
igcann
GRanges object with 769449 ranges and 0 metadata columns:
           seqnames      ranges strand
              <Rle>   <IRanges>  <Rle>
       [1]     chr1     1-10000      *
       [2]     chr1 31132-31292      *
       [3]     chr1 31755-32840      *
       [4]     chr1 34109-34450      *
       [5]     chr1 37596-37732      *
       ...      ...         ...    ...
  [769445]     chrM   2746-3229      *
  [769446]     chrM   3308-4328      *
  [769447]     chrM   4401-7447      *
  [769448]     chrM  7515-16204      *
  [769449]     chrM 16250-16569      *
  -------
  seqinfo: 25 sequences (1 circular) from hg38 genome
intann <- getInt(gdnax)
intann
GRanges object with 1633634 ranges and 0 metadata columns:
            seqnames            ranges strand
               <Rle>         <IRanges>  <Rle>
        [1]     chr1       12722-12974      *
        [2]     chr1       13053-13220      *
        [3]     chr1       18062-18267      *
        [4]     chr1       18380-18496      *
        [5]     chr1       18555-18906      *
        ...      ...               ...    ...
  [1633630]     chrY 57207675-57208210      *
  [1633631]     chrY 57208313-57208518      *
  [1633632]     chrY 57213358-57213525      *
  [1633633]     chrY 57213603-57213855      *
  [1633634]     chrY 57213983-57214349      *
  -------
  seqinfo: 25 sequences (1 circular) from hg38 genome
```

## 2.1 Strandedness estimation

Since we have let the `gDNAdx()` function to estimate strandedness, we can
examine those estimated values using the getter function `strandedness()` on
the `gDNAx` object.

```
strandedness(gdnax)
          strandMode1 strandMode2      ambig Nalignments
s32gDNA0    0.5010443   0.4989557 0.05012399       66535
s33gDNA0    0.5014063   0.4985937 0.05052960       66654
s34gDNA0    0.5047144   0.4952856 0.04993086       66532
s26gDNA1    0.5048053   0.4951947 0.04839641       64075
s27gDNA1    0.5069977   0.4930023 0.04947422       63144
s28gDNA1    0.5007322   0.4992678 0.04977687       62519
s23gDNA10   0.5027862   0.4972138 0.05008068       50818
s24gDNA10   0.4978624   0.5021376 0.04926229       49206
s25gDNA10   0.5007535   0.4992465 0.05066963       50326
```

Using the function `classifyStrandMode()` we can obtain a classification of
the most likely strand mode for each BAM file, given some default cutoff
values.

```
classifyStrandMode(strandedness(gdnax))
 s32gDNA0  s33gDNA0  s34gDNA0  s26gDNA1  s27gDNA1  s28gDNA1 s23gDNA10 s24gDNA10
       NA        NA        NA        NA        NA        NA        NA        NA
s25gDNA10
       NA
```

Li et al. ([2022](#ref-li2022genes)) report in their publication that “sequencing libraries were
generated using a TruSeq Stranded Total RNA Library Prep Kit”. However, we can
see that the proportion of alignments overlapping transcripts in the column
`strandMode1` is very similar to the one in the column `strandMode2`, which is
compatible with an unstranded library and the reason why we obtain `NA` values
in the output of `classifyStrandMode()`. We reach the same conclusion if we use
the RSeQC tool `infer_experiment.py` (Wang, Wang, and Li [2012](#ref-wang2012rseqc)) and by visual inspection
of the alignment data in the Integrative Genomics Viewer (IGV)
(Robinson et al. [2011](#ref-robinson2011integrative)).

Following the recommendations made by Signal and Kahlke ([2022](#ref-signal2022how_are_we_stranded_here)),
`gDNAx` attempts to use at least 200,000 alignments overlapping exonic regions
to estimate strandedness. In the subset of data used in this vignette, the
number of alignments used for that estimation is close to 60,000, which is
the total number of exonic alignments present in the BAM files.

If we are only interested in the estimation of strandedness values, we can
can also directly call `strandedness()` with a character string vector of BAM
filenames and a `TxDb` annotation object; see the help page of `strandedness()`.

# 3 Remove gDNA contamination

We can attempt removing read alignments from putative gDNA origin using the
function `gDNAtx()`, which should be called with the `gDNAx` object returned
by `gDNAdx()` and a path in the filesystem where to stored the filtered
BAM files. By default, these filtered BAM files include splice-compatible
read alignments (SCJ and SCE) that are found in a genomic window enriched for
stranded alignments. For further fine tuning of this filtering strategy please
use the function `filterBAMtx()`.

```
## fbf <- filterBAMtxFlag(isSpliceCompatibleJunction=TRUE,
##                        isSpliceCompatibleExonic=TRUE)
## fstats <- filterBAMtx(gdnax, path=tmpdir, txflag=fbf)
## fstats
tmpdir <- tempdir()
fstats <- gDNAtx(gdnax, path=tmpdir)
fstats
```

```
           NALN NIGC NINT  NSCJ  NSCE  NSTW NNCH
s32gDNA0  99660   NA   NA 15134 39905 46336  340
s33gDNA0  99694   NA   NA 15170 40189 46823  306
s34gDNA0  99686   NA   NA 15352 40068 46529  314
s26gDNA1  99726   NA   NA 14743 38586 45061  274
s27gDNA1  99456   NA   NA 14466 38011 45083  544
s28gDNA1  99457   NA   NA 14023 37470 43892  543
s23gDNA10 99007   NA   NA 11115 30690 36424  993
s24gDNA10 99005   NA   NA 10746 29716 35032  995
s25gDNA10 99156   NA   NA 11103 30394 36039  844
```

The first column `NALN` corresponds to the total number of read alignments
processed. Columns `NIGC` to `NSCE` contain the number of selected alignments
from each corresponding origin, where `NA` indicates that that type of
alignment was not selected for filtering. The column `NSTW` corresponds to
selected alignments occurring in stranded windows, and therefore this number
will be always equal or smaller than the number of the previous columns. The
column `NNCH` corresponds to discarded read alignments ocurring in non-standard
chromosomes.

# 4 Session information

```
sessionInfo()
R version 4.5.2 (2025-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] gDNAx_1.8.2
 [2] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
 [3] GenomicFeatures_1.62.0
 [4] AnnotationDbi_1.72.0
 [5] Biobase_2.70.0
 [6] Rsamtools_2.26.0
 [7] Biostrings_2.78.0
 [8] XVector_0.50.0
 [9] GenomicRanges_1.62.1
[10] IRanges_2.44.0
[11] S4Vectors_0.48.0
[12] Seqinfo_1.0.0
[13] BiocGenerics_0.56.0
[14] generics_0.1.4
[15] gDNAinRNAseqData_1.10.0
[16] knitr_1.51
[17] BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] tidyselect_1.2.1            dplyr_1.1.4
 [3] blob_1.2.4                  filelock_1.0.3
 [5] bitops_1.0-9                fastmap_1.2.0
 [7] RCurl_1.98-1.17             BiocFileCache_3.0.0
 [9] VariantAnnotation_1.56.0    GenomicAlignments_1.46.0
[11] XML_3.99-0.20               digest_0.6.39
[13] lifecycle_1.0.4             KEGGREST_1.50.0
[15] RSQLite_2.4.5               magrittr_2.0.4
[17] compiler_4.5.2              rlang_1.1.6
[19] sass_0.4.10                 tools_4.5.2
[21] plotrix_3.8-13              yaml_2.3.12
[23] rtracklayer_1.70.1          S4Arrays_1.10.1
[25] bit_4.6.0                   curl_7.0.0
[27] DelayedArray_0.36.0         RColorBrewer_1.1-3
[29] abind_1.4-8                 BiocParallel_1.44.0
[31] withr_3.0.2                 purrr_1.2.0
[33] grid_4.5.2                  ExperimentHub_3.0.0
[35] tinytex_0.58                SummarizedExperiment_1.40.0
[37] cli_3.6.5                   rmarkdown_2.30
[39] crayon_1.5.3                otel_0.2.0
[41] httr_1.4.7                  rjson_0.2.23
[43] DBI_1.2.3                   cachem_1.1.0
[45] parallel_4.5.2              BiocManager_1.30.27
[47] restfulr_0.0.16             matrixStats_1.5.0
[49] vctrs_0.6.5                 Matrix_1.7-4
[51] jsonlite_2.0.0              bookdown_0.46
[53] bit64_4.6.0-1               magick_2.9.0
[55] GenomicFiles_1.46.0         jquerylib_0.1.4
[57] glue_1.8.0                  codetools_0.2-20
[59] GenomeInfoDb_1.46.2         BiocVersion_3.22.0
[61] UCSC.utils_1.6.1            BiocIO_1.20.0
[63] tibble_3.3.0                pillar_1.11.1
[65] rappdirs_0.3.3              htmltools_0.5.9
[67] BSgenome_1.78.0             R6_2.6.1
[69] dbplyr_2.5.1                httr2_1.2.2
[71] evaluate_1.0.5              lattice_0.22-7
[73] AnnotationHub_4.0.0         png_0.1-8
[75] cigarillo_1.0.0             memoise_2.0.1
[77] bslib_0.9.0                 Rcpp_1.1.0
[79] SparseArray_1.10.8          xfun_0.55
[81] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# References

Li, Xiangnan, Peipei Zhang, Haijian Wang, and Ying Yu. 2022. “Genes Expressed at Low Levels Raise False Discovery Rates in Rna Samples Contaminated with Genomic Dna.” *BMC Genomics* 23 (1): 554.

Robinson, James T, Helga Thorvaldsdóttir, Wendy Winckler, Mitchell Guttman, Eric S Lander, Gad Getz, and Jill P Mesirov. 2011. “Integrative Genomics Viewer.” *Nature Biotechnology* 29 (1): 24–26.

Signal, Brandon, and Tim Kahlke. 2022. “How\_are\_we\_stranded\_here: Quick Determination of Rna-Seq Strandedness.” *BMC Bioinformatics* 23 (1): 1–9.

Wang, Liguo, Shengqin Wang, and Wei Li. 2012. “RSeQC: Quality Control of Rna-Seq Experiments.” *Bioinformatics* 28 (16): 2184–5.