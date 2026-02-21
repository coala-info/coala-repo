# cfdnakit vignette

Pitithat Puranachot

#### 29 October 2025

#### Package

cfdnakit 1.8.0

# 1 Introduction

This package provides basic functions for analyzing next-generation sequencing data of cell-free DNA (cfDNA). The package focuses on extracting the length of cfDNA sample and visualization of genome-wide enrichment of short-fragmented cfDNA. The aberration of fragmentation profile, denoted modified ctDNA estimation score (CES), allows quantification of circulating tumor DNA (ctDNA). We recommend using this package to analysis shallow whole-genome sequencing data (~0.3X or more). This package was complemented by Bioconductor packages e.g. QDNAseq, Rsamtools and GenomicRanges which could further expand the functionality of this package in the future.

## 1.1 Installation

### 1.1.1 Install via the Bioconductor repository

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("cfdnakit")
```

### 1.1.2 Install the latest version via github

To install this package is via this github repository, please follow the instruction below.

**Install prerequisites packages**

```
if(! "devtools" %in% rownames(installed.packages()))
    install.packages("devtools")
if(! "BiocManager" %in% rownames(installed.packages()))
    install.packages("BiocManager")
```

**Install cfdnakit package**

```
library(devtools)  ### use devtools
install_github("Pitithat-pu/cfdnakit") ### install cfDNAKit
```

The installation should work fine without non-zero exit status. Try load cfdnakit package into current R session

```
library(cfdnakit) ### Load cfdnakit package
```

# 2 Prepare input BAM

A coordination-sorted BAM file of cfDNA from any liquid biopsy source (e.g. blood-plasma, CSF, urine) should be applicable. You should examine if the sequencing coverage reach coverage threshold before the analysis. Please make sure that the sequencing reads are mapped onto the following version of reference genome. cfdnakit supports the human reference genome GRCh37(hg19) and GRCh38(hg38). Preliminary fragment-length analysis can be performed using mouse cfDNA when mapping onto the mouse reference genome GRCm38(mm10).

# 3 Read the BAM file with read\_bamfile

Let’s read sequence alignment file (.bam) using function **read\_bamfile**. A BAM index file (.bai) is necessary for efficiently reading the file. If it doesn’t exist in the same directory, this function will automatically create one. This function will split sequencing reads into equal-size non-overlapping windows. Possible size of bin are 100, 500, and 1000 KB. A path to the input file is given to the function **read\_bamfile**. A SampleBam object will be created as the result.

For demonstration, we read an example sequence file ex.plasma.bam.

```
library(cfdnakit)
sample_bamfile <- system.file("extdata",
                             "ex.plasma.bam",
                package = "cfdnakit")
plasma_SampleBam <- read_bamfile(sample_bamfile,
                                apply_blacklist = FALSE)
#> The BAM index file (.bai) is missing. Creating an index file
#> Bam index file created.
#> Reading bamfile
```

By default, running read\_bamfile will split reads into 1000 KB non-overlapping bins based-on the human reference genome GRCh37.

Reading the file should take a while depending on the size of your BAM. We recommend to save the result as RDS file using **saveRDS** function.

```
### Optional
saveRDS(plasma_SampleBam, file = "patientcfDNA_SampleBam.RDS")
```

# 4 Analyse the Fragment Length Distribution

Fragment-length distribution of the sample can be visualized with function **plot\_fragment\_dist**. In the top-right legend, the modal length (bp) is shown in the parenthesis behind each sample name. The x-axis is the length of cfDNA; y-axis is the proportion of cfDNA fragment having a specific length.

```
plot_fragment_dist(list("Plasma.Sample"=plasma_SampleBam))
```

This document will demonstate by using SampleBam object (example\_patientcfDNA\_SampleBam.RDS). Now we load this file into R session.

```
example_RDS <- "example_patientcfDNA_SampleBam.RDS"
example_RDS_file <-
    system.file("extdata",example_RDS,
                package = "cfdnakit")
