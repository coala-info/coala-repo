# CITE-seq setup for scviR, 2025

Vince Carey stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Overview](#overview)
* [2 Acquire CITE-seq data from 10x human discovery platform (15k cells, 349 proteins)](#acquire-cite-seq-data-from-10x-human-discovery-platform-15k-cells-349-proteins)
* [3 Use the scvi-tools approach to preprocessing](#use-the-scvi-tools-approach-to-preprocessing)
* [4 Prepare for TOTALVI](#prepare-for-totalvi)
* [5 Train TOTALVI](#train-totalvi)
* [6 Session info](#session-info)

# 1 Overview

This vignette concerns a 2025 update of scviR.

The objective is to allow exploration of CITE-seq data
with TOTALVI as illustrated in notebooks provided
in the scvi-tools project. Ultimately it would
be desirable to compare the analyses of the OSCA book
to those produced with TOTALVI, but at this time
we are focused on tool interoperability.

As of May 2025, use BiocManager to install scviR in R 4.5 or above:

```
BiocManager::install("scviR")
```

Note that this package uses basilisk primarily to pin
versions of associated software. We expose python objects
in the global environment. When the required API comes
into focus, more isolation of python operations and objects
will be established.

# 2 Acquire CITE-seq data from 10x human discovery platform (15k cells, 349 proteins)

```
library(scviR)
HDP.h5 = cacheCiteseqHDPdata()
mdata1 = muonR()$read_10x_h5(HDP.h5)
mdata1$mod["rna"]$var_names_make_unique()
reticulate::py_run_string('r.mdata1.mod["rna"].layers["counts"] = r.mdata1.mod["rna"].X.copy()')
mdata1
```

```
## MuData object with n_obs × n_vars = 15530 × 18431
##   var:   'gene_ids', 'feature_types', 'ENS.GENE', 'IsoCtrl', 'genome', 'map_rna', 'pattern', 'read', 'sequence', 'uniprot'
##   2 modalities
##     rna: 15530 x 18082
##       var:   'gene_ids', 'feature_types', 'ENS.GENE', 'IsoCtrl', 'genome', 'map_rna', 'pattern', 'read', 'sequence', 'uniprot'
##       layers:    'counts'
##     prot:    15530 x 349
##       var:   'gene_ids', 'feature_types', 'ENS.GENE', 'IsoCtrl', 'genome', 'map_rna', 'pattern', 'read', 'sequence', 'uniprot'
```

# 3 Use the scvi-tools approach to preprocessing

Filter genes using scanpy.

```
scr = scanpyR()
scr$pp$normalize_total(mdata1$mod["rna"])
scr$pp$log1p(mdata1$mod["rna"])
#
scr$pp$highly_variable_genes(
    mdata1$mod["rna"],
    n_top_genes=4000L,
    flavor="seurat_v3",
    layer="counts",
)
```

Add the filtered data to the MuData instance.

```
reticulate::py_run_string('r.mdata1.mod["rna_subset"] = r.mdata1.mod["rna"][:, r.mdata1.mod["rna"].var["highly_variable"]].copy()')
mdata1 = MuDataR()$MuData(mdata1$mod)
```

Produce dense versions of quantification matrices, and “update”.

```
reticulate::py_run_string('r.mdata1["prot"].X = r.mdata1["prot"].X.toarray()')
reticulate::py_run_string('r.mdata1["rna_subset"].X = r.mdata1["rna_subset"].X.toarray()')
reticulate::py_run_string('r.mdata1.mod["rna_subset"].layers["counts"] = r.mdata1.mod["rna_subset"].layers["counts"].toarray()')
mdata1$update()
```

# 4 Prepare for TOTALVI

Text of notebook:

```
Now we run `setup_mudata`, which is the MuData analog to `setup_anndata`.
The caveat of this workflow is that we need to provide this function which
modality of the `mdata` object contains each piece of data. So for example,
the batch information is in `mdata.mod["rna"].obs["batch"]`. Therefore, in the `modalities`
argument below we specify that the `batch_key` can be
found in the `"rna_subset"` modality of the MuData object.

Notably, we provide `protein_layer=None`. This means scvi-tools will pull
information from `.X` from the modality specified in `modalities` (`"protein"`
in this case). In the case of RNA, we want to use the counts,
which we stored in `mdata.mod["rna"].layers["counts"]`.
```

```
scviR()$model$TOTALVI$setup_mudata(
    mdata1,
    rna_layer="counts",
    protein_layer=reticulate::py_none(),
    modalities=list(
        "rna_layer"= "rna_subset",
        "protein_layer"= "prot",
        "batch_key"= "rna_subset"
    ),
)
```

# 5 Train TOTALVI

Here’s the model:

```
model = scviR()$model$TOTALVI(mdata1)
model
```

Use `model$module` to see the complete architecture.

Perform truncated training:

```
n_epochs = 50L
n_epochs.cpu = 5L
acc = "cpu"
tchk = try(reticulate::import("torch"))
if (!inherits(tchk, "try-error") && tchk$backends$mps$is_available()) acc = "mps"
if (!inherits(tchk, "try-error") && tchk$cuda$is_available()) acc = "gpu"
#runtim.cpu = system.time(model$train(max_epochs=n_epochs.cpu, accelerator = "cpu"))
runtim.cpu = c(NA,NA,NA)
runtim = system.time(model$train(max_epochs=n_epochs, accelerator = acc))
```

The gpu processor was used leading to an average clock time per epoch of 1.05
seconds.

By contrast, the average epoch runtime for a very short run with CPU only is NA.

Extract the ELBO criteria. The plot below includes both the CPU and GPU (if available) results.

```
total_ep = n_epochs # + n_epochs.cpu
val_elbo = unlist(model$history$elbo_validation)
tr_elbo = model$history$elbo_train$elbo_trai
plot(1:total_ep, tr_elbo, type="l", xlab="epoch", ylab="ELBO", ylim=c(0,7000))
lines(1:total_ep, val_elbo, col="blue")
legend(3, 6000, col=c("black", "blue"), lty=1, legend=c("train", "validate"))
```

![](data:image/png;base64...)

# 6 Session info

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88803)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /media/volume/biocgpu2/biocbuild/bbs-3.22-bioc-gpu/R/lib/libRblas.so
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] scviR_1.10.0                shiny_1.11.1
##  [3] basilisk_1.21.5             reticulate_1.44.0
##  [5] scater_1.37.0               ggplot2_4.0.0
##  [7] scuttle_1.19.0              SingleCellExperiment_1.31.1
##  [9] SummarizedExperiment_1.39.2 Biobase_2.69.1
## [11] GenomicRanges_1.61.8        Seqinfo_0.99.4
## [13] IRanges_2.43.8              S4Vectors_0.47.6
## [15] BiocGenerics_0.55.4         generics_0.1.4
## [17] MatrixGenerics_1.21.0       matrixStats_1.5.0
## [19] BiocStyle_2.37.1
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            gridExtra_2.3        httr2_1.2.1
##  [4] rlang_1.1.6          magrittr_2.0.4       otel_0.2.0
##  [7] compiler_4.5.1       RSQLite_2.4.3        mgcv_1.9-3
## [10] dir.expiry_1.17.0    png_0.1-8            vctrs_0.6.5
## [13] pkgconfig_2.0.3      fastmap_1.2.0        dbplyr_2.5.1
## [16] XVector_0.49.3       labeling_0.4.3       promises_1.4.0
## [19] rmarkdown_2.30       ggbeeswarm_0.7.2     tinytex_0.57
## [22] purrr_1.1.0          bit_4.6.0            xfun_0.53
## [25] cachem_1.1.0         beachmat_2.25.5      jsonlite_2.0.0
## [28] blob_1.2.4           later_1.4.4          DelayedArray_0.35.4
## [31] BiocParallel_1.43.4  irlba_2.3.5.1        parallel_4.5.1
## [34] R6_2.6.1             bslib_0.9.0          RColorBrewer_1.1-3
## [37] limma_3.65.7         jquerylib_0.1.4      Rcpp_1.1.0
## [40] bookdown_0.45        knitr_1.50           splines_4.5.1
## [43] httpuv_1.6.16        Matrix_1.7-4         tidyselect_1.2.1
## [46] abind_1.4-8          yaml_2.3.10          viridis_0.6.5
## [49] codetools_0.2-20     curl_7.0.0           lattice_0.22-7
## [52] tibble_3.3.0         withr_3.0.2          S7_0.2.0
## [55] evaluate_1.0.5       BiocFileCache_2.99.6 pillar_1.11.1
## [58] BiocManager_1.30.26  filelock_1.0.3       rprojroot_2.1.1
## [61] scales_1.4.0         xtable_1.8-4         glue_1.8.0
## [64] pheatmap_1.0.13      tools_4.5.1          BiocNeighbors_2.3.1
## [67] ScaledMatrix_1.17.0  cowplot_1.2.0        grid_4.5.1
## [70] nlme_3.1-168         beeswarm_0.4.0       BiocSingular_1.25.1
## [73] vipor_0.4.7          cli_3.6.5            rsvd_1.0.5
## [76] rappdirs_0.3.3       S4Arrays_1.9.2       viridisLite_0.4.2
## [79] dplyr_1.1.4          gtable_0.3.6         sass_0.4.10
## [82] digest_0.6.37        SparseArray_1.9.1    ggrepel_0.9.6
## [85] farver_2.1.2         memoise_2.0.1        htmltools_0.5.8.1
## [88] lifecycle_1.0.4      here_1.0.2           statmod_1.5.1
## [91] mime_0.13            bit64_4.6.0-1
```