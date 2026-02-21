# Example using structToolbox

Gavin R Lloyd1\* and Ralf J Weber1\*\*

1Phenome Centre Birmingham, University of Birmingham, UK

\*g.r.lloyd@bham.ac.uk
\*\*r.j.weber@bham.ac.uk

#### 22 December 2025

#### Package

metabolomicsWorkbenchR 1.20.0

# 1 Introduction

Metabolomics Workbench [(link)](www.metabolomicsworkbench.org) hosts a metabolomics
data repository. It contains over 1000 publicly available studies including raw data,
processed data and metabolite/compound information.

The repository is searchable using a REST service API. The metabolomicsWorkbenchR
package makes the endpoints of this service available in R and provides functionality
to search the database and import datasets and metabolite information into commonly used
formats such as data frames and SummarizedExperiment objects.

In this vigenette we will use `metabolomicsWorkbenchR` to retrieve the uploaded peak matrix
for a study. We will then use `structToolbox` to apply a basic workflow to analyse the data.

# 2 Installation

To install this package enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("metabolomicsWorkbenchR")
```

For older versions, please refer to the appropriate Bioconductor release.

# 3 Querying the database

The API endpoints for Metabolomics Workbench are accessible using the `do_query`
function in `metabolomicsWorkBenchR`.

The `do_query` functions takes 4 inputs:
- `context` A valid context name (character)
- `input_item` A valid input\_item name (character)
- `input_value` A valid input\_value name (character)
- `output_item` A valid output\_item (character)

Contexts refer to the different database searches available in the API. The reader
is referred to the API manual for details of each context
[(link)](https://www.metabolomicsworkbench.org/tools/mw_rest.php).
In `metabolomicsWorkBenchR` contexts are stored as a list, and a list of valid
contexts can be obtained using the `names` function:

```
names(metabolomicsWorkbenchR::context)
```

```
## [1] "study"     "compound"  "refmet"    "gene"      "protein"   "moverz"
## [7] "exactmass"
```

`input_item` is specific to a context. Valid items for a context can
be listed using `context_inputs` function:

```
cat('Valid inputs:\n')
```

```
## Valid inputs:
```

```
context_inputs('study')
```

```
## [1] "study_id"      "study_title"   "institute"     "last_name"
## [5] "analysis_id"   "metabolite_id"
```

```
cat('\nValid outputs:\n')
```

```
##
## Valid outputs:
```

```
context_outputs('study')
```

```
##  [1] "summary"                     "factors"
##  [3] "analysis"                    "metabolites"
##  [5] "mwtab"                       "source"
##  [7] "species"                     "disease"
##  [9] "number_of_metabolites"       "data"
## [11] "datatable"                   "untarg_studies"
## [13] "untarg_factors"              "untarg_data"
## [15] "metabolite_info"             "SummarizedExperiment"
## [17] "untarg_SummarizedExperiment" "DatasetExperiment"
## [19] "untarg_DatasetExperiment"
```

# 4 Choosing a study

First we query the database to return a list of untargeted studies. We use the
“study” context in combination with a special case input item called “ignored”
that is required for the “untarg\_studies” output item.

```
US = do_query(
  context = 'study',
  input_item = 'ignored',
  input_value = 'ignored',
  output_item = 'untarg_studies'
)

head(US[,1:3])
```

```
##   study_id analysis_id                         analysis_display
## 1 ST000009    AN000023 LC/Electro-spray /QTOF positive ion mode
## 2 ST000009    AN000024 LC/Electro-spray /QTOF negative ion mode
## 3 ST000010    AN000025 LC/Electro-spray /QTOF positive ion mode
## 4 ST000010    AN000026 LC/Electro-spray /QTOF negative ion mode
## 5 ST000045    AN000072                 MS positive ion mode/C18
## 6 ST000045    AN000073               MS positive ion mode/HILIC
```

We will pull data for study “ST000009”. We can obtain summary information using
the “summary” output item.

```
S = do_query('study','study_id','ST000010','summary')
t(S)
```

```
##                 [,1]
## study_id        "ST000010"
## study_title     "Lung Cancer Cells 4"
## study_type      "MS analysis (Untargeted)"
## institute       "University of Michigan"
## department      ""
## last_name       "Keshamouni"
## first_name      "Venkat"
## email           "vkeshamo@umich.edu"
## phone           ""
## submit_date     "2013-04-03"
## study_summary   "In cancer cells, the process of epithelial–mesenchymal transition (EMT) confers migratory and invasive capacity, resistance to apoptosis, drug resistance, evasion of host immune surveillance and tumor stem cell traits. Cells undergoing EMT may represent tumor cells with metastatic potential. Characterizing the EMT secretome may identify biomarkers to monitor EMT in tumor progression and provide a prognostic signature to predict patient survival. Utilizing a transforming growth factor-β-induced cell culture model of EMT, we quantitatively profiled differentially secreted proteins, by GeLC-tandem mass spectrometry. Integrating with the corresponding transcriptome, we derived an EMT-associated secretory phenotype (EASP) comprising of proteins that were differentially upregulated both at protein and mRNA levels. Four independent primary tumor-derived gene expression data sets of lung cancers were used for survival analysis by the random survival forests (RSF) method. Analysis of 97-gene EASP expression in human lung adenocarcinoma tumors revealed strong positive correlations with lymph node metastasis, advanced tumor stage and histological grade. RSF analysis built on a training set (n = 442), including age, sex and stage as variables, stratified three independent lung cancer data sets into low-, medium- and high-risk groups with significant differences in overall survival. We further refined EASP to a 20 gene signature (rEASP) based on variable importance scores from RSF analysis. Similar to EASP, rEASP predicted survival of both adenocarcinoma and squamous carcinoma patients. More importantly, it predicted survival in the early-stage cancers. These results demonstrate that integrative analysis of the critical biological process of EMT provides mechanism-based and clinically relevant biomarkers with significant prognostic value.\nResearch is published, core data not used but project description is relevant:\nhttp://www.jimmunol.org/content/194/12/5789.long\n"
## subject_species "Homo sapiens"
```

As there are multiple datasets per study untargeted data needs to be requested
by Analysis ID. We will request DatasetExperiment format so that we can use the
data directly with `structToolbox`.

```
DE = do_query(
  context = 'study',
  input_item = 'analysis_id',
  input_value = 'AN000025',
  output_item = 'untarg_DatasetExperiment'
)
DE
```

# 5 Workflow

Now we construct a minimal metabolomics workflow consisting of quality filtering,
normalisation, imputation and scaling before applying PCA.

```
# model sequence
M =
    mv_feature_filter(
      threshold = 40,
      method='across',
      factor_name='FCS') +
    mv_sample_filter(mv_threshold =40) +
    vec_norm() +
    knn_impute() +
    log_transform() +
    mean_centre() +
    PCA()
