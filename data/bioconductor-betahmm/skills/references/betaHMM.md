# 1 Installation

To install this package, start R (version “4.3”) and enter:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# The following initializes usage of Bioc devel
BiocManager::install(version='devel')

BiocManager::install("betaHMM")
```

# 2 Introduction

DNA methylation, the addition of a methyl group to a cytosine-guanine
dinucleotide (CpG) site, is influenced by environmental factors and serves as a
disease biomarker. In diploid individuals, CpG sites are hypermethylated (both
strands methylated), hypomethylated (neither strand methylated), or
hemimethylated (one strand methylated). Identifying differentially methylated
CpG sites (DMC) and regions (DMR) can reveal the impact of environmental
stressors.

Methylation levels, called beta values, represent the proportion of methylated
probes, usually modeled with beta distributions. They are often logit
transformed into M-values for modeling. To directly model beta values and
account for spatial correlation between CpG sites, we propose a homogeneous
hidden Markov model (HMM) approach called betaHMM. It identifies DMCs and DMRs
while considering spatial dependency and sample relationships. Simulation and
prostate cancer data demonstrate its effectiveness. Through our submission of
betaHMM to Bioconductor, we intend to contribute to the open-source software
ecosystem, supporting robust and reproducible data analysis
for both established and emerging biological assays.

This document gives a quick tour of the functionalities in **betaHMM**. See
`help(package="betaHMM")` for further details and references provided by
`citation("betaHMM")`.

# 3 Walk through

## 3.1 Prerequisites

Before starting the **betaHMM** walk through, the user should have a working
R software environment installed on their machine. The **betaHMM** package has
the following dependencies which, if not already installed on the machine will
automatically be installed along with the package:
**stats, ggplot2, utils, scales, methods, pROC, foreach, doParallel, cowplot,
dplyr, tidyr, stringr**.

Assuming that the user has the **betaHMM** package installed,
the user first needs to load the package:

```
library(betaHMM)
```

## 3.2 Loading the data

## 3.3 Loading the methylation and annotation data

The **betaHMM** software package offers a pre-processed methylation dataset
containing beta values obtained from DNA samples collected from four patients
with high-grade prostate cancer. These samples encompass both benign and tumor
prostate tissues and were subjected to methylation profiling using Infinium
MethylationEPIC Beadchip technology. The dataset comprises DNA samples from
R = 2 treatment conditions for each of N = 4 patients, with each DNA sample
providing beta values for C = 694,820 CpG sites. This data collection was
part of a study on prostate cancer methylomics (Silva et al. 2020). For
testing purposes, a subset of CpG sites from chromosome 7 has been included
in the package.

This package also provides a subset of the EPIC annotation file, which
users need to input into the **betaHMM** function. Users can load these two
datasets from the package and inspect the first six rows in the dataframes
using the following procedure:

```
data(pca_methylation_data)
head(pca_methylation_data)
#>            IlmnID FFPE_benign_1 FFPE_benign_2 FFPE_benign_3 FFPE_benign_4
#> 271510 cg00725145     0.5942203     0.6258024     0.5058501     0.5520584
#> 271511 cg05107246     0.8433906     0.8475270     0.6314132     0.7155429
#> 271512 cg15535638     0.3437175     0.4081485     0.3283133     0.3578261
#> 271513 cg20044143     0.5863234     0.6594629     0.5081511     0.6201563
#> 271514 cg07921164     0.8811453     0.8876218     0.8556576     0.8807811
#> 271515 cg07972624     0.6200234     0.6917817     0.8356504     0.8365774
#>        FFPE_tumour_1 FFPE_tumour_2 FFPE_tumour_3 FFPE_tumour_4
#> 271510     0.4602464     0.5864220     0.5699625     0.5628296
#> 271511     0.7354857     0.6965985     0.7902308     0.7044976
#> 271512     0.3874172     0.5715608     0.4915726     0.4126223
#> 271513     0.4197936     0.6960895     0.6438289     0.7456794
#> 271514     0.8342399     0.8981871     0.8781351     0.7571686
#> 271515     0.8512817     0.8675258     0.8292696     0.6937511
data(annotation_data)
head(annotation_data)
#>         IlmnID Genome_Build CHR   MAPINFO          UCSC_RefGene_Name
#> 54  cg17236668           37   7    933891                    C7orf20
#> 88  cg02552646           37   7  65953949
#> 93  cg12409226           37   7 100076985                    TSC22D4
#> 100 cg00376553           37   7 100073281                    TSC22D4
#> 121 cg00039070           37   7 133167057                EXOC4;EXOC4
#> 127 cg13643060           37   7  95765717 SLC25A13;SLC25A13;SLC25A13
#>               UCSC_RefGene_Accession UCSC_RefGene_Group
#> 54                         NM_015949               Body
#> 88
#> 93                         NM_030935             TSS200
#> 100                        NM_030935               Body
#> 121           NM_021807;NM_001037126          Body;Body
#> 127 NM_014251;NM_001160210;NR_027662     Body;Body;Body
#>        UCSC_CpG_Islands_Name Relation_to_UCSC_CpG_Island
#> 54        chr7:935031-935648                     N_Shore
#> 88
#> 93  chr7:100075303-100075551                     S_Shore
#> 100 chr7:100075303-100075551                     N_Shelf
#> 121
#> 127
```

## 3.4 The betaHMM workflow

The betaHMM model, which is employed to identify DMCs (differentially
methylated CpG sites) and DMRs (differentially methylated regions), consists of
three crucial functions. The entire process is carried out separately for each
chromosome and involves the following steps:

## 3.5 Model parameter estimation

The initial phase of the workflow involves employing the Baum-Welch algorithm
to estimate the model parameters. Subsequently, we apply the Viterbi algorithm
to determine the most probable sequence of hidden states.

```
M <- 3 ## No. of methylation states in a DNA sample type
N <- 4 ## No. of patients
R <- 2 ## No. of treatment conditions
my.seed <- 321 ## set seed for reproducibility

