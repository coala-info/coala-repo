# The consICa package: User’s manual

Petr V. Nazarov, Tony Kaoma, Maryna Chepeleva

#### 2025-10-29

#### Abstract

This vignette describes the Bioconductor package consICA. We developed a fast parallelized algorithm for deconvolution of omics data, based on the independent component analysis. Additionally, we implemented convenient functionality for the analysis of decomposed signals including ANOVA-based linking to experimental factors, enrichment analysis, and survival analysis. A PDF report can be generated automatically by the package. The package was previously applied to single-cell and bulk-sample transcriptomics data in the field of cancer research. We showed the ability of the approach to (i) separate biologically relevant molecular signals from technical biases, (ii) identify molecular signals specific to cell types and cellular processes, (iii) provide a feature engineering mechanism improving the classification of the samples [1,2,3].

#### Package

consICA 2.8.0

# Contents

* [1 Introduction](#introduction)
* [2 Installing and loading the package](#installing-and-loading-the-package)
* [3 Example dataset](#example-dataset)
* [4 Consensus independent component analysis](#consensus-independent-component-analysis)
* [5 Enrichment analysis](#enrichment-analysis)
* [6 Survival analysis](#survival-analysis)
* [7 Automatic report generation](#automatic-report-generation)
* [8 Session info](#session-info)
* [9 References](#references)
* **Appendix**

This document describes the usage of the functions integrated into the package and is meant to be a reference document for the end-user.

# 1 Introduction

Independent component analysis (ICA) of omics data can be used for deconvolution of biological signals and technical biases, correction of batch effects, feature engineering for classification and integration of the data [4]. The consICA package allows building robust consensus ICA-based deconvolution of the data as well as running post-hoc biological interpretation of the results. The implementation of parallel computing in the package ensures efficient analysis using modern multicore systems.

# 2 Installing and loading the package

Load the package with the following command:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("consICA")
```

```
library('consICA')
```

# 3 Example dataset

The usage of the package functions for an independent component deconvolution is shown for an example set of 472 samples and 2454 most variable genes from the skin cutaneous melanoma (SKCM) TCGA cohort. It stored as a `SummarizedExperiment` object. In addition the data includes metadata such as age, gender, cancer subtype etc. and survival time-to-event data.
Use data as

```
library(SummarizedExperiment)
data("samples_data")
samples_data
#> class: SummarizedExperiment
#> dim: 2454 472
#> metadata(0):
#> assays(1): X
#> rownames(2454): A2ML1 AACSP1 ... ZNF883 ZP1
#> rowData names(0):
#> colnames(472): 3N.A9WB.Metastatic 3N.A9WC.Metastatic ...
#>   Z2.AA3S.Metastatic Z2.AA3V.Metastatic
#> colData names(103): age_at_initial_pathologic_diagnosis gender ... time
#>   event

# According to our terminology expression matrix X of 2454 genes and 472 samples
X <- data.frame(assay(samples_data))
dim(X)
#> [1] 2454  472
# variables described each sample
Var <- data.frame(colData(samples_data))
dim(Var)
#> [1] 472 103
colnames(Var)[1:20] # print first 20
#>  [1] "age_at_initial_pathologic_diagnosis" "gender"
#>  [3] "race"                                "Weight"
#>  [5] "Height"                              "BMI"
#>  [7] "Ethinicity"                          "Cancer.Type.Detailed"
#>  [9] "Tumor.location.site"                 "ajcc_pathologic_tumor_stage"
#> [11] "Cancer.stage.M"                      "Cancer.stage.N"
#> [13] "Cancer.stage.T"                      "initial_pathologic_dx_year"
#> [15] "birth_days_to_initial_diagnosis"     "Year.of.Birth"
#> [17] "age.at.last.contact"                 "Year.of.last.contact"
#> [19] "last_contact_days_to"                "age.at.death"
# survival time and event for each sample
Sur <- data.frame(colData(samples_data))[,c("time", "event")]
Var <- Var[,which(colnames(Var) != "time" & colnames(Var) != "event")]
```

# 4 Consensus independent component analysis

Independent component analysis (ICA) is an unsupervised method of signal deconvolution [3].
ICA decomposes combined gene expression matrix from multiple samples into meaningful signals in the space of genes (metagenes, S) and weights in the space of samples (weight matrix, M).
![](data:image/jpeg;base64...)
Figure 1. ICA decomposes combined gene expression matrix from multiple samples into meaningful signals in the space of genes (metagenes, S) and weights in the space of samples (weight matrix, M). Biological processes and signatures of cell subtypes can be found in S, while M could be linked to patient groups and patient survival (Cox regression and Eq.1).

The `consICA` function calculates the consensus ICA for an expression matrix: X = 𝑆 × 𝑀, where S is a
matrix of statistically independent and biologically meaningful signals (metagenes) and M – their weights (metasamples). You can set the number of components, the number of consensus runs. The function will print logs every `show.every` run. Use `ncores` for parallel calculation. To filter out genes (rows) with values lower than a threshold set the `filter.thr` argument.

```
set.seed(2022)
cica <- consICA(samples_data, ncomp=20, ntry=10, ncores=1, show.every=0)
```

The output of consensus ICA is a list with input data `X` (assays of SummarizedExperiment `samples_data` object) and it dimensions, consensus metagene `S` and weight matrix `M`, number of components, mean R2 between rows of M (`mr2`), stability as mean R2 between consistent columns of S in multiple tries (`stab`) and number of best iteration (`ibest`). For compact output use `reduced` = TRUE.

```
str(cica, max.level=1)
#> List of 10
#>  $ X        : num [1:2454, 1:472] 5.13 0 3.7 1.58 5.7 ...
#>   ..- attr(*, "dimnames")=List of 2
#>  $ X_num    : num [1:2454, 1:472] 5.13 0 3.7 1.58 5.7 ...
#>   ..- attr(*, "dimnames")=List of 2
#>  $ S        : num [1:2454, 1:20] 0.2929 -0.0551 0.2261 -0.474 0.1712 ...
#>   ..- attr(*, "dimnames")=List of 2
#>  $ M        : num [1:20, 1:472] 0.427 -0.45 -0.131 -1.13 -0.6 ...
#>   ..- attr(*, "dimnames")=List of 2
#>  $ mr2      : num [1:10] 0.0302 0.0328 0.0341 0.0298 0.0295 ...
#>  $ i.best   : int 5
#>  $ stab     : num [1:10, 1:20] 0.982 0.988 0.983 0.988 0.988 ...
#>   ..- attr(*, "dimnames")=List of 2
#>  $ ncomp    : num 20
#>  $ nsamples : int 472
#>  $ nfeatures: int 2454
```

Now we can extract the names of features (rows in `X` and `S` matrices) and their false discovery rates values for positive/negative contribution to each component. Use `getFeatures` to extract them.

```
features <- getFeatures(cica, alpha = 0.05, sort = TRUE)
#Positive and negative affecting features for first components are
head(features$ic.1$pos)
#>        features fdr
#> DDX3Y     DDX3Y   0
#> EIF1AY   EIF1AY   0
#> GYG2P1   GYG2P1   0
#> KDM5D     KDM5D   0
#> NLGN4Y   NLGN4Y   0
#> PRKY       PRKY   0
head(features$ic.1$neg)
#>        features           fdr
#> XIST       XIST 9.636860e-308
#> PAGE2     PAGE2  1.718979e-06
#> MAGEB2   MAGEB2  3.286000e-05
#> FDCSP     FDCSP  4.664017e-05
#> FRG2DP   FRG2DP  1.478113e-04
#> DSCR8     DSCR8  2.588904e-04
```

Two lists of top-contributing genes resulted from the `getFeatures` – positively and negatively involved. The plot of genes contribution to the first component (metagene) is shown below.

```
icomp <- 1
plot(sort(cica$S[,icomp]),col = "#0000FF", type="l", ylab=("involvement"),xlab="genes",las=2,cex.axis=0.4, main=paste0("Metagene #", icomp, "\n(involvement of features)"),cex.main=0.6)
```

![](data:image/png;base64...)

Estimate the variance explained by the independent components with `estimateVarianceExplained`. Use `plotICVarianceExplained` to plot it.

```
var_ic <- estimateVarianceExplained(cica)
p <- plotICVarianceExplained(cica)
```

![](data:image/png;base64...)
Independent components could be linked to factors from meta data with ANOVA.

```
## Run ANOVA for components 1 and 5
# Get metadata from SummarizedExperiment object
# Var <- data.frame(SummarizedExperiment::colData(samples_data))
var_ic1 <- anovaIC(cica, Var, icomp = 1, color_by_pv = TRUE, plot = TRUE)
```

![](data:image/png;base64...)

```
var_ic5 <- anovaIC(cica, Var, icomp = 5, mode = 'box', plot = FALSE)

head(var_ic1, 3)
#>   factor       p.value p.value_disp
#> 1 gender 2.373407e-186    2.37e-186
#> 2 Height  3.090046e-29     3.09e-29
#> 3 Weight  4.130014e-07     4.13e-07
head(var_ic5, 5)
#>                      factor      p.value p.value_disp
#> 1 RNASEQ.CLUSTER_CONSENHIER 1.623478e-32     1.62e-32
#> 2         Tumor.tissue.site 3.957786e-24     3.96e-24
#> 3       Tumor.location.site 1.356281e-23     1.36e-23
#> 4           ICD.10.TopLevel 2.765156e-15     2.77e-15
#> 5               Sample.Type 1.952728e-12     1.95e-12
```

In this example 1st component isolated gender differences. To remove them, the reconstruction of initial matrix could be done with zero weights for first component.

# 5 Enrichment analysis

For each component we can carry out an enrichment analysis. The genes with expression above the selected threshold in at least one sample, were used as a background gene list and significantly overrepresented(adj.p-value < `alpha`) GO terms. You can select the DB for search: biological process (“BP”), molecular function (“MF”) and/or cellular component (“CC”).

```
## To save time for this example load result of getGO(cica, alpha = 0.05, db = c("BP", "MF", "CC"))
if(!file.exists("cica_GOs_20_s2022.rds")){

  # Old version < 1.1.1 - GO was an external object. Add it to cica and rotate if need
  # GOs <- readRDS(url("http://edu.modas.lu/data/consICA/GOs_40_s2022.rds", "r"))
  # cica$GO <- GOs
  # cica <- setOrientation(cica)

  # Actual version >= 1.1.1
  cica <- readRDS(url("http://edu.modas.lu/data/consICA/cica_GOs_20_s2022.rds", "r"))
  saveRDS(cica, "cica_GOs_20_s2022.rds")
} else{
  cica <- readRDS("cica_GOs_20_s2022.rds")
}

## Search GO (biological process)
# cica <- getGO(cica, alpha = 0.05, db = "BP", ncores = 4)
## Search GO (biological process, molecular function, cellular component)
# cica <- getGO(cica, alpha = 0.05, db = c("BP", "MF", "CC"), ncores = 4)
```

You can compare lists of enriched GO from different runs or datasets. See function `overlapGO()` for more.

# 6 Survival analysis

Weights of the components (rows of matrix M) can be statistically linked to patient survival using Cox partial hazard regression [4]. In `survivalAnalysis` function adjusted p-values of the log-rank test are used to select significant components. However, the prognostic power of each individual component might not have been high enough to be applied to the patients from the new cohort. Therefore, `survivalAnalysis` integrates weights of several components, calculating the risk score (RS) with improved prognostic power. For each sample, its RS is the sum of the products of significant log-hazard ratios (LHR) of the univariable Cox regression, the component stability R2 and the standardized row of weight matrix M.

```
RS <- survivalAnalysis(cica, surv = Sur)
```

![](data:image/png;base64...)

```
cat("Hazard score for significant components")
#> Hazard score for significant components
RS$hazard.score
#>       ic.2       ic.3       ic.5       ic.9      ic.10      ic.11      ic.15
#>  0.1806700  0.3661800  0.2620083  0.2987519 -0.3415036 -0.1648588 -0.1555157
#>      ic.16      ic.19
#>  0.1930739  0.1813600
```

# 7 Automatic report generation

The best way to get a full description of extracted components is using our automatic report. We union all analyses of independent components into a single function-generated report.

```
# Generate report with independent components description
if(FALSE){
  saveReport(cica, Var=Var, surv = Sur)
}
```

The copy of this report you can find at <http://edu.modas.lu/data/consICA/report_ICA_20.pdf>

```
# delete loaded file after vignette run
unlink("cica_GOs_20_s2022.rds")
```

# 8 Session info

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
#>  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [5] IRanges_2.44.0              S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0         generics_0.1.4
#>  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [11] consICA_2.8.0               BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1      dplyr_1.1.4           farver_2.1.2
#>  [4] blob_1.2.4            Biostrings_2.78.0     S7_0.2.0
#>  [7] fastmap_1.2.0         fastICA_1.2-7         digest_0.6.37
#> [10] lifecycle_1.0.4       topGO_2.62.0          survival_3.8-3
#> [13] KEGGREST_1.50.0       RSQLite_2.4.3         magrittr_2.0.4
#> [16] compiler_4.5.1        rlang_1.1.6           sass_0.4.10
#> [19] tools_4.5.1           yaml_2.3.10           sm_2.2-6.0
#> [22] knitr_1.50            labeling_0.4.3        S4Arrays_1.10.0
#> [25] bit_4.6.0             DelayedArray_0.36.0   RColorBrewer_1.1-3
#> [28] abind_1.4-8           BiocParallel_1.44.0   withr_3.0.2
#> [31] grid_4.5.1            GO.db_3.22.0          ggplot2_4.0.0
#> [34] scales_1.4.0          dichromat_2.0-0.1     tinytex_0.57
#> [37] cli_3.6.5             rmarkdown_2.30        crayon_1.5.3
#> [40] RcppParallel_5.1.11-1 httr_1.4.7            DBI_1.2.3
#> [43] cachem_1.1.0          splines_4.5.1         parallel_4.5.1
#> [46] AnnotationDbi_1.72.0  BiocManager_1.30.26   XVector_0.50.0
#> [49] vctrs_0.6.5           Matrix_1.7-4          jsonlite_2.0.0
#> [52] SparseM_1.84-2        bookdown_0.45         bit64_4.6.0-1
#> [55] magick_2.9.0          jquerylib_0.1.4       glue_1.8.0
#> [58] codetools_0.2-20      gtable_0.3.6          tibble_3.3.0
#> [61] pillar_1.11.1         htmltools_0.5.8.1     graph_1.88.0
#> [64] R6_2.6.1              zigg_0.0.2            evaluate_1.0.5
#> [67] lattice_0.22-7        png_0.1-8             Rfast_2.1.5.2
#> [70] pheatmap_1.0.13       memoise_2.0.1         bslib_0.9.0
#> [73] Rcpp_1.1.0            SparseArray_1.10.0    org.Hs.eg.db_3.22.0
#> [76] xfun_0.53             pkgconfig_2.0.3
```

# 9 References

# Appendix

1. Golebiewska, A., et al. Patient-derived organoids and orthotopic xenografts of primary and recurrent gliomas represent relevant patient avatars for precision oncology. Acta Neuropathol 2020;140(6):919-949.
2. Scherer, M., et al. Reference-free deconvolution, visualization and interpretation of complex DNA methylation data using DecompPipeline, MeDeCom and FactorViz. Nat Protoc 2020;15(10):3240-3263.
3. Sompairac, N.; Nazarov, P.V.; Czerwinska, U.; Cantini, L.; Biton, A,; Molkenov, A,; Zhumadilov, Z.; Barillot, E.; Radvanyi, F.; Gorban, A.; Kairov, U.; Zinovyev, A. Independent component analysis for unravelling complexity of cancer omics datasets. International Journal of Molecular Sciences 20, 18 (2019). <https://doi.org/10.3390/ijms20184414>

4.Nazarov, P.V., Wienecke-Baldacchino, A.K., Zinovyev, A. et al. Deconvolution of transcriptomes and miRNomes by independent component analysis provides insights into biological processes and clinical outcomes of melanoma patients. BMC Med Genomics 12, 132 (2019). <https://doi.org/10.1186/s12920-019-0578-4>