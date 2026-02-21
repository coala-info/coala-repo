# The *exomePeak2* user’s guide

Zhen Wei1,2\* and Jia Meng1,2\*\*

1Department of Biological Sciences, Xi’an Jiaotong-Liverpool University, Suzhou, Jiangsu, 215123, China
2Institute of Integrative Biology, University of Liverpool, L7 8TX, Liverpool, United Kingdom

\*ZhenWei01@xjtlu.edu.cn
\*\*JiaMeng@xjtlu.edu.cn

#### 2020-04-28

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Peak Calling](#peak-calling)
* [4 Differential Modification Analysis](#differential-modification-analysis)
* [5 Quantification and Statistical Analysis with Single Based Modification Annotation](#quantification-and-statistical-analysis-with-single-based-modification-annotation)
* [6 Peak Calling and Visualization in Multiple Steps](#peak-calling-and-visualization-in-multiple-steps)
* [7 Contact](#contact)
* [8 Session Info](#session-info)

# 1 Introduction

**exomePeak2** provides bias awared quantification and peak detection on Methylated RNA immunoprecipitation sequencing data (**MeRIP-Seq**). *MeRIP-Seq* is a commonly applied sequencing technology to measure the transcriptome-wide location and abundance of RNA modification sites under a given cellular condition. However, the quantification and peak calling in *MeRIP-Seq* are sensitive to PCR amplification bias which is prevalent in next generation sequencing (NGS) techniques. In addition, the **RNA-Seq** based count data exhibits biological variation in small reads count. *exomePeak2* collectively address these challanges by introducing a rich set of robust data science models tailored for MeRIP-Seq. With *exomePeak2*, users can perform peak calling, modification site quantification, and differential analysis with a straightforward one-step function. Alternatively, users could define personalized methods for their own analysis through multi-step functions and diagnostic plots.

# 2 Installation

To install exomePeak2 from bioconductor, sart R (version >“3.6”) and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("exomePeak2")
```

For order versions of R, please refer to the appropriate [Bioconductor release](<https://www.bioconductor.org/about/release-announcements/>}.

# 3 Peak Calling

For peak calling of *MeRIP-Seq* experiment, exomePeak2 demands the reads alignment results in **BAM** files. Users can specify the biological replicates of the IP and input samples by a character vector of the corresponding **BAM** directories at the arguments `bam_ip` and `bam_input` separately.

In the following example, the transcript annotation is provided using GFF files. Transcript annotation can also be provided by the `TxDb` object. exomePeak2 will automatically download the TxDb if the `genome` argument is filled with the corresponding UCSC genome name.

The genome sequence is required to conduct GC content bias correction. If the `genome` argument is missing ( `= NULL` ), exomPeak2 will perform peak calling without correcting the GC content bias.

```
library(exomePeak2)

set.seed(1)

GENE_ANNO_GTF = system.file("extdata", "example.gtf", package="exomePeak2")

f1 = system.file("extdata", "IP1.bam", package="exomePeak2")
f2 = system.file("extdata", "IP2.bam", package="exomePeak2")
f3 = system.file("extdata", "IP3.bam", package="exomePeak2")
f4 = system.file("extdata", "IP4.bam", package="exomePeak2")
IP_BAM = c(f1,f2,f3,f4)

f1 = system.file("extdata", "Input1.bam", package="exomePeak2")
f2 = system.file("extdata", "Input2.bam", package="exomePeak2")
f3 = system.file("extdata", "Input3.bam", package="exomePeak2")
INPUT_BAM = c(f1,f2,f3)

exomePeak2(bam_ip = IP_BAM,
           bam_input = INPUT_BAM,
           gff_dir = GENE_ANNO_GTF,
           genome = "hg19",
           paired_end = FALSE)
## class: SummarizedExomePeak
## dim: 31 7
## metadata(0):
## assays(2): counts GCsizeFactors
## rownames(31): peak_11 peak_13 ... control_13 control_14
## rowData names(2): GC_content feature_length
## colnames(7): IP1.bam IP2.bam ... Input2.bam Input3.bam
## colData names(3): design_IP design_Treatment sizeFactor
```

exomePeak2 will export the modification peaks in formats of **BED** file and **CSV** table, the data will be saved automatically under a folder named by `exomePeak2_output`.

The modification peak statistics are derived from the \({\beta}\_{i,1}\) terms in the following linear regression design.

\[log2(Q\_{i,j}) = {\beta}\_{i,0} + {\beta}\_{i,1}I(\rho(j)=IP) + t\_{i,j}\]

\(Q\_{i,j}\) is the expected value of reads abundence of modification \(i\) under sample \(j\). \({\beta}\_{i,0}\) is the intercept coefficient, \({\beta}\_{i,1}\) is the coefficient for IP/input log2 fold change, \(I(\rho(j)=IP)\) is the regression covariate that is the indicator variable for the sample \(j\) being IP sample. \(t\_{i,j}\) is the regression offset that account for the sequencing depth variation and the GC content biases.

Under the default settings, the linear models fitted are the regularized **GLM (Generalized Linear Model)** of NB developed by **DESeq2**. If one of the IP and input group has no biological replicates, Poisson GLMs will be fitted to the modification peaks.

Explaination over the columns of the exported table:

* ***chr***: the chromosomal name of the peak.
* ***chromStart***: the start of the peak on the chromosome.
* ***chromEnd***: the end of the peak on the chromosome.
* ***name***: the unique ID of the modification peak.
* ***score***: the -log2 p value of the peak.
* ***strand***: the strand of the peak on genome.
* ***thickStart***: the start position of the peak.
* ***thickEnd***: the end position of the peak.
* ***itemRgb***: the column for the RGB encoded color in BED file visualization.
* ***blockCount***: the block (exon) number within the peak.
* ***blockSizes***: the widths of blocks.
* ***blockStarts***: the start positions of blocks.
* ***geneID***: the gene ID of the peak.
* ***ReadsCount.input***: the reads count of the input sample.
* ***ReadsCount.IP***: the reads count of the IP sample.
* ***log2FoldChange***: the estimates of IP over input log2 fold enrichment (coefficient estimates of \({\beta}\_{i,1}\)).
* ***pvalue***: the Wald test p value on the modification coefficient.
* ***padj***: the adjusted Wald test p value using BH approach.

# 4 Differential Modification Analysis

The code below could conduct differential modification analysis (Comparison of Two Conditions) on exon regions defined by the transcript annotation.

In differential modification mode, exomePeak2 will first perform Peak calling on exon regions using both the control and treated samples. Then, it will conduct the differential modification analysis on peaks reported from peak calling using an interactive GLM.

```
f1 = system.file("extdata", "treated_IP1.bam", package="exomePeak2")
TREATED_IP_BAM = c(f1)
f1 = system.file("extdata", "treated_Input1.bam", package="exomePeak2")
TREATED_INPUT_BAM = c(f1)

exomePeak2(bam_ip = IP_BAM,
           bam_input = INPUT_BAM,
           bam_treated_input = TREATED_INPUT_BAM,
           bam_treated_ip = TREATED_IP_BAM,
           gff_dir = GENE_ANNO_GTF,
           genome = "hg19",
           paired_end = FALSE)
## Warning in glmDM(sep, LFC_shrinkage = LFC_shrinkage, glm_type = glm_type): At least one of the IP or input group has no replicates. Quantification method changed to Poisson GLM.
## class: SummarizedExomePeak
## dim: 23 9
## metadata(0):
## assays(2): counts GCsizeFactors
## rownames(23): peak_10 peak_11 ... control_5 control_6
## rowData names(2): GC_content feature_length
## colnames(9): IP1.bam IP2.bam ... treated_IP1.bam treated_Input1.bam
## colData names(3): design_IP design_Treatment sizeFactor
```

In differential modification mode, exomePeak2 will export the differential modification peaks in formats of **BED** file and **CSV** table, the data will also be saved automatically under a folder named by `exomePeak2_output`.

The peak statistics in differential modification setting are derived from the interactive coefficient \({\beta}\_{i,3}\) in the following regression design of the **NB GLM**:

\[log2(Q\_{i,j}) = {\beta}\_{i,0} + {\beta}\_{i,1}I(\rho(j)=IP) + {\beta}\_{i,2}I(\rho(j)=Treatment) + {\beta}\_{i,3}I(\rho(j)=IP\&Treatment) + t\_{i,j}\]

Explaination for the additional table columns:

* ***ModLog2FC\_control***: the modification log2 fold enrichment in the control condition.
* ***ModLog2FC\_treated***: the modification log2 fold enrichment in the treatment condition.
* ***DiffModLog2FC***: the log2 Fold Change estimates of differential modification (coefficient estimates of \({\beta}\_{i,3}\)).
* ***pvalue***: the Wald test p value on the differential modification coefficient.
* ***padj***: the adjusted Wald test p value using BH approach.

# 5 Quantification and Statistical Analysis with Single Based Modification Annotation

exomePeak2 supports the modification quantification and differential modification analysis on single based modification annotation. The modification sites with single based resolution can provide a more accurate mapping of modification locations compared with the peaks called directly from the MeRIP-seq datasets.

Some of the datasets in epitranscriptomics have a single based resolution, e.x. Data generated by the *m6A-CLIP-Seq* or *m6A-miCLIP-Seq* techniques. Reads count on the single based modification sites could provide a more accurate and consistent quantification on *MeRIP-Seq* experiments due to the elimination of the technical variation introduced by the feature lengths.

exomePeak2 will automatically initiate the mode of single based modification quantification by providing a sigle based annotation file under the argument `mod_annot`.

The single based annotation information should be provided to the exomePeak2 function in the format of a `GRanges` object.

```
f2 = system.file("extdata", "mod_annot.rds", package="exomePeak2")

MOD_ANNO_GRANGE <- readRDS(f2)

exomePeak2(bam_ip = IP_BAM,
           bam_input = INPUT_BAM,
           gff_dir = GENE_ANNO_GTF,
           genome = "hg19",
           paired_end = FALSE,
           mod_annot = MOD_ANNO_GRANGE)
## class: SummarizedExomePeak
## dim: 171 7
## metadata(0):
## assays(2): '' GCsizeFactors
## rownames(171): peak_1 peak_2 ... control_83 control_84
## rowData names(2): GC_content feature_length
## colnames(7): IP1.bam IP2.bam ... Input2.bam Input3.bam
## colData names(3): design_IP design_Treatment sizeFactor
```

In this mode, exomePeak2 will export the analysis result also in formats of **BED** file and **CSV** table, while each row of the table corresponds to the sites of the annotation `GRanges`.

# 6 Peak Calling and Visualization in Multiple Steps

The exomePeak2 package can achieve peak calling and peak statistics calulation with multiple functions.

**1. Check the bam files of MeRIP-seq data before peak calling.**

```
MeRIP_Seq_Alignment <- scanMeripBAM(
                         bam_ip = IP_BAM,
                         bam_input = INPUT_BAM,
                         paired_end = FALSE
                        )
```

For MeRIP-seq experiment with interactive design (contain control and treatment groups), use the following code.

```
MeRIP_Seq_Alignment <- scanMeripBAM(
    bam_ip = IP_BAM,
    bam_input = INPUT_BAM,
    bam_treated_input = TREATED_INPUT_BAM,
    bam_treated_ip = TREATED_IP_BAM,
    paired_end = FALSE
  )
```

**2. Conduct peak calling analysis on exons using the provided bam files.**

```
SummarizedExomePeaks <- exomePeakCalling(merip_bams = MeRIP_Seq_Alignment,
                                         gff_dir = GENE_ANNO_GTF,
                                         genome = "hg19")
```

Alternatively, use the following code to quantify MeRIP-seq data on single based modification annotation.

```
SummarizedExomePeaks <- exomePeakCalling(merip_bams = MeRIP_Seq_Alignment,
                                         gff_dir = GENE_ANNO_GTF,
                                         genome = "hg19",
                                         mod_annot = MOD_ANNO_GRANGE)
```

**3. Estimate size factors that are required for GC content bias correction.**

```
SummarizedExomePeaks <- normalizeGC(SummarizedExomePeaks)
```

**4. Report the statistics of modification peaks using Generalized Linear Model (GLM).**

```
SummarizedExomePeaks <- glmM(SummarizedExomePeaks)
```

Alternatively, If the treated IP and input bam files are provided, `glmDM` function could be used to conduct differential modification analysis on modification Peaks with interactive GLM.

```
SummarizedExomePeaks <- glmDM(SummarizedExomePeaks)
## Warning in glmDM(SummarizedExomePeaks): At least one of the IP or input group has no replicates. Quantification method changed to Poisson GLM.
```

**5. Generate the scatter plot between GC content and log2 Fold Change (LFC).**

```
plotLfcGC(SummarizedExomePeaks)
```

![](data:image/png;base64...)

**6. Generate the bar plot for the sequencing depth size factors.**

```
plotSizeFactors(SummarizedExomePeaks)
```

![](data:image/png;base64...)

**7. Export the modification peaks and the peak statistics with user decided format.**

```
exportResults(SummarizedExomePeaks, format = "BED")
```

# 7 Contact

Please contact the maintainer of exomePeak2 if you have encountered any problems:

**ZhenWei** : zhen.wei01@xjtlu.edu.cn

Please visit the github page of exomePeak2:

<https://github.com/ZhenWei10/exomePeak2>

# 8 Session Info

```
sessionInfo()
## R version 4.0.0 (2020-04-24)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
##  [1] splines   parallel  stats4    stats     graphics  grDevices utils
##  [8] datasets  methods   base
##
## other attached packages:
##  [1] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.56.0
##  [3] rtracklayer_1.48.0                Biostrings_2.56.0
##  [5] XVector_0.28.0                    exomePeak2_1.0.0
##  [7] cqn_1.34.0                        quantreg_5.55
##  [9] SparseM_1.78                      preprocessCore_1.50.0
## [11] nor1mix_1.3-0                     mclust_5.4.6
## [13] SummarizedExperiment_1.18.0       DelayedArray_0.14.0
## [15] matrixStats_0.56.0                Biobase_2.48.0
## [17] GenomicRanges_1.40.0              GenomeInfoDb_1.24.0
## [19] IRanges_2.22.0                    S4Vectors_0.26.0
## [21] BiocGenerics_0.34.0               BiocStyle_2.16.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-6             bit64_0.9-7              RColorBrewer_1.1-2
##  [4] progress_1.2.2           httr_1.4.1               numDeriv_2016.8-1.1
##  [7] tools_4.0.0              R6_2.4.1                 DBI_1.1.0
## [10] colorspace_1.4-1         apeglm_1.10.0            tidyselect_1.0.0
## [13] prettyunits_1.1.1        DESeq2_1.28.0            curl_4.3
## [16] bit_1.1-15.2             compiler_4.0.0           labeling_0.3
## [19] bookdown_0.18            scales_1.1.0             mvtnorm_1.1-0
## [22] genefilter_1.70.0        askpass_1.1              rappdirs_0.3.1
## [25] stringr_1.4.0            digest_0.6.25            Rsamtools_2.4.0
## [28] rmarkdown_2.1            pkgconfig_2.0.3          htmltools_0.4.0
## [31] bbmle_1.0.23.1           dbplyr_1.4.3             RMariaDB_1.0.8
## [34] rlang_0.4.5              RSQLite_2.2.0            farver_2.0.3
## [37] BiocParallel_1.22.0      dplyr_0.8.5              RCurl_1.98-1.2
## [40] magrittr_1.5             GenomeInfoDbData_1.2.3   Matrix_1.2-18
## [43] Rcpp_1.0.4.6             munsell_0.5.0            lifecycle_0.2.0
## [46] stringi_1.4.6            yaml_2.2.1               MASS_7.3-51.6
## [49] zlibbioc_1.34.0          plyr_1.8.6               BiocFileCache_1.12.0
## [52] grid_4.0.0               blob_1.2.1               bdsmatrix_1.3-4
## [55] crayon_1.3.4             lattice_0.20-41          GenomicFeatures_1.40.0
## [58] annotate_1.66.0          hms_0.5.3                magick_2.3
## [61] locfit_1.5-9.4           knitr_1.28               pillar_1.4.3
## [64] reshape2_1.4.4           geneplotter_1.66.0       biomaRt_2.44.0
## [67] XML_3.99-0.3             glue_1.4.0               evaluate_0.14
## [70] BiocManager_1.30.10      vctrs_0.2.4              MatrixModels_0.4-1
## [73] openssl_1.4.1            gtable_0.3.0             purrr_0.3.4
## [76] assertthat_0.2.1         emdbook_1.3.12           ggplot2_3.3.0
## [79] xfun_0.13                xtable_1.8-4             coda_0.19-3
## [82] survival_3.1-12          tibble_3.0.1             GenomicAlignments_1.24.0
## [85] AnnotationDbi_1.50.0     memoise_1.1.0            ellipsis_0.3.0
```