Code

* Show All Code
* Hide All Code

# Guide to Spatial Registration

Louise Huuki-Myers1\*

1Lieber Institute for Brain Development

\*lahuuki@gmail.com

#### 4 November 2025

#### Package

spatialLIBD 1.22.0

# 1 What is Spatial Registration?

Spatial Registration is an analysis that compares the gene expression of groups
in a query RNA-seq data set (typically spatially resolved RNA-seq or single cell RNA-seq) to
groups in a reference spatially resolved RNA-seq data set (such annotated anatomical features).

For spatial data, this can be helpful to compare manual annotations,
or annotating clusters. For scRNA-seq data it can check if
a cell type might be more concentrated in one area or anatomical feature of the
tissue.

The spatial annotation process correlates the \(t\)-statistics from the gene enrichment
analysis between spatial features from the reference data set, with the \(t\)-statistics
from the gene enrichment of features in the query data set. Pairs with high
positive correlation show where similar patterns of gene expression are occurring
and what anatomical feature the new spatial feature or cell population may map to.

## 1.1 Overview of the Spatial Registration method

1. Perform gene set enrichment analysis between spatial features (ex. anatomical
   features, histological layers) on reference spatial data set. Or access existing statistics.
2. Perform gene set enrichment analysis between features (ex. new
   annotations, data-driven clusters) on new query data set.
3. Correlate the \(t\)-statistics between the reference and query features.
4. Annotate new spatial features with the most strongly associated reference feature.
5. Plot correlation heat map to observe patterns between the two data sets.

![Spatial Registration Overview](data:image/png;base64... "fig:")

# 2 How to run Spatial Registration with `spatialLIBD` tools

## 2.1 Introduction.

In this example we will utilize the human DLPFC 10x Genomics Visium dataset
from Maynard, Collado-Torres et al. (Maynard, Collado-Torres, Weber et al., 2021) as the **reference**.
This data contains manually annotated features: the **six cortical layers + white matter**
present in the DLPFC. We will use the pre-calculated enrichment statistics for the
layers, which are available from *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)*.

![Dotplot of sample from refernce DLPFC data, colored by annotated layers](data:image/png;base64... "fig:")

The **query** dataset will be the DLPFC single nucleus RNA-seq (snRNA-seq) data from (Tran, Maynard, Spangler, Huuki, Montgomery, Sadashivaiah, Tippani, Barry, Hancock, Hicks, Kleinman, Hyde, Collado-Torres, Jaffe, and Martinowich, 2021).

We will compare the gene expression in the cell type populations of the **query**
dataset to the annotated **layers** in the **reference**.

## 2.2 Important Notes

### 2.2.1 Required knowledge

It may be helpful to review *Introduction to spatialLIBD* vignette available through [GitHub](http://research.libd.org/spatialLIBD/articles/spatialLIBD.html) or [Bioconductor](https://bioconductor.org/packages/spatialLIBD) for more information about this data set and R package.

### 2.2.2 Citing `spatialLIBD`

We hope that *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("spatialLIBD")
#> To cite package 'spatialLIBD' in publications use:
#>
#>   Pardo B, Spangler A, Weber LM, Hicks SC, Jaffe AE, Martinowich K, Maynard KR, Collado-Torres L (2022).
#>   "spatialLIBD: an R/Bioconductor package to visualize spatially-resolved transcriptomics data." _BMC
#>   Genomics_. doi:10.1186/s12864-022-08601-w <https://doi.org/10.1186/s12864-022-08601-w>,
#>   <https://doi.org/10.1186/s12864-022-08601-w>.
#>
#>   Maynard KR, Collado-Torres L, Weber LM, Uytingco C, Barry BK, Williams SR, II JLC, Tran MN, Besich Z,
#>   Tippani M, Chew J, Yin Y, Kleinman JE, Hyde TM, Rao N, Hicks SC, Martinowich K, Jaffe AE (2021).
#>   "Transcriptome-scale spatial gene expression in the human dorsolateral prefrontal cortex." _Nature
#>   Neuroscience_. doi:10.1038/s41593-020-00787-0 <https://doi.org/10.1038/s41593-020-00787-0>,
#>   <https://www.nature.com/articles/s41593-020-00787-0>.
#>
#>   Huuki-Myers LA, Spangler A, Eagles NJ, Montgomergy KD, Kwon SH, Guo B, Grant-Peters M, Divecha HR,
#>   Tippani M, Sriworarat C, Nguyen AB, Ravichandran P, Tran MN, Seyedian A, Consortium P, Hyde TM, Kleinman
#>   JE, Battle A, Page SC, Ryten M, Hicks SC, Martinowich K, Collado-Torres L, Maynard KR (2024). "A
#>   data-driven single-cell and spatial transcriptomic map of the human prefrontal cortex." _Science_.
#>   doi:10.1126/science.adh1938 <https://doi.org/10.1126/science.adh1938>,
#>   <https://doi.org/10.1126/science.adh1938>.
#>
#>   Kwon SH, Parthiban S, Tippani M, Divecha HR, Eagles NJ, Lobana JS, Williams SR, Mark M, Bharadwaj RA,
#>   Kleinman JE, Hyde TM, Page SC, Hicks SC, Martinowich K, Maynard KR, Collado-Torres L (2023). "Influence
#>   of Alzheimer’s disease related neuropathology on local microenvironment gene expression in the human
#>   inferior temporal cortex." _GEN Biotechnology_. doi:10.1089/genbio.2023.0019
#>   <https://doi.org/10.1089/genbio.2023.0019>, <https://doi.org/10.1089/genbio.2023.0019>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>, bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

## 2.3 Setup

### 2.3.1 Install `spatialLIBD`

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("spatialLIBD")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

### 2.3.2 Load required packages

```
library("spatialLIBD")
library("SingleCellExperiment")
```

## 2.4 Download Data

### 2.4.1 Spatial Reference

The reference data is easily accessed through *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)*. The modeling results
for the annotated layers is already calculated and can be accessed with the `fetch_data()` function.

