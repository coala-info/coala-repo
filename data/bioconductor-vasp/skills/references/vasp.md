# VaSP: Quantification and Visulization of Variations of Splicing in Population

#### *Huihui Yu, Qian Du and Chi Zhang*

#### 2020-04-28

* [1. Introduction](#introduction)
* [2. Installation](#installation)
* [3. Data input](#data-input)
* [4. Quick start](#quick-start)
* [5. Functions](#functions)
  + [5.1 getDepth](#getdepth)
  + [5.2 getGeneinfo](#getgeneinfo)
  + [5.3 spliceGene](#splicegene)
  + [5.4 spliceGenome](#splicegenome)
  + [5.5 BMfinder](#bmfinder)
  + [5.6 spliceplot](#spliceplot)
* [6. Session Information](#session-information)

## 1. Introduction

**VaSP** is an R package for the discovery of genome-wide variable splicing events from short-read RNA-seq data. Based on R package **Ballgown**, VaSP calculates the Single Splicing Strength (3S) score of an intron by the junction count normalized by the gene-level average read coverage (score=junction count/gene-level average read coverage). The 3S scores can be used for further analysis, such as differential splicing analysis between two sample groups and sQTL (splicing Quantitative Trait Locus) identification in a large population. The VaSP package provides a function to find large-effect differential splicing events without the need of genotypic information in an inbred plant population, so called genotype-specific splicing (GSS). Integrated with functions from R package **Sushi**, VaSP package also provides a function to visualize gene splicing information for publication-quality multi-panel figures.

## 2. Installation

Start R (>= 4.0) and run:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")

# The following initializes usage of Bioc devel
BiocManager::install(version='devel')

BiocManager::install("vasp", build_vignettes=TRUE)
vignette('vasp')
```

If you use an older version of R (>=3.5.0), enter:

```
BiocManager::install("yuhuihui2011/vasp@R3", build_vignettes=TRUE)
vignette('vasp')
```

## 3. Data input

Users need to follow the manual of R package Ballgown (<https://github.com/alyssafrazee/ballgown>) to create a ballgown object as an input for the VaSP package. See `?ballgown` for detailed information on creating Ballgown objects. The object can be stored in a `.RDate` file by `save()` . Here is an example of constructing rice.bg object from HISAT2+StringTie output

```
library(vasp)
?ballgown
path<-system.file('extdata', package='vasp')
rice.bg<-ballgown(samples = list.dirs(path = path,recursive = F) )
```

## 4. Quick start

Calculate 3S (Single Splicing Strength) scores, find GSS (genotype-specific splicing) events and display the splicing information.

* Calculating 3S scores:

```
library(vasp)
#> Loading required package: ballgown
#>
#> Attaching package: 'ballgown'
#> The following object is masked from 'package:base':
#>
#>     structure
data(rice.bg)
?rice.bg
rice.bg
#> ballgown instance with 33 transcripts and 6 samples
score<-spliceGene(rice.bg, gene="MSTRG.183", junc.type = "score")
tail(round(score,2),2)
#>    Sample_027 Sample_042 Sample_102 Sample_137 Sample_237 Sample_272
#> 58          0       0.02       0.22       0.23       0.23       0.23
#> 59          0       0.00       0.00       0.12       0.12       0.12
```

* Discovering GSS:

```
gss <- BMfinder(score, cores = 1)
#> Warning in BMfinder(score, cores = 1): sample size < 30, the result should be
#> further tested!
#> ---BMfinder: 16 features * 6 samples
#> ---Completed:  a total of 4 bimodal distrubition features found!
gss
#>    Sample_027 Sample_042 Sample_102 Sample_137 Sample_237 Sample_272
#> 55          2          2          1          1          1          1
#> 57          1          1          2          2          2          2
#> 58          1          1          2          2          2          2
#> 59          1          1          1          2          2          2
```

* Extracing intron information

```
gss_intron<-structure(rice.bg)$intron
(gss_intron<-gss_intron[gss_intron$id%in%rownames(gss)])
#> GRanges object with 4 ranges and 2 metadata columns:
#>       seqnames          ranges strand |        id transcripts
#>          <Rle>       <IRanges>  <Rle> | <integer> <character>
#>   [1]     Chr1 1179011-1179226      - |        55       15:16
#>   [2]     Chr1 1179011-1179134      - |        57          17
#>   [3]     Chr1 1179011-1179110      - |        58          18
#>   [4]     Chr1 1179011-1179106      - |        59          19
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
range(gss_intron)
#> GRanges object with 1 range and 0 metadata columns:
#>       seqnames          ranges strand
#>          <Rle>       <IRanges>  <Rle>
#>   [1]     Chr1 1179011-1179226      -
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

* Showing the splicing information

```
splicePlot(rice.bg,gene='MSTRG.183',samples = sampleNames(rice.bg)[c(1,3,5)],
start = 1179000, end = 1179300)
#> [1] "yes"
```

![](data:image/png;base64...)

## 5. Functions

Currently, there are 6 functions in VaSP:
***getDepth***: Get read depth from a BAM file (in bedgraph format)
***getGeneinfo***: Get gene informaton from a ballgown object
***spliceGene***: Calculate 3S scores for one gene
***spliceGenome***: Calculate genome-wide splicing scores
***BMfinder***: Discover bimodal distrubition features
***splicePlot***: Visualization of read coverage, splicing information and gene information in a gene region

### 5.1 getDepth

Get read depth from a BAM file (in bedgraph format) and return a data.frame in bedgraph file format which can be used as input for `plotBedgraph` in the **SuShi** package.

```
path <- system.file("extdata", package = "vasp")
bam_files <- list.files(path, "*.bam$")
bam_files
#> [1] "Sample_027.bam" "Sample_102.bam" "Sample_237.bam"

depth <- getDepth(file.path(path, bam_files[1]), "Chr1", start = 1171800,
end = 1179400)
head(depth)
#>   chrom   start    stop value
#> 1  Chr1 1171799 1171859     0
#> 2  Chr1 1171859 1171899     1
#> 3  Chr1 1171899 1171902     2
#> 4  Chr1 1171902 1171903     4
#> 5  Chr1 1171903 1171909     5
#> 6  Chr1 1171909 1171911     6

library(Sushi)
#> Loading required package: zoo
#>
#> Attaching package: 'zoo'
#> The following objects are masked from 'package:base':
#>
#>     as.Date, as.Date.numeric
#> Loading required package: biomaRt
par(mar=c(3,5,1,1))
plotBedgraph(depth, "Chr1", chromstart = 1171800, chromend = 1179400,yaxt = "s")
mtext("Depth", side = 2, line = 2.5, cex = 1.2, font = 2)
labelgenome("Chr1", 1171800, 1179400, side = 1, scipen = 20, n = 5,scale = "Kb")
```

![](data:image/png;base64...)

### 5.2 getGeneinfo

Get gene informaton from a ballgown object by genes or by genomic regions and return a data.frame in bed-like file format that can be used as input for `plotGenes` in the **SuShi** package

```
unique(geneIDs(rice.bg))
#>  [1] "MSTRG.177" "MSTRG.178" "MSTRG.179" "MSTRG.180" "MSTRG.181" "MSTRG.182"
#>  [7] "MSTRG.183" "MSTRG.184" "MSTRG.185" "MSTRG.186"

gene_id <- c("MSTRG.181", "MSTRG.182", "MSTRG.183")
geneinfo <- getGeneinfo(genes = gene_id, rice.bg)
trans <- table(geneinfo$name)  # show how many exons each transcript has
trans
#>
#> LOC_Os01g03050.1 LOC_Os01g03060.1 LOC_Os01g03060.2 LOC_Os01g03060.3
#>                5                2                3                3
#> LOC_Os01g03070.1 LOC_Os01g03070.2      MSTRG.181.1      MSTRG.182.2
#>               14               14                6                3
#>      MSTRG.183.3      MSTRG.183.4      MSTRG.183.5
#>               14               14               14

chrom = geneinfo$chrom[1]
chromstart = min(geneinfo$start) - 1e3
chromend = max(geneinfo$stop) + 1e3
color = rep(SushiColors(2)(length(trans)), trans)

par(mar=c(3,1,1,1))
p<-plotGenes(geneinfo, chrom, chromstart, chromend, col = color, bheight = 0.2,
bentline = FALSE, plotgenetype = "arrow", labeloffset = 0.5)
#> [1] "yes"
labelgenome(chrom, chromstart , chromend, side = 1, n = 5, scale = "Kb")
```

![](data:image/png;base64...)

### 5.3 spliceGene

Calculate 3S Scores from ballgown object for a given gene. This function can only calculate one gene. Please use function `spliceGenome` to obtain genome-wide 3S scores.

```
rice.bg
#> ballgown instance with 33 transcripts and 6 samples
head(geneIDs(rice.bg))
#>           1           2           3           4           5           6
#> "MSTRG.177" "MSTRG.177" "MSTRG.177" "MSTRG.178" "MSTRG.178" "MSTRG.179"

score <- spliceGene(rice.bg, "MSTRG.183", junc.type = "score")
count <- spliceGene(rice.bg, "MSTRG.183", junc.type = "count")

## compare
tail(score)
#>    Sample_027 Sample_042 Sample_102 Sample_137 Sample_237 Sample_272
#> 54   1.073545  1.1034944  0.9799037  1.0581254  1.0581254  1.0581254
#> 55   1.073545  1.1034944  0.1224880  0.1594436  0.1594436  0.1594436
#> 56   0.788727  1.3148018  1.1803386  1.3190330  1.3190330  1.3190330
#> 57   0.000000  0.0000000  0.5790340  0.4058563  0.4058563  0.4058563
#> 58   0.000000  0.0234786  0.2227054  0.2319179  0.2319179  0.2319179
#> 59   0.000000  0.0000000  0.0000000  0.1159589  0.1159589  0.1159589
tail(count)
#>    Sample_027 Sample_042 Sample_102 Sample_137 Sample_237 Sample_272
#> 54         49         47         88         73         73         73
#> 55         49         47         11         11         11         11
#> 56         36         56        106         91         91         91
#> 57          0          0         52         28         28         28
#> 58          0          1         20         16         16         16
#> 59          0          0          0          8          8          8

## get intron structrue
intron <- structure(rice.bg)$intron
intron[intron$id %in% rownames(score)]
#> GRanges object with 16 ranges and 2 metadata columns:
#>        seqnames          ranges strand |        id transcripts
#>           <Rle>       <IRanges>  <Rle> | <integer> <character>
#>    [1]     Chr1 1172688-1173213      - |        43       15:19
#>    [2]     Chr1 1173416-1173795      - |        44       15:19
#>    [3]     Chr1 1173877-1173965      - |        45       15:19
#>    [4]     Chr1 1174170-1174670      - |        46       15:19
#>    [5]     Chr1 1175175-1176065      - |        48       15:19
#>    ...      ...             ...    ... .       ...         ...
#>   [12]     Chr1 1179011-1179226      - |        55       15:16
#>   [13]     Chr1 1174881-1174952      - |        56       16:19
#>   [14]     Chr1 1179011-1179134      - |        57          17
#>   [15]     Chr1 1179011-1179110      - |        58          18
#>   [16]     Chr1 1179011-1179106      - |        59          19
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 5.4 spliceGenome

Calculate 3S scores from ballgown objects for all genes and return a list of two elements: “score’ is a matrix of intron 3S scores with intron rows and sample columns and”intron" is a `GRanges` object of intron structure.

```
rice.bg
#> ballgown instance with 33 transcripts and 6 samples

splice <- spliceGenome(rice.bg, gene.select = NA, intron.select = NA)
#> ---Calculate gene-level read coverage:
#>   10 genes selected.
#> ---Extract intron-level read ucount:
#>   81 introns in 9 genes selected.
names(splice)
#> [1] "score"  "intron"

head(splice$score)
#>   Sample_027 Sample_042 Sample_102 Sample_137 Sample_237 Sample_272
#> 1  1.4852698  1.6132865   1.934796   1.834662   1.834662   1.834662
#> 2  1.1580070  1.5164893   1.924559   1.726741   1.726741   1.726741
#> 3  1.2838773  1.7423494   2.129300   2.309516   2.309516   2.309516
#> 4  1.8377067  1.3551606   1.904085   2.050505   2.050505   2.050505
#> 5  0.9817885  0.9679719   1.289864   1.446146   1.446146   1.446146
#> 6  1.1076589  1.1615663   1.637923   1.661988   1.661988   1.661988
splice$intron
#> GRanges object with 81 ranges and 3 metadata columns:
#>      seqnames          ranges strand |        id   transcripts     gene_id
#>         <Rle>       <IRanges>  <Rle> | <integer>   <character> <character>
#>    1     Chr1 1146321-1146479      - |         1           1:2   MSTRG.177
#>    2     Chr1 1146612-1147484      - |         2           1:2   MSTRG.177
#>    3     Chr1 1147563-1148021      - |         3           1:3   MSTRG.177
#>    4     Chr1 1148200-1148268      - |         4           1:3   MSTRG.177
#>    5     Chr1 1148442-1148530      - |         5           1:3   MSTRG.177
#>   ..      ...             ...    ... .       ...           ...         ...
#>   77     Chr1 1187243-1187436      - |        77 c(28, 29, 32)   MSTRG.186
#>   78     Chr1 1189347-1190773      - |        78         29:30   MSTRG.186
#>   79     Chr1 1190863-1190978      - |        79         29:30   MSTRG.186
#>   80     Chr1 1189347-1189914      - |        80         31:33   MSTRG.186
#>   81     Chr1 1189961-1190037      - |        81            33   MSTRG.186
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

### 5.5 BMfinder

Find bimodal distrubition features and divide the samples into 2 groups by k-means clustering and return a matrix with feature rows and sample columns.

```
score <- spliceGene(rice.bg, "MSTRG.183", junc.type = "score")
score <- round(score, 2)
as <- BMfinder(score, cores = 1)  # 4 bimodal distrubition features found
#> Warning in BMfinder(score, cores = 1): sample size < 30, the result should be
#> further tested!
#> ---BMfinder: 16 features * 6 samples
#> ---Completed:  a total of 4 bimodal distrubition features found!

## compare
as
#>    Sample_027 Sample_042 Sample_102 Sample_137 Sample_237 Sample_272
#> 55          2          2          1          1          1          1
#> 57          1          1          2          2          2          2
#> 58          1          1          2          2          2          2
#> 59          1          1          1          2          2          2
score[rownames(score) %in% rownames(as), ]
#>    Sample_027 Sample_042 Sample_102 Sample_137 Sample_237 Sample_272
#> 55       1.07       1.10       0.12       0.16       0.16       0.16
#> 57       0.00       0.00       0.58       0.41       0.41       0.41
#> 58       0.00       0.02       0.22       0.23       0.23       0.23
#> 59       0.00       0.00       0.00       0.12       0.12       0.12
```

### 5.6 spliceplot

Visualization of read coverage, splicing information and gene information in a gene region. This function is a wrapper of `getDepth`, `getGeneinfo`, `spliceGene`, `plotBedgraph` and `plotGenes`.

```
samples <- paste("Sample", c("027", "102", "237"), sep = "_")
bam.dir <- system.file("extdata", package = "vasp")

## plot the whole gene region without junction lables
splicePlot(rice.bg, samples, bam.dir, gene = "MSTRG.183", junc.text = FALSE,
bheight = 0.2)
#> [1] "yes"
```

![](data:image/png;base64...)

```
## plot the alternative splicing region with junction splicing scores
splicePlot(rice.bg, samples, bam.dir, gene = "MSTRG.183", start = 1179000)
#> [1] "yes"
```

![](data:image/png;base64...)

If the bam files are provided (`bam.dir` is not NA), the read depth for each sample is plotted. Otherwise (`bam.dir=NA`), the conserved exons of the samples are displayed by rectangles (an example is the figure in **4. Quick start**). And by default (`junc.type = 'score'`, `junc.text = TRUE`), the junctions (represented by arcs) are labeled with splicing scores. You can change the argument `junc.text = FALSE` to unlabel the junctions or change the argument `junc.type = 'count'` to label with junction read counts.

```
splicePlot(rice.bg, samples, bam.dir, gene = "MSTRG.183", junc.type = 'count',
start = 1179000)
#> [1] "yes"
```

![](data:image/png;base64...)

There are other more options to modify the plot, please see the function `?splicePlot` for details.

## 6. Session Information

```
sessionInfo()
#> R version 4.0.0 (2020-04-24)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 18.04.4 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] Sushi_1.26.0    biomaRt_2.44.0  zoo_1.8-7       vasp_1.0.0
#> [5] ballgown_2.20.0
#>
#> loaded via a namespace (and not attached):
#>  [1] Biobase_2.48.0              httr_1.4.1
#>  [3] edgeR_3.30.0                bit64_0.9-7
#>  [5] splines_4.0.0               assertthat_0.2.1
#>  [7] askpass_1.1                 stats4_4.0.0
#>  [9] BiocFileCache_1.12.0        blob_1.2.1
#> [11] GenomeInfoDbData_1.2.3      Rsamtools_2.4.0
#> [13] yaml_2.2.1                  progress_1.2.2
#> [15] pillar_1.4.3                RSQLite_2.2.0
#> [17] lattice_0.20-41             glue_1.4.0
#> [19] limma_3.44.0                digest_0.6.25
#> [21] GenomicRanges_1.40.0        RColorBrewer_1.1-2
#> [23] XVector_0.28.0              htmltools_0.4.0
#> [25] Matrix_1.2-18               XML_3.99-0.3
#> [27] pkgconfig_2.0.3             genefilter_1.70.0
#> [29] zlibbioc_1.34.0             purrr_0.3.4
#> [31] xtable_1.8-4                BiocParallel_1.22.0
#> [33] tibble_3.0.1                openssl_1.4.1
#> [35] annotate_1.66.0             mgcv_1.8-31
#> [37] IRanges_2.22.0              ellipsis_0.3.0
#> [39] SummarizedExperiment_1.18.0 BiocGenerics_0.34.0
#> [41] survival_3.1-12             magrittr_1.5
#> [43] crayon_1.3.4                memoise_1.1.0
#> [45] evaluate_0.14               nlme_3.1-147
#> [47] tools_4.0.0                 prettyunits_1.1.1
#> [49] hms_0.5.3                   lifecycle_0.2.0
#> [51] matrixStats_0.56.0          stringr_1.4.0
#> [53] S4Vectors_0.26.0            locfit_1.5-9.4
#> [55] cluster_2.1.0               DelayedArray_0.14.0
#> [57] AnnotationDbi_1.50.0        Biostrings_2.56.0
#> [59] compiler_4.0.0              GenomeInfoDb_1.24.0
#> [61] rlang_0.4.5                 grid_4.0.0
#> [63] RCurl_1.98-1.2              rappdirs_0.3.1
#> [65] bitops_1.0-6                rmarkdown_2.1
#> [67] curl_4.3                    DBI_1.1.0
#> [69] R6_2.4.1                    GenomicAlignments_1.24.0
#> [71] dplyr_0.8.5                 knitr_1.28
#> [73] rtracklayer_1.48.0          bit_1.1-15.2
#> [75] stringi_1.4.6               parallel_4.0.0
#> [77] sva_3.36.0                  Rcpp_1.0.4.6
#> [79] vctrs_0.2.4                 tidyselect_1.0.0
#> [81] dbplyr_1.4.3                xfun_0.13
```