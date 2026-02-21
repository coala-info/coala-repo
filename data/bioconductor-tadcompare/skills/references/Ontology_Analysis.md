# Gene Ontology Enrichment Analysis

Kellen Cresswell1 and Mikhail Dozmorov1

1Department of Biostatistics, Virginia Commonwealth University, Richmond, VA

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Introduction](#introduction)
* [3 Performing gene ontology analysis using TADCompare](#performing-gene-ontology-analysis-using-tadcompare)
* [4 Session Info](#session-info)

# 1 Installation

```
BiocManager::install("TADCompare")
```

# 2 Introduction

Using the output of `TADCompare` and `TimeCompare`, we can do a range of analyses. One common one is gene ontology enrichment analysis to determine the pathways in which genes near TAD boundaries occur in. To do this, we use [rGREAT](https://bioconductor.org/packages/release/bioc/html/rGREAT.html) an R package for performing gene ontology enrichment analysis.

# 3 Performing gene ontology analysis using TADCompare

In the first example, we show how to perform gene ontology enrichment using differential boundaries. Here, we perform the analysis on shifted boundaries detected in matrix 1.

```
library(rGREAT)
# Reading in data
data("rao_chr22_prim")
data("rao_chr22_rep")

# Performing differential analysis
results <- TADCompare(rao_chr22_prim, rao_chr22_rep, resolution = 50000)

# Saving the results into its own data frame
TAD_Frame <- results$TAD_Frame

# Filter data to only include complex boundaries enriched in the second
# contact matrix
TAD_Frame <- TAD_Frame %>% dplyr::filter((Type == "Shifted") &
                                         (Enriched_In == "Matrix 2"))

# Assign a chromosome and convert to a bed format
TAD_Frame <- TAD_Frame %>% dplyr::select(Boundary) %>% mutate(chr = "chr22",
    start = Boundary, end = Boundary) %>% dplyr::select(chr, start, end)

# Set up rGREAT job with default parameters
great_shift <- submitGreatJob(TAD_Frame, request_interval = 1, version = "2.0")

# Submit the job
enrichment_table <- getEnrichmentTables(great_shift)

# Subset to only include vital information
enrichment_table <- bind_rows(enrichment_table, .id = "source") %>%
  dplyr::select(Ontology = source, Description = name,
                `P-value` = Hyper_Raw_PValue)

# Print head organizaed by p-values
head(enrichment_table %>% dplyr::arrange(`P-value`))
```

```
               Ontology                                          Description     P-value
1 GO Molecular Function                   gamma-glutamyltransferase activity 0.001802360
2 GO Biological Process                     glutathione biosynthetic process 0.002927596
3 GO Cellular Component         anchored to external side of plasma membrane 0.003152529
4 GO Cellular Component        intrinsic to external side of plasma membrane 0.004051881
5 GO Biological Process                         peptide biosynthetic process 0.004725996
6 GO Molecular Function transferase activity, transferring amino-acyl groups 0.004950625
```

The first column, “Ontology”, is simply the domain from which the corresponding ontology (“Description” column) comes from. Here, we use the default, which is the GO ontologies. For more available ontologies, see the [rGREAT vignette](https://bioconductor.org/packages/release/bioc/vignettes/rGREAT/inst/doc/rGREAT.html). “Description” is the pathway itself. “P-value” is the unadjusted hypergeometric p-value, as output by `rGREAT`. `rGREAT` also provides binomial p-values (Binom\_Raw\_Pvalue, Binom\_Adjp\_BH) and adjusted hypergeometric p-values (Hyper\_Adjp\_BH).

Now we demonstrate how to perform the same analysis but for all boundary types simultaneously. In this case, we use time-varying data.

```
# Read in time course data
data("time_mats")
# Identifying boundaries
results <- TimeCompare(time_mats, resolution = 50000)

# Pulling out the frame of TADs
TAD_Frame <- results$TAD_Bounds

# Getting coordinates for TAD boundaries and converting into bed format
Bound_List <- lapply(unique(TAD_Frame$Category), function(x) {
    TAD_Frame %>% filter((Category == x)) %>% mutate(chr = "chr22") %>%
        dplyr::select(chr, Coordinate) %>%
        mutate(start = Coordinate, end = Coordinate) %>%
        dplyr::select(chr, start, end)
})

# Performing rGREAT analysis for each boundary Category
TAD_Enrich <- lapply(Bound_List, function(x) {
  getEnrichmentTables(submitGreatJob(x, request_interval = 1, version = "2.0"))
})

# Name list of data frames to keep track of which enrichment belongs to which
names(TAD_Enrich) <- unique(TAD_Frame$Category)

# Bind each category of pathway and create new column for each pathway
TAD_Enrich <- lapply(names(TAD_Enrich), function(x) {
  bind_rows(lapply(TAD_Enrich[[x]], function(y) {
    y %>% mutate(Category = x)
  }), .id = "source")
})

# Bind each boundary category together and pull out important variables
enrichment_table <- bind_rows(TAD_Enrich) %>%
  dplyr::select(Ontology = source, Description = name,
                `P-value` = Hyper_Raw_PValue, Category)

# Get the top enriched pathways
head(enrichment_table %>% dplyr::arrange(`P-value`))
```

```
               Ontology                                              Description      P-value            Category
1 GO Biological Process positive regulation of B cell receptor signaling pathway 0.0002254283         Dynamic TAD
2 GO Molecular Function                               lipid transporter activity 0.0003760684   Highly Common TAD
3 GO Biological Process          regulation of B cell receptor signaling pathway 0.0004508185         Dynamic TAD
4 GO Biological Process                               Schwann cell proliferation 0.0006761897 Early Appearing TAD
5 GO Biological Process                            lipoprotein metabolic process 0.0007139088   Highly Common TAD
6 GO Molecular Function        peptide-methionine (R)-S-oxide reductase activity 0.0009015354   Highly Common TAD
```

These columns are the same as the differential analysis but with an extra column, “Category”, indicating the type of time-varying TAD boundary.

# 4 Session Info

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
## [1] microbenchmark_1.5.0 TADCompare_1.20.0    SpectralTAD_1.26.0
## [4] dplyr_1.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            farver_2.1.2
##  [3] S7_0.2.0                    fastmap_1.2.0
##  [5] TH.data_1.1-4               digest_0.6.37
##  [7] lifecycle_1.0.4             cluster_2.1.8.1
##  [9] survival_3.8-3              HiCcompare_1.32.0
## [11] magrittr_2.0.4              compiler_4.5.1
## [13] rlang_1.1.6                 sass_0.4.10
## [15] tools_4.5.1                 yaml_2.3.10
## [17] data.table_1.17.8           knitr_1.50
## [19] ggsignif_0.6.4              S4Arrays_1.10.0
## [21] PRIMME_3.2-6                DelayedArray_0.36.0
## [23] plyr_1.8.9                  RColorBrewer_1.1-3
## [25] multcomp_1.4-29             abind_1.4-8
## [27] BiocParallel_1.44.0         KernSmooth_2.23-26
## [29] withr_3.0.2                 purrr_1.1.0
## [31] BiocGenerics_0.56.0         grid_4.5.1
## [33] stats4_4.5.1                ggpubr_0.6.2
## [35] Rhdf5lib_1.32.0             ggplot2_4.0.0
## [37] MASS_7.3-65                 scales_1.4.0
## [39] gtools_3.9.5                tinytex_0.57
## [41] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [43] mvtnorm_1.3-3               cli_3.6.5
## [45] rmarkdown_2.30              generics_0.1.4
## [47] reshape2_1.4.4              cachem_1.1.0
## [49] rhdf5_2.54.0                stringr_1.5.2
## [51] splines_4.5.1               parallel_4.5.1
## [53] BiocManager_1.30.26         XVector_0.50.0
## [55] matrixStats_1.5.0           vctrs_0.6.5
## [57] sandwich_3.1-1              Matrix_1.7-4
## [59] carData_3.0-5               jsonlite_2.0.0
## [61] bookdown_0.45               car_3.1-3
## [63] IRanges_2.44.0              S4Vectors_0.48.0
## [65] rstatix_0.7.3               Formula_1.2-5
## [67] magick_2.9.0                jquerylib_0.1.4
## [69] tidyr_1.3.1                 glue_1.8.0
## [71] codetools_0.2-20            cowplot_1.2.0
## [73] stringi_1.8.7               gtable_0.3.6
## [75] GenomicRanges_1.62.0        tibble_3.3.0
## [77] pillar_1.11.1               htmltools_0.5.8.1
## [79] Seqinfo_1.0.0               rhdf5filters_1.22.0
## [81] R6_2.6.1                    evaluate_1.0.5
## [83] lattice_0.22-7              Biobase_2.70.0
## [85] backports_1.5.0             pheatmap_1.0.13
## [87] broom_1.0.10                bslib_0.9.0
## [89] Rcpp_1.1.0                  InteractionSet_1.38.0
## [91] gridExtra_2.3               SparseArray_1.10.0
## [93] nlme_3.1-168                mgcv_1.9-3
## [95] xfun_0.53                   zoo_1.8-14
## [97] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```