This data contains the results form three models (anova, enrichment, and pairwise),
we will use the **enrichment** results for spatial registration. The tables contain the
\(t\)-statistics, p-values, and gene ensembl ID and symbol.

```
## get reference layer enrichment statistics
layer_modeling_results <- fetch_data(type = "modeling_results")
#> 2025-11-04 11:47:01.607958 loading file /home/biocbuild/.cache/R/BiocFileCache/195c812bb20746_Human_DLPFC_Visium_modeling_results.Rdata%3Fdl%3D1

layer_modeling_results$enrichment[1:5, 1:5]
#>    t_stat_WM t_stat_Layer1 t_stat_Layer2 t_stat_Layer3 t_stat_Layer4
#> 1 -0.6344143    -1.0321320     0.1781501   -0.72835965    1.56703859
#> 2 -2.4758891     1.2232062    -0.8733745    1.93793650    1.33150141
#> 3 -3.0079360    -0.8564572     2.1335852    0.48741121    0.35212807
#> 4 -1.2916584    -0.9494234    -0.9485440    0.56378302   -0.11206713
#> 5  2.3175897     0.6156900     0.1127478   -0.09907566   -0.03376771
```

### 2.4.2 Query Data: snRNA-seq

For the query data set, we will use the public single nucleus RNA-seq (snRNA-seq)
data from (Tran, Maynard, Spangler et al., 2021) can be accessed on [github](https://github.com/LieberInstitute/10xPilot_snRNAseq-human#processed-data).

This data is also from postmortem human brain DLPFC, and contains gene
expression data for 11k nuclei and 19 cell types.

We will use `BiocFileCache()` to cache this data. It is stored as a `SingleCellExperiment`
object named `sce.dlpfc.tran`, and takes 1.01 GB of RAM memory to load.

```
# Download and save a local cache of the data available at:
# https://github.com/LieberInstitute/10xPilot_snRNAseq-human#processed-data
bfc <- BiocFileCache::BiocFileCache()
url <- paste0(
    "https://libd-snrnaseq-pilot.s3.us-east-2.amazonaws.com/",
    "SCE_DLPFC-n3_tran-etal.rda"
)
local_data <- BiocFileCache::bfcrpath(url, x = bfc)

load(local_data, verbose = TRUE)
#> Loading objects:
#>   sce.dlpfc.tran
```

DLPFC tissue consists of many cell types, some are quite rare and will not have enough data to complete the analysis

```
table(sce.dlpfc.tran$cellType)
#>
#>      Astro    Excit_A    Excit_B    Excit_C    Excit_D    Excit_E    Excit_F    Inhib_A    Inhib_B    Inhib_C
#>        782        529        773        524        132        187        243        333        454        365
#>    Inhib_D    Inhib_E    Inhib_F Macrophage      Micro      Mural      Oligo        OPC      Tcell
#>        413          7          8         10        388         18       5455        572          9
```

The data will be pseudo-bulked over `donor` x `cellType`, it is recommended to drop
groups with < 10 nuclei (this is done automatically in the pseudobulk step).

```
table(sce.dlpfc.tran$donor, sce.dlpfc.tran$cellType)
#>
#>          Astro Excit_A Excit_B Excit_C Excit_D Excit_E Excit_F Inhib_A Inhib_B Inhib_C Inhib_D Inhib_E Inhib_F
#>   donor1   371     111      75      44      22      77     102      39      98      47     119       2       0
#>   donor2   137     120     154     155      27      25      36      89     106      56      78       2       1
#>   donor6   274     298     544     325      83      85     105     205     250     262     216       3       7
#>
#>          Macrophage Micro Mural Oligo  OPC Tcell
#>   donor1          1   152     3  2754  196     2
#>   donor2          3    92     2   517   91     2
#>   donor6          6   144    13  2184  285     5
```

## 2.5 Get Enrichment statistics for snRNA-seq data

`spatialLIBD` contains many functions to compute `modeling_results` for the query sc/snRNA-seq or spatial data.

**The process includes the following steps**

1. `registration_pseudobulk()`: Pseudo-bulks data, filter low expressed genes, and normalize counts
2. `registration_mod()`: Defines the statistical model that will be used for computing the block correlation
3. `registration_block_cor()` : Computes the block correlation using the sample ID as the blocking factor, used as correlation in eBayes call
4. `registration_stats_enrichment()` : Computes the gene enrichment \(t\)-statistics (one group vs. All other groups)

The function `registration_wrapper()` makes life easy by wrapping these functions together in to one step!

```
## Perform the spatial registration
sce_modeling_results <- registration_wrapper(
    sce = sce.dlpfc.tran,
    var_registration = "cellType",
    var_sample_id = "donor",
    gene_ensembl = "gene_id",
    gene_name = "gene_name"
)
#> 2025-11-04 11:47:10.957324 make pseudobulk object
#> 2025-11-04 11:47:11.970294 dropping 13 pseudo-bulked samples that are below 'min_ncells'.
#> 2025-11-04 11:47:12.04248 drop lowly expressed genes
#> 2025-11-04 11:47:12.255941 normalize expression
#> 2025-11-04 11:47:13.427684 create model matrix
#> 2025-11-04 11:47:13.468911 run duplicateCorrelation()
#> 2025-11-04 11:47:36.026572 The estimated correlation is: 0.138734774807097
#> 2025-11-04 11:47:36.0313 computing enrichment statistics
#> 2025-11-04 11:47:38.282124 extract and reformat enrichment results
#> 2025-11-04 11:47:38.499828 running the baseline pairwise model
#> 2025-11-04 11:47:38.745193 computing pairwise statistics
#> 2025-11-04 11:47:41.231681 computing F-statistics
```

## 2.6 Extract Enrichment t-statistics

```
## check out table on enrichment t-statistics
sce_modeling_results$enrichment[1:5, 1:5]
#>                 t_stat_Astro t_stat_Excit_A t_stat_Excit_B t_stat_Excit_C t_stat_Excit_D
#> ENSG00000238009  -0.71009456      0.7957792      0.0497619      0.6825793      0.5526941
#> ENSG00000237491  -4.24672326      1.7724150      1.6819367      0.9047336      2.8222782
#> ENSG00000225880   0.06152726      0.6941825      0.9819037     -0.1958094     -0.7766439
#> ENSG00000223764   7.69037575     -0.4106009     -0.4107015     -0.4106542     -0.4107933
#> ENSG00000187634  10.14422194     -0.4721603      0.2733466     -0.1397438     -1.0111055
```

## 2.7 Correlate statsics with Layer Reference

```
cor_layer <- layer_stat_cor(
    stats = sce_modeling_results$enrichment,
    modeling_results = layer_modeling_results,
    model_type = "enrichment",
    top_n = 100
)

cor_layer
#>                 WM       Layer6      Layer5       Layer4      Layer3       Layer2      Layer1
#> Oligo    0.7536847 -0.038947167 -0.22313462 -0.216143460 -0.39418956 -0.336272668 -0.04559186
#> Astro    0.2902852 -0.215372148 -0.32009814 -0.320189919 -0.24920587 -0.128017818  0.66950829
#> OPC      0.3309766 -0.076892980 -0.19246279 -0.254222683 -0.21417502 -0.073209686  0.22845154
#> Micro    0.2548264 -0.066391136 -0.14907964 -0.132236668 -0.18353524 -0.118307525  0.19395081
#> Mural    0.1652788 -0.046487411 -0.12107471 -0.190269592 -0.11924637 -0.076057486  0.24642004
#> Excit_B -0.3718199 -0.119246604 -0.26805619 -0.034391012  0.57980667  0.675251157 -0.12563319
#> Excit_C -0.5232250 -0.187359062  0.01974092  0.381935813  0.69540412  0.326841133 -0.26729177
#> Excit_A -0.3902148  0.128043074  0.63735797  0.405168995  0.06011232 -0.171933501 -0.38823893
#> Excit_E -0.3651414  0.489930498  0.13044242 -0.001907714  0.15141352  0.194625039 -0.33496664
#> Excit_F -0.2108888  0.443748447  0.35812706 -0.064476608 -0.09199288 -0.012550826 -0.30917103
#> Inhib_A -0.2497876 -0.035402374  0.08242644  0.105770587  0.12358824  0.133982729  0.01021479
#> Inhib_C -0.2100641 -0.080878595  0.05282252  0.052311336  0.09462094  0.160416496  0.06801709
#> Excit_D -0.3363905 -0.004936028  0.29430601  0.402875525  0.19153576 -0.014930006 -0.27248937
#> Inhib_B -0.1574240 -0.016415116  0.15172576  0.190096545  0.05317902 -0.004791031 -0.09307309
#> Inhib_D -0.2224211 -0.062788566  0.20260766  0.314434866  0.08963108 -0.067981519 -0.09229913
```

# 3 Explore Results

Now we can use these correlation values to learn about the cell types.

## 3.1 Create Heatmap of Correlations

We can see from this heatmap what layers the different cell types are associated with.

* Oligo with WM
* Astro with Layer 1
* Excitatory neurons to different layers of the cortex
* Weak associate with Inhibitory Neurons

```
layer_stat_cor_plot(cor_layer)
```

![](data:image/png;base64...)

## 3.2 Annotate Cell Types by Top Correlation

We can use `annotate_registered_clusters` to create annotation labels for the
cell types based on the correlation values.

```
anno <- annotate_registered_clusters(
    cor_stats_layer = cor_layer,
    confidence_threshold = 0.25,
    cutoff_merge_ratio = 0.25
)

anno
#>    cluster layer_confidence           layer_label layer_label_simple
#> 1    Oligo             good                    WM                 WM
#> 2    Astro             good                Layer1                 L1
#> 3      OPC             good                    WM                 WM
#> 4    Micro             good                    WM                 WM
#> 5    Mural             poor               Layer1*                L1*
#> 6  Excit_B             good         Layer2/Layer3               L2/3
#> 7  Excit_C             good                Layer3                 L3
#> 8  Excit_A             good                Layer5                 L5
#> 9  Excit_E             good                Layer6                 L6
#> 10 Excit_F             good         Layer6/Layer5               L6/5
#> 11 Inhib_A             poor Layer2/Layer3/Layer4*            L2/3/4*
#> 12 Inhib_C             poor               Layer2*                L2*
#> 13 Excit_D             good                Layer4                 L4
#> 14 Inhib_B             poor               Layer4*                L4*
#> 15 Inhib_D             good                Layer4                 L4
```

## 3.3 Plot Annotated Cell Types

Finally, we can update our heatmap with colors and annotations based on cluster
registration for the snRNA-seq clusters.

```
layer_stat_cor_plot(
    cor_layer,
    query_colors = get_colors(clusters = rownames(cor_layer)),
    reference_colors = libd_layer_colors,
    annotation = anno,
    cluster_rows = FALSE,
    cluster_columns = FALSE
)
```

![](data:image/png;base64...)

# 4 Reproducibility

The *[spatialLIBD](https://bioconductor.org/packages/3.22/spatialLIBD)* package (Pardo, Spangler, Weber et al., 2022) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight et al., 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("guide_to_spatial_registration.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("guide_to_spatial_registration.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-11-04 11:47:47 EST"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 47.819 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-11-04
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi          1.72.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub          4.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  attempt                0.3.1     2020-05-03 [2] CRAN (R 4.5.1)
#>  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  beachmat               2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  beeswarm               0.4.0     2021-06-01 [2] CRAN (R 4.5.1)
#>  benchmarkme            1.0.8     2022-06-12 [2] CRAN (R 4.5.1)
#>  benchmarkmeData        1.0.4     2020-04-23 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 3.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                 1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocNeighbors          2.4.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel           1.44.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocSingular           1.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  Cairo                  1.7-0     2025-10-29 [2] CRAN (R 4.5.1)
#>  cigarillo              1.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  circlize               0.4.16    2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66    2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  config                 0.3.2     2023-08-30 [2] CRAN (R 4.5.1)
#>  cowplot                1.2.0     2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.1     2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DelayedMatrixStats     1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17    2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  dqrng                  0.4.1     2024-05-28 [2] CRAN (R 4.5.1)
#>  DropletUtils           1.30.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  DT                     0.34.0    2025-09-02 [2] CRAN (R 4.5.1)
#>  edgeR                  4.8.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  ExperimentHub          3.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicAlignments      1.46.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges        * 1.62.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5     2020-12-15 [2] CRAN (R 4.5.1)
#>  ggbeeswarm             0.7.2     2023-04-29 [2] CRAN (R 4.5.1)
#>  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6     2024-09-07 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2     2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  golem                  0.5.1     2024-08-27 [2] CRAN (R 4.5.1)
#>  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  h5mread                1.2.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  HDF5Array              1.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16    2025-04-16 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  irlba                  2.3.5.1   2022-10-03 [2] CRAN (R 4.5.1)
#>  iterators              1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  later                  1.4.4     2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                  3.66.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  lobstr               * 1.1.2     2022-06-22 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  mime                   0.13      2025-03-17 [2] CRAN (R 4.5.1)
#>  otel                   0.2.0     2025-08-29 [2] CRAN (R 4.5.1)
#>  paletteer              1.6.0     2024-01-21 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plotly                 4.11.0    2025-06-19 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  prismatic              1.1.2     2024-04-10 [2] CRAN (R 4.5.1)
#>  promises               1.5.0     2025-11-01 [2] CRAN (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  R.methodsS3            1.8.2     2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo                   1.27.1    2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils                2.13.0    2025-02-24 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  rematch2               2.1.2     2020-05-01 [2] CRAN (R 4.5.1)
#>  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rhdf5                  2.54.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  rhdf5filters           1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Rhdf5lib               1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  Rsamtools              2.26.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rsvd                   1.0.5     2021-04-16 [2] CRAN (R 4.5.1)
#>  rtracklayer          * 1.70.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays               1.10.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  ScaledMatrix           1.18.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  scater                 1.38.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  scuttle                1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0     2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1   2024-02-23 [2] CRAN (R 4.5.1)
#>  shiny                  1.11.1    2025-07-03 [2] CRAN (R 4.5.1)
#>  shinyWidgets           0.9.0     2025-02-21 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.1    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  sparseMatrixStats      1.22.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  SpatialExperiment    * 1.20.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  spatialLIBD          * 1.22.0    2025-11-04 [1] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                  1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7     2023-12-18 [2] CRAN (R 4.5.1)
#>  viridis                0.6.5     2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2     2023-05-02 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.54      2025-10-30 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4     2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0    2025-11-03 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpBXD2ka/Rinst8a4186f8154c0
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 5 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-maynard2021transcriptome)
K. R. Maynard, L. Collado-Torres, L. M. Weber, et al.
“Transcriptome-scale spatial gene expression in the human dorsolateral prefrontal cortex”.
In: *Nature Neuroscience* (2021).
DOI: [10.1038/s41593-020-00787-0](https://doi.org/10.1038/s41593-020-00787-0).
URL: <https://www.nature.com/articles/s41593-020-00787-0>.

[[3]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[4]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[5]](#cite-pardo2022spatiallibd)
B. Pardo, A. Spangler, L. M. Weber, et al.
“spatialLIBD: an R/Bioconductor package to visualize spatially-resolved transcriptomics data”.
In: *BMC Genomics* (2022).
DOI: [10.1186/s12864-022-08601-w](https://doi.org/10.1186/s12864-022-08601-w).
URL: <https://doi.org/10.1186/s12864-022-08601-w>.

[[6]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[7]](#cite-tran2021)
M. N. Tran, K. R. Maynard, A. Spangler, et al.
“Single-nucleus transcriptome analysis reveals cell-type-specific molecular signatures across reward circuitry in the human brain”.
In: *Neuron* (2021).
DOI: [10.1016/j.neuron.2021.09.001](https://doi.org/10.1016/j.neuron.2021.09.001).

[[8]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[9]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[10]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.