betaHMM_out <- betaHMM(pca_methylation_data,
                                annotation_data,
                                M = 3,
                                N = 4,
                                R = 2,
                                parallel_process = FALSE,
                                seed = my.seed,
                                treatment_group = c("Benign","Tumour"))
```

## 3.6 Summary of model parameters

The resulting output of a call to betaHMM is an S4 object of class
betaHMMResults.

```
class(betaHMM_out)
#> [1] "betaHMMResults"
#> attr(,"package")
#> [1] "betaHMM"
```

The parameters estimated can be displayed using the following S4 methods:

```
## transition matrix estimated for all chromosomes
A(betaHMM_out)
#> $`chr 7`
#>              [,1]       [,2]       [,3]       [,4]       [,5]        [,6]
#>  [1,] 0.563464443 0.30159595 0.02171567 0.05775670 0.01719193 0.003560975
#>  [2,] 0.309176595 0.37144773 0.04563686 0.15721470 0.03832432 0.013790827
#>  [3,] 0.014678238 0.02210834 0.27914989 0.07875379 0.16946328 0.154331183
#>  [4,] 0.060779770 0.13012916 0.11362618 0.38853200 0.06917960 0.043989810
#>  [5,] 0.009254578 0.01275665 0.12016980 0.03810062 0.31401902 0.020499434
#>  [6,] 0.006178354 0.01753161 0.25864344 0.05347247 0.04454113 0.441342903
#>  [7,] 0.008642219 0.02109744 0.03150352 0.13309251 0.22205179 0.007581204
#>  [8,] 0.007778939 0.01579866 0.10164230 0.03379551 0.23464662 0.039059438
#>  [9,] 0.004280800 0.01208498 0.06853067 0.02232936 0.18650997 0.031000600
#>              [,7]       [,8]       [,9]
#>  [1,] 0.004794773 0.01769074 0.01222881
#>  [2,] 0.010722351 0.03687122 0.01681540
#>  [3,] 0.012067699 0.17800292 0.09144466
#>  [4,] 0.072879893 0.07716979 0.04371381
#>  [5,] 0.051637094 0.26953129 0.16403151
#>  [6,] 0.001813682 0.10854337 0.06793305
#>  [7,] 0.420786918 0.10132311 0.05392130
#>  [8,] 0.021503796 0.31350795 0.23226680
#>  [9,] 0.016214745 0.30900249 0.35004638