sample_bins <- readRDS(example_RDS_file)
```

In general, plasma cfDNA should show non-random fragmentation pattern. The modal length of cfDNA is 167 bp and 10-bp periodic peaks. However, tumor-derived cfDNA are observed to be shorter (<150 bp) than cfDNA of non-tumor origin. Here, we compare the fragment length distribution of patient’s cfDNA with healthy individual. We derived a healthy cfDNA from Snyder et al. (2016) and create a RData file “BH01\_chr15.RDS”. This file can be loaded in R environment with readRDS function.

```
control_rds<-"BH01_CHR15.SampleBam.rds"
control_RDS_file <-
    system.file("extdata",control_rds,
                package = "cfdnakit")
control_bins <-
    readRDS(control_RDS_file)
```

To provide visual comparison of cell-free DNA fragmentation, cfdnakit provide a function that allows plotting multiple distribution plots. We create a list of SampleBam files and plot their distribution together with function plot\_fragment\_dist. Each element in the list must be given a distinct sample name (e.g. Healthy.cfDNA).

```
comparing_list <- list("Healthy.cfDNA"=control_bins,
                      "Patient.1"=sample_bins)
plot_fragment_dist(comparing_list)
#> Warning: `aes_()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`
#> ℹ The deprecated feature was likely used in the cfdnakit package.
#>   Please report the issue at <https://github.com/Pitithat-pu/cfdnakit/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

**Optional Parameters**

maximum\_length = Maximum length of cfDNA (Default 550)

minimum\_length = Minimum length of cfDNA (Default 20)

# 5 Quantification of Short Fragmented CfDNA

We can extract genome-wide fragment-length profile. First we define the short fragment as fragments having size (by default) between 100 - 150 base and 151 - 250 as the long fragment. Providing a SampleBam object to the function get\_fragment\_profile will return a SampleFragment object.

```
sample_profile <-
  get_fragment_profile(sample_bins,
                       sample_id = "Patient.1")
```

This SampleFragment contains a dataframe named **sample\_profile**. This table contains information about the BAM file and the ratio number of Short/Long fragments. The table below describes important variables.

```
sample_profile$sample_profile
#>   Sample.ID Total.Fragments Read.Pairs.in.range Read.Pairs.in.range..corrected.
#> 1 Patient.1           68094               65421                        62091.41
#>   N.Short N.Long Mode Median   Mean   Mad S.L.Ratio S.L.Ratio_corrected
#> 1   23503  41918  167    159 163.23 20.76      0.56                0.56
#>   Bin.Size.KB.
#> 1         1000
```

| Variable | Description |
| --- | --- |
| Total.Fragments | Number of DNA fragments (not the number of reads) |
| Read.Pairs.in.range | Number of fragments within the defined range (short and long) |
| Mode | Fragment length of the majority (bp) |
| Median | Median Fragment length (bp) |
| Mean | Average Fragment length (bp) |
| Mad | Fragment length median absolute deviation (MAD) |
| N.Short | Number of short fragments (n) |
| N.Long | Number of long fragments (n) |
| S.L.Ratio | N.Short/N.Long; Ratio of short fragment over long fragment |
| S.L.Ratio\_corrected | Ratio of short fragment over long fragment after GC-bias correction |
| Bin.Size.KB. | Size of genomic bin of the analysis (KB) |

# 6 Plot Genome-wide Short-fragmented Ratio

We can plot genome-wide short-fragment ratio with the function plot\_sl\_ratio. Given short-fragment profile, short-fragment ratio per bin infer contribution of circulating tumor DNA (ctDNA) into cfDNA. The enrichment of short-fragment cfDNA in a large genomic region could infer the copy-number aberration status. The higher short-fragment ratio indicate amplification event whereas deletion would have relatively lower short-fragment ratio.

