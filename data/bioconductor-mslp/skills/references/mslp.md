# mslp

Chunxuan Shao

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Analysis](#analysis)
  + [3.1 Data preprocessing](#data-preprocessing)
  + [3.2 Call SLPs from compensationModule](#call-slps-from-compensationmodule)
  + [3.3 Call SLPs from correlationModule](#call-slps-from-correlationmodule)
  + [3.4 Call consensus SLPs](#call-consensus-slps)
* [4 Reference](#reference)

# 1 Introduction

`mslp` (Mutation specific Synthetic Lethal Partners) is a comprehensive pipeline to identify consensus SLPs for loss of function mutations in a cancer context-specific manner through integrating genomic and transcriptomic data from patients, as well as genetic screen data in cell line [1](Shao%20C.%20mslp%3A%20a%20comprehensive%20pipeline%20in%20predicting%20cancer%20mutations%20specific%20synthetic%20lethal%20partners.%202021.). It is an unsupervised method which does not relies on training sets of curated SLPs. Compared to other approaches, mslp has the advantage of explicitly and stringently integrating available genetic screen data.

In the pipeline, we first infer the primary SLPs based on two simple yet complementary assumptions: 1) expression of mutations correlate with SLPs in wide type patients, 2) over-expression of SLPs compensate for the loss of function of the mutation. Two computational modules, correlationSLP and compensationSLP, are derived from state-of-art statistical methods to realize the assumptions with the ever-increasing patient omics data. Further, in spite of complex gene-gene interaction, we hypothesize that genetic perturbations targeting mutation specific SLPs would likely reduce cell viability. Thus, for the recurrent mutations detected in both patient tumors and cancer cell lines, we develope the idea of consensus SLPs under two constraints, 1) primary SLPs are screen hits, 2) consistent impact on cell viability in different cell lines. When applied to real datasets, we found that perturbation of predicted consensus SLPs has a significant impact on cell viability compared to other hits. Thus, mslp provides a novel approach to study mutation specific SLPs and explore the possibility of personalized medicine with great flexibilities. More on mslp could be found in the biorxiv paper.

`mslp` has been submitted to [Bioconductor](https://www.bioconductor.org/) for easy access, better documentation and user support.

# 2 Installation

Install the package from Bioconductor.

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mslp")
BiocManager::install("data.table")
```

# 3 Analysis

## 3.1 Data preprocessing

The raw data could be downloaded from public databases, like [cBioPortal](https://www.cbioportal.org/) [2], where the following necessary files are needed:

* mutation profiles, “data\_mutations\_extended.txt”.
* CNA profiles, “data\_CNA.txt”.
* gene expression, “data\_RNA\_Seq\_v2\_expression\_median.txt”.
* z-score data, “data\_RNA\_Seq\_v2\_mRNA\_median\_Zscores.txt”.

It is possible to use customized datasets, simply following the format and column names of above files, e.g., “data\_mutations\_extended.txt” is a gene by sample matrix, with “Hugo\_Symbol”, “Entrez\_Gene\_Id” as the first two columns. Three columns are mandatory in mutation profiles: “Tumor\_Sample\_Barcode”, “Gene” and “Variant\_Classification”, while “Gene” contains the Ensembl gene ids. `pp_tcga` could be used to preprocess the data.

```
#- Preprocessing the data.
#- Path to input files.
library(mslp)
P_mut  <- "data_mutations_extended.txt"
P_cna  <- "data_CNA.txt"
P_expr <- "data_RNA_Seq_v2_expression_median.txt"
P_z    <- "data_RNA_Seq_v2_mRNA_median_Zscores.txt"

res <- pp_tcga(P_mut, P_cna, P_expr, P_z)

saveRDS(res$mut_data, "mut_data.rds")
saveRDS(res$expr_data, "expr_data.rds")
saveRDS(res$zscore_data, "zscore_data.rds")
```

Here we load toy datasets showing the proper data formats.

```
require(future)
#> Loading required package: future
require(doFuture)
#> Loading required package: doFuture
#> Loading required package: foreach
library(magrittr)
library(mslp)
library(data.table)

#- mutation from TCGA datasets to computate SLP via comp_slp
data(example_comp_mut)
#- mutation from TCGA datasets to computate SLP via corr_slp.
data(example_corr_mut)
data(example_expr)
data(example_z)
```

## 3.2 Call SLPs from compensationModule

We use `comp_slp` to predict SLPs compensated for loss of functions due to mutations. Briefly, we identify overexpressed genes in patients with interested mutations via the rank products algorithm [3], while co-occurring mutations are removed beforehand. `mslp` uses `Future` as the parallel backend, and it is recommended to run `corr_slp`, `comp_slp`, `cons_slp` and `est_im` in parallel.

```
plan(multisession, workers = 2)
res_comp <- comp_slp(example_z, example_comp_mut)
#> (==) Number of mutations: 5.
#> Warning: executing %dopar% sequentially: no parallel backend registered
#>
saveRDS(res_comp, file = "compSLP_res.rds")
plan(sequential)
```

## 3.3 Call SLPs from correlationModule

We use `corr_slp` to predict SLPs correlated with mutations in wide type patients. Internally, GENIE3 is used to select potential SLPs [4]. The im\_thresh of 0.0016 was a rather robust threshold identified from various TCGA datasets with 100 random selected mutations and 50 repetitions.

```
plan(multisession, workers = 2)
res_corr <- corr_slp(example_expr, example_corr_mut)
#> (II) Number of mutations: 5.
saveRDS(res_corr, "corrSLP_res.rds")

#- Filter res by importance threshold to reduce false positives.
im_thresh <- 0.0016
res_f     <- res_corr[im >= im_thresh]
plan(sequential)
```

It is recommended to compute the `im_thresh` for each cancer type separately. We derived an approach estimating the threshold by running `corr_slp` for randomly selected mutations repeatedly. SLPs of high relevance are picked as “true” SLPs for each mutation using the rank products algorithm. We then calculated the best threshold of receiver operating characteristic curve (ROC) of each repetition, and took the mean value across repetition. The average value among mutations is the final threshold.

```
plan(multisession, workers = 2)
#- Random mutations and runs
mutgene    <- sample(intersect(example_corr_mut$mut_entrez, rownames(example_expr)), 5)
nperm      <- 3
res_random <- lapply(seq_len(nperm), function(x) corr_slp(example_expr, example_corr_mut, mutgene = mutgene))
#> (II) Number of mutations: 5.
#> (II) Number of mutations: 5.
#> (II) Number of mutations: 5.
im_res     <- est_im(res_random)
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
#> Warning in coords.roc(roc_res, "best", best.method = "youden", transpose =
#> TRUE): 'transpose=TRUE' is deprecated. Only 'transpose=FALSE' will be allowed
#> in a future version.
res_f_2    <- res_corr[im >= mean(im_res$roc_thresh)]
plan(sequential)
```

## 3.4 Call consensus SLPs

The mutation profiles and genetic screen data of cancer cell lines are required for this step. The Cancer Cell Line Encyclopedia (CCLE) is a great place to find mutation data [5]; and genetic screen results could be found in datasets such as Project Drive [6] and DepMap [7].

For example, the following codes show how to extract mutation data from CCLE.

```
library(readxl)

#- nature11003-s3.xls is available in the supplementary data of CCLE publication.
ccle <- readxl::read_excel("nature11003-s3.xls", sheet = "Table S1", skip = 2) %>%
  as.data.frame %>%
  set_names(gsub(" ", "_", names(.))) %>%
  as.data.table %>%
  .[, CCLE_name := toupper(CCLE_name)] %>%
  unique

#- Only use the Nonsynonymous Mutations. CCLE_DepMap_18Q1_maf_20180207.txt can be downloaded from the CCLE website.
#- Only need the columns of cell_line and mut_entrez.
mut_type  <- c("Missense_Mutation", "Nonsense_Mutation", "Frame_Shift_Del", "Frame_Shift_Ins", "In_Frame_Del", "In_Frame_Ins", "Nonstop_Mutation")
ccle_mut  <- fread("CCLE_DepMap_18Q1_maf_20180207.txt") %>%
  .[Variant_Classification %in% mut_type] %>%
  .[, Tumor_Sample_Barcode := toupper(Tumor_Sample_Barcode)] %>%
  .[, Entrez_Gene_Id := as.character(Entrez_Gene_Id)] %>%
  .[, .(Tumor_Sample_Barcode, Entrez_Gene_Id)] %>%
  unique %>%
  setnames(c("cell_line", "mut_entrez"))

#- Select brca cell lines
brca_ccle_mut <- ccle_mut[cell_line %in% unique(ccle[CCLE_tumor_type == "breast"])]
```

Now we are ready to uncover the consensus SLPs, which are 1) hits in genetic screens, 2) consistent for the same mutations among cell lines evaluated by Cohen’s kappa coefficient. `scr_slp` and `cons_slp` are used for these two steps, respectively.

```
plan(multisession, workers = 2)
#- Merge data.
#- Load previous results.
res_comp   <- readRDS("compSLP_res.rds")
res_corr   <- readRDS("corrSLP_res.rds")
merged_res <- merge_slp(res_comp, res_corr)

#- Toy hits data.
screen_1 <- merged_res[, .(slp_entrez, slp_symbol)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    setnames(c(1, 2), c("screen_entrez", "screen_symbol")) %>%
    .[, cell_line := "cell_1"]

screen_2 <- merged_res[, .(slp_entrez, slp_symbol)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    setnames(c(1, 2), c("screen_entrez", "screen_symbol")) %>%
    .[, cell_line := "cell_2"]

screen_hit <- rbind(screen_1, screen_2)

#- Toy mutation data.
mut_1 <- merged_res[, .(mut_entrez)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    .[, cell_line := "cell_1"]

mut_2 <- merged_res[, .(mut_entrez)] %>%
    unique %>%
    .[sample(nrow(.), round(.8 * nrow(.)))] %>%
    .[, cell_line := "cell_2"]

mut_info <- rbind(mut_1, mut_2)

#- Hits that are identified as SLPs.
scr_res <- lapply(c("cell_1", "cell_2"), scr_slp, screen_hit, mut_info, merged_res)
scr_res[lengths(scr_res) == 0] <- NULL
scr_res <- rbindlist(scr_res)

k_res   <- cons_slp(scr_res, merged_res)
#- Filter results, e.g., by kappa_value and padj.
k_res_f <- k_res[kappa_value >= 0.6 & padj <= 0.1]

plan(sequential)

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
#> [1] doRNG_1.8.6.2     rngtools_1.5.2    data.table_1.17.8 mslp_1.12.0
#> [5] magrittr_2.0.4    doFuture_1.1.2    foreach_1.5.2     future_1.67.0
#> [9] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gmp_0.7-5            sass_0.4.10          generics_0.1.4
#>  [4] RSQLite_2.4.3        pROC_1.19.0.1        listenv_0.9.1
#>  [7] digest_0.6.37        evaluate_1.0.5       bookdown_0.45
#> [10] iterators_1.0.14     fastmap_1.2.0        blob_1.2.4
#> [13] jsonlite_2.0.0       AnnotationDbi_1.72.0 DBI_1.2.3
#> [16] BiocManager_1.30.26  httr_1.4.7           fmsb_0.7.6
#> [19] Biostrings_2.78.0    codetools_0.2-20     jquerylib_0.1.4
#> [22] cli_3.6.5            Rmpfr_1.1-2          crayon_1.5.3
#> [25] rlang_1.1.6          XVector_0.50.0       Biobase_2.70.0
#> [28] parallelly_1.45.1    future.apply_1.20.0  bit64_4.6.0-1
#> [31] cachem_1.1.0         yaml_2.3.10          tools_4.5.1
#> [34] parallel_4.5.1       memoise_2.0.1        globals_0.18.0
#> [37] BiocGenerics_0.56.0  png_0.1-8            vctrs_0.6.5
#> [40] org.Hs.eg.db_3.22.0  R6_2.6.1             stats4_4.5.1
#> [43] lifecycle_1.0.4      randomForest_4.7-1.2 Seqinfo_1.0.0
#> [46] KEGGREST_1.50.0      IRanges_2.44.0       S4Vectors_0.48.0
#> [49] bit_4.6.0            pkgconfig_2.0.3      bslib_0.9.0
#> [52] Rcpp_1.1.0           RankProd_3.36.0      xfun_0.53
#> [55] knitr_1.50           htmltools_0.5.8.1    rmarkdown_2.30
#> [58] compiler_4.5.1
```

# 4 Reference

[2]: Cerami, E. et al. The cBio Cancer Genomics Portal: An Open Platform for Exploring Multidimensional Cancer Genomics Data. Cancer Discovery 2, 401–404 (2012).

[3]: Breitling, R., Armengaud, P., Amtmann, A. & Herzyk, P. Rank products: a simple, yet powerful, new method to detect differentially regulated genes in replicated microarray experiments. FEBS Letters 573, 83–92 (2004).

[4]: Huynh-Thu, V. A., Irrthum, A., Wehenkel, L. & Geurts, P. Inferring Regulatory Networks from Expression Data Using Tree-Based Methods. PLoS ONE 5, e12776 (2010).

[5]: Barretina, J. et al. The Cancer Cell Line Encyclopedia enables predictive modeling of anticancer drug sensitivity. Nature 483, 603 (2012).

[6]: McDonald, E. R. et al. Project DRIVE: A Compendium of Cancer Dependencies and Synthetic Lethal Relationships Uncovered by Large-Scale, Deep RNAi Screening. Cell 170, 577-592.e10 (2017).

[7]: Tsherniak, A. et al. Defining a Cancer Dependency Map. Cell 170, 564-576.e16 (2017).