# apply model
M = model_apply(M,DE)

# pca scores plot
C = pca_scores_plot(factor_name=c('FCS'))
chart_plot(C,M[length(M)])
```

![](data:image/png;base64...)

# 6 Session Info

```
## R version 4.5.2 (2025-10-31)
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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] structToolbox_1.22.0          struct_1.22.1
## [3] curl_7.0.0                    metabolomicsWorkbenchR_1.20.0
## [5] httptest_4.2.3                testthat_3.3.1
## [7] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                S7_0.2.1
##  [5] fastmap_1.2.0               digest_0.6.39
##  [7] lifecycle_1.0.4             magrittr_2.0.4
##  [9] compiler_4.5.2              rngtools_1.5.2
## [11] rlang_1.1.6                 sass_0.4.10
## [13] tools_4.5.2                 yaml_2.3.12
## [15] data.table_1.17.8           knitr_1.51
## [17] labeling_0.4.3              doRNG_1.8.6.2
## [19] S4Arrays_1.10.1             ontologyIndex_2.12
## [21] sp_2.2-0                    DelayedArray_0.36.0
## [23] plyr_1.8.9                  RColorBrewer_1.1-3
## [25] abind_1.4-8                 withr_3.0.2
## [27] purrr_1.2.0                 itertools_0.1-3
## [29] BiocGenerics_0.56.0         stats4_4.5.2
## [31] ggplot2_4.0.1               scales_1.4.0
## [33] iterators_1.0.14            tinytex_0.58
## [35] MultiAssayExperiment_1.36.1 dichromat_2.0-0.1
## [37] SummarizedExperiment_1.40.0 cli_3.6.5
## [39] rmarkdown_2.30              generics_0.1.4
## [41] otel_0.2.0                  reshape2_1.4.5
## [43] httr_1.4.7                  BiocBaseUtils_1.12.0
## [45] cachem_1.1.0                stringr_1.6.0
## [47] ggthemes_5.2.0              parallel_4.5.2
## [49] impute_1.84.0               BiocManager_1.30.27
## [51] XVector_0.50.0              matrixStats_1.5.0
## [53] vctrs_0.6.5                 Matrix_1.7-4
## [55] jsonlite_2.0.0              bookdown_0.46
## [57] IRanges_2.44.0              S4Vectors_0.48.0
## [59] magick_2.9.0                foreach_1.5.2
## [61] jquerylib_0.1.4             missForest_1.6.1
## [63] glue_1.8.0                  codetools_0.2-20
## [65] stringi_1.8.7               gtable_0.3.6
## [67] GenomicRanges_1.62.1        tibble_3.3.0
## [69] pillar_1.11.1               pcaMethods_2.2.0
## [71] htmltools_0.5.9             Seqinfo_1.0.0
## [73] brio_1.1.5                  pmp_1.22.1
## [75] randomForest_4.7-1.2        R6_2.6.1
## [77] Rdpack_2.6.4                evaluate_1.0.5
## [79] lattice_0.22-7              Biobase_2.70.0
## [81] rbibutils_2.4               bslib_0.9.0
## [83] Rcpp_1.1.0                  gridExtra_2.3
## [85] SparseArray_1.10.8          ranger_0.17.0
## [87] xfun_0.55                   MatrixGenerics_1.22.0
## [89] pkgconfig_2.0.3
```