```
## For this demenstration, we load a real patient-derived cfDNA profile.
patient.SampleFragment.file <-
    system.file("extdata",
                "example_patientcfDNA_SampleFragment.RDS",
                package = "cfdnakit")
patient.SampleFragment <- readRDS(patient.SampleFragment.file)
plot_sl_ratio(patient.SampleFragment)
```

![](data:image/png;base64...)

The range of S.L.Ratio is broad. It could be as high as 2 or more in sample with high contribution of ctDNA. Adjusting the plot is possible with parameter **ylim** or with other ggplot functions.

# 7 Save SampleFragment as RDS file

Up to this step, we rather save the SampleFragment object as RDS for later use and for creation of a Panel-of-Normal.

```
destination_dir <- "~/cfdnakit.result"
saveRDS(sample_profile,
        file = paste0(destination_dir,
        "/plasma.SampleFragment.RDS"))
```

# 8 Create Panel of Normal (PoN)

## 8.1 Creating list of PoN files

Making a Panel-of-Normal is necessary for downstream analysis as we want to compare fragment profile between a cfDNA from patient with pooled of healthy individuals. First, we create a text file where each line is a full path to rds file of the SampleFragment object.

**Example content of PoN list file (let’s name it Pon-list.txt)**

```
### Example content of Pon-list.txt
Path.to/SampleFragment_healthyplasma-01.rds
Path.to/SampleFragment_healthyplasma-02.rds
Path.to/SampleFragment_healthyplasma-03.rds
Path.to/SampleFragment_healthyplasma-04.rds
Path.to/SampleFragment_healthyplasma-05.rds
```

## 8.2 Creating a PoN dataset

**create\_PoN** function will read through all fragment profile files and create a set of PoN profile. We save this PoN profile and load into analysis later.

```
PoN.profiles <- create_PoN("Path.to/Pon-list.txt")

saveRDS(PoN.profiles, "PoN.rds")
```

# 9 Inferring CNV from short fragment cfDNA

## 9.1 Normalizing Short-fragmented Ratio

The contribution of short-fragmented cfDNA into genomic regions could infer copy-number aberration harbored in the tumor cells. For this demonstration, we load ready-to-use PoN profile (ex.PoN.rds).

```
PoN_rdsfile <- system.file("extdata",
                          "ex.PoN.rds",
                          package = "cfdnakit")

PoN.profiles <- readRDS(PoN_rdsfile)
```

cfdnakit transforms S.L.Ratio of each genomic windows with the distribution of samples in PoN by function **get\_zscore\_profile**.

```
sample_zscore <-
  get_zscore_profile(patient.SampleFragment,
                     PoN.profiles)
```

## 9.2 Circular Binary Segmentation (CBS)

cfdnakit implement the circular binary segmentation algorithm. Function **segmentByCBS** of package PSCBS were used through function segmentByPSCB. We can visualize both transformed S.L.Ratio and the segmentation by function **plot\_transformed\_sl**.

```
sample_zscore_segment <- segmentByPSCB(sample_zscore)

plot_transformed_sl(sample_zscore,sample_zscore_segment)
```

![](data:image/png;base64...)

**Optional parameters** ylim = Y-axis of plot (Default c(-20,20))

## 9.3 Estimating tumor fraction (TF) and CNV calling

Base on hypothesis that short-fragmented cfDNA originate from tumor cells. Enrichment of short-fragmented cfDNA in a large genomic segments correlates with the absolute copy in the tumor origin. cfdnakit heuristically search for fittest solution per absolute ploidy of 2, 3 and 4. The distance of each solution is calculated similarly to ACE (Poell JB et.al 2019) method.

Function call\_cnv returns 3 solutions of the CNV calling and TF estimation. The analysis perform only on autosomal chromosomes. We can plot the distance matrix of all solution where solutions with \* are optimal solutions (minimum distance) per absolute genome ploidy.

```
sample_cnv <- call_cnv(sample_zscore_segment,sample_zscore)

plot_distance_matrix(sample_cnv)
```

![](data:image/png;base64...)

