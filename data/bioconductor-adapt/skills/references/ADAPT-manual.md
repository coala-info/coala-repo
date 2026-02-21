# ADAPT Tutorial

# Introduction

This is the tutorial for `ADAPT` (analysis of microbiome differential abundance analysis by pooling Tobit models). Differential abundance analysis (DAA) is one of the fundamental steps in microbiome research.1 The metagenomics count data have excessive zeros and are compositional, causing challenges for detecting microbiome taxa whose abundances are associated with different conditions. `ADAPT` overcomes these challenges differently from other DAA methods. First, `ADAPT` treats zero counts as left censored observations and apply Tobit models which are censored regressions2 for modeling the log count ratios. Second, `ADAPT` has an innovative and theoretically justified way of finding non-differentially abundant taxa as reference taxa. It then applies Tobit models to log count ratios between individual taxa and the summed counts of reference taxa to identify differentially abundant taxa. The overall workflow is presented in the graph below.

![Workflow of ADAPT](data:image/png;base64...)

Workflow of ADAPT

There are two ways to install the package, either through GitHub or Bioconductor.

```
# install through GitHub
if(!require("ADAPT")) BiocManager::install("mkbwang/ADAPT", build_vignettes = TRUE)

# install through Bioconductor
if(!require("ADAPT")) BiocManager::install("ADAPT", version="devel",
                                           build_vignettes = TRUE)
```

# Main function `adapt`

The main function `adapt` takes in a phyloseq3 object that needs to have at least a count table and a sample metadata. The metadata must contain one variable that represents the condition to test on. We currently allow binary and continuous conditions. If there are more than two groups for the condition variable, the user may single out one group to compare with all the others for DAA. `ADAPT` allows adjusting for extra covariates. There are eight arguments in the `adapt` function:

1. `input_data` is the phyloseq object with the count matrix and metadata. This argument is required.
2. `cond.var` is the variable in the metadata that represents the condition to test on. This argument is required.
3. `base.cond` is the group that the user is interested in comparing against other groups. This argument is only needed if the condition is categorical.
4. `adj.var` contains the covariates to adjust for. It can be empty or be a vector of variable names.
5. `censor` is the value to censor at for all the zero counts. By default the zeros are censored at one.
6. `prev.filter` is the threshold for filtering out rare taxa. By default taxa with prevalence lower than 0.05 are filtered out before analysis.
7. `depth.filter` is the threshold for filtering out samples with low sequencing depths. The default threshold is 1000 reads.
8. `alpha` is the cutoff for the Benjamini-hochberg adjusted p-values to decide differentially abundant taxa. The default is 0.05.

The `ADAPT` package contains two metagenomics datasets from an early childhood dental caries study.4 One corresponds to 16S rRNA sequencing of 161 saliva samples collected from 12-month-old infants (`ecc_saliva`). The other corresponds to shotgun metagenomic sequencing of 30 plaque samples collected from kids between 36 and 60 months old (`ecc_plaque`). In this vignette let’s use the saliva data to find out differentially abundant taxa between kids who developed early childhood caries (ECC) after 36 months old and those who didn’t. Besides the main variable `CaseStatus`, there is another variable `Site` representing the site where each sample was collected. Both variables are discrete and contain two categories each.

```
library(ADAPT)
data(ecc_saliva)
```

We can run `adapt` with or without covariate adjustment. The returned object is a customized S4-type object with slots corresponding to analysis name, reference taxa, differentially abundant taxa, detailed analysis results (a dataframe) and input phyloseq object.

```
saliva_output_noadjust <- adapt(input_data=ecc_saliva, cond.var="CaseStatus", base.cond="Control")
#> Choose 'Control' as the baseline condition
#> 155 taxa and 161 samples being analyzed...
#> Selecting Reference Set... 77 taxa selected as reference
#> 27 differentially abundant taxa detected
saliva_output_adjust <- adapt(input_data=ecc_saliva, cond.var="CaseStatus", base.cond="Control", adj.var="Site")
#> Choose 'Control' as the baseline condition
#> 155 taxa and 161 samples being analyzed...
#> Selecting Reference Set... 77 taxa selected as reference
#> 28 differentially abundant taxa detected
```

The `Site` is not a confounding variable, therefore the DAA results only differ by one taxon.

# Explore Analysis Results

We have developed two utility functions for result exploration. `summary` returns a dataframe with the estimated log10 abundance fold changes, hypothesis test p-values and taxonomy (if provided in the phyloseq object). The user can choose to return results of all the taxa, the differentially abundant taxa only or the reference taxa only through the `select` variable (“all”, “da” or “ref”). We choose to return the results of only the DA taxa below.

```
DAtaxa_result <- summary(saliva_output_noadjust, select="da")
#> Differential abundance analysis for CaseStatus (Case VS Control)
#> 155 taxa and 161 samples analyzed
#> 77 taxa are selected as reference and 27 taxa are differentially abundant
```