## Shape parameters estimated for a certain chromosome
phi(betaHMM_out)
#> $sp_1
#> $sp_1$`chr 7`
#>          [,1]     [,2]     [,3]     [,4]      [,5]     [,6]     [,7]     [,8]
#> [1,] 4.655330 3.637389 6.057968 2.130392  8.756417 9.171012 2.976585 21.62786
#> [2,] 5.291346 4.052073 4.326648 2.063767 17.471114 4.574163 6.667445 43.22361
#>          [,9]
#> [1,] 66.98608
#> [2,] 95.94335
#>
#>
#> $sp_2
#> $sp_2$`chr 7`
#>          [,1]     [,2]     [,3]     [,4]     [,5]     [,6]     [,7]     [,8]
#> [1,] 105.2895 38.06930 5.091516 8.264149 3.766216 2.215542 5.996411 3.461735
#> [2,] 131.6684 43.86579 4.208591 5.566511 4.864919 1.942536 4.331857 5.290168
#>          [,9]
#> [1,] 4.524619
#> [2,] 5.633629

## Hidden states assigned to all CpG sites for a certain chromosome
head(hidden_states(betaHMM_out)[["chr 7"]])
#> [1] 5 5 3 3 8 5
```

A summary of the model parameters estimated for each chromosome can be obtained
as below:

```
summary(betaHMM_out)
#> *************************************************
#> betaHMM workflow function: Parameter estimation
#> Number of hidden states estimated:9
#> No. of total CpG sites:38672
#> Number of treatment conditions :2
#> No. of patients in each treatment group:4,4
#> *************************************************
#>
#> Summary of each chromosome analysed
#>
#>  Chromosome Number log-likelihood
#>  "7"               "355810.1"
#>  Prop. of CpG sites in each hidden state
#>  "0.08,0.075,0.121,0.085,0.176,0.067,0.042,0.201,0.153"
```

## 3.7 DMC identification

After estimating the parameters and hidden states, we proceed to calculate the
AUC metric, which quantifies the dissimilarities between the cumulative
distributions estimated for each hidden state within each chromosome. A
user-defined threshold for the AUC metric is then applied to identify the most
differentially methylated hidden states. Additionally, we utilize a
user-defined threshold for the measure of uncertainty regarding membership in
these highly differentially methylated hidden states to pinpoint the most
differentially methylated CpG sites.

To access the dataframe containing information about CpG site locations,
methylation values, hidden state assignments, and a flag indicating DMC status,
you can use the S4 `assay` command.

```
dmc_out <- dmc_identification(betaHMM_out)
dmc_df <- assay(dmc_out)
head(dmc_df)
#>                IlmnID CHR MAPINFO FFPE_benign_1 FFPE_benign_2 FFPE_benign_3
#> cg00725145 cg00725145   7   31006     0.5942203     0.6258024     0.5058501
#> cg05107246 cg05107246   7   31441     0.8433906     0.8475270     0.6314132
#> cg15535638 cg15535638   7   31467     0.3437175     0.4081485     0.3283133
#> cg20044143 cg20044143   7   31497     0.5863234     0.6594629     0.5081511
#> cg07921164 cg07921164   7   36011     0.8811453     0.8876218     0.8556576
#> cg07972624 cg07972624   7   41525     0.6200234     0.6917817     0.8356504
#>            FFPE_benign_4 FFPE_tumour_1 FFPE_tumour_2 FFPE_tumour_3
#> cg00725145     0.5520584     0.4602464     0.5864220     0.5699625
#> cg05107246     0.7155429     0.7354857     0.6965985     0.7902308
#> cg15535638     0.3578261     0.3874172     0.5715608     0.4915726
#> cg20044143     0.6201563     0.4197936     0.6960895     0.6438289
#> cg07921164     0.8807811     0.8342399     0.8981871     0.8781351
#> cg07972624     0.8365774     0.8512817     0.8675258     0.8292696
#>            FFPE_tumour_4 hidden_state DMC
#> cg00725145     0.5628296            5   0
#> cg05107246     0.7044976            5   0
#> cg15535638     0.4126223            3   0
#> cg20044143     0.7456794            3   0
#> cg07921164     0.7571686            8   0
#> cg07972624     0.6937511            5   0
```

## 3.8 Summary of the DMCs identified

```
summary(dmc_out)
#> *************************************************
#> betaHMM workflow function: DMC identification
#> No. of total CpG sites:38672
#> Number of treatment conditions :2
#> No. of patients in each treatment group:4,4
#> Total number of DMCs:1231
#> *************************************************
#>
#>
#> No. of CpG sites and DMCs in each chromosome:
#>  Chromosome Number No. of CpG sites No. of DMCs
#>  "7"               "38672"          "1231"
```

## 3.9 Plot the density estimates of the model parameter estimates

The fitted density estimates, kernel density estimates, and the uncertainty in
the hidden state assignment can be observed using the plot function for the
betaHMM output. Since the parameters are estimated individually for each
chromosome, one can generate plots for each chromosome separately. To specify
the chromosome of interest, the user should utilize the `chromosome` parameter
within the function.

Additionally, the AUC metrics calculated for the hidden states can also be
displayed using the `AUC` parameter. By providing the AUC values obtained
through the `dmc_identification` function as an input parameter, the plot will
depict the AUC metrics corresponding to the selected chromosome in the plot
panels.

```
AUC_chr <- AUC(dmc_out)
plot(betaHMM_out, chromosome = "7", what = "fitted density", AUC = AUC_chr)
```

![](data:image/png;base64...)

The visualization of uncertainties in hidden state estimation is accomplished
using a boxplot. Additionally, users have the option to input the threshold of
uncertainty intended for DMC identification into the plotting function. This
allows for the incorporation of the specified threshold into the visualization
of uncertainties.

```
plot(betaHMM_out, chromosome = "7", what = "uncertainty",
        uncertainty_threshold = 0.2)
