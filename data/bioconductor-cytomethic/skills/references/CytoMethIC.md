[[![](data:image/png;base64...)](https://www.bioconductor.org/packages/release/data/experiment/html/CytoMethIC.html)](index.html)

* [Basic Information](CytoMethIC.html)
* [Oncology](Oncology.html)

# 1. Basic Information

#### 6 November 2025

`CytoMethIC` is a comprehensive package that provides model data and functions for easily using machine learning models that use data from the DNA methylome to classify cancer type and phenotype from a sample. The primary motivation for the development of this package is to abstract away the granular and accessibility-limiting code required to utilize machine learning models in R. Our package provides this abstraction for RandomForest, e1071 Support Vector, Extreme Gradient Boosting, and Tensorflow models. This is paired with an ExperimentHub component, which contains our lab’s models developed for epigenetic cancer classification and predicting phenotypes. This includes CNS tumor classification, Pan-cancer classification, race prediction, cell of origin classification, and subtype classification models.

# MODELS

Models available are listed below:

CytoMethIC Basic Models

| EHID | ModelID | PredictionLabel |
| --- | --- | --- |
| NA | Age\_HM450\_20240504 | Age prediction (year) |
| NA | Age\_HM450\_20240611 | Age prediction (year) |
| NA | Age\_MM285\_20220101 | Age prediction (year) |
| NA | Age\_MM285\_20230101 | Age prediction (year) |
| NA | CellMethID\_mouseBlood\_MM285 | Deconvolution model for mouse blood components |
| NA | LeukoFrac\_HM27\_20240614 | Leukocyte fraction prediction (%) |
| NA | LeukoFrac\_HM450\_20240614 | Leukocyte fraction prediction (%) |
| NA | MIR200C\_EPIC\_20240315 | Mesenchymal score based on Mir200C meth [0-1] |
| NA | Race3\_InfHum3\_20240114 | Races (N=3) |
| EH8421 | Race5\_rfc | Races (N=5) |
| NA | Race5\_rfcTCGA\_InfHum3 | Races (N=5) |
| NA | RepliTali\_EPIC\_20240315 | Replication/mitotic age (scale-less) |
| NA | Sex2\_HM450\_20240114 | Sex (N=2) |
| NA | Sex2\_MM285\_20240114 | Sex (N=2) |
| NA | TissueComp\_EPIC\_20240717 | Tissue composition (%) |
| NA | TissueComp\_EPICv2\_20240717 | Tissue composition (%) |
| NA | TissueComp\_HM450\_20240827 | Tissue composition (%) |
| NA | TissueComp\_MSA\_20240717 | Tissue composition (%) |
| NA | TissueType\_EPIC\_20240610 | Dominating tissue type |
| NA | TissueType\_EPIC\_20240624 | Dominating tissue type |
| NA | TissueType\_EPICv2\_20240716 | Dominating tissue type |

One can access the model using the EHID above in `ExperimentHub()[["EHID"]]`.

More models (if EHID is NA) are available in the following [Github Repo](https://github.com/zhou-lab/CytoMethIC_models/tree/main/models). You can directly download them and load with `readRDS()`. Some examples using either approach are below.

# EXAMPLE INPUT

```
library(sesame)
library(CytoMethIC)
betasHM450 = imputeBetas(sesameDataGet("HM450.1.TCGA.PAAD")$betas)
```

To make models work for incompatible platforms, you could try the [mLiftOver](https://academic.oup.com/bioinformatics/article/40/7/btae423/7705981). Here is an example:

```
betasEPIC = openSesame(sesameDataGet("EPICv2.8.SigDF")[[1]], mask=FALSE)
betasHM450 = imputeBetas(mLiftOver(betasEPIC, "HM450"))
```

# SEX

```
model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/Sex2_HM450_20240114.rds"))
cmi_predict(betasHM450, model)
```

```
## $score
## [1] 0.8132805
##
## $sex
## [1] "MALE"
```

# AGE

```
model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/Age_HM450_20240504.rds"))
cmi_predict(betasHM450, model)
```

```
## $age
## [1] 84.13913
##
## $x
## [1] 3.054244
```

# RACE

The below snippet shows a demonstration of the cmi\_predict function working to predict the ethnicity of the patient.

```
model = ExperimentHub()[["EH8421"]] # the same as "https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/Race5_rfcTCGA_InfHum3.rds"
```

```
cmi_predict(betasHM450, model)
```

```
## $response
## [1] "WHITE"
##
## $prob
## WHITE
## 0.886
```

# CELL FRACTIONS

```
## leukocyte fractions
model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/LeukoFrac_HM450_20240614.rds"))
cmi_predict(betasHM450, model)
```

```
## $leukoFrac
## [1] 0.1960776
```

Cell-type deconvolution using Loyfer et al. conferences:

```
model = readRDS(url("https://github.com/zhou-lab/CytoMethIC_models/raw/refs/heads/main/models/TissueComp_HM450_20240827.rds"))
cell_comps = cmi_predict(betasHM450, model)
cell_comps = enframe(cell_comps$frac, name="cell_type", value="frac")
cell_comps = cell_comps |> filter(frac>0)

ggplot(cell_comps, aes(x="", y=frac, fill=cell_type)) +
    geom_bar(stat="identity", width=1) +
    coord_polar(theta="y") +
    theme_void() + labs(fill = "Cell Type") +
    theme(plot.title = element_text(hjust = 0.5))
```

![deconvolution](data:image/png;base64...)

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
##  [1] sesame_1.28.0       sesameData_1.28.0   CytoMethIC_1.6.0
##  [4] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
##  [7] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
## [10] knitr_1.50
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] filelock_1.0.3              Biostrings_2.78.0
##  [7] S7_0.2.0                    fastmap_1.2.0
##  [9] digest_0.6.37               lifecycle_1.0.4
## [11] KEGGREST_1.50.0             RSQLite_2.4.3
## [13] magrittr_2.0.4              compiler_4.5.1
## [15] rlang_1.1.6                 sass_0.4.10
## [17] tools_4.5.1                 yaml_2.3.10
## [19] S4Arrays_1.10.0             bit_4.6.0
## [21] curl_7.0.0                  DelayedArray_0.36.0
## [23] plyr_1.8.9                  RColorBrewer_1.1-3
## [25] abind_1.4-8                 BiocParallel_1.44.0
## [27] withr_3.0.2                 purrr_1.2.0
## [29] grid_4.5.1                  stats4_4.5.1
## [31] preprocessCore_1.72.0       wheatmap_0.2.0
## [33] colorspace_2.1-2            ggplot2_4.0.0
## [35] scales_1.4.0                dichromat_2.0-0.1
## [37] SummarizedExperiment_1.40.0 cli_3.6.5
## [39] rmarkdown_2.30              crayon_1.5.3
## [41] reshape2_1.4.4              httr_1.4.7
## [43] tzdb_0.5.0                  DBI_1.2.3
## [45] cachem_1.1.0                stringr_1.6.0
## [47] parallel_4.5.1              AnnotationDbi_1.72.0
## [49] BiocManager_1.30.26         XVector_0.50.0
## [51] matrixStats_1.5.0           vctrs_0.6.5
## [53] Matrix_1.7-4                jsonlite_2.0.0
## [55] IRanges_2.44.0              hms_1.1.4
## [57] S4Vectors_0.48.0            bit64_4.6.0-1
## [59] jquerylib_0.1.4             glue_1.8.0
## [61] codetools_0.2-20            stringi_1.8.7
## [63] gtable_0.3.6                BiocVersion_3.22.0
## [65] GenomicRanges_1.62.0        tibble_3.3.0
## [67] pillar_1.11.1               rappdirs_0.3.3
## [69] htmltools_0.5.8.1           Seqinfo_1.0.0
## [71] randomForest_4.7-1.2        R6_2.6.1
## [73] httr2_1.2.1                 evaluate_1.0.5
## [75] Biobase_2.70.0              lattice_0.22-7
## [77] readr_2.1.5                 png_0.1-8
## [79] memoise_2.0.1               BiocStyle_2.38.0
## [81] bslib_0.9.0                 Rcpp_1.1.0
## [83] SparseArray_1.10.1          xfun_0.54
## [85] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```