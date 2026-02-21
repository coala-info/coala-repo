# LRcellTypeMarkers: Marker gene information for LRcell R Bioconductor package using Bioconductor’s ExperimentHub

Wenjing Ma

#### 4 November 2025

# Contents

* [1 Download cell-type specific marker gene information](#download-cell-type-specific-marker-gene-information)
* [2 Usage of cell-type specific markers](#usage-of-cell-type-specific-markers)
* [3 sessionInfo()](#sessioninfo)

# 1 Download cell-type specific marker gene information

LRcellTypeMarkers currently provides gene enrichment scores for mouse whole brain
and human prefrontal cortex. These gene enrichment scores were calculated
using the algorithm proposed in (Marques et al. [2016](#ref-marques2016oligodendrocyte)). The detailed
procedures are described in `scripts/make-data.R`. Users are encouraged
to download the data, generate customized cell-type specific marker genes and
apply it in on bulk DE genes using [LRcell](https://github.com/marvinquiet/LRcell).

The example below shows how to download the data using ExperimentHub.

```
library(ExperimentHub)
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: generics
```

```
##
## Attaching package: 'generics'
```

```
## The following objects are masked from 'package:base':
##
##     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
##     setequal, union
```

```
##
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:stats':
##
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
##
##     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
##     as.data.frame, basename, cbind, colnames, dirname, do.call,
##     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
##     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
##     unsplit, which.max, which.min
```

```
## Loading required package: AnnotationHub
```

```
## Loading required package: BiocFileCache
```

```
## Loading required package: dbplyr
```

```
eh <- ExperimentHub()
eh <- query(eh, "LRcellTypeMarkers")
eh ## show entries of LRcellTypeMarkers package
```

```
## ExperimentHub with 15 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Emory University
## # $species: Mus musculus, Homo sapiens
## # $rdataclass: Matrix, list
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH4548"]]'
##
##            title
##   EH4548 | Mouse Frontal Cortex Marker Genes
##   EH4549 | Mouse Cerebellum Marker Genes
##   EH4550 | Mouse Entopeduncular Marker Genes
##   EH4551 | Mouse Globus Pallidus Marker Genes
##   EH4552 | Mouse Posterior Cortex Marker Genes
##   ...      ...
##   EH5420 | Human PBMC Marker Genes
##   EH6727 | MSigDB C8 MANNO MIDBRAIN
##   EH6728 | MSigDB C8 ZHENG CORD BLOOD
##   EH6729 | MSigDB C8 FAN OVARY
##   EH6730 | MSigDB C8 RUBENSTEIN SKELETAL MUSCLE
```

According to the description, users can choose the most suitable marker gene
information for further analysis. Here, we used mouse frontal cortex marker genes
as an example, which has the title as **EH4548**.

```
mouse_FC <- eh[['EH4548']]
```

```
## see ?LRcellTypeMarkers and browseVignettes('LRcellTypeMarkers') for documentation
```

```
## loading from cache
```

```
mouse_FC[1:6, 1:6]  # show head of the data
```

```
##               FC_1-1.Interneuron_CGE FC_1-10.Interneuron_CGE
## 0610005C13Rik            0.001478288             0.000000000
## 0610007P14Rik            0.058866903             0.073872567
## 0610009B22Rik            0.113303793             0.240960122
## 0610009E02Rik            0.009086005             0.000000000
## 0610009L18Rik            0.021694610             0.001329023
## 0610009O20Rik            0.027142597             0.023486916
##               FC_1-11.Interneuron_CGE FC_1-2.Interneuron_CGE
## 0610005C13Rik              0.00000000            0.000000000
## 0610007P14Rik              0.11023412            0.077231929
## 0610009B22Rik              0.07701829            0.043167790
## 0610009E02Rik              0.00212738            0.006541533
## 0610009L18Rik              0.00000000            0.014922859
## 0610009O20Rik              0.02644789            0.022989316
##               FC_1-3.Interneuron_CGE FC_1-4.Interneuron_CGE
## 0610005C13Rik            0.000000000            0.000000000
## 0610007P14Rik            0.076905406            0.044742740
## 0610009B22Rik            0.111148329            0.250265646
## 0610009E02Rik            0.000000000            0.000000000
## 0610009L18Rik            0.000000000            0.005565732
## 0610009O20Rik            0.009772696            0.004191282
```

From the data, we can observe that the rows are gene symbols and the columns are
the sub-cell types (or clusters). The values indicate the gene enrichment level
in a sub-cell type (or cluster). Higher the values are, more unique the genes
are in the certain cell types. Users can sort the enrichment score in a
descending order and select top 100 genes for each sub-cell type (or cluster)
using the following command or the function named `get_markergenes()` in LRcell.

Here, we take a glance at the first 6 clusters and the first 6 marker genes in
each cluster.

```
library(LRcell)
FC_marker_genes <- get_markergenes(mouse_FC, method="LR", topn=100)
head(lapply(FC_marker_genes, head))  # glance at the marker genes
```

```
## $`FC_1-1.Interneuron_CGE`
## [1] "Npy"    "Pde11a" "Kit"    "Gad2"   "Fam46a" "Pnoc"
##
## $`FC_1-10.Interneuron_CGE`
## [1] "Krt73"   "Npas1"   "Yjefn3"  "Dlx6os1" "Igf1"    "Sln"
##
## $`FC_1-11.Interneuron_CGE`
## [1] "Htr3a"     "Tnfaip8l3" "Npy2r"     "Adarb2"    "Npas1"     "Crabp1"
##
## $`FC_1-2.Interneuron_CGE`
## [1] "Ndnf"  "Kit"   "Reln"  "Npy"   "Cplx3" "Gad1"
##
## $`FC_1-3.Interneuron_CGE`
## [1] "Calb2"  "Crh"    "Nr2f2"  "Dlx1"   "Penk"   "Pcdh18"
##
## $`FC_1-4.Interneuron_CGE`
## [1] "Htr3a"    "Tac2"     "Vip"      "Crh"      "Crispld2" "Adarb2"
```

**Note**: For MSigDB C8 datasets, the marker genes are only available for
Logistic Regression (LR) analysis.

# 2 Usage of cell-type specific markers

LRcellTypeMarkers package is a data source for running LRcell analysis which
identifies (sub-)cell types are transcriptionally enriched in bulk differentially
expressed genes (DEGs) experiments. Here, we demonstrate an example on using provided
mouse brain Frontal Cortex marker genes on Alzheimer’s Disease (AD) to identify Microglia.

First, we load the sample bulk DEGs vector provided by LRcell package which
contrasts AD mice with wild type mouse at the timepoint of 6 months. The names
of the vector are the genes and values are the p-value calculated from DESeq2.

```
library(LRcell)
data("example_gene_pvals")
head(example_gene_pvals, n=5)
```

```
##         Xkr4          Rp1        Sox17       Mrpl15       Lypla1
## 1.742186e-05 4.103134e-02 9.697389e-02 1.206500e-02 6.609558e-01
```

Then, we applied LRcell analysis on this DEG list using the FC marker genes we just
acquired from the last section. Please note that the method for acquiring marker genes
and running LRcell should be the same.

```
res <- LRcellCore(gene.p = example_gene_pvals,
           marker.g = FC_marker_genes,
           method = "LR", min.size = 5,
           sig.cutoff = 0.05)
```

```
## Warning: glm.fit: algorithm did not converge
```

```
## curate cell types
res$cell_type <- unlist(lapply(strsplit(res$ID, '\\.'), '[', 2))
head(subset(res, select=-lead_genes))
```

```
##                        ID genes_num        coef odds_ratio     p.value
## 1  FC_1-1.Interneuron_CGE        98 0.011908189   1.076812 0.006035417
## 2 FC_1-10.Interneuron_CGE        92 0.006805227   1.043199 0.358384832
## 3 FC_1-11.Interneuron_CGE        95 0.006160366   1.039027 0.441406086
## 4  FC_1-2.Interneuron_CGE        98 0.009983947   1.064012 0.039942444
## 5  FC_1-3.Interneuron_CGE        85 0.004671113   1.029455 0.651009137
## 6  FC_1-4.Interneuron_CGE        98 0.006406322   1.040616 0.400647777
##          FDR       cell_type
## 1 0.01357969 Interneuron_CGE
## 2 0.41470245 Interneuron_CGE
## 3 0.48316072 Interneuron_CGE
## 4 0.05882433 Interneuron_CGE
## 5 0.66749038 Interneuron_CGE
## 6 0.45707704 Interneuron_CGE
```

Plot out the result using a function provided by LRcell:

```
plot_manhattan_enrich(res, sig.cutoff = .05, label.topn = 5)
```

![](data:image/png;base64...)

For further usage of LRcell, please check [LRcell Tutorial](https://github.com/marvinquiet/LRcell).

# 3 sessionInfo()

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
## [1] LRcell_1.18.0            LRcellTypeMarkers_1.18.0 ExperimentHub_3.0.0
## [4] AnnotationHub_4.0.0      BiocFileCache_3.0.0      dbplyr_2.5.1
## [7] BiocGenerics_0.56.0      generics_0.1.4           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      gtable_0.3.6         xfun_0.54
##  [4] bslib_0.9.0          ggplot2_4.0.0        httr2_1.2.1
##  [7] ggrepel_0.9.6        Biobase_2.70.0       vctrs_0.6.5
## [10] tools_4.5.1          stats4_4.5.1         curl_7.0.0
## [13] parallel_4.5.1       tibble_3.3.0         AnnotationDbi_1.72.0
## [16] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
## [19] RColorBrewer_1.1-3   S7_0.2.0             S4Vectors_0.48.0
## [22] lifecycle_1.0.4      farver_2.1.2         compiler_4.5.1
## [25] Biostrings_2.78.0    tinytex_0.57         Seqinfo_1.0.0
## [28] codetools_0.2-20     htmltools_0.5.8.1    sass_0.4.10
## [31] yaml_2.3.10          pillar_1.11.1        crayon_1.5.3
## [34] jquerylib_0.1.4      BiocParallel_1.44.0  cachem_1.1.0
## [37] magick_2.9.0         tidyselect_1.2.1     digest_0.6.37
## [40] dplyr_1.1.4          purrr_1.1.0          bookdown_0.45
## [43] BiocVersion_3.22.0   labeling_0.4.3       fastmap_1.2.0
## [46] grid_4.5.1           cli_3.6.5            magrittr_2.0.4
## [49] dichromat_2.0-0.1    withr_3.0.2          scales_1.4.0
## [52] filelock_1.0.3       rappdirs_0.3.3       bit64_4.6.0-1
## [55] rmarkdown_2.30       XVector_0.50.0       httr_1.4.7
## [58] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [61] evaluate_1.0.5       knitr_1.50           IRanges_2.44.0
## [64] rlang_1.1.6          Rcpp_1.1.0           glue_1.8.0
## [67] DBI_1.2.3            BiocManager_1.30.26  jsonlite_2.0.0
## [70] R6_2.6.1
```

Marques, Sueli, Amit Zeisel, Simone Codeluppi, David van Bruggen, Ana Mendanha Falcão, Lin Xiao, Huiliang Li, et al. 2016. “Oligodendrocyte Heterogeneity in the Mouse Juvenile and Adult Central Nervous System.” *Science* 352 (6291): 1326–9.