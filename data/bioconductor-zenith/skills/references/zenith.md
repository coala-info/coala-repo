# Zenith gene set testing after dream analysis

#### [Gabriel Hoffman](http://gabrielhoffman.github.io)

Icahn School of Medicine at Mount Sinai, New York

`zenith` performs gene set analysis on the result of differential expression using linear (mixed) modeling with [dream](https://doi.org/10.1093/bioinformatics/btaa687) by considering the correlation between gene expression traits. This package implements the [camera](https://www.rdocumentation.org/packages/limma/versions/3.28.14/topics/camera) method from the [limma](https://bioconductor.org/packages/limma/) package proposed by [Wu and Smyth (2012)](https://doi.org/10.1093/nar/gks461). `zenith()` is a simple extension of `camera()` to be compatible with linear (mixed) models implemented in `dream()`.

# Standard workflow

```
# Load packages
library(zenith)
library(edgeR)
library(variancePartition)
library(tweeDEseqCountData)
library(kableExtra)

# Load RNA-seq data from LCL's
data(pickrell)
geneCounts = exprs(pickrell.eset)
df_metadata = pData(pickrell.eset)

# Filter genes
# Note this is low coverage data, so just use as code example
dsgn = model.matrix(~ gender, df_metadata)
keep = filterByExpr(geneCounts, dsgn, min.count=5)

# Compute library size normalization
dge = DGEList(counts = geneCounts[keep,])
dge = calcNormFactors(dge)

# Estimate precision weights using voom
vobj = voomWithDreamWeights(dge, ~ gender, df_metadata)

# Apply dream analysis
fit = dream(vobj, ~ gender, df_metadata)
fit = eBayes(fit)

# Load get_MSigDB database, Hallmark genes
# use gene 'SYMBOL', or 'ENSEMBL' id
# use get_GeneOntology() to load Gene Ontology
msdb.gs = get_MSigDB("H", to="ENSEMBL")

# Run zenith analysis, and specific which coefficient to evaluate
res.gsa = zenith_gsa(fit, msdb.gs, 'gendermale', progressbar=FALSE )

# Show top gene sets: head(res.gsa)
kable_styling(kable(head(res.gsa), row.names=FALSE))
```

| coef | Geneset | NGenes | Correlation | delta | se | p.less | p.greater | PValue | Direction | FDR |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| gendermale | HALLMARK\_TNFA\_SIGNALING\_VIA\_NFKB | 118 | 0.01 | -0.9999389 | 0.1621467 | 0.0000000 | 1.0000000 | 0.0000000 | Down | 0.0000021 |
| gendermale | HALLMARK\_CHOLESTEROL\_HOMEOSTASIS | 37 | 0.01 | -1.0915363 | 0.2296170 | 0.0000055 | 0.9999945 | 0.0000110 | Down | 0.0002582 |
| gendermale | HALLMARK\_INFLAMMATORY\_RESPONSE | 93 | 0.01 | -0.7819360 | 0.1722474 | 0.0000120 | 0.9999880 | 0.0000241 | Down | 0.0003769 |
| gendermale | HALLMARK\_IL2\_STAT5\_SIGNALING | 105 | 0.01 | -0.6493291 | 0.1672385 | 0.0001194 | 0.9998806 | 0.0002389 | Down | 0.0028066 |
| gendermale | HALLMARK\_ESTROGEN\_RESPONSE\_LATE | 81 | 0.01 | -0.5424138 | 0.1789531 | 0.0017312 | 0.9982688 | 0.0034624 | Down | 0.0279921 |
| gendermale | HALLMARK\_EPITHELIAL\_MESENCHYMAL\_TRANSITION | 53 | 0.01 | -0.6136470 | 0.2031832 | 0.0017867 | 0.9982133 | 0.0035735 | Down | 0.0279921 |

```
# for each cell type select 3 genesets with largest t-statistic
# and 1 geneset with the lowest
# Grey boxes indicate the gene set could not be evaluted because
#    to few genes were represented
plotZenithResults(res.gsa)
```

![](data:image/png;base64...)

# Session Info

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
##  [1] kableExtra_1.4.0          tweeDEseqCountData_1.47.0
##  [3] Biobase_2.70.0            BiocGenerics_0.56.0
##  [5] generics_0.1.4            variancePartition_1.40.0
##  [7] BiocParallel_1.44.0       ggplot2_4.0.0
##  [9] edgeR_4.8.0               zenith_1.12.0
## [11] limma_3.66.0              knitr_1.50
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] farver_2.1.2                nloptr_2.2.1
##   [7] rmarkdown_2.30              vctrs_0.6.5
##   [9] memoise_2.0.1               minqa_1.2.8
##  [11] RCurl_1.98-1.17             htmltools_0.5.8.1
##  [13] S4Arrays_1.10.0             progress_1.2.3
##  [15] curl_7.0.0                  broom_1.0.10
##  [17] SparseArray_1.10.0          sass_0.4.10
##  [19] KernSmooth_2.23-26          bslib_0.9.0
##  [21] pbkrtest_0.5.5              plyr_1.8.9
##  [23] cachem_1.1.0                lifecycle_1.0.4
##  [25] iterators_1.0.14            pkgconfig_2.0.3
##  [27] Matrix_1.7-4                R6_2.6.1
##  [29] fastmap_1.2.0               rbibutils_2.3
##  [31] MatrixGenerics_1.22.0       digest_0.6.37
##  [33] numDeriv_2016.8-1.1         AnnotationDbi_1.72.0
##  [35] S4Vectors_0.48.0            textshaping_1.0.4
##  [37] GenomicRanges_1.62.0        RSQLite_2.4.3
##  [39] labeling_0.4.3              httr_1.4.7
##  [41] abind_1.4-8                 compiler_4.5.1
##  [43] withr_3.0.2                 bit64_4.6.0-1
##  [45] aod_1.3.3                   S7_0.2.0
##  [47] backports_1.5.0             DBI_1.2.3
##  [49] gplots_3.2.0                MASS_7.3-65
##  [51] DelayedArray_0.36.0         corpcor_1.6.10
##  [53] gtools_3.9.5                caTools_1.18.3
##  [55] tools_4.5.1                 msigdbr_25.1.1
##  [57] remaCor_0.0.20              glue_1.8.0
##  [59] nlme_3.1-168                grid_4.5.1
##  [61] reshape2_1.4.4              gtable_0.3.6
##  [63] tidyr_1.3.1                 hms_1.1.4
##  [65] xml2_1.4.1                  XVector_0.50.0
##  [67] pillar_1.11.1               stringr_1.5.2
##  [69] babelgene_22.9              splines_4.5.1
##  [71] dplyr_1.1.4                 lattice_0.22-7
##  [73] bit_4.6.0                   annotate_1.88.0
##  [75] tidyselect_1.2.1            locfit_1.5-9.12
##  [77] Biostrings_2.78.0           reformulas_0.4.2
##  [79] IRanges_2.44.0              Seqinfo_1.0.0
##  [81] SummarizedExperiment_1.40.0 svglite_2.2.2
##  [83] RhpcBLASctl_0.23-42         stats4_4.5.1
##  [85] xfun_0.53                   statmod_1.5.1
##  [87] matrixStats_1.5.0           KEGGgraph_1.70.0
##  [89] stringi_1.8.7               yaml_2.3.10
##  [91] boot_1.3-32                 evaluate_1.0.5
##  [93] codetools_0.2-20            tibble_3.3.0
##  [95] Rgraphviz_2.54.0            graph_1.88.0
##  [97] cli_3.6.5                   RcppParallel_5.1.11-1
##  [99] systemfonts_1.3.1           xtable_1.8-4
## [101] Rdpack_2.6.4                jquerylib_0.1.4
## [103] dichromat_2.0-0.1           Rcpp_1.1.0
## [105] zigg_0.0.2                  EnvStats_3.1.0
## [107] png_0.1-8                   XML_3.99-0.19
## [109] parallel_4.5.1              Rfast_2.1.5.2
## [111] assertthat_0.2.1            blob_1.2.4
## [113] prettyunits_1.2.0           bitops_1.0-9
## [115] lme4_1.1-37                 viridisLite_0.4.2
## [117] mvtnorm_1.3-3               GSEABase_1.72.0
## [119] lmerTest_3.1-3              scales_1.4.0
## [121] purrr_1.1.0                 crayon_1.5.3
## [123] fANCOVA_0.6-1               rlang_1.1.6
## [125] EnrichmentBrowser_2.40.0    KEGGREST_1.50.0
```