Function call\_cnv returns 3 solutions of the CNV calling and TF estimation. The analysis perform only on autosomal chromosomes. We can plot the distance matrix of all solution where solutions with \* are optimal solutions (minimum distance) per absolute genome ploidy.

The available solution can be obtained with function **get\_solution\_table**. The table shows the best solution (minimum distance) per absolute genome ploidy and rank them by the distance.

```
solution_table <- get_solution_table(sample_cnv)

solution_table
#>     TF rounded_ploidy ploidy    distance rank
#> 1 0.21              2   2.05 0.006484562    1
#> 2 0.25              3   3.00 0.007383756    2
```

## 9.4 Plot optimal CNV profile

We can plot copy-number result by function plot\_cnv\_solution. By default, this function will produce the plot of the best solution (rank 1) and can be changed by specifying solution number to parameter **selected\_solution**.

```
plot_cnv_solution(sample_cnv,selected_solution = 1)
```

![](data:image/png;base64...)

# 10 Copy-number Abnormality Score

As the result of copy-number solution fitting, the tumor fraction (tf ) indicates the estimated quantity of ctDNA from the amplitude of signals. cfdnakit also implements the ctDNA estimation score (CES) score to quantify the tumor-derived cell-free DNA from the segmentation and the SLRatio.

```
calculate_CES_score(sample_zscore_segment)
#> [1] 122.457
```

This score is robust to coverage bias and noisy fragmented signals. Briefly, the Gaussian noise does not affect the score because the z-scores of segments, instead of the z-score of bins, are considered. Second, the average segment length is used as a penalty for sample quality. The signal of a bad quality sample does not strongly affect the score whereas a true highly unstable genome would overcome this penalty.

# 11 Session info

Output of sessionInfo on the system on which this document was compiled:

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] DNAcopy_1.84.0   future_1.67.0    cfdnakit_1.8.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10          generics_0.1.4       bitops_1.0-9
#>  [4] magrittr_2.0.4       listenv_0.9.1        digest_0.6.37
#>  [7] evaluate_1.0.5       grid_4.5.1           RColorBrewer_1.1-3
#> [10] bookdown_0.45        fastmap_1.2.0        R.oo_1.27.1
#> [13] R.cache_0.17.0       jsonlite_2.0.0       R.utils_2.13.0
#> [16] tinytex_0.57         BiocManager_1.30.26  scales_1.4.0
#> [19] Biostrings_2.78.0    codetools_0.2-20     jquerylib_0.1.4
#> [22] cli_3.6.5            crayon_1.5.3         rlang_1.1.6
#> [25] XVector_0.50.0       Biobase_2.70.0       R.methodsS3_1.8.2
#> [28] parallelly_1.45.1    withr_3.0.2          cachem_1.1.0
#> [31] yaml_2.3.10          tools_4.5.1          parallel_4.5.1
#> [34] BiocParallel_1.44.0  dplyr_1.1.4          ggplot2_4.0.0
#> [37] Rsamtools_2.26.0     globals_0.18.0       BiocGenerics_0.56.0
#> [40] vctrs_0.6.5          R6_2.6.1             magick_2.9.0
#> [43] matrixStats_1.5.0    stats4_4.5.1         lifecycle_1.0.4
#> [46] aroma.light_3.40.0   Seqinfo_1.0.0        S4Vectors_0.48.0
#> [49] IRanges_2.44.0       pkgconfig_2.0.3      pillar_1.11.1
#> [52] bslib_0.9.0          gtable_0.3.6         Rcpp_1.1.0
#> [55] glue_1.8.0           tidyselect_1.2.1     tibble_3.3.0
#> [58] xfun_0.53            GenomicRanges_1.62.0 knitr_1.50
#> [61] dichromat_2.0-0.1    farver_2.1.2         htmltools_0.5.8.1
#> [64] labeling_0.4.3       rmarkdown_2.30       compiler_4.5.1
#> [67] S7_0.2.0             PSCBS_0.68.0
```