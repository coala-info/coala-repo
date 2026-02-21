# Confident fold change

Paul Harrison

#### 2025-10-30

# Contents

* [1 limma analysis](#limma-analysis)
  + [1.1 Standard limma analysis steps](#standard-limma-analysis-steps)
  + [1.2 Apply topconfects](#apply-topconfects)
  + [1.3 Looking at the result](#looking-at-the-result)
* [2 edgeR analysis](#edger-analysis)
  + [2.1 Standard edgeR analysis](#standard-edger-analysis)
  + [2.2 Apply topconfects](#apply-topconfects-1)
  + [2.3 Looking at the result](#looking-at-the-result-1)
* [3 DESeq2 analysis](#deseq2-analysis)
  + [3.1 Apply topconfects](#apply-topconfects-2)
  + [3.2 Looking at the result](#looking-at-the-result-2)
* [4 Comparing results](#comparing-results)

This document shows typical Topconfects usage with limma, edgeR, or DESeq2.

The first step is to load a dataset. Here, we’re looking at RNA-seq data that
investigates the response of *Arabodopsis thaliana* to a bacterial pathogen.
Besides the experimental and control conditions, there is also a batch effect.
This dataset is also examined in section 4.2 of the `edgeR` user manual, and
I’ve followed the initial filtering steps in the `edgeR` manual.

```
library(topconfects)

library(NBPSeq)
library(edgeR)
library(limma)

library(dplyr)
library(ggplot2)

data(arab)

# Retrieve symbol for each gene
info <-
    AnnotationDbi::select(
        org.At.tair.db::org.At.tair.db,
        rownames(arab), "SYMBOL") %>%
    group_by(TAIR) %>%
    summarize(
        SYMBOL=paste(unique(na.omit(SYMBOL)),collapse="/"))
arab_info <-
    info[match(rownames(arab),info$TAIR),] %>%
    select(-TAIR) %>%
    as.data.frame
rownames(arab_info) <- rownames(arab)

# Extract experimental design from sample names
Treat <- factor(substring(colnames(arab),1,4)) %>% relevel(ref="mock")
Time <- factor(substring(colnames(arab),5,5))

y <- DGEList(arab, genes=as.data.frame(arab_info))

# Keep genes with at least 3 samples having an RPM of more than 2
keep <- rowSums(cpm(y)>2) >= 3
y <- y[keep,,keep.lib.sizes=FALSE]
y <- calcNormFactors(y)
```

# 1 limma analysis

## 1.1 Standard limma analysis steps

We use the voom-limma method.

```
design <- model.matrix(~Time+Treat)
design[,]
```

```
##   (Intercept) Time2 Time3 Treathrcc
## 1           1     0     0         0
## 2           1     1     0         0
## 3           1     0     1         0
## 4           1     0     0         1
## 5           1     1     0         1
## 6           1     0     1         1
```

```
fit <-
    voom(y, design) %>%
    lmFit(design)
```

## 1.2 Apply topconfects

Find largest fold changes that we can be confident of at FDR 0.05.

```
confects <- limma_confects(fit, coef="Treathrcc", fdr=0.05)

confects
```

```
## $table
##    confect effect AveExpr name      SYMBOL
## 1  3.086   4.845  6.567   AT3G46280
## 2  2.894   4.332  9.155   AT4G12500
## 3  2.894   4.492  6.053   AT2G19190 FRK1/SIRK
## 4  2.608   3.838  9.166   AT4G12490 AZI3
## 5  2.608   4.301  5.440   AT2G39530 CASPL4D1
## 6  2.608   3.953  6.615   AT1G51800 IOS1
## 7  2.608   5.363  1.807   AT5G31702
## 8  2.608   3.905  7.899   AT2G39200 ATMLO12/MLO12
## 9  2.606   4.905  2.383   AT2G08986
## 10 2.606   3.710  8.729   AT5G64120 AtPRX71/PRX71
## ...
## 2202 of 16526 non-zero log2 fold change at FDR 0.05
## Prior df 18.6
```

Note: If not using `voom` or a similar precision weighting method, it may be important to use `limma_confects(..., trend=TRUE)` to account for a mean-variance trend, similar to how you would call `limma::treat(..., trend=TRUE)`. You can check the need for this with `limma::plotSA(fit)`.

## 1.3 Looking at the result

Here the usual `logFC` values estimated by `limma` are shown as dots, with lines
to the `confect` value.

```
confects_plot(confects)
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the topconfects package.
##   Please report the issue at <https://github.com/pfh/topconfects/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

`confects_plot_me2` produces a Mean-Difference Plot (as might be produced by `limma::plotMD`),
and colors points based on thresholds for the `confect` values.
Effect sizes confidently “> 0” correspond to traditional differential expression testing,
and effect sizes confidently greater than larger values correspond to the TREAT test at that
threshold.
I have specified the `breaks` here explicitly,
to aid comparison with other methods in similar plots below.

```
confects_plot_me2(confects, breaks=c(0,1,2))
```

![](data:image/png;base64...)

You can see that while large estimated effect sizes are produced at low expression levels,
this is mostly due to noise in the estimates. They are not *confidently* large expression levels.

There is also a `confects_plot_me`, which I no longer recommend.
This overlays the confects (red/blue) on a Mean-Difference Plot (grey).
This proved to be confusing, as significant gene are represented by two different points.

```
confects_plot_me(confects) + labs(title="This plot is not recommended")
```

![](data:image/png;base64...)

Let’s compare this to the ranking we obtain from `topTable`.

```
fit_eb <- eBayes(fit)
top <- topTable(fit_eb, coef="Treathrcc", n=Inf)

rank_rank_plot(confects$table$name, rownames(top), "limma_confects", "topTable")
```

![](data:image/png;base64...)

You can see that the top 19 genes from topTable are all within the top 40 for
topconfects ranking, but topconfects has also highly ranked some other genes.
These have a large effect size, and sufficient if not overwhelming evidence of
this.

An MD-plot highlighting the positions of the top 40 genes in both rankings also
illustrates the differences between these two ways of ranking genes.

```
plotMD(fit, legend="bottomleft", status=paste0(
    ifelse(rownames(fit) %in% rownames(top)[1:40], "topTable ",""),
    ifelse(rownames(fit) %in% confects$table$name[1:40], "confects ","")))
```

![](data:image/png;base64...)

# 2 edgeR analysis

An analysis in edgeR produces similar results. Note that only quasi-likelihood
testing from edgeR is supported.

## 2.1 Standard edgeR analysis

```
y <- estimateDisp(y, design, robust=TRUE)
efit <- glmQLFit(y, design, robust=TRUE)
```

## 2.2 Apply topconfects

A step of 0.05 is used here merely so that the vignette will build quickly.
`edger_confects` calls `edgeR::glmTreat` repeatedly, which is necessarily slow.
In practice a smaller value such as 0.01 should be used.

```
econfects <- edger_confects(efit, coef="Treathrcc", fdr=0.05, step=0.05)

econfects
```

```
## $table
##    confect effect logCPM name      SYMBOL
## 1  3.60    6.300   6.729 AT5G48430
## 2  3.10    4.802   8.097 AT3G46280
## 3  3.00    4.501   7.374 AT2G19190 FRK1/SIRK
## 4  3.00    5.769   4.903 AT3G55150 ATEXO70H1/EXO70H1
## 5  3.00    5.287   5.419 AT1G51850 SIF2
## 6  3.00    4.934   5.771 AT2G39380 ATEXO70H2/EXO70H2
## 7  3.00    5.422   5.199 AT2G44370
## 8  2.85    4.334   6.709 AT2G39530 CASPL4D1
## 9  2.80    4.319  10.445 AT4G12500
## 10 2.75    5.543   5.952 AT5G31702
## ...
## 2121 of 16526 non-zero log2 fold change at FDR 0.05
## Dispersion 0.047 to 0.047
## Biological CV 21.6% to 21.6%
```

## 2.3 Looking at the result

```
confects_plot(econfects)
```

![](data:image/png;base64...)

```
confects_plot_me2(econfects, breaks=c(0,1,2))
```

![](data:image/png;base64...)

```
etop <-
    glmQLFTest(efit, coef="Treathrcc") %>%
    topTags(n=Inf)

plotMD(efit, legend="bottomleft", status=paste0(
    ifelse(rownames(efit) %in% econfects$table$name[1:40], "confects ", ""),
    ifelse(rownames(efit) %in% rownames(etop)[1:40], "topTags ","")))
```

![](data:image/png;base64...)

# 3 DESeq2 analysis

DESeq2 does its own filtering of lowly expressed genes, so we start from the
original count matrix. The initial steps are as for a normal DESeq2 analysis.

```
library(DESeq2)

dds <- DESeqDataSetFromMatrix(
    countData = arab,
    colData = data.frame(Time, Treat),
    rowData = arab_info,
    design = ~Time+Treat)

dds <- DESeq(dds)
```

## 3.1 Apply topconfects

The contrast or coefficient to test is specified as in the `DESeq2::results`
function. The step of 0.05 is merely so that this vignette will build quickly,
in practice a smaller value such as 0.01 should be used. `deseq2_confects`
calls `results` repeatedly, and in fairness `results`
has not been optimized for this.

```
dconfects <- deseq2_confects(dds, name="Treat_hrcc_vs_mock", step=0.05)
```

DESeq2 offers shrunken estimates of LFC. This is another sensible way of ranking
genes. Let’s compare them to the confect values.

```
shrunk <- lfcShrink(dds, coef="Treat_hrcc_vs_mock", type="ashr")
```

```
## using 'ashr' for LFC shrinkage. If used in published research, please cite:
##     Stephens, M. (2016) False discovery rates: a new deal. Biostatistics, 18:2.
##     https://doi.org/10.1093/biostatistics/kxw041
```

```
dconfects$table$shrunk <- shrunk$log2FoldChange[dconfects$table$index]

dconfects
```

```
## $table
##    confect effect baseMean name      filtered shrunk
## 1  3.45    4.785   586.43  AT3G46280 FALSE    4.637
## 2  3.20    4.501   354.89  AT2G19190 FALSE    4.363
## 3  3.15    4.320  2997.60  AT4G12500 FALSE    4.211
## 4  3.00    5.433    89.39  AT1G51850 FALSE    4.829
## 5  3.00    4.976   115.20  AT2G39380 FALSE    4.595
## 6  2.95    4.350   223.26  AT2G39530 FALSE    4.176
## 7  2.95    5.875    62.88  AT3G55150 FALSE    4.930
## 8  2.95    5.453    77.13  AT2G44370 FALSE    4.785
## 9  2.90    3.838  2532.56  AT4G12490 FALSE    3.763
## 10 2.85    3.969   448.55  AT1G51800 FALSE    3.864
## ...
## 1219 of 26222 non-zero effect size at FDR 0.05
```

DESeq2 filters some genes, these are placed last in the table. If your intention
is to obtain a ranking of all genes, you should disable this with
`deseq2_confects(..., cooksCutoff=Inf, independentFiltering=FALSE)`.

```
table(dconfects$table$filtered)
```

```
##
## FALSE  TRUE
## 11479 14743
```

```
tail(dconfects$table)
```

```
##        rank index confect     effect  baseMean      name filtered      shrunk
## 26217 26217 26203      NA  0.8487098  6.324289 AT5G67460     TRUE  0.08464016
## 26218 26218 26206      NA -0.6852089  1.220362 AT5G67488     TRUE -0.01672116
## 26219 26219 26207      NA  1.4505333  4.657085 AT5G67490     TRUE  0.13703515
## 26220 26220 26210      NA -0.5940465  6.699483 AT5G67520     TRUE -0.06727656
## 26221 26221 26213      NA  0.6767779  1.542612 AT5G67550     TRUE  0.02225821
## 26222 26222 26219      NA  0.1805069 12.111601 AT5G67610     TRUE  0.03021757
```

## 3.2 Looking at the result

Shrunk LFC estimates are shown in red.

```
confects_plot(dconfects) +
    geom_point(aes(x=shrunk, size=baseMean, color="lfcShrink"), alpha=0.75)
```

![](data:image/png;base64...)

`lfcShrink` aims for a best estimate of the LFC, whereas confect is a
conservative estimate. `lfcShrink` can produce non-zero values for genes which
can’t be said to significantly differ from zero – it doesn’t do double duty as
an indication of significance – whereas the confect value will be `NA` in this
case. The plot below compares these two quantities. Only un-filtered genes are
shown (see above).

```
filter(dconfects$table, !filtered) %>%
ggplot(aes(
        x=ifelse(is.na(confect),0,confect), y=shrunk, color=!is.na(confect))) +
    geom_point() + geom_abline() + coord_fixed() + theme_bw() +
    labs(color="Significantly\nnon-zero at\nFDR 0.05",
        x="confect", y="lfcShrink using ashr")
```

![](data:image/png;base64...)

# 4 Comparing results

The `rank_rank_plot` function can be used to pick differences between the different methods. It seems edgeR and DESeq2 tend to promote some genes, relative to limma. edgeR and DESeq2 are more similar to each other, which is reassuring given that they are based on similar statistical models.

```
rank_rank_plot(confects$table$name, econfects$table$name,
    "limma confects", "edgeR confects")
```

![](data:image/png;base64...)

```
rank_rank_plot(confects$table$name, dconfects$table$name,
    "limma confects", "DESeq2 confects")
```

![](data:image/png;base64...)

```
rank_rank_plot(econfects$table$name, dconfects$table$name,
    "edgeR confects", "DESeq2 confects")
```

![](data:image/png;base64...)

---

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
##  [1] DESeq2_1.50.0               SummarizedExperiment_1.40.0
##  [3] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [5] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              ggplot2_4.0.0
## [13] dplyr_1.1.4                 edgeR_4.8.0
## [15] limma_3.66.0                NBPSeq_0.3.1
## [17] topconfects_1.26.0          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1      farver_2.1.2          blob_1.2.4
##  [4] Biostrings_2.78.0     S7_0.2.0              fastmap_1.2.0
##  [7] digest_0.6.37         lifecycle_1.0.4       statmod_1.5.1
## [10] KEGGREST_1.50.0       invgamma_1.2          RSQLite_2.4.3
## [13] magrittr_2.0.4        compiler_4.5.1        rlang_1.1.6
## [16] sass_0.4.10           tools_4.5.1           yaml_2.3.10
## [19] knitr_1.50            S4Arrays_1.10.0       labeling_0.4.3
## [22] bit_4.6.0             DelayedArray_0.36.0   plyr_1.8.9
## [25] RColorBrewer_1.1-3    abind_1.4-8           BiocParallel_1.44.0
## [28] withr_3.0.2           grid_4.5.1            scales_1.4.0
## [31] dichromat_2.0-0.1     tinytex_0.57          cli_3.6.5
## [34] rmarkdown_2.30        crayon_1.5.3          httr_1.4.7
## [37] reshape2_1.4.4        DBI_1.2.3             qvalue_2.42.0
## [40] cachem_1.1.0          stringr_1.5.2         splines_4.5.1
## [43] parallel_4.5.1        assertthat_0.2.1      AnnotationDbi_1.72.0
## [46] BiocManager_1.30.26   XVector_0.50.0        vctrs_0.6.5
## [49] Matrix_1.7-4          jsonlite_2.0.0        bookdown_0.45
## [52] mixsqp_0.3-54         bit64_4.6.0-1         irlba_2.3.5.1
## [55] magick_2.9.0          locfit_1.5-9.12       jquerylib_0.1.4
## [58] glue_1.8.0            codetools_0.2-20      stringi_1.8.7
## [61] gtable_0.3.6          org.At.tair.db_3.22.0 tibble_3.3.0
## [64] pillar_1.11.1         htmltools_0.5.8.1     truncnorm_1.0-9
## [67] R6_2.6.1              evaluate_1.0.5        lattice_0.22-7
## [70] png_0.1-8             SQUAREM_2021.1        memoise_2.0.1
## [73] ashr_2.2-63           bslib_0.9.0           Rcpp_1.1.0
## [76] SparseArray_1.10.0    xfun_0.53             pkgconfig_2.0.3
```