```

![](data:image/png;base64...)

## 3.10 DMR identification from DMCs identified

Spatially correlated CpG sites give rise to clusters of CpG sites with similar
methylation states, leading to the formation of biologically significant
regions known as differentially methylated regions (DMRs). To define the number
of adjacent DMCs required to identify a DMR, users can utilize the user-defined
parameter `DMC_count`, which is set to a default value of 2. If no value is
specified, the function automatically identifies regions within a chromosome
containing two or more adjacent DMCs as DMRs.

The DMR location information, along with the DMCs within each DMR, is presented
as an S4 output of class `dmrResults`. Accessing this output can be achieved
using the S4 assay method.

```
dmr_out <- dmr_identification(dmc_out, parallel_process = FALSE)
dmr_df <- assay(dmr_out)
head(dmr_df)
#>             start_CpG    end_CpG DMR_size CHR map_start map_end
#> cg17039461 cg17039461 cg07744114        3   7    641283  641413
#> cg10385101 cg10385101 cg07454365        2   7    707728  707796
#> cg09414673 cg09414673 cg25428297        3   7   1022797 1022841
#> cg17937564 cg17937564 cg06537110        2   7   1250425 1250500
#> cg17790928 cg17790928 cg10260267        2   7   1277790 1278142
#> cg25201047 cg25201047 cg08777421        6   7   1282630 1285084
#>                                                                         DMCs
#> cg17039461                                  cg17039461,cg16304656,cg07744114
#> cg10385101                                             cg10385101,cg07454365
#> cg09414673                                  cg09414673,cg20646556,cg25428297
#> cg17937564                                             cg17937564,cg06537110
#> cg17790928                                             cg17790928,cg10260267
#> cg25201047 cg25201047,cg06507579,cg18090004,cg24846199,cg00338391,cg08777421
```

## 3.11 Summary of the DMRs identified

```
summary(dmr_out)
#> *************************************************
#> betaHMM workflow function: DMR identification
#> Total number of DMRs:265
#> *************************************************
#>
#>
#>
#> Summary of DMRs identified in each chromosome:
#>  Chromosome Number No. of DMRs Average length of DMRs
#>  "7"               "265"       "3.128"
```

## 3.12 Plot to visualise the DMCs and DMRs

The S4 plot method has the capability to utilize the output generated by the
`dmc_identification` function for plotting methylation values along with the
uncertainty associated with being identified as a DMC. To create such plots,
users must provide the starting CpG site’s IlmnID as an input to the
`start_CpG` parameter. Additionally, the `end_CpG` parameter can either take
the IlmnID of the ending CpG site to be plotted or the number of CpG sites
to be plotted, excluding the starting CpG site.

It is worth noting that even though a CpG site may exhibit a very low
uncertainty in being associated with the hidden state identified as the most
differentially methylated, it might not be selected as a DMC if it falls below
the threshold value set by the user.

```
plot(dmc_out, start_CpG = "cg17750844", end_CpG = 15)
```

![](data:image/png;base64...)

## 3.13 Threshold identification in DNA samples belonging to a specific condition

The initialization of the intricate hidden states betaHMM model,
aimed at identifying differentially methylated hidden states across DNA
samples collected from multiple biological conditions, begins with the
utilization of a simpler 3-state betaHMM model for parameter estimation
within a single treatment condition for identifying the 3 known methylation
states (hypomethylation, hemimethylation and hypermethylation). Subsequently,
these estimated parameters are amalgamated to construct the hidden
states parameter model.

The function employed to estimate the 3-state betaHMM also provides an
objective estimation of the threshold methylation value distinguishing the
three methylation states. This function can be executed independently to
analyze the data distribution within DNA samples originating from a single
biological condition.

```
threshold_out <- threshold_identification(pca_methylation_data[,1:5],
                                            package_workflow = FALSE,
                                            annotation_file = annotation_data,
                                            M = 3,
                                            N = 4,
                                            parameter_estimation_only = FALSE,
                                            seed = my.seed)