```
head(DAtaxa_result)
#>        Taxa prevalence log10foldchange  teststat         pval adjusted_pval
#> ASV3   ASV3  0.9751553      -0.3618780  9.313926 2.274187e-03  1.855258e-02
#> ASV8   ASV8  0.9689441       0.3567131  9.881400 1.669578e-03  1.437693e-02
#> ASV9   ASV9  0.8695652      -0.8925900 19.157084 1.203899e-05  4.665108e-04
#> ASV14 ASV14  0.7204969       0.9203963 13.159234 2.861058e-04  4.031491e-03
#> ASV18 ASV18  0.7080745      -1.3929574 28.068324 1.171070e-07  9.075792e-06
#> ASV20 ASV20  0.4099379       2.2046044 31.758612 1.745735e-08  2.705889e-06
#>        Kingdom         Phylum               Class           Order
#> ASV3  Bacteria Proteobacteria Gammaproteobacteria  Pasteurellales
#> ASV8  Bacteria     Firmicutes             Bacilli Lactobacillales
#> ASV9  Bacteria Proteobacteria  Betaproteobacteria    Neisseriales
#> ASV14 Bacteria     Firmicutes             Bacilli Lactobacillales
#> ASV18 Bacteria   Fusobacteria       Fusobacteriia Fusobacteriales
#> ASV20 Bacteria  Bacteroidetes         Bacteroidia   Bacteroidales
#>                 Family         Genus        Species
#> ASV3   Pasteurellaceae   Haemophilus parainfluenzae
#> ASV8  Streptococcaceae Streptococcus     salivarius
#> ASV9     Neisseriaceae     Neisseria       subflava
#> ASV14 Streptococcaceae Streptococcus           <NA>
#> ASV18 Fusobacteriaceae Fusobacterium  periodonticum
#> ASV20   Prevotellaceae    Prevotella           <NA>
```

We have also developed a `plot` function to generate a volcano plot. The DA taxa are highlighted in red. The user can decide how many points with the smallest p-values are labeled (default 5) with `n.label` argument.

```
plot(saliva_output_noadjust, n.label=5)
```

![Volcano plot for differential abundance analysis between saliva samples of children who developed early childhood dental caries and those who didn't](data:image/png;base64...)

Volcano plot for differential abundance analysis between saliva samples of children who developed early childhood dental caries and those who didn’t

# Session Information and References

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
#> [1] ADAPT_1.4.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6           xfun_0.53              bslib_0.9.0
#>  [4] ggplot2_4.0.0          ggrepel_0.9.6          rhdf5_2.54.0
#>  [7] Biobase_2.70.0         lattice_0.22-7         rhdf5filters_1.22.0
#> [10] vctrs_0.6.5            tools_4.5.1            generics_0.1.4
#> [13] biomformat_1.38.0      stats4_4.5.1           parallel_4.5.1
#> [16] tibble_3.3.0           cluster_2.1.8.1        pkgconfig_2.0.3
#> [19] Matrix_1.7-4           data.table_1.17.8      RColorBrewer_1.1-3
#> [22] S7_0.2.0               S4Vectors_0.48.0       RcppParallel_5.1.11-1
#> [25] lifecycle_1.0.4        compiler_4.5.1         farver_2.1.2
#> [28] stringr_1.5.2          Biostrings_2.78.0      Seqinfo_1.0.0
#> [31] codetools_0.2-20       permute_0.9-8          htmltools_0.5.8.1
#> [34] sass_0.4.10            yaml_2.3.10            pillar_1.11.1
#> [37] crayon_1.5.3           jquerylib_0.1.4        MASS_7.3-65
#> [40] cachem_1.1.0           vegan_2.7-2            iterators_1.0.14
#> [43] foreach_1.5.2          nlme_3.1-168           tidyselect_1.2.1
#> [46] digest_0.6.37          stringi_1.8.7          dplyr_1.1.4
#> [49] reshape2_1.4.4         labeling_0.4.3         splines_4.5.1
#> [52] RcppArmadillo_15.0.2-2 ade4_1.7-23            fastmap_1.2.0
#> [55] grid_4.5.1             cli_3.6.5              magrittr_2.0.4
#> [58] dichromat_2.0-0.1      survival_3.8-3         ape_5.8-1
#> [61] withr_3.0.2            scales_1.4.0           rmarkdown_2.30
#> [64] XVector_0.50.0         igraph_2.2.1           multtest_2.66.0
#> [67] phyloseq_1.54.0        evaluate_1.0.5         knitr_1.50
#> [70] IRanges_2.44.0         mgcv_1.9-3             rlang_1.1.6
#> [73] Rcpp_1.1.0             glue_1.8.0             BiocGenerics_0.56.0
#> [76] jsonlite_2.0.0         R6_2.6.1               Rhdf5lib_1.32.0
#> [79] plyr_1.8.9
```

1. Li, H. Microbiome, Metagenomics, and High-Dimensional Compositional Data Analysis. *Annual Review of Statistics and Its Application* **2**, 73–94 (2015).

2. Tobin, J. Estimation of Relationships for Limited Dependent Variables. *Econometrica* **26**, 24 (1958).

3. McMurdie, P. J. & Holmes, S. Phyloseq: An r package for reproducible interactive analysis and graphics of microbiome census data. *PLoS ONE* **8**, e61217 (2013).

4. Blostein, F. *et al.* Evaluating the ecological hypothesis: early life salivary microbiome assembly predicts dental caries in a longitudinal case-control study. *Microbiome* **10**, 240 (2022).