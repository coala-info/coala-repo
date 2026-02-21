# hotSPOT-vignette

Sydney Grant, Lei Wei and Gyorgy Paragh

#### 30 October 2025

#### Package

seq.hotSPOT 1.10.0

# Contents

* [1 seq.hotSPOT](#seq.hotspot)
  + [1.0.1 Sydney R. Grant1,2, Lei Wei3, Gyorgy Paragh1,2](#sydney-r.-grant12-lei-wei3-gyorgy-paragh12)
  + [1.1 Introduction](#introduction)
  + [1.2 Installation & Setup](#installation-setup)
  + [1.3 Generation of Amplicon Pool](#generation-of-amplicon-pool)
    - [1.3.1 Dataset](#dataset)
    - [1.3.2 amp\_pool](#amp_pool)
  + [1.4 Forward Selection Sequencing Panel Identifier](#forward-selection-sequencing-panel-identifier)
    - [1.4.1 fw\_hotspot](#fw_hotspot)
  + [1.5 Comprehensive Selection Sequencing Panel Identifier](#comprehensive-selection-sequencing-panel-identifier)
    - [1.5.1 com\_hotspot](#com_hotspot)

# 1 seq.hotSPOT

### 1.0.1 Sydney R. Grant1,2, Lei Wei3, Gyorgy Paragh1,2

1Department of Dermatology, Roswell Park Comprehensive Cancer Center, Buffalo, NY
2Department of Cell Stress Biology, Roswell Park Comprehensive Cancer Center, Buffalo, NY
3Department of Biostatistics and Bioinformatics, Roswell Park Comprehensive Cancer Center, Buffalo, NY

[In detail description of methods and application of seq.hotSPOT](https://www.mdpi.com/2072-6694/15/5/1612)

## 1.1 Introduction

Next generation sequencing is a powerful tool for assessment of mutation burden in both healthy and diseased tissues. However, in order to sufficiently capture mutation burden in clinically healthy tissues, deep sequencing is required. While whole-exome and whole-genome sequencing are popular methods for sequencing cancer samples, it is not economically feasible to sequence large genomic regions at the high depth needed for healthy tissues. Therefore, it is important to identify relevant genomic areas to design targeted sequencing panels.

Currently, minimal resources exist which enable researchers to design their own targeted sequencing panels based on specific biological questions and tissues of interest. seq.hotSPOT may be used in combination with the Bioconductor package `RTCGA.mutations`, which can be used to pull mutation datasets from the TCGA database to be used as input data in seq.hotSPOT functions. This would not only allow users to identify highly mutated regions in cancer of interest, but the package `RTCGA.clinical` may be also used to identify highly mutated regions in subsets of patients with specific clinical features of interest.

seq.hotSPOT provides a resource for designing effective sequencing panels to help improve mutation capture efficacy for ultradeep sequencing projects. Establishing efficient targeted sequencing panels can allow researchers to study mutation burden in tissues at high depth without the economic burden of whole-exome or whole-genome sequencing.

## 1.2 Installation & Setup

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("seq.hotSPOT")
```

Load [*seq.hotSPOT*][]

```
library(seq.hotSPOT)
```

## 1.3 Generation of Amplicon Pool

### 1.3.1 Dataset

The mutation dataset should include two columns containing the chromosome and genomic position of each mutation. The columns should be named “chr” and “pos” respectively. Optionally, the gene names for each mutation may be included under a column named “gene”.

```
data("mutation_data")
head(mutation_data)
#>    chr       pos gene
#> 22   4 126329603 FAT4
#> 23   4 126329653 FAT4
#> 24   4 126329608 FAT4
#> 25   4 126329651 FAT4
#> 26   4 126329633 FAT4
#> 27   4 126329653 FAT4
```

### 1.3.2 amp\_pool

This algorithm searches the mutational dataset (input) for mutational hotspot regions on each chromosome:

1. Starting at the mutation with the lowest chromosomal position (primary mutation), using a modified rank and recovery system, the algorithm searches for the closest neighboring mutation.
2. If the neighboring mutation is less than one amplicon, in distance, away from the primary mutation, the neighboring mutation is included within the hotspot region.
   -This rank and recovery system is repeated, integrating mutations into the hotspot region until the neighboring mutation is greater than or equal to the length of one amplicon in distance, from the primary mutation.
   -Once neighboring mutations equal or exceed one amplicon in distance from the primary mutation, incorporation into the hotspot region, halts incorporation.
3. For hotspots within the one amplicon range, from the lowest to highest mutation location, this area is covered by a single amplicon and added to an amplicon pool, with a unique ID.
   -The center of these single amplicons is then defined by the weighted distribution of mutations.
4. For all hotspots larger than one amplicon, the algorithm examines 5 potential amplicons at each covered mutation in the hotspot:
   -one amplicon directly upstream of the primary mutation
   -one amplicon directly downstream of the primary mutation
   -one amplicon including the mutation at the end of the read and base pairs (amplicon length - 1) upstream
   -one amplicon including the mutation at the beginning of the read and base pairs (amplicon length - 1) downstream
   -one amplicon with the mutation directly in the center.
5. All amplicons generated for each hotspot region of interest, are assigned a unique ID and added to the amplicon pool.

```
amps <- amp_pool(data = mutation_data, amp = 100)
head(amps)
#>   lowerbound upperbound chromosome count id mut_lowerbound mut_upperbound
#> 1    1803511    1803610          4    17  x        1803553        1803564
#> 2    1806007    1806106          4    11  x        1806047        1806066
#> 3    1808912    1809011          4     6  x        1808958        1808970
#> 4  126329597  126329696          4    34  x      126329601      126329700
#> 5    7577035    7577134         17    10  x        7577058        7577127
#> 6    7577498    7577597         17    38  x        7577537        7577569
```

## 1.4 Forward Selection Sequencing Panel Identifier

### 1.4.1 fw\_hotspot

1. Amplicons covering hotspots less than or equal to one amplicon in length, are added to the final sequencing panel dataset.
2. For amplicons covering larger hotspot regions, the algorithm uses a forward selection method to determine the optimal combination of amplicons to use in the sequencing panel:
   -the algorithm first identifies the amplicon containing the highest number of mutations
   -the algorithm then identifies the next amplicon, which contains the highest number of new mutations.
   -this process continues until all mutations are covered by at least one amplicon
3. Each of these amplicons are then added to the final sequencing panel, with their own unique IDs.
4. All amplicons in the final sequencing panel are ranked from highest to lowest based on the number of mutations they cover.
5. The algorithm then calculates the cumulative base-pair length and the cumulative mutations covered by each amplicon.
6. Dependent on the desired length of the targeted panel, a cutoff may be applied to remove all amplicons which fall below a set cumulative length.

```
fw_bins <- fw_hotspot(bins = amps, data = mutation_data, amp = 100, len = 1000, include_genes = TRUE)
head(fw_bins)
#>     Lowerbound Upperbound Chromosome Mutation Count Cumulative Panel Length
#> 6      7577498    7577597         17             38                     100
#> 4    126329597  126329696          4             34                     200
#> 1      1803511    1803610          4             17                     300
#> 102  120512189  120512288          1             13                     400
#> 2      1806007    1806106          4             11                     500
#> 5      7577035    7577134         17             10                     600
#>     Cumulative Mutations   Gene
#> 6                     38   TP53
#> 4                     72   FAT4
#> 1                     89  FGFR3
#> 102                  102 NOTCH2
#> 2                    113  FGFR3
#> 5                    123   TP53
```

## 1.5 Comprehensive Selection Sequencing Panel Identifier

### 1.5.1 com\_hotspot

1. To conserve computational power, the forward selection sequencing panel identifier is run to determine the lowest number of mutations per amplicon (mutation frequency) that need to be included in the predetermined length sequencing panel.
   -any amplicon generated by the algorithm, which is less than this threshold value, will be removed.
2. For the feasible exhaustive selection of amplicon combinations covering hotspot areas larger than the predefined number of amplicons in length, the algorithm breaks these large regions into multiple smaller regions.
   -the amplicons covering these regions are pulled from the amplicon pool, based on their unique IDs.
3. The algorithm finds both the minimum number of amplicons overlap and all positions with this value and identifies the region with the longest continuous spot of minimum value.
   -the region is split at the center of this longest continuous minimum post values and continues the splitting process until all smaller regions are less than the “n” number amplicon length set by the user.
   -As this set number of amplicons decreases, the computation time required also often decreases.
4. All amplicons contained in these bins are added back to the amplicon pool, based on a new unique ID.
5. Amplicons covering hotspots less than or equal to one amplicon length are added to the final sequencing panel dataset.
6. To determine the optimal combination of amplicons for each region, the number of amplicons necessary for full coverage of the bin is calculated.
7. A list is generated of every possible combination of n, number of amplicons, needed. For each combination of amplicons:
   -amplicons that would not meet the threshold of unique mutations are filtered out, and the number of all mutations captured by these amplicons is calculated.
   -the combination of amplicons that yields the highest number of mutations is added to the final sequencing panel.
8. All amplicons in the final sequencing panel are ranked from highest to lowest based on the number of mutations they cover.
9. All amplicons capturing the number of mutations equal to the cutoff are further ranked to favor amplicons that have mutations closer in location to the center of the amplicon.
10. Cumulative base-pair length and cumulative mutations covered by each amplicon are calculated.
    -Depending on the desired length of the targeted panel, a cutoff may be applied to remove all amplicons which fall below a set cumulative length.

```
com_bins <- com_hotspot(fw_panel = fw_bins, bins = amps, data = mutation_data,
                        amp = 100, len = 1000, size = 3, include_genes = TRUE)
head(com_bins)
#>    Lowerbound Upperbound Chromosome Mutation Count Cumulative Panel Length
#> 6     7577498    7577597         17             38                     100
#> 4   126329597  126329696          4             34                     200
#> 1     1803511    1803610          4             17                     300
#> 2     1806007    1806106          4             11                     400
#> 5     7577035    7577134         17             10                     500
#> 47  120497611  120497710          1              8                     600
#>    Cumulative Mutations   Gene
#> 6                    38   TP53
#> 4                    72   FAT4
#> 1                    89  FGFR3
#> 2                   100  FGFR3
#> 5                   110   TP53
#> 47                  118 NOTCH2
```

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
#> [1] seq.hotSPOT_1.10.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] hash_2.2.6.3        digest_0.6.37       R6_2.6.1
#>  [4] bookdown_0.45       fastmap_1.2.0       xfun_0.53
#>  [7] cachem_1.1.0        R.utils_2.13.0      knitr_1.50
#> [10] htmltools_0.5.8.1   rmarkdown_2.30      lifecycle_1.0.4
#> [13] cli_3.6.5           R.methodsS3_1.8.2   sass_0.4.10
#> [16] jquerylib_0.1.4     compiler_4.5.1      R.oo_1.27.1
#> [19] tools_4.5.1         evaluate_1.0.5      bslib_0.9.0
#> [22] yaml_2.3.10         BiocManager_1.30.26 jsonlite_2.0.0
#> [25] rlang_1.1.6
```