# compSPOT-Vignette

Sydney Grant1\*, Ella Sampson1\*\*, Rhea Rodrigues1\*\*\* and Gyorgy Paragh1\*\*\*\*

1Roswell Park Comprehensive Cancer Center

\*sydney.grant@roswellpark.org
\*\*ellasamp@buffalo.edu
\*\*\*RheaCarmelGlen.Rodrigues@roswellpark.org
\*\*\*\*Gyorgy.Paragh@roswellpark.org

#### 29 October 2025

#### Package

compSPOT 1.8.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation & Setup](#installation-setup)
* [3 Example Input Data](#example-input-data)
  + [3.1 Mutation Data](#mutation-data)
  + [3.2 Regions Data](#regions-data)
* [4 Example Workflow](#example-workflow)
  + [4.1 Identifying Mutation Hotspots with find\_hotspots](#identifying-mutation-hotspots-with-find_hotspots)
  + [4.2 Comparison Mutation Hotspot Burden with compare\_groups](#comparison-mutation-hotspot-burden-with-compare_groups)
  + [4.3 EDA of Mutation Hotspot Burden and Personal Risk Factors with compare\_features](#eda-of-mutation-hotspot-burden-and-personal-risk-factors-with-compare_features)

# 1 Introduction

Sydney R. Grant1,2, Ella Sampson1, Rhea Rodrigues1,2, Gyorgy Paragh1,2

1Department of Dermatology, Roswell Park Comprehensive Cancer Center, Buffalo, NY
2Department of Cell Stress Biology, Roswell Park Comprehensive Cancer Center, Buffalo, NY

Clonal cell groups share common mutations within cancer, precancer, and even
clinically normal appearing tissues. The frequency and location of these
mutations may predict prognosis and cancer risk. It has also been well
established that certain genomic regions have increased sensitivity to acquiring
mutations. Mutation-sensitive genomic regions may therefore serve as markers
for predicting cancer risk. This package contains multiple functions to
establish significantly mutated hotspots, compare hotspot mutation burden
between samples, and perform exploratory data analysis of the correlation
between hotspot mutation burden and personal risk factors for cancer, such as
age, gender, and history of carcinogen exposure. This package allows users to
identify robust genomic markers to help establish cancer risk.

Currently, minimal resources exist which enable researchers to design their own
targeted sequencing panels based on specific biological questions and tissues
of interest. `compSPOT` has been designed to work sequentially with Bioconductor
package `seq.hotSPOT`. Highly mutated genomic regions identified by `seq.hotSPOT`
may be used for discovery of significant mutation hotspots with `compSPOT`.
`compSPOT` may also be used to discover differences in hotspot mutation burden
between different groups of interest, and the association of mutation burden with
clinical features. `compSPOT` may be used in combination with the Bioconductor
package `RTCGA.mutations`, which can be used to pull mutation datasets from the
TCGA database to be used as input data in various cancer types. Additionally,
the package `RTCGA.clinical` may be also used to identify highly mutated regions
in subsets of patients with specific clinical features of interest.

# 2 Installation & Setup

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("compSPOT")
```

Load [*compSPOT*][]

```
library(compSPOT)
```

# 3 Example Input Data

## 3.1 Mutation Data

The mutation dataset should include the following columns:
“Chromosome” <– Chromosome number where the mutation is located
“Position” <– Genomic position number where the mutation is located
“Sample” <– Unique ID for each sample in dataset
“Gene” <– Name of the gene which mutation is located in (optional)
“Group” <– Group classification ID (for compare\_groups only)
Clinical Parameters <– (for compare\_features only)

Loading example mutations:

```
data("compSPOT_example_mutations")
```

## 3.2 Regions Data

The regions dataset should include the following columns:
“Chromosome” <– Chromosome number where the region is located
“Lowerbound” <– Genomic position number where the region begins
“Upperbound” <– Genomic position number where the region ends
“Gene” <– Name of the gene which mutation is located in (optional)
“Count” <– Number of mutations in mutation dataset which are found within the
region (optional)

Loading example regions:

```
data("compSPOT_example_regions")
```

# 4 Example Workflow

The compSPOT package contains three main functions for (1) selection of
mutation hotspots (2) comparison of hotspot mutation burden between groups,
and (3) comparison of mutation hotspot enrichment based on clinical and personal
risk factors. All functions return both numerical outputs based on analysis
summary and data visualization components for quick and easy interpretation of
results.

## 4.1 Identifying Mutation Hotspots with find\_hotspots

Our previously published Bioconductor package `seq.hotSPOT`
(doi: 10.3390/cancers15051612) identifies highly mutated genomic regions based
on SNV datasets. While this tool can identify long lists of mutated regions,
we sought to establish a method for identifying which of these genomic regions
have significantly higher mutation frequency compared to others and may be used
as markers of carcinogenic progression.

Methods: This function begins by measuring the mutation frequency for each
unique sample for each provided genomic region. Beginning with the top-ranked
hotspot, a Kolmogorov-Smirnov test is performed on the mutation frequency of
the top genomic region compared to the normalized mutation frequency of all the
lower-ranked regions. This continues, then running the Kolmogorov-Smirnov test
for the normalized mutation frequency of the top 2 genomic regions compared to
the normalized mutation frequency of all lower-ranked regions. This process
repeats itself, continuously adding an additional genomic regions each time
until either the set p-value or empirical distribution threshold is not met.
Once this cutoff has been reached, an established list of mutation hotspots is
provided.

```
significant_spots <- find_hotspots(data = compSPOT_example_mutations,
                                   regions = compSPOT_example_regions,
                                   pvalue = 0.05, threshold = 0.2,
                                   include_genes = TRUE,
                                   rank = TRUE)
```

Table 1. Example output table from find\_hotspots function.
This table is stored in the first position of the output list.

```
head(significant_spots[[1]])
#>    Chromosome Lowerbound Upperbound Count   Gene number  percent    type
#>        <char>      <int>      <int> <int> <char>  <int>    <num>  <char>
#> 1:         17    7578429    7578528     6   TP53      1 19.35484 Hotspot
#> 2:          3  178936041  178936140     6 PIK3CA      2 19.35484 Hotspot
#> 3:          9   21971009   21971108     6 CDKN2A      3 19.35484 Hotspot
#> 4:         17    7577039    7577138     5   TP53      4 16.12903 Hotspot
#> 5:         17    7577496    7577595     5   TP53      5 16.12903 Hotspot
#> 6:         17    7578369    7578468     5   TP53      6 16.12903 Hotspot
#>                           Label
#>                          <char>
#> 1:      TP53 17:7578429-7578528
#> 2: PIK3CA 3:178936041-178936140
#> 3:   CDKN2A 9:21971009-21971108
#> 4:      TP53 17:7577039-7577138
#> 5:      TP53 17:7577496-7577595
#> 6:      TP53 17:7578369-7578468
```

## 4.2 Comparison Mutation Hotspot Burden with compare\_groups

Previously, we have shown mutation hotspots identified using seq.hotSPOT may be
used to differentiate between samples with history of frequent vs infrequent
carcinogen exposure (doi: 10.3390/cancers15051612, doi: 10.3390/ijms24097852).
compare\_groups provides an automated approach for statistical and visual
comparison between mutation enrichment of different groups of interest.

Methods: This function creates a list of mutation frequency per unique sample
for each genomic region separated based on specified sub-groups. The regions
with significant differences in mutation distribution are calculated using a
Kolmogorov-Smirnov test. The difference in mutation frequency is output in a
violin plot.

For this example dataset, the sig.spot function identified 6 hotspots. We will
use these 6 hotspots to compared the mutation burden between Lung Cancer
patients with high- and low-risk of disease progression.

```
hotspots <- subset(significant_spots[[1]], type == "Hotspot")

group_comp <- compare_groups(data = compSPOT_example_mutations,
                             regions = hotspots, pval = 0.05,
                             threshold = 0.2,
                             name1 = "High-Risk",
                             name2 = "Low-Risk",
                             include_genes = TRUE)
```

Table 2. Example output table from compare\_groups function.
This table is stored in the first position of the output list.

```
group_comp[[1]]
#>            D         pval Higher.Group                      Hotspot
#>        <num>        <num>       <char>                       <char>
#> 1: 0.5866667 0.0063168817      Group 1      TP53 17:7578429-7578528
#> 2: 0.7933333 0.0002050847      Group 1 PIK3CA 3:178936041-178936140
```

## 4.3 EDA of Mutation Hotspot Burden and Personal Risk Factors with compare\_features

Mutation enrichment in cancer mutation hotspots has been shown to relate to
personal cancer risk factors such as age, gender, and carcinogen exposure
history and may be used in combination to create predictive models of cancer
risk (doi: 10.3390/ijms24097852). feature.spot provides a baseline analysis of
any set of clinical features to identify trends in the enrichment of mutations
and personal risk factors.

Methods: This function first classifies the features into sequential or
categorical features. Sequential features are compared to the mutation count
using Pearson Correlation. Similarly, in categorical features Wilcox Rank Sum
and Kruska-Wallis Tests are used to compare groups within the features based on
their mutational count.

```
features <- c("AGE", "SEX", "SMOKING_HISTORY", "TUMOR_VOLUME", "KI_67")
feature_example <- compare_features(data = compSPOT_example_mutations,
                                    regions = compSPOT_example_regions,
                                    feature = features)
```

```
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
#> [1] compSPOT_1.8.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] plotly_4.11.0       sass_0.4.10         generics_0.1.4
#>  [4] tidyr_1.3.1         rstatix_0.7.3       digest_0.6.37
#>  [7] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1
#> [10] RColorBrewer_1.1-3  bookdown_0.45       fastmap_1.2.0
#> [13] jsonlite_2.0.0      backports_1.5.0     Formula_1.2-5
#> [16] gridExtra_2.3       BiocManager_1.30.26 httr_1.4.7
#> [19] purrr_1.1.0         crosstalk_1.2.2     viridisLite_0.4.2
#> [22] scales_1.4.0        lazyeval_0.2.2      jquerylib_0.1.4
#> [25] abind_1.4-8         cli_3.6.5           rlang_1.1.6
#> [28] cowplot_1.2.0       withr_3.0.2         cachem_1.1.0
#> [31] yaml_2.3.10         tools_4.5.1         ggsignif_0.6.4
#> [34] dplyr_1.1.4         ggplot2_4.0.0       ggpubr_0.6.2
#> [37] broom_1.0.10        vctrs_0.6.5         R6_2.6.1
#> [40] lifecycle_1.0.4     car_3.1-3           htmlwidgets_1.6.4
#> [43] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
#> [46] gtable_0.3.6        data.table_1.17.8   glue_1.8.0
#> [49] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
#> [52] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2
#> [55] htmltools_0.5.8.1   rmarkdown_2.30      carData_3.0-5
#> [58] labeling_0.4.3      compiler_4.5.1      S7_0.2.0
```