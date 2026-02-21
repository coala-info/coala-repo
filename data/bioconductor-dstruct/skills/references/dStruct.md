# Differential RNA structurome analysis using `dStruct`

Krishna Choudhary1\* and Sharon Aviran2

1University of California, San Francisco, USA
2University of California, Davis, USA

\*kchoudhary@ucdavis.edu

#### 29 October 2025

#### Abstract

A large variety of RNA molecules exist in cells. They adopt diverse structures to serve important cellular functions. In the last decade, a number of deep sequencing-based technologies have been developed to study RNA structures at a genome-wide scale, at high resolution, and in vivo or in vitro. These technologies generate large-scale and highly noisy data. A common goal in many studies utilizing such data is to compare RNA structuromes under two or more conditions, and identify RNAs or their regions that may have altered structures between the conditions.

`dStruct`: dStruct is a package meant for **d**ifferential analysis of RNA **Struct**urome profiling data (Choudhary et al. [2019](#ref-choudhary2019dstruct)). It is broadly applicable to all existing technologies for RNA structurome profiling. It accounts for inherent biological variation in structuromes between replicate samples and returns differential regions. Here, we describe the input data format required by dStruct, provide use cases, and discuss options for analysis and visualization.

#### Package

dStruct 1.16.0

---

For details on the methods presented here, consider having a look at our manuscript:

> Choudhary, K., Lai, Y. H., Tran, E. J., & Aviran, S. (2019). dStruct: identifying differentially reactive regions from RNA structurome profiling data. Genome Biology, 20(1), 1-26. doi: [10.1186/s13059-019-1641-3](https://doi.org/10.1186/s13059-019-1641-3)

# Load packages

The following code chunk loads the `dStruct` and `tidyverse` packages. We use `tidyverse` for cleaner code presentation in this vignette.

```
library(dStruct)
library(tidyverse)
```

# 1 Introduction

dStruct is broadly applicable to technologies for RNA structurome profiling, e.g., SHAPE-Seq, Structure-Seq, PARS, SHAPE-MaP, etc. The raw data from these technologies are reads from DNA sequencing platforms. The start sites of read alignment coordinates are adjacent to sites of reactions of ribonucleotides with a structure-probing reagent. For some technologies, the sites of mismatches between reads and the reference genome sequences are sites of reactions, e.g., SHAPE-MaP and DMS-MaPseq. The counts of reads mapping to the nucleotides of an RNA should be tallied and converted to reactivities, which represent the degrees of reactions. The specific steps to process data from sequencing reads to reactivities depend on the structurome profiling technology. For a review on structurome profiling technologies and methods for assessing reactivities, see Choudhary, Deng, and Aviran ([2017](#ref-choudhary2017comparative)).

dStruct takes nucleotide-level normalized reactivities of one or multiple RNAs as input. Currently, the preffered normalization method depends on the RNA structurome profiling technology. We have provided an implementation of the 2-8 % method for normalization (Low and Weeks ([2010](#ref-low2010shape))) via a function named `twoEightNormalize`, which is commonly used to normalize data from technologies such as SHAPE-Seq, Structure-Seq, etc. In the following, we assume that the user has processed the raw reads to obtain normalized reactivities for their RNAs of interest.

# 2 Input data

The input data to dStruct is a `list` object. Each element of the `list` should be a `data.frame` containing normalized reactivities.

## 2.1 Load inbuilt sample data

We have provided two test datasets with this package. These are derived from experiments described in Lai et al. ([2019](#ref-lai2019genome)) and Wan et al. ([2014](#ref-wan2014landscape)). As described in the section on differential analysis below, we use these to illustrate de novo and guided discovery use cases, respectively. To start with, let us examine the data structure required for input.

The Lai et al. data can be loaded as follows.

```
data(lai2019)
```

This adds an object named `lai2019` to the global environment, which can be checked using the following function.

```
ls()
```

```
## [1] "lai2019"
```

`lai2019` is an object of class `list`. Each of the list elements is a `data.frame` containing normalized reactivities.

```
class(lai2019)
```

```
## [1] "list"
```

```
names(lai2019) %>% head()
```

```
## [1] "YJR045C" "YOR383C" "YHL033C" "YMR120C" "YJR009C" "YJL189W"
```

All elements of `lai2019` have the same structure. Let us check one of them.

```
class(lai2019[[1]])
```

```
## [1] "data.frame"
```

```
head(lai2019[["YAL042W"]], n= 20)
```

```
##           A1         A2         A3         B1        B2
## 1         NA         NA         NA         NA        NA
## 2         NA         NA         NA         NA        NA
## 3         NA         NA         NA         NA        NA
## 4         NA         NA         NA         NA        NA
## 5         NA         NA         NA         NA        NA
## 6         NA         NA         NA         NA        NA
## 7         NA         NA         NA         NA        NA
## 8  0.1543654 0.68574419 0.58373375 0.10324931 1.5352021
## 9         NA         NA         NA         NA        NA
## 10 1.4011014 0.74277787 0.78535765 0.00000000 0.8647261
## 11        NA         NA         NA         NA        NA
## 12 0.8934077 0.70739927 0.77902156 1.90763268 0.4470532
## 13 0.2122749 0.04184798 0.08881596 0.43993182 0.0000000
## 14 0.0000000 0.07652060 0.07850023 0.25289521 0.9604754
## 15 0.1638981 0.25520100 0.07795018 0.06206092 0.0000000
## 16 2.3609079 1.26914665 0.37622768 0.26726991 2.5536829
## 17 0.7113571 0.15869237 0.22513679 0.07022696 0.0000000
## 18 0.0000000 0.00000000 0.00000000 0.00000000 0.0000000
## 19 0.2581967 0.00000000 0.18476585 0.01770362 0.4273101
## 20        NA         NA         NA         NA        NA
```

Each row of the above `data.frame` has the reactivity for one nucleotide of the RNA with id `"YAL042W"` and each column is one sample. Consecutive rows must represent consecutive nucleotides. `NA` values represent unavailable reactivities. If the data were generated using base-selective reagents (e.g., DMS used by Lai et al.), `dStruct` expects that the reactivities of unprobed bases have been masked as `NA` before running the differential analysis.

Currently, `dStruct` supports comparisons of samples from two conditions at a time. The prefixes `A` and `B` in the columns of each `data.frame` of `lai2019` stand for the two conditions. It is required that the conditions be labeled as `A` and `B` because `dStruct` will be looking for these internally. The numeric suffixes in the column names are replicate sample numbers. These must start with `1` and increase in steps of 1. If the samples were prepared in batches with each batch having one sample of each group, the corresponding samples should be given the same numeric suffix.

# 3 Differential analysis

Differential analysis can be performed for multiple RNAs in one step or a single RNA at a time. Additionally, we allow for two modes of analysis, one to identify differentially reactive regions de novo, and another called as guided discovery to assess the significance of differences in reactivities in the regions provided by the user.

## 3.1 De novo discovery

The function `dStruct` analyzes reactivity profiles for a single transcript to identify differential regions de novo. Additionally, we provide a wrapper function called `dStructome` which can analyze profiles for multiple transcripts simultaneously. For example, a single transcript, say `YAL042W`, can be analyzed as follows.

```
dStruct(rdf = lai2019[["YAL042W"]],
        reps_A = 3, reps_B = 2,
        batches = TRUE, min_length = 21,
        between_combs = data.frame(c("A3", "B1", "B2")),
        within_combs = data.frame(c("A1", "A2", "A3")),
        ind_regions = TRUE)
```

```
## IRanges object with 5 ranges and 3 metadata columns:
##           start       end     width |        pval     del_d         FDR
##       <integer> <integer> <integer> |   <numeric> <numeric>   <numeric>
##   [1]        19       146       128 | 0.000145679 0.1107181 0.000728395
##   [2]       530       553        24 | 0.071184091 0.0793906 0.071184091
##   [3]       583       632        50 | 0.021902932 0.0174842 0.036504886
##   [4]      1122      1177        56 | 0.036887884 0.0204798 0.046109855
##   [5]      1187      1218        32 | 0.016484691 0.0920271 0.036504886
```

**Input arguments.** The arguments `rdf`, `reps_A` and `reps_B` of the `dStruct` function are required while the others are optional. These take in a `data.frame` with reactivity values, the number of samples of group A (group of wild-type *S. cerevisiae* samples), and the number of samples of group B (group of *dbp2\(\Delta\) S. cerevisiae* samples), respectively. Set `batches` to `TRUE` if the samples were prepared in batches with a paired experiment design, i.e., two samples in each batch – one of each group. `min_length` is the minimum length of a differential region that `dStruct` would search for. For the Lai et al. dataset, we set it to 21 nt because that is the putative length of regions bound by Dbp2, which was the RNA helicase under investigation in their study. As described in our manuscript, `dStruct` performs differential analysis by regrouping the samples in homogeneous and heterogeneous groups and assessing the dissimilarity of reactivity profiles in these groups. The homogeneous groups comprise of samples from the same original group (e.g., A or B) while the heterogeneous groups comprise of samples from both A and B, respectively (see Choudhary et al. ([2019](#ref-choudhary2019dstruct)) for details). Users can explicitly specify these groupings to the `dStruct` function as shown in the example above. Otherwise, `dStruct` would automatically generate the homogeneous and heterogeneous groups. Setting `ind_regions` to `TRUE` requires test for significance of difference in reactivity patterns in individual regions. If it is set to `FALSE` all regions identified within a transcript are tested collectively to obtain significance scores at the level of a transcript.

**Output.** The output is an `IRanges` object with columns giving the start (column titled *start*) and end (column titled *end*) coordinates of the tested regions from the transcript whose reactivity profile is input, *p*-values, medians of nucleotide-wise differences of the between-group and within-group *d* scores (column titled *del\_d*), and the FDR-adjusted *p*-values.

Alternatively, all transcripts in a reactivity list can be analyzed in one step using the wrapper function `dStructome`. By default, `dStructome` spawns multiple processes, which speeds up the analysis by processing transcripts in parallel. This behavior can be changed using the argument `processes` as shown in the following code chunk.

```
res <- dStructome(lai2019, 3, 2, batches= TRUE, min_length = 21,
                  between_combs = data.frame(c("A3", "B1", "B2")),
                  within_combs = data.frame(c("A1", "A2", "A3")),
                  ind_regions = TRUE, processes = 1)
```

This returns the coordinates of regions in transcripts with the corresponding *p*- and FDR-values.

```
head(res)
```

```
## IRanges object with 6 ranges and 4 metadata columns:
##           start       end     width |        pval     del_d           t
##       <integer> <integer> <integer> |   <numeric> <numeric> <character>
##   [1]        15       203       189 | 2.33508e-10 0.0931510     YJR045C
##   [2]       397       450        54 | 5.86849e-03 0.1454283     YJR045C
##   [3]       486       516        31 | 1.07727e-02 0.1392935     YJR045C
##   [4]       540       586        47 | 1.47197e-02 0.1025044     YJR045C
##   [5]      1009      1060        52 | 1.12415e-03 0.0947074     YJR045C
##   [6]      1065      1150        86 | 1.61434e-03 0.0758058     YJR045C
##               FDR
##         <numeric>
##   [1] 2.21833e-08
##   [2] 1.50677e-02
##   [3] 2.17746e-02
##   [4] 2.74190e-02
##   [5] 5.08545e-03
##   [6] 6.66793e-03
```

## 3.2 Guided discovery

The function `dStructGuided` tests for differential reactivity profiles of pre-defined regions. Additionally, the wrapper function `dStructome` can analyze profiles for multiple regions simultaneously when its argument `method = "guided"`.

We illustrate this mode of running `dStruct` using PARS data from Wan et al. ([2014](#ref-wan2014landscape)). We downloaded the data reported in their manuscript and processed it to get PARS scores as described in Choudhary et al. ([2019](#ref-choudhary2019dstruct)). The PARS scores are available with the `dStruct` package and can be loaded as follows.

```
data(wan2014)
```

This adds an object named `wan2014` to the global environment, which can be checked using the following function.

```
ls()
```

```
## [1] "lai2019" "res"     "wan2014"
```

`wan2014` is an object of class `list` and has the same structure as described for Lai et al.’s data above. Each of its elements is a `data.frame` containing PARS scores for an 11 nt region. At its center, each region has a single-nucleotide variant between the two groups of samples (the regions could be defined by users based on other considerations, e.g., regions bound by proteins based on assays such as eCLIP-seq). There are two samples of group A and one of group B.

```
wan2014[[1]]
```

```
##             A1        A2         B1
## 357  3.6080461  4.017427  2.9634741
## 358  2.7955295  4.334984  2.4288433
## 359  3.7938507  3.336283  2.3813066
## 360 -4.6073303 -4.857981 -5.2343042
## 361 -4.1478987 -3.960829 -3.5739914
## 362 -0.3410369 -1.915608 -0.7267698
## 363 -1.1824781 -1.669851 -2.0728629
## 364 -1.6066576 -3.048363 -5.2223924
## 365 -3.1375035 -2.807355 -2.8479969
## 366  3.1375035  1.841302  1.2895066
## 367  3.0356239  2.938599  2.4780473
```

The names of the list elements give a transcript’s ID and the coordinates of its region to be tested.

```
names(wan2014) %>% head()
```

```
## [1] "1__NM_000146__357__367"         "3__NM_015841__2784__2794"
## [3] "2__ENST00000527880.1__281__291" "3__NM_033554__673__683"
## [5] "3__NM_020820__2667__2677"       "3__NM_002473__6909__6919"
```

To test a single region, use `dStructGuided` as follows.

```
dStructGuided(wan2014[[1]],
               reps_A = 2, reps_B = 1)
```

```
##       pval      del_d
## 0.16015625 0.02291958
```

`dStructGuided` returns a *p*-value for significance of differential PARS scores in the input region and the median of nucleotide-wise differences of the between-group and within-group *d* scores. Alternatively, all regions in `wan2014` can be analyzed in one step using the wrapper function `dStructome`.

```
res_predefined_regs <- dStructome(wan2014,
                                  reps_A = 2, reps_B = 1, method = "guided",
                                  processes = 1)
```

This returns a table with the coordinates of regions in transcripts with the corresponding *p*- and FDR-values.

```
head(res_predefined_regs)
```

```
##                                t       pval      del_d        FDR
## 1         1__NM_000146__357__367 0.16015625 0.02291958 0.18017578
## 2 2__ENST00000527880.1__281__291 0.20654297 0.09063676 0.20654297
## 3       3__NM_020820__2667__2677 0.08740234 0.07210989 0.11237444
## 4       1__NM_002482__1624__1634 0.07373047 0.01983767 0.11059570
## 5       3__NM_032855__1812__1822 0.04150391 0.07708277 0.09140625
## 6         2__NM_199440__385__395 0.05078125 0.09179449 0.09140625
```

# 4 Visualizing results

The function `plotDStructurome` takes in a list of `data.frame`s with reactivities and the results from `dStructome` to save a PDF file showing the reactivities in a region. We illustrate this with the result for the `lai2019` data. Let us plot the reactivities for the gene with the lowest FDR value. We can identify it as follows.

```
toPlot <- res@elementMetadata %>%
  data.frame() %$%
  magrittr::extract(t, order(FDR)) %>%
  head(., n = 1)

toPlot
```

```
## [1] "YJR045C"
```

Users may pass the entire reactivity list to `plotDStructurome` and the complete result table. By default, the results are plotted for FDR < 0.05 and \(y\)-axis limits range from 0 to 3. However, this may take some time in case there are a large number of differential regions. Here, we plot the reactivities for the gene in the object `toPlot`.

```
plotDStructurome(rl = lai2019[toPlot],
                  diff_regions = subset(res, t == toPlot),
                  outfile = paste0("DRRs_in_", toPlot),
                  fdr = 0.05,
                  ylim = c(-0.05, 3))
```

```
## NULL
```

This saves a PDF file named “DRRs\_in\_YJR045C.pdf” in the current working directory.

# Session Information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] lubridate_1.9.4  forcats_1.0.1    stringr_1.5.2    dplyr_1.1.4
##  [5] purrr_1.1.0      readr_2.1.5      tidyr_1.3.1      tibble_3.3.0
##  [9] ggplot2_4.0.0    tidyverse_2.0.0  dStruct_1.16.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         generics_0.1.4      stringi_1.8.7
##  [4] lattice_0.22-7      hms_1.1.4           digest_0.6.37
##  [7] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1
## [10] timechange_0.3.0    RColorBrewer_1.1-3  bookdown_0.45
## [13] fastmap_1.2.0       plyr_1.8.9          jsonlite_2.0.0
## [16] BiocManager_1.30.26 scales_1.4.0        jquerylib_0.1.4
## [19] cli_3.6.5           rlang_1.1.6         withr_3.0.2
## [22] cachem_1.1.0        yaml_2.3.10         parallel_4.5.1
## [25] tools_4.5.1         reshape2_1.4.4      tzdb_0.5.0
## [28] BiocGenerics_0.56.0 vctrs_0.6.5         R6_2.6.1
## [31] stats4_4.5.1        zoo_1.8-14          lifecycle_1.0.4
## [34] S4Vectors_0.48.0    IRanges_2.44.0      pkgconfig_2.0.3
## [37] pillar_1.11.1       bslib_0.9.0         gtable_0.3.6
## [40] Rcpp_1.1.0          glue_1.8.0          xfun_0.53
## [43] tidyselect_1.2.1    knitr_1.50          dichromat_2.0-0.1
## [46] farver_2.1.2        htmltools_0.5.8.1   labeling_0.4.3
## [49] rmarkdown_2.30      compiler_4.5.1      S7_0.2.0
```

# References

Choudhary, Krishna, Fei Deng, and Sharon Aviran. 2017. “Comparative and Integrative Analysis of RNA Structural Profiling Data: Current Practices and Emerging Questions.” *Quantitative Biology* 5 (1): 3–24.

Choudhary, Krishna, Yu-Hsuan Lai, Elizabeth J Tran, and Sharon Aviran. 2019. “dStruct: Identifying Differentially Reactive Regions from RNA Structurome Profiling Data.” *Genome Biology* 20 (1): 1–26.

Lai, Yu-Hsuan, Krishna Choudhary, Sara C Cloutier, Zheng Xing, Sharon Aviran, and Elizabeth J Tran. 2019. “Genome-Wide Discovery of DEAD-Box RNA Helicase Targets Reveals RNA Structural Remodeling in Transcription Termination.” *Genetics* 212 (1): 153–74.

Low, Justin T, and Kevin M Weeks. 2010. “SHAPE-Directed RNA Secondary Structure Prediction.” *Methods* 52 (2): 150–58.

Wan, Yue, Kun Qu, Qiangfeng Cliff Zhang, Ryan A Flynn, Ohad Manor, Zhengqing Ouyang, Jiajing Zhang, et al. 2014. “Landscape and Variation of RNA Secondary Structure Across the Human Transcriptome.” *Nature* 505 (7485): 706–9.