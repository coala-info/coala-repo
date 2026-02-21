# ‘Motif2Site’: an R package to detect binding sites from ChIP-seq and recenter them

Peyman Zarrineh1\*

1The University of Manchester

\*peyman.zarrineh@manchester.ac.uk

#### October 30, 2025

#### Abstract

‘Motif2Site’ is an R package to detect transcription factor binding sites from motif sets and ChIP-seq experiments. The motif sets are either user provided bed files or user provided DNA nucleotide sequence motifs. It also combines andcompares binding sites of a transcription factor across various experiments and conditions.

#### Package

Motif2Site 1.14.0

# Contents

* [1 Introduction](#introduction)
* [2 Major functions of Motif2Site](#major-functions-of-motif2site)
* [3 Selecting sequence motif](#selecting-sequence-motif)
* [4 Detecting binding sites](#detecting-binding-sites)
* [5 Combining binding sites across experiments](#combining-binding-sites-across-experiments)
* [6 Session Info](#session-info)
* [References](#references)

# 1 Introduction

Transcription factors often bind to specific DNA nucleotide patterns referred to as sequence motifs. Although sequence motifs are well-characterized for many transcription factors, detecting the actual binding sites is not always a straightforward task. Chromatin immunoprecipitation (ChIP) followed by DNA sequencing (ChIP-seq) is the major technology to detect binding regions of transcription factors. However, the binding regions detected by ChIP-seq may contains several or no DNA sequence motifs. **Motif2Site** is a novel R package which uses ChIP-seq information and detect transcription factor binding sites from a user provided DNA sequence motifs set.

**Motif2Site** gets two different input, motif and ChIP-seq alignment information, to detect binding sites. First input is ChIP-seq alignment short reads in the bam or bed format. For each aligned short read the center of the alignment is calculated using *[GenomicAlignments](https://bioconductor.org/packages/3.22/GenomicAlignments)* (Lawrence et al. [2013](#ref-Lawrence2013)) and *[Rsamtools](https://bioconductor.org/packages/3.22/Rsamtools)* (Morgan et al. [2020](#ref-Morgan2020)) packages. Motif information is the second input which is provided by user either as a bed file or a DNA string with a mismatch number. In the case of DNA string input, *[Biostrings](https://bioconductor.org/packages/3.22/Biostrings)* (Pagès et al. [2019](#ref-Pages2019)) and *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* (H. Pagès [2019](#ref-Herve2019)) packages are used to find motif locations on the genome in *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* (Lawrence et al. [2013](#ref-Lawrence2013)) format.

Negative binomial distribution is used to model count data by using *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* package (Robinson, McCarthy, and Smyth [2010](#ref-Robinson2010)). *[mixtools](https://CRAN.R-project.org/package%3Dmixtools)* (Benaglia et al. [2009](#ref-Benaglia2009)) is used to deconvolve binding intensities of closely spaced binding sites. **Motif2Site** also combines binding sites across different experiments. It calls differential binding sites using TMM normalization and GLM test using *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* package (Robinson, McCarthy, and Smyth [2010](#ref-Robinson2010)).

# 2 Major functions of Motif2Site

First install and load the libraries needed to run the examples of this document:

```
library(GenomicRanges)
library(Motif2Site)
library(BSgenome.Scerevisiae.UCSC.sacCer3)
library(BSgenome.Ecoli.NCBI.20080805)
```

The functions, implemented in **Motif2Site**, perform three tasks: **1.** To assist users to select better sequence motif input.
**2.** To detect binding sites from sequence motifs and ChIP-seq datasets **3.** To combine and compare binding sites across different experiments, conditions, or tissues. Each of these functions are explained in a separate section.

# 3 Selecting sequence motif

**Motif2Site** uses DNA motif information as one of its input. To facilitate choosing proper sequence motif, `compareBedFiless2UserProvidedRegions` and `compareMotifs2UserProvidedRegions` functions compare motif regions with a user provided confident regions in terms of precision and recall.

As the first example, an artificially generated “YeastSampleMotif.bed” bed file in yeast is considered as a confident binding regions set. `compareMotifs2UserProvidedRegions` function compares these regions with locations of ‘TGATTSCAGGANT’ 1-mismatch, ‘TGATTCCAGGANT’ 0-mismatch, ‘TGATWSCAGGANT’ 2-mismatches on the yeast genome in terms of precision and recall.

```
yeastExampleFile =
  system.file("extdata", "YeastSampleMotif.bed", package="Motif2Site")
YeastRegionsChIPseq <- Bed2Granges(yeastExampleFile)
SequenceComparison <-
  compareMotifs2UserProvidedRegions(
    givenRegion=YeastRegionsChIPseq,
    motifs = c("TGATTSCAGGANT", "TGATTCCAGGANT", "TGATWSCAGGANT"),
    mismatchNumbers = c(1,0,2),
    genome="Scerevisiae",
    genomeBuild="sacCer3"
    )
```

![](data:image/png;base64...)

```
SequenceComparison
```

```
##                 motifName regionCoverage motifCoverage
## 1 TGATTSCAGGANT_1mismatch    0.350877193     0.6060606
## 2 TGATTCCAGGANT_0mismatch    0.005847953     1.0000000
## 3 TGATWSCAGGANT_2mismatch    1.000000000     0.0475132
```

In the following example, an artificially generated “YeastSampleMotif.bed” bed file in yeast is considered as a confident binding regions set. `compareBedFiless2UserProvidedRegions` function compares these regions with two bed files “YeastBedFile1.bed” and “YeastBedFile2.bed” in terms of precision and recall.

```
# Yeast artificial dataset for comparison bed files

yeastExampleFile =
  system.file("extdata", "YeastSampleMotif.bed", package="Motif2Site")
YeastRegionsChIPseq <- Bed2Granges(yeastExampleFile)
bed1 <- system.file("extdata", "YeastBedFile1.bed", package="Motif2Site")
bed2 <- system.file("extdata", "YeastBedFile2.bed", package="Motif2Site")
BedFilesVector <- c(bed1, bed2)
SequenceComparison <-
  compareBedFiless2UserProvidedRegions(
    givenRegion=YeastRegionsChIPseq,
    bedfiles = BedFilesVector,
    motifnames = c("YeastBed1", "YeastBed2")
    )
```

![](data:image/png;base64...)

```
SequenceComparison
```

```
##   motifName regionCoverage motifCoverage
## 1 YeastBed1      0.3099415      1.000000
## 2 YeastBed2      0.4853801      0.209068
```

# 4 Detecting binding sites

`DetectBindingSitesMotif` function detects binding sites from provided sequence motif information. Here, Artificial ChIP-seq data for FUR transcription factor in Escherichia coli was generated in two conditions fe2+ and dpd inspired by (Seo et al. [2014](#ref-Seo2014)). In the following examples, artificial sequence motif locations have been and provided as a bed file called ‘FurMotifs.bed’. The alignment of ChIP-seq short reads is the other input of this function. The alignment files can be passed to the function as bam or bed files. In the following examples both IP and background alignment files have been passed as single-end bed files to this function.

```
# FUR candidate motifs in NC_000913 E. coli
FurMotifs = system.file("extdata", "FurMotifs.bed", package="Motif2Site")

# ChIP-seq FUR fe datasets binding sites from user provided bed file
# ChIP-seq datasets in bed single end format

IPFe <- c(system.file("extdata", "FUR_fe1.bed", package="Motif2Site"),
          system.file("extdata", "FUR_fe2.bed", package="Motif2Site"))
Inputs <- c(system.file("extdata", "Input1.bed", package="Motif2Site"),
            system.file("extdata", "Input2.bed", package="Motif2Site"))
FURfeBedInputStats <-
  DetectBindingSitesBed(BedFile=FurMotifs,
                        IPfiles=IPFe,
                        BackgroundFiles=Inputs,
                        genome="Ecoli",
                        genomeBuild="20080805",
                        DB="NCBI",
                        expName="FUR_Fe_BedInput",
                        format="BEDSE"
                        )
FURfeBedInputStats
```

```
## $FRiP
## [1] 0.3668289 0.1997165
##
## $sequencingStatitic
##   nonSequenced underBinding overBinding
## 1   0.02293399            0 0.005022041
##
## $motifStatistics
##   skewnessTestRejected decompositionRejected accepted
## 1                   98                    59      192
```

```
# ChIP-seq FUR dpd datasets binding sites from user provided bed file
# ChIP-seq datasets in bed single end format

IPDpd <- c(system.file("extdata", "FUR_dpd1.bed", package="Motif2Site"),
           system.file("extdata", "FUR_dpd2.bed", package="Motif2Site"))
FURdpdBedInputStats <-
  DetectBindingSitesBed(BedFile=FurMotifs,
                        IPfiles=IPDpd,
                        BackgroundFiles=Inputs,
                        genome="Ecoli",
                        genomeBuild="20080805",
                        DB="NCBI",
                        expName="FUR_Dpd_BedInput",
                        format="BEDSE"
                        )
FURdpdBedInputStats
```

```
## $FRiP
## [1] 0.2826046 0.2823270
##
## $sequencingStatitic
##   nonSequenced underBinding overBinding
## 1   0.02254338            0 0.005022041
##
## $motifStatistics
##   skewnessTestRejected decompositionRejected accepted
## 1                   63                    59      192
```

`DetectBindingSitesMotif` function also works with DNA string motifs. In the following example, FUR binding sites in fe2+ condition are detected from ‘GWWTGAGAA’ with 1-mismatch motif. The dataset is generated only for ‘NC\_000913’ build. Therefore, in this example the coordinates of this regions are provided as a ‘GivenRegion’ field. Providing this field ensures that binding sites are only detected in the given regions. This will accelerate the peak calling, and also improve the prediction accuracy.

```
# Granages region for motif search
NC_000913_Coordiante <- GRanges(seqnames=Rle("NC_000913"),
                                ranges = IRanges(1, 4639675))

# ChIP-seq FUR fe datasets binding sites from user provided string motif
# ChIP-seq datasets in bed single end format

FURfeStringInputStats <-
  DetectBindingSitesMotif(motif = "GWWTGAGAA",
                          mismatchNumber = 1,
                          IPfiles=IPFe,
                          BackgroundFiles=Inputs,
                          genome="Ecoli",
                          genomeBuild="20080805",
                          DB= "NCBI",
                          expName="FUR_Fe_StringInput",
                          format="BEDSE",
                          GivenRegion = NC_000913_Coordiante
                          )
FURfeStringInputStats
```

```
## $FRiP
## [1] 0.07620002 0.08057296
##
## $sequencingStatitic
##   nonSequenced underBinding overBinding
## 1   0.02464332            0 0.003891051
##
## $motifStatistics
##   skewnessTestRejected decompositionRejected accepted
## 1                    3                     2       36
```

# 5 Combining binding sites across experiments

`recenterBindingSitesAcrossExperiments` function combines the binding sites of different tissues or conditions into a single count matrix. In the FUR example, at the first step it combines fe2+ and dpd binding sites. At the next step, it recalculates the p-adjusted values. To ensure the high quality of the combined binding site set, an stringent cross-experiment FDR cutoff is applied (default 0.001). The accepted binding sites should fullfill this cutoff at least in one experiment. Another FDR cutoff value (default 0.05) is used to assign binding or non-binding labels to each binding site for each experiment.

```
# Combine FUR binding sites from bed input into one table
corMAT <- recenterBindingSitesAcrossExperiments(
  expLocations=c("FUR_Fe_BedInput","FUR_Dpd_BedInput"),
  experimentNames=c("FUR_Fe","FUR_Dpd"),
  expName="combinedFUR"
  )
corMAT
```

```
##             FUR_Fe     FUR_Fe    FUR_Dpd    FUR_Dpd
## FUR_Fe   1.0000000  0.4077409 -0.4229531 -0.3698326
## FUR_Fe   0.4077409  1.0000000 -0.4667162 -0.4332716
## FUR_Dpd -0.4229531 -0.4667162  1.0000000  0.7168176
## FUR_Dpd -0.3698326 -0.4332716  0.7168176  1.0000000
```

```
FurTable <-
  read.table(file.path("combinedFUR","CombinedMatrix"),
             header = TRUE,
              check.names = FALSE
             )
FurBindingTotal <-
  GRanges(seqnames=Rle(FurTable[,1]),
          ranges = IRanges(FurTable[,2], FurTable[,3])
          )
FurFe <- FurBindingTotal[which((FurTable$FUR_Fe_binding =="Binding")==TRUE)]
FurDpd <- FurBindingTotal[which((FurTable$FUR_Dpd_binding =="Binding")==TRUE)]
findOverlaps(FurFe,FurDpd)
```

```
## Hits object with 107 hits and 0 metadata columns:
##         queryHits subjectHits
##         <integer>   <integer>
##     [1]         1           1
##     [2]         7           5
##     [3]         9           7
##     [4]        10           8
##     [5]        16          10
##     ...       ...         ...
##   [103]       203         187
##   [104]       204         188
##   [105]       205         189
##   [106]       206         190
##   [107]       208         192
##   -------
##   queryLength: 211 / subjectLength: 193
```

`pairwisDifferential` function uses edgeR TMM normalization and GLM test to detect differential binding sites across two experiments. In the following example it takes combined FUR count matrix and detect differential binding sites across fe2+ and dpd.

```
# Differential binding sites across FUR conditions fe vs dpd
diffFUR <- pairwisDifferential(tableOfCountsDir="combinedFUR",
                              exp1="FUR_Fe",
                              exp2="FUR_Dpd",
                              FDRcutoff = 0.05,
                              logFCcuttoff = 1
                              )
FeUp <- diffFUR[[1]]
DpdUp <- diffFUR[[2]]
TotalComparison <- diffFUR[[3]]
head(TotalComparison)
```

```
##    seqnames  start    end      logFC   logCPM         LR      PValue
## 1 NC_000913   8346   8355  0.4029776 11.75436 0.05617941 0.812639754
## 2 NC_000913  58862  58874  7.7338459 11.56870 8.68961311 0.003200285
## 3 NC_000913  70508  70516  5.4870802 11.85314 6.71898657 0.009539182
## 4 NC_000913 111527 111535  5.0433421 11.48656 4.76497503 0.029044481
## 5 NC_000913 146492 146501 -6.8293987 10.81313 5.19342810 0.022672451
## 6 NC_000913 167150 167158 -4.4220524 11.40363 3.72463958 0.053615198
```

# 6 Session Info

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
##  [1] BSgenome.Ecoli.NCBI.20080805_1.3.1000
##  [2] BSgenome.Scerevisiae.UCSC.sacCer3_1.4.0
##  [3] BSgenome_1.78.0
##  [4] rtracklayer_1.70.0
##  [5] BiocIO_1.20.0
##  [6] Biostrings_2.78.0
##  [7] XVector_0.50.0
##  [8] Motif2Site_1.14.0
##  [9] GenomicRanges_1.62.0
## [10] Seqinfo_1.0.0
## [11] IRanges_2.44.0
## [12] S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0
## [14] generics_0.1.4
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            viridisLite_0.4.2
##  [3] dplyr_1.1.4                 farver_2.1.2
##  [5] mixtools_2.0.0.1            S7_0.2.0
##  [7] bitops_1.0-9                lazyeval_0.2.2
##  [9] fastmap_1.2.0               RCurl_1.98-1.17
## [11] GenomicAlignments_1.46.0    XML_3.99-0.19
## [13] digest_0.6.37               lifecycle_1.0.4
## [15] survival_3.8-3              statmod_1.5.1
## [17] kernlab_0.9-33              magrittr_2.0.4
## [19] compiler_4.5.1              rlang_1.1.6
## [21] sass_0.4.10                 tools_4.5.1
## [23] yaml_2.3.10                 data.table_1.17.8
## [25] knitr_1.50                  htmlwidgets_1.6.4
## [27] S4Arrays_1.10.0             curl_7.0.0
## [29] DelayedArray_0.36.0         RColorBrewer_1.1-3
## [31] abind_1.4-8                 BiocParallel_1.44.0
## [33] purrr_1.1.0                 grid_4.5.1
## [35] edgeR_4.8.0                 ggplot2_4.0.0
## [37] scales_1.4.0                MASS_7.3-65
## [39] dichromat_2.0-0.1           tinytex_0.57
## [41] SummarizedExperiment_1.40.0 cli_3.6.5
## [43] rmarkdown_2.30              crayon_1.5.3
## [45] httr_1.4.7                  rjson_0.2.23
## [47] cachem_1.1.0                splines_4.5.1
## [49] parallel_4.5.1              BiocManager_1.30.26
## [51] restfulr_0.0.16             matrixStats_1.5.0
## [53] vctrs_0.6.5                 Matrix_1.7-4
## [55] jsonlite_2.0.0              bookdown_0.45
## [57] magick_2.9.0                locfit_1.5-9.12
## [59] limma_3.66.0                plotly_4.11.0
## [61] tidyr_1.3.1                 jquerylib_0.1.4
## [63] glue_1.8.0                  codetools_0.2-20
## [65] gtable_0.3.6                GenomeInfoDb_1.46.0
## [67] UCSC.utils_1.6.0            tibble_3.3.0
## [69] pillar_1.11.1               htmltools_0.5.8.1
## [71] R6_2.6.1                    evaluate_1.0.5
## [73] lattice_0.22-7              Biobase_2.70.0
## [75] Rsamtools_2.26.0            cigarillo_1.0.0
## [77] segmented_2.1-4             bslib_0.9.0
## [79] Rcpp_1.1.0                  nlme_3.1-168
## [81] SparseArray_1.10.0          xfun_0.53
## [83] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```

# References

Benaglia, T., D. Chauveau, D. R. Hunter, and D. Young. 2009. “mixtools: An R Package for Analyzing Finite Mixture Models.” *Journal of Statistical Software* 32 (6): 1–29. <http://www.jstatsoft.org/v32/i06/>.

Lawrence, M., W. Huber, H. Pagès, P. Aboyoun, M. Carlson, R. Gentleman, M. Morgan, and V. Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Computational Biology* 9 (8). <https://doi.org/10.1371/journal.pcbi.1003118>.

Morgan, M., H. Pagès, V. Obenchain, and N. Hayden. 2020. *Rsamtools: Binary Alignment (Bam), Fasta, Variant Call (Bcf), and Tabix File Import*. <http://bioconductor.org/packages/Rsamtools>.

Pagès, H., P. Aboyoun, R. Gentleman, and S. DebRoy. 2019. *Biostrings: Efficient Manipulation of Biological Strings*.

Pagès, Hervé. 2019. *BSgenome: Software Infrastructure for Efficient Representation of Full Genomes and Their Snps*.

Robinson, M. D., D. J. McCarthy, and G. K. Smyth. 2010. “EdgeR: A Bioconductor Package for Differential Expression Analysis of Digital Gene Expression Data.” *Bioinformatics* 26 (1): 139–40. <https://doi.org/10.1093/bioinformatics/btp616>.

Seo, S. W., D. Kim, H. Latif, and others. 2014. “Deciphering Fur Transcriptional Regulatory Network Highlights Its Complex Role Beyond Iron Metabolism in Escherichia Coli.” *Nature Communications* 5 (1). <https://doi.org/10.1038/ncomms5910>.