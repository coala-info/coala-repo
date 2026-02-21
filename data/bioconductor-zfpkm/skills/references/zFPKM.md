# Introduction to zFPKM Transformation

#### Ron Ammar

#### 2025-10-30

```
## Registered S3 method overwritten by 'printr':
##   method                from
##   knit_print.data.frame rmarkdown
```

## Summary

Perform the zFPKM transform on RNA-seq FPKM data. This algorithm is based on the publication by [Hart et al., 2013 (Pubmed ID 24215113)](https://www.ncbi.nlm.nih.gov/pubmed/24215113). The reference recommends using zFPKM > -3 to select expressed genes. Validated with ENCODE open/closed promoter chromatin structure epigenetic data on six of the ENCODE cell lines. It works well for gene level data using FPKM or TPM, but does not appear to calibrate well for transcript level data.

## Identifying *active* genes for subsequent analysis

We calculate zFPKM for existing FPKM from [gse94802](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=gse94802).

```
library(dplyr)
library(GEOquery)
library(stringr)
library(SummarizedExperiment)
library(tidyr)

getSpecificGEOSupp <- function(url) {
  temp <- tempfile()
  download.file(url, temp)
  out <- read.csv(gzfile(temp), row.names=1, check.names=FALSE)
  out <- select(out, -MGI_Symbol)
  return(out)
}

gse94802_fpkm <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE94nnn/GSE94802/suppl/GSE94802_Minkina_etal_normalized_FPKM.csv.gz"
gse94802_counts <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE94nnn/GSE94802/suppl/GSE94802_Minkina_etal_raw_counts.csv.gz"

if (file.exists("gse94802.rds")) {
  esetlist <- readRDS("gse94802.rds")
} else {
  esetlist <- getGEO("gse94802")
}

doe <- pData(esetlist[[1]])

colData <- DataFrame(
  condition=ifelse(str_detect(doe$title, regex("control", ignore_case=TRUE)), "control", "mutant"),
  sample_id=str_match(doe$title, "rep\\d_(.+)")[, 2],
  row.names=str_match(doe$title, "rep\\d_(.+)")[, 2])

se <- SummarizedExperiment(assays=SimpleList(fpkm=getSpecificGEOSupp(gse94802_fpkm),
                                             counts=getSpecificGEOSupp(gse94802_counts)),
                           colData=colData)

# clear namespace
rm(esetlist, gse94802_fpkm, gse94802_counts, doe, colData, getSpecificGEOSupp)
```

We compute zFPKM.

```
library(zFPKM)
assay(se, "zfpkm") <- zFPKM(se)
```

We can also plot the Guassian fit to the FPKM data for which the z-scores are based.

```
zFPKMPlot(se)
```

![](data:image/png;base64...)

To determine which genes are *active*, we compute the median expression within each group.

```
activeGenes <- assay(se, "zfpkm") %>%
  mutate(gene=rownames(assay(se, "zfpkm"))) %>%
  gather(sample_id, zfpkm, -gene) %>%
  left_join(select(as.data.frame(colData(se)), sample_id, condition), by="sample_id") %>%
  group_by(gene, condition) %>%
  summarize(median_zfpkm=median(zfpkm)) %>%
  ungroup() %>%
  mutate(active=(median_zfpkm > -3)) %>%
  filter(active) %>%
  select(gene) %>%
  distinct()

seActive <- SummarizedExperiment(
  assays=SimpleList(counts=as.matrix(assay(se, "counts")[activeGenes$gene, ])),
  colData=colData(se))
```

In the following DE analysis, we only use genes that were active in either group.

```
library(limma)
library(edgeR)

# Generate normalized log2CPM from counts AFTER we filter for protein-coding
# genes that are detectably expressed.
dge <- DGEList(counts=assay(seActive, "counts"))
dge <- calcNormFactors(dge)
design <- model.matrix(~ 0 + condition, data=colData(seActive))
vq <- voomWithQualityWeights(dge, design, plot=TRUE)
```

![](data:image/png;base64...)

```
fit <- lmFit(vq, design)
contrastMatrix <- makeContrasts(conditioncontrol - conditionmutant, levels=design)
fit <- contrasts.fit(fit, contrastMatrix)
fit <- eBayes(fit, robust=TRUE)
deGenes <- topTable(fit, number=Inf)
```

### References

Hart T, Komori HK, LaMere S, Podshivalova K, Salomon DR. Finding the active genes in deep RNA-seq gene expression studies. BMC Genomics. 2013 Nov 11;14:778. doi: 10.1186/1471-2164-14-778.

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] edgeR_4.8.0                 limma_3.66.0
##  [3] zFPKM_1.32.0                tidyr_1.3.1
##  [5] SummarizedExperiment_1.40.0 GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           stringr_1.5.2
## [13] GEOquery_2.78.0             Biobase_2.70.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] dplyr_1.1.4                 printr_0.3
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] ggplot2_4.0.0       lattice_0.22-7      tzdb_0.5.0
##  [7] vctrs_0.6.5         tools_4.5.1         tibble_3.3.0
## [10] pkgconfig_2.0.3     Matrix_1.7-4        data.table_1.17.8
## [13] checkmate_2.3.3     rentrez_1.2.4       RColorBrewer_1.1-3
## [16] S7_0.2.0            lifecycle_1.0.4     compiler_4.5.1
## [19] farver_2.1.2        statmod_1.5.1       htmltools_0.5.8.1
## [22] sass_0.4.10         yaml_2.3.10         pillar_1.11.1
## [25] jquerylib_0.1.4     DelayedArray_0.36.0 cachem_1.1.0
## [28] abind_1.4-8         locfit_1.5-9.12     tidyselect_1.2.1
## [31] digest_0.6.37       stringi_1.8.7       purrr_1.1.0
## [34] labeling_0.4.3      fastmap_1.2.0       grid_4.5.1
## [37] cli_3.6.5           SparseArray_1.10.0  magrittr_2.0.4
## [40] S4Arrays_1.10.0     dichromat_2.0-0.1   XML_3.99-0.19
## [43] readr_2.1.5         withr_3.0.2         scales_1.4.0
## [46] backports_1.5.0     rmarkdown_2.30      XVector_0.50.0
## [49] hms_1.1.4           evaluate_1.0.5      knitr_1.50
## [52] rlang_1.1.6         glue_1.8.0          xml2_1.4.1
## [55] jsonlite_2.0.0      R6_2.6.1
```