threshold(threshold_out)
#> $thresholds
#> [1] 0.249 0.786
```

## 3.14 Plotting the results from threshold identification function

```
plot(threshold_out, plot_threshold = TRUE, what = "fitted density")
```

![](data:image/png;base64...)

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] betaHMM_1.6.0               SummarizedExperiment_1.40.0
#>  [3] Biobase_2.70.0              GenomicRanges_1.62.0
#>  [5] Seqinfo_1.0.0               IRanges_2.44.0
#>  [7] S4Vectors_0.48.0            BiocGenerics_0.56.0
#>  [9] generics_0.1.4              MatrixGenerics_1.22.0
#> [11] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] ggplot2_4.0.0       lattice_0.22-7      vctrs_0.6.5
#>  [7] tools_4.5.1         parallel_4.5.1      tibble_3.3.0
#> [10] pkgconfig_2.0.3     Matrix_1.7-4        RColorBrewer_1.1-3
#> [13] S7_0.2.0            lifecycle_1.0.4     compiler_4.5.1
#> [16] farver_2.1.2        stringr_1.5.2       tinytex_0.57
#> [19] codetools_0.2-20    htmltools_0.5.8.1   sass_0.4.10
#> [22] yaml_2.3.10         pillar_1.11.1       jquerylib_0.1.4
#> [25] tidyr_1.3.1         DelayedArray_0.36.0 cachem_1.1.0
#> [28] magick_2.9.0        iterators_1.0.14    abind_1.4-8
#> [31] foreach_1.5.2       tidyselect_1.2.1    digest_0.6.37
#> [34] stringi_1.8.7       dplyr_1.1.4         purrr_1.1.0
#> [37] bookdown_0.45       labeling_0.4.3      cowplot_1.2.0
#> [40] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [43] SparseArray_1.10.0  magrittr_2.0.4      S4Arrays_1.10.0
#> [46] dichromat_2.0-0.1   withr_3.0.2         scales_1.4.0
#> [49] rmarkdown_2.30      XVector_0.50.0      evaluate_1.0.5
#> [52] knitr_1.50          doParallel_1.0.17   rlang_1.1.6
#> [55] Rcpp_1.1.0          glue_1.8.0          BiocManager_1.30.26
#> [58] pROC_1.19.0.1       jsonlite_2.0.0      R6_2.6.1
```