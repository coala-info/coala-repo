# ATACseqTFEA Guide

Jianhong Ou

#### 29 October 2025

# 1 Introduction

ATAC-seq, an assay for Transposase-Accessible Chromatin using sequencing, is a
widely used technique for chromatin accessibility analysis.
Detecting differential activation of transcription factors between two
different experiment conditions provides the possibility of decoding the
key factors in a phenotype. Lots of tools have been developed to detect
the differential activity of TFs (DATFs) for different groups of samples.
Those tools can be divided into two groups. One group detects DATFs from
differential accessibility analysis, such as MEME[1](#ref-bailey2006meme),
HOMER[2](#ref-heinz2010simple), enrichr[3](#ref-chen2013enrichr), and ChEA[4](#ref-lachmann2010chea).
Another group finds the DATFs by enrichment tests, such as
BiFET[5](#ref-youn2019bifet), diffTF[6](#ref-berest2019quantification), and TFEA[7](#ref-rubin2020transcription).
For single-cell ATAC-seq analysis, Signac and chromVar are widely used tools.

# 2 Motivation

All of these tools detect the DATF by only considering the open status of
chromatin. None of them take the TF footprint into count. The open status
provides the possibility of TF can bind to that position.
The TF footprint by ATAC-seq shows the status of TF bindings.

To help researchers quickly assess the differential activity of hundreds of TFs
by detecting the difference in TF footprint via enrichment
score[8](#ref-subramanian2005gene),
we have developed the *ATACseqTFEA* package.
The *ATACseqTFEA* package is a robust and reliable computational tool to
identify the key regulators responding to a phenotype.

![](data:image/png;base64...)

schematic diagram of ATACseqTFEA

# 3 Quick start

Here is an example using *ATACseqTFEA* with a subset of ATAC-seq data.

## 3.1 Installation

First, install *ATACseqTFEA* and other packages required to run
the examples.
Please note that the example dataset used here is from zebrafish.
To run an analysis with a dataset from a different species or different assembly,
please install the corresponding Bsgenome and “TxDb”.
For example, to analyze mouse data aligned to “mm10”,
please install “BSgenome.Mmusculus.UCSC.mm10”,
and “TxDb.Mmusculus.UCSC.mm10.knownGene”.
You can also generate a TxDb object by
functions `makeTxDbFromGFF` from a local “gff” file,
or `makeTxDbFromUCSC`, `makeTxDbFromBiomart`, and `makeTxDbFromEnsembl`,
from online resources in the *GenomicFeatures* package.

```
library(BiocManager)
BiocManager::install(c("ATACseqTFEA",
                       "ATACseqQC",
                       "Rsamtools",
                       "BSgenome.Drerio.UCSC.danRer10",
                       "TxDb.Drerio.UCSC.danRer10.refGene"))
```

## 3.2 Load library

```
library(ATACseqTFEA)
library(BSgenome.Drerio.UCSC.danRer10) ## for binding sites search
library(ATACseqQC) ## for footprint
```

## 3.3 Prepare binding sites

To do TFEA, there are two inputs, the binding sites, and the change ranks.
To get the binding sites, the *ATACseqTFEA* package provides the
`prepareBindingSites` function. Users can also try to get the binding sites
list by other tools such as “fimo”[9](#ref-grant2011fimo).

The `prepareBindingSites` function request a cluster of position weight matrix
(PWM) of TF motifs. *ATACseqTFEA* prepared a merged `PWMatrixList` for
405 motifs. The `PWMatrixList` is a collection of jasper2018, jolma2013 and
cisbp\_1.02 from package motifDB (v 1.28.0) and merged by distance smaller than
1e-9 calculated by MotIV::motifDistances function (v 1.42.0).
The merged motifs were exported by motifStack (v 1.30.0).

```
motifs <- readRDS(system.file("extdata", "PWMatrixList.rds",
                               package="ATACseqTFEA"))
```

The `best_curated_Human` is a list of TF motifs
downloaded from [TFEA github](https://github.com/Dowell-Lab/TFEA)[7](#ref-rubin2020transcription).
There are 1279 human motifs in the data set.

```
motifs_human <- readRDS(system.file("extdata", "best_curated_Human.rds",
                                    package="ATACseqTFEA"))
```

Another list of non-redundant TF motifs are also available by downloading
the data from [DeepSTARR](https://github.com/bernardo-de-almeida/motif-clustering)[10](#ref-de2021deepstarr). There are 6502 motifs in the data set.

```
MotifsSTARR <- readRDS(system.file("extdata", "cluster_PWMs.rds",
                                      package="ATACseqTFEA"))
```

To scan the binding sites along a genome, a `BSgenome` object is required by
the `prepareBindingSites` function.

```
# for test run, we use a subset of data within chr1:5000-100000
# for real data, use the merged peaklist as grange input.
# Drerio is the short-link of BSgenome.Drerio.UCSC.danRer10
seqlev <- "chr1"
bindingSites <-
  prepareBindingSites(motifs, Drerio, seqlev,
                      grange=GRanges("chr1", IRanges(5000, 100000)),
                      p.cutoff = 5e-05)#set higher p.cutoff to get more sites.
```

## 3.4 TFEA

The correct insertion site is the key to the enrichment analysis of TF binding
sites. The parameter `positive` and `negative` in the function of `TFEA`
are used to shift the 5’ ends of the reads to the correct insertion positions.
However, this shift does not consider the soft clip of the reads.
The best way to generate correct shifted bam files is using
ATACseqQC::shiftGAlignmentsList[11](#ref-ou2018atacseqqc) for paired-end or
shiftGAlignments for single-end of the bam file.
The samples must be at least biologically duplicated for the one-step `TFEA`
function.

```
bamExp <- system.file("extdata",
                      c("KD.shift.rep1.bam",
                        "KD.shift.rep2.bam"),
                      package="ATACseqTFEA")
bamCtl <- system.file("extdata",
                      c("WT.shift.rep1.bam",
                        "WT.shift.rep2.bam"),
                      package="ATACseqTFEA")
res <- TFEA(bamExp, bamCtl, bindingSites=bindingSites,
            positive=0, negative=0) # the bam files were shifted reads
```

## 3.5 View results

The results will be saved in a `TFEAresults` object. We will use multiple
functions to present the results.
The `plotES` function will return a `ggplot` object for single TF input and
no `outfolder` is defined.
The `ESvolcanoplot` function will provide an overview of all the TFs enrichment.
And we can borrow the `factorFootprints` function from `ATACseqQC` package
to view the footprints of one TF.

```
TF <- "Tal1::Gata1"
## volcanoplot
ESvolcanoplot(TFEAresults=res, TFnameToShow=TF)
```

![](data:image/png;base64...)

```
### plot enrichment score for one TF
plotES(res, TF=TF, outfolder=NA)
```

![](data:image/png;base64...)

```
## footprint
sigs <- factorFootprints(c(bamCtl, bamExp),
                         pfm = as.matrix(motifs[[TF]]),
                         bindingSites = getBindingSites(res, TF=TF),
                         seqlev = seqlev, genome = Drerio,
                         upstream = 100, downstream = 100,
                         group = rep(c("WT", "KD"), each=2))
```

![](data:image/png;base64...)

```
## export the results into a csv file
write.csv(res$resultsTable, tempfile(fileext = ".csv"),
          row.names=FALSE)
```

The command-line scripts are available at `extdata` named as `sample_scripts.R`.

# 4 Do TFEA step by step.

The one-step `TFEA` is a function containing multiple steps, which include:

1. count the reads in binding sites, proximal region, and distal region;
2. filter the binding site not open;
3. normalize the count number by the width of the count region;
4. calculate the binding scores and weight the binding scores by open scores;
5. differential analysis by limma for the binding score
6. filter the differential results by P-value and fold change
7. TF enrichment analysis

If you want to tune the parameters, it will be much better to do it step by step
to avoid repeating the computation for the same step.
Here are the details for each step.

## 4.1 Counting reads

We will count the insertion site in binding sites, proximal and distal regions
by counting the 5’ ends of the reads in a shifted bam file.
Here we suggest keeping the `proximal` and `distal` the same value.

```
# prepare the counting region
exbs <- expandBindingSites(bindingSites=bindingSites,
                           proximal=40,
                           distal=40,
                           gap=10)
## count reads by 5'ends
counts <- count5ends(bam=c(bamExp, bamCtl),
                     positive=0L, negative=0L,
                     bindingSites = bindingSites,
                     bindingSitesWithGap=exbs$bindingSitesWithGap,
                     bindingSitesWithProximal=exbs$bindingSitesWithProximal,
                     bindingSitesWithProximalAndGap=
                         exbs$bindingSitesWithProximalAndGap,
                     bindingSitesWithDistal=exbs$bindingSitesWithDistal)
```

## 4.2 Filter the counts

We filter the binding sites by at least there is 1 reads in proximal region.
Users may want to try filter the sites by more stringent criteria such as
“proximalRegion>1”.

```
colnames(counts)
```

```
## [1] "bindingSites"   "proximalRegion" "distalRegion"
```

```
counts <- eventsFilter(counts, "proximalRegion>0")
```

## 4.3 Normalize the counts by width of count region

We will normalize the counts to count per base (CPB).

```
counts <- countsNormalization(counts, proximal=40, distal=40)
```

## 4.4 Get weighted binding scores

Here we use the open score to weight the binding score. Users can also define
the weight for binding score via parameter `weight` in
the function `getWeightedBindingScore`.

```
counts <- getWeightedBindingScore(counts)
```

## 4.5 Differential analysis

Here we use `DBscore`, which borrows the power of the `limma` package,
to do differential binding analysis.

```
design <- cbind(CTL=1, EXPvsCTL=c(1, 1, 0, 0))
counts <- DBscore(counts, design=design, coef="EXPvsCTL")
```

## 4.6 Filter the DB results

We can filter the binding results to decrease the data size by
the function `eventsFilter`.
For the sample data, we skip this step.

## 4.7 TF enrichment analysis

Last, we use the function `doTFEA` to get the enrichment scores.

```
res <- doTFEA(counts)
res
```

```
## This is an object of TFEAresults with
## slot enrichmentScore ( matrix:  399 x 2166 ),
## slot bindingSites ( GRanges object with  2166  ranges and  12  metadata columns ),
## slot motifID ( a list of the positions of binding sites for  399 TFs ), and
## slot resultsTable ( 399  x  5 ). Here is the top 2 rows:
##          TF enrichmentScore normalizedEnrichmentScore   p_value   adjPval
## NRF1   NRF1       0.1923613                 0.7960275 0.7253614 0.9994472
## Gfi1b Gfi1b       0.3099024                 1.3769160 0.1143751 0.9585665
```

```
plotES(res, TF=TF, outfolder=NA) ## will show same figure as above one
```

![](data:image/png;base64...)

# 5 SessionInfo

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
##  [1] ATACseqQC_1.34.0                    Rsamtools_2.26.0
##  [3] BSgenome.Drerio.UCSC.danRer10_1.4.2 BSgenome_1.78.0
##  [5] rtracklayer_1.70.0                  BiocIO_1.20.0
##  [7] Biostrings_2.78.0                   XVector_0.50.0
##  [9] GenomicRanges_1.62.0                Seqinfo_1.0.0
## [11] IRanges_2.44.0                      S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0                 generics_0.1.4
## [15] ATACseqTFEA_1.12.0                  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              magick_2.9.0
##   [5] GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              vctrs_0.6.5
##   [9] multtest_2.66.0             Cairo_1.7-0
##  [11] memoise_2.0.1               RCurl_1.98-1.17
##  [13] base64enc_0.1-3             tinytex_0.57
##  [15] polynom_1.4-1               htmltools_0.5.8.1
##  [17] S4Arrays_1.10.0             progress_1.2.3
##  [19] AnnotationHub_4.0.0         lambda.r_1.2.4
##  [21] curl_7.0.0                  Rhdf5lib_1.32.0
##  [23] rhdf5_2.54.0                SparseArray_1.10.0
##  [25] sass_0.4.10                 pracma_2.4.6
##  [27] KernSmooth_2.23-26          bslib_0.9.0
##  [29] htmlwidgets_1.6.4           httr2_1.2.1
##  [31] futile.options_1.0.1        cachem_1.1.0
##  [33] GenomicAlignments_1.46.0    ChIPpeakAnno_3.44.0
##  [35] lifecycle_1.0.4             pkgconfig_2.0.3
##  [37] Matrix_1.7-4                R6_2.6.1
##  [39] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [41] digest_0.6.37               TFMPvalue_0.0.9
##  [43] AnnotationDbi_1.72.0        regioneR_1.42.0
##  [45] RSQLite_2.4.3               labeling_0.4.3
##  [47] seqLogo_1.76.0              filelock_1.0.3
##  [49] randomForest_4.7-1.2        httr_1.4.7
##  [51] abind_1.4-8                 compiler_4.5.1
##  [53] withr_3.0.2                 bit64_4.6.0-1
##  [55] S7_0.2.0                    BiocParallel_1.44.0
##  [57] GenomicScores_2.22.0        DBI_1.2.3
##  [59] preseqR_4.0.0               HDF5Array_1.38.0
##  [61] biomaRt_2.66.0              MASS_7.3-65
##  [63] rappdirs_0.3.3              DelayedArray_0.36.0
##  [65] rjson_0.2.23                gtools_3.9.5
##  [67] caTools_1.18.3              tools_4.5.1
##  [69] glue_1.8.0                  VennDiagram_1.7.3
##  [71] h5mread_1.2.0               restfulr_0.0.16
##  [73] InteractionSet_1.38.0       rhdf5filters_1.22.0
##  [75] grid_4.5.1                  ade4_1.7-23
##  [77] TFBSTools_1.48.0            gtable_0.3.6
##  [79] tidyr_1.3.1                 ensembldb_2.34.0
##  [81] data.table_1.17.8           hms_1.1.4
##  [83] BiocVersion_3.22.0          ggrepel_0.9.6
##  [85] pillar_1.11.1               motifmatchr_1.32.0
##  [87] stringr_1.5.2               limma_3.66.0
##  [89] splines_4.5.1               dplyr_1.1.4
##  [91] BiocFileCache_3.0.0         lattice_0.22-7
##  [93] survival_3.8-3              bit_4.6.0
##  [95] universalmotif_1.28.0       tidyselect_1.2.1
##  [97] DirichletMultinomial_1.52.0 RBGL_1.86.0
##  [99] locfit_1.5-9.12             knitr_1.50
## [101] grImport2_0.3-3             bookdown_0.45
## [103] ProtGenerics_1.42.0         edgeR_4.8.0
## [105] SummarizedExperiment_1.40.0 futile.logger_1.4.3
## [107] xfun_0.53                   Biobase_2.70.0
## [109] statmod_1.5.1               matrixStats_1.5.0
## [111] stringi_1.8.7               UCSC.utils_1.6.0
## [113] lazyeval_0.2.2              yaml_2.3.10
## [115] evaluate_1.0.5              codetools_0.2-20
## [117] cigarillo_1.0.0             tibble_3.3.0
## [119] BiocManager_1.30.26         graph_1.88.0
## [121] cli_3.6.5                   jquerylib_0.1.4
## [123] dichromat_2.0-0.1           Rcpp_1.1.0
## [125] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [127] png_0.1-8                   XML_3.99-0.19
## [129] parallel_4.5.1              ggplot2_4.0.0
## [131] blob_1.2.4                  prettyunits_1.2.0
## [133] jpeg_0.1-11                 AnnotationFilter_1.34.0
## [135] bitops_1.0-9                pwalign_1.6.0
## [137] motifStack_1.54.0           scales_1.4.0
## [139] purrr_1.1.0                 crayon_1.5.3
## [141] rlang_1.1.6                 KEGGREST_1.50.0
## [143] formatR_1.14
```

# References

1. Bailey, T. L., Williams, N., Misleh, C. & Li, W. W. MEME: Discovering and analyzing dna and protein sequence motifs. *Nucleic acids research* **34,** W369–W373 (2006).

2. Heinz, S. *et al.* Simple combinations of lineage-determining transcription factors prime cis-regulatory elements required for macrophage and b cell identities. *Molecular cell* **38,** 576–589 (2010).

3. Chen, E. Y. *et al.* Enrichr: Interactive and collaborative html5 gene list enrichment analysis tool. *BMC bioinformatics* **14,** 128 (2013).

4. Lachmann, A. *et al.* ChEA: Transcription factor regulation inferred from integrating genome-wide chip-x experiments. *Bioinformatics* **26,** 2438–2444 (2010).

5. Youn, A., Marquez, E. J., Lawlor, N., Stitzel, M. L. & Ucar, D. BiFET: Sequencing bi as-free transcription factor f ootprint e nrichment t est. *Nucleic acids research* **47,** e11–e11 (2019).

6. Berest, I. *et al.* Quantification of differential transcription factor activity and multiomics-based classification into activators and repressors: DiffTF. *Cell Reports* **29,** 3147–3159 (2019).

7. Rubin, J. D. *et al.* Transcription factor enrichment analysis (tfea): Quantifying the activity of hundreds of transcription factors from a single experiment. *Commun Biol* 661 (2021).

8. Subramanian, A. *et al.* Gene set enrichment analysis: A knowledge-based approach for interpreting genome-wide expression profiles. *Proceedings of the National Academy of Sciences* **102,** 15545–15550 (2005).

9. Grant, C. E., Bailey, T. L. & Noble, W. S. FIMO: Scanning for occurrences of a given motif. *Bioinformatics* **27,** 1017–1018 (2011).

10. Almeida, B. P. de, Reiter, F., Pagani, M. & Stark, A. DeepSTARR predicts enhancer activity from dna sequence and enables the de novo design of enhancers. *bioRxiv* (2021).

11. Ou, J. *et al.* ATACseqQC: A bioconductor package for post-alignment quality assessment of atac-seq data. *BMC genomics* **19,** 169 (2018).