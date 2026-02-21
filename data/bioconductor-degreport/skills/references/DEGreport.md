# QC and downstream analysis for differential expression RNA-seq

#### Lorena Pantano

#### 29 October 2025

Abstract

DEGreport package version: 1.46.0

* [General QC figures from DE analysis](#general-qc-figures-from-de-analysis)
  + [Size factor QC](#size-factor-qc)
  + [Mean-Variance QC plots](#mean-variance-qc-plots)
  + [Covariates effect on count data](#covariates-effect-on-count-data)
  + [Covariates correlation with metrics](#covariates-correlation-with-metrics)
  + [QC report](#qc-report)
* [Report from DESeq2 analysis](#report-from-deseq2-analysis)
  + [Contrasts](#contrasts)
  + [Volcano plots](#volcano-plots)
  + [Gene plots](#gene-plots)
  + [Markers plots](#markers-plots)
  + [Full report](#full-report)
  + [Interactive shiny-app](#interactive-shiny-app)
* [Detect patterns of expression](#detect-patterns-of-expression)
* [Useful functions](#useful-functions)
  + [Filter genes by group](#filter-genes-by-group)
  + [Generate colors for metadata variables](#generate-colors-for-metadata-variables)
* [Session info](#session-info)

[Lorena Pantano](lorena.pantano%40gmail.com) Harvard TH Chan School of Public Health, Boston, US

```
library(DEGreport)
data(humanGender)
```

## General QC figures from DE analysis

We are going to do a differential expression analysis with edgeR/DESeq2. We have an object that is coming from the edgeR package. It contains a gene count matrix for 85 TSI HapMap individuals, and the gender information. With that, we are going to apply the `glmFit` function or *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* to get genes differentially expressed between males and females.

```
library(DESeq2)
idx <- c(1:10, 75:85)
dds <- DESeqDataSetFromMatrix(assays(humanGender)[[1]][1:1000, idx],
                              colData(humanGender)[idx,], design=~group)
dds <- DESeq(dds)
res <- results(dds)
```

We need to extract the experiment design data.frame where the condition is Male or Female.

```
counts <- counts(dds, normalized = TRUE)
design <- as.data.frame(colData(dds))
```

### Size factor QC

A main assumption in library size factor calculation of edgeR and DESeq2 (and others) is that the majority of genes remain unchanged. Plotting the distribution of gene ratios between each gene and the average gene can show how true this is. Not super useful for many samples because the plot becomes crowed.

```
degCheckFactors(counts[, 1:6])
```

![](data:image/png;base64...)

### Mean-Variance QC plots

p-value distribution gives an idea on how well you model is capturing the input data and as well whether it could be some problem for some set of genes. In general, you expect to have a flat distribution with peaks at 0 and 1. In this case, we add the mean count information to check if any set of genes are enriched in any specific p-value range.

Variation (dispersion) and average expression relationship shouldn’t be a factor among the differentially expressed genes. When plotting average mean and standard deviation, significant genes should be randomly distributed.

In this case, it would be good to look at the ones that are totally outside the expected correlation.

You can put this tree plots together using `degQC`.

```
degQC(counts, design[["group"]], pvalue = res[["pvalue"]])
```

```
## Warning: Guides provided to `guides()` must be named.
## ℹ All guides are unnamed.
```

![](data:image/png;base64...)

### Covariates effect on count data

Another important analysis to do if you have covariates is to calculate the correlation between PCs from PCA analysis to different variables you may think are affecting the gene expression. This is a toy example of how the function works with raw data, where clearly library size correlates with some of the PCs.

```
resCov <- degCovariates(log2(counts(dds)+0.5),
                        colData(dds))
```

```
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
```

```
## Warning: `aes_()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`
## ℹ The deprecated feature was likely used in the DEGreport package.
##   Please report the issue at <https://github.com/lpantano/DEGreport/issues>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

### Covariates correlation with metrics

Also, the correlation among covariates and metrics from the analysis can be tested. This is useful when the study has multiple variables, like in clinical trials. The following code will return a correlation table, and plot the correlation heatmap for all the covariates and metrics in a table.

```
cor <- degCorCov(colData(dds))
```

```
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
## Warning in type.convert.default(X[[i]], ...): 'as.is' should be specified by
## the caller; using TRUE
```

```
## Warning: The input is a data frame-like object, convert it to a matrix.
```

![](data:image/png;base64...)

```
names(cor)
```

```
## [1] "cor"    "corMat" "fdrMat" "plot"
```

### QC report

A quick HTML report can be created with `createReport` to show whether a DE analysis is biased to a particular set of genes. It contains the output of `degQC,`degVB and `degMB`.

Note: Nozzle.R1 is not longer available since 3.16. You need to install the package manually before using this function.

```
createReport(colData(dds)[["group"]], counts(dds, normalized = TRUE),
             row.names(res)[1:20], res[["pvalue"]], path = "~/Downloads")
```

## Report from DESeq2 analysis

Here, we show some useful plots for differentially expressed genes.

### Contrasts

`DEGSet` is a class to store the DE results like the one from `results` function. *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* offers multiple way to ask for contrasts/coefficients. With `degComps` is easy to get multiple results in a single object:

```
degs <- degComps(dds, combs = "group",
                 contrast = list("group_Male_vs_Female",
                                 c("group", "Female", "Male")))
names(degs)
```

```
## [1] "group_Male_vs_Female" "group_Female_vs_Male"
```

`degs` contains 3 elements, one for each contrast/coefficient asked for. It contains the results output in the element `raw` and the output of `lfcShrink` in the element `shrunken`. To obtain the results from one of them, use the method `dge`:

```
deg(degs[[1]])
```

```
## log2 fold change (MAP): group Male vs Female
## Wald test p-value: group Male vs Female
## DataFrame with 1000 rows and 6 columns
##                  baseMean log2FoldChange     lfcSE        stat       pvalue
##                 <numeric>      <numeric> <numeric>   <numeric>    <numeric>
## ENSG00000067048 1025.0378       1.939488 0.1006940    23.99438 3.18302e-127
## ENSG00000012817  411.5439       3.700564 0.0989888    21.80452 2.10214e-105
## ENSG00000067646  169.8148       3.322846 0.0995193    15.48385  4.45984e-54
## ENSG00000005889  670.8619      -0.489435 0.0929363    -5.26371  1.41179e-07
## ENSG00000006757   92.6611      -0.472926 0.0992749    -4.75701  1.96486e-06
## ...                   ...            ...       ...         ...          ...
## ENSG00000068120  1214.097   -0.000114322 0.0797227 -0.00143400     0.998856
## ENSG00000072062   935.317    0.000559219 0.0915352  0.00610872     0.995126
## ENSG00000076770  1019.796    0.000850082 0.1016663  0.00836193     0.993328
## ENSG00000078967   166.422    0.000415745 0.0959758  0.00432971     0.996545
## ENSG00000079246  5226.339    0.000149584 0.0926205  0.00161500     0.998711
##                         padj
##                    <numeric>
## ENSG00000067048 3.18302e-124
## ENSG00000012817 1.05107e-102
## ENSG00000067646  1.48661e-51
## ENSG00000005889  3.52946e-05
## ENSG00000006757  3.92971e-04
## ...                      ...
## ENSG00000068120     0.998856
## ENSG00000072062     0.998856
## ENSG00000076770     0.998856
## ENSG00000078967     0.998856
## ENSG00000079246     0.998856
```

By default it would output the `shrunken` table always, as defined by `degDefault`, that contains the default table to get.

To get the original results table, use the parameter as this:

```
deg(degs[[1]], "raw", "tibble")
```

```
## # A tibble: 1,000 × 7
##    gene            baseMean log2FoldChange  lfcSE  stat    pvalue      padj
##    <chr>              <dbl>          <dbl>  <dbl> <dbl>     <dbl>     <dbl>
##  1 ENSG00000067048   1025.          10.2   0.423  24.0  3.18e-127 3.18e-124
##  2 ENSG00000012817    412.           9.24  0.424  21.8  2.10e-105 1.05e-102
##  3 ENSG00000067646    170.          10.2   0.658  15.5  4.46e- 54 1.49e- 51
##  4 ENSG00000005889    671.          -0.692 0.131  -5.26 1.41e-  7 3.53e-  5
##  5 ENSG00000006757     92.7         -0.767 0.161  -4.76 1.96e-  6 3.93e-  4
##  6 ENSG00000073282    220.          -1.87  0.421  -4.44 8.89e-  6 1.48e-  3
##  7 ENSG00000005302   2027.          -0.742 0.176  -4.21 2.59e-  5 3.69e-  3
##  8 ENSG00000005020   1234.           0.389 0.0952  4.08 4.44e-  5 5.56e-  3
##  9 ENSG00000003400    394.           0.680 0.177   3.85 1.17e-  4 1.31e-  2
## 10 ENSG00000069702    107.          -1.63  0.459  -3.56 3.71e-  4 3.71e-  2
## # ℹ 990 more rows
```

Note that the format of the output can be changed to tibble, or data.frame with a third parameter `tidy`.

The table will be always sorted by padj.

And easy way to get significant genes is:

```
significants(degs[[1]], fc = 0, fdr = 0.05)
```

```
##  [1] "ENSG00000012817" "ENSG00000067646" "ENSG00000067048" "ENSG00000005889"
##  [5] "ENSG00000006757" "ENSG00000005302" "ENSG00000003400" "ENSG00000073282"
##  [9] "ENSG00000005020" "ENSG00000069702"
```

This function can be used as well for a list of comparisons:

```
significants(degs, fc = 0, fdr = 0.05)
```

```
##  [1] "ENSG00000012817" "ENSG00000067646" "ENSG00000067048" "ENSG00000005889"
##  [5] "ENSG00000006757" "ENSG00000005302" "ENSG00000003400" "ENSG00000073282"
##  [9] "ENSG00000005020" "ENSG00000069702"
```

And it can returns the full table for a list:

```
significants(degs, fc = 0, fdr = 0.05, full = TRUE)
```

```
## # A tibble: 10 × 7
##    gene   log2FoldChange      padj log2FoldChange_group…¹ log2FoldChange_group…²
##    <chr>           <dbl>     <dbl>                  <dbl>                  <dbl>
##  1 ENSG0…          0.388 1.31e-  2                 -0.494                  0.388
##  2 ENSG0…          0.319 5.56e-  3                 -0.351                  0.319
##  3 ENSG0…          0.541 3.69e-  3                  0.541                 -0.425
##  4 ENSG0…          0.573 3.53e-  5                  0.573                 -0.489
##  5 ENSG0…          0.585 3.93e-  4                  0.585                 -0.473
##  6 ENSG0…          3.70  1.05e-102                 -5.01                   3.70
##  7 ENSG0…          1.94  3.18e-124                 -3.63                   1.94
##  8 ENSG0…          3.32  1.49e- 51                 -4.43                   3.32
##  9 ENSG0…          0.453 3.71e-  2                  0.453                 -0.260
## 10 ENSG0…          0.582 1.48e-  3                  0.582                 -0.339
## # ℹ abbreviated names: ¹​log2FoldChange_group_Female_vs_Male,
## #   ²​log2FoldChange_group_Male_vs_Female
## # ℹ 2 more variables: padj_group_Female_vs_Male <dbl>,
## #   padj_group_Male_vs_Female <dbl>
```

Since log2FoldChange are shrunken, the method for DEGSet class now can plot these changes as follow:

```
degMA(degs[[1]], diff = 2, limit = 3)
```

![](data:image/png;base64...)

The blue arrows indicate how foldchange is affected by this new feature.

As well, it can plot the original MA plot:

```
degMA(degs[[1]], diff = 2, limit = 3, raw = TRUE)
```

![](data:image/png;base64...)

or the correlation between the original log2FoldChange and the new ones:

```
degMA(degs[[1]], limit = 3, correlation = TRUE)
```

![](data:image/png;base64...)

### Volcano plots

Volcano plot using the output of *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*. It mainly needs data.frame with two columns (logFC and pVal). Specific genes can be plot using the option `plot\_text` (subset of the previous data.frame with a 3rd column to be used to plot the gene name).

```
res[["id"]] <- row.names(res)
show <- as.data.frame(res[1:10, c("log2FoldChange", "padj", "id")])
degVolcano(res[,c("log2FoldChange", "padj")], plot_text = show)
```

```
## Warning: ggrepel: 10 unlabeled data points (too many overlaps). Consider
## increasing max.overlaps
```

![](data:image/png;base64...)

Note that the function is compatible with DEGset. Using `degVolcano(degs[[1]])` is valid.

### Gene plots

Plot top genes coloring by group. Very useful for experiments with nested groups. `xs` can be `time` or `WT`/`KO`, and `group` can be `treated`/`untreated`. Another classification can be added, like `batch` that will plot points with different shapes.

```
degPlot(dds = dds, res = res, n = 6, xs = "group")
```

![](data:image/png;base64...)

Another option for plotting genes in a wide format:

```
degPlotWide(dds, rownames(dds)[1:5], group="group")
```

![](data:image/png;base64...)

### Markers plots

Markers can be used to show whether different conditions are enriched in different markers. For instance, in this example, Females and Males show different total expression for chromosome X/Y markers

```
data(geneInfo)
degSignature(humanGender, geneInfo, group = "group")
```

![](data:image/png;base64...)

### Full report

If you have a DESeq2 object, you can use degResults to create a full report with markdown code inserted, including figures and table with top de-regulated genes, GO enrichment analysis and heatmaps and PCA plots. If you set , different files will be saved there.

```
resreport <- degResults(dds = dds, name = "test", org = NULL,
                        do_go = FALSE, group = "group", xs = "group",
                        path_results = NULL)
```

```
## ## Comparison:  test {.tabset}
##
##
##  [1] "DESeqResults object of length 6 with 2 metadata columns"<br>[2] NA                                                       <br>[3] NA                                                       <br>[4] NA                                                       <br>[5] NA                                                       <br>[6] NA                                                       <br>[7] NA                                                       <br>[8] NA
##
##
## Differential expression file at:  test_de.csv
##
## Normalized counts matrix file at:  test_log2_counts.csv
##
## ### MA plot plot
```

![](data:image/png;base64...)

```
##
##
## ### Volcano plot
##
##
##
## ### QC for DE genes
```

```
## Warning: Guides provided to `guides()` must be named.
## ℹ All guides are unnamed.
```

![](data:image/png;base64...)

```
##
##
## ### Most significants, FDR< 0.05  and log2FC >  0.1 :  10
```

![](data:image/png;base64...)

```
##
##
##
## ### Plots top 9 most significants
```

```
##
##
##
## ### Top DE table
##
##
##
## |                |   baseMean| log2FoldChange|     lfcSE|      stat|    pvalue|      padj| absMaxLog2FC|
## |:---------------|----------:|--------------:|---------:|---------:|---------:|---------:|------------:|
## |ENSG00000067048 | 1025.03783|     10.1571705| 0.4233146| 23.994380| 0.0000000| 0.0000000|   10.1571705|
## |ENSG00000012817 |  411.54387|      9.2394007| 0.4237379| 21.804517| 0.0000000| 0.0000000|    9.2394007|
## |ENSG00000067646 |  169.81477|     10.1874916| 0.6579432| 15.483847| 0.0000000| 0.0000000|   10.1874916|
## |ENSG00000005889 |  670.86191|     -0.6919265| 0.1314523| -5.263708| 0.0000001| 0.0000353|    0.6919265|
## |ENSG00000006757 |   92.66111|     -0.7666012| 0.1611520| -4.757006| 0.0000020| 0.0003930|    0.7666012|
## |ENSG00000073282 |  220.15603|     -1.8685615| 0.4206120| -4.442482| 0.0000089| 0.0014821|    1.8685615|
## |ENSG00000005302 | 2026.54990|     -0.7418952| 0.1763412| -4.207157| 0.0000259| 0.0036943|    0.7418952|
## |ENSG00000005020 | 1233.86316|      0.3888370| 0.0952312|  4.083085| 0.0000444| 0.0055552|    0.3888370|
## |ENSG00000003400 |  393.62677|      0.6803243| 0.1766475|  3.851310| 0.0001175| 0.0130542|    0.6803243|
## |ENSG00000069702 |  106.67010|     -1.6323189| 0.4585611| -3.559654| 0.0003713| 0.0371343|    1.6323189|
## |ENSG00000010278 |   84.30823|      1.2035871| 0.3554857|  3.385754| 0.0007098| 0.0645300|    1.2035871|
## |ENSG00000023171 |  165.31692|     -1.4022259| 0.4236024| -3.310240| 0.0009322| 0.0776799|    1.4022259|
## |ENSG00000072501 | 3694.76013|     -0.5604815| 0.1707989| -3.281529| 0.0010325| 0.0794200|    0.5604815|
## |ENSG00000070018 |  119.89049|     -1.0921227| 0.3512409| -3.109327| 0.0018751| 0.1339388|    1.0921227|
## |ENSG00000059377 |  131.98111|      0.8405094| 0.2744635|  3.062372| 0.0021959| 0.1463935|    0.8405094|
## |ENSG00000008277 |  377.43955|     -0.6368732| 0.2136506| -2.980910| 0.0028739| 0.1796208|    0.6368732|
## |ENSG00000005059 |  479.12528|      0.4225402| 0.1492246|  2.831571| 0.0046320| 0.2289281|    0.4225402|
## |ENSG00000012963 | 1829.21224|      0.2471040| 0.0861859|  2.867104| 0.0041425| 0.2289281|    0.2471040|
## |ENSG00000038427 |  100.87217|     -1.0743654| 0.3810269| -2.819658| 0.0048075| 0.2289281|    1.0743654|
## |ENSG00000068079 | 1035.17996|      0.4075632| 0.1415563|  2.879160| 0.0039874| 0.2289281|    0.4075632|
```

### Interactive shiny-app

Browsing gene expression can help to validate results or select some gene for downstream analysis. Run the following lines if you want to visualize your expression values by condition:

```
degObj(counts, design, "degObj.rda")
library(shiny)
shiny::runGitHub("lpantano/shiny", subdir="expression")
```

## Detect patterns of expression

In this section, we show how to detect pattern of expression. Mainly useful when data is a time course experiment. `degPatterns` needs a expression matrix, the design experiment and the column used to group samples.

```
ma = assay(rlog(dds))[row.names(res)[1:100],]
res <- degPatterns(ma, design, time = "group")
```

![](data:image/png;base64...)

## Useful functions

This section shows some useful functions during DEG analysis.

### Filter genes by group

`degFilter` helps to filter genes with a minimum read count by group.

```
cat("gene in original count matrix: 1000")
```

gene in original count matrix: 1000

```
filter_count <- degFilter(counts(dds),
                          design, "group",
                          min=1, minreads = 50)
cat("gene in final count matrix", nrow(filter_count))
```

gene in final count matrix 940

### Generate colors for metadata variables

This functions allows you to create colors for metadata columns to be used as annotation for columns in a heatmap figure.

```
library(ComplexHeatmap)
th <- HeatmapAnnotation(df = colData(dds),
                        col = degColors(colData(dds), TRUE))
Heatmap(log2(counts(dds) + 0.5)[1:10,],
        top_annotation = th)
```

![](data:image/png;base64...)

```
library(pheatmap)
pheatmap(log2(counts(dds) + 0.5)[1:10,],
         annotation_col = as.data.frame(colData(dds))[,1:4],
         annotation_colors = degColors(colData(dds)[1:4],
                                       con_values = c("white",
                                                      "red")
                                       )
         )
```

![](data:image/png;base64...)

# Session info

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] pheatmap_1.0.13             ComplexHeatmap_2.26.0
##  [3] DESeq2_1.50.0               SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [7] matrixStats_1.5.0           GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              DEGreport_1.46.0
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] mnormt_2.1.1                rlang_1.1.6
##  [3] magrittr_2.0.4              clue_0.3-66
##  [5] GetoptLong_1.0.5            compiler_4.5.1
##  [7] mgcv_1.9-3                  png_0.1-8
##  [9] vctrs_0.6.5                 quantreg_6.1
## [11] stringr_1.5.2               pkgconfig_2.0.3
## [13] shape_1.4.6.1               crayon_1.5.3
## [15] fastmap_1.2.0               magick_2.9.0
## [17] backports_1.5.0             XVector_0.50.0
## [19] labeling_0.4.3              utf8_1.2.6
## [21] rmarkdown_2.30              MatrixModels_0.5-4
## [23] purrr_1.1.0                 xfun_0.53
## [25] cachem_1.1.0                jsonlite_2.0.0
## [27] DelayedArray_0.36.0         reshape_0.8.10
## [29] BiocParallel_1.44.0         psych_2.5.6
## [31] broom_1.0.10                parallel_4.5.1
## [33] cluster_2.1.8.1             R6_2.6.1
## [35] bslib_0.9.0                 stringi_1.8.7
## [37] RColorBrewer_1.1-3          limma_3.66.0
## [39] jquerylib_0.1.4             Rcpp_1.1.0
## [41] iterators_1.0.14            knitr_1.50
## [43] Matrix_1.7-4                splines_4.5.1
## [45] tidyselect_1.2.1            dichromat_2.0-0.1
## [47] abind_1.4-8                 yaml_2.3.10
## [49] doParallel_1.0.17           codetools_0.2-20
## [51] lattice_0.22-7              tibble_3.3.0
## [53] plyr_1.8.9                  withr_3.0.2
## [55] S7_0.2.0                    evaluate_1.0.5
## [57] survival_3.8-3              ConsensusClusterPlus_1.74.0
## [59] circlize_0.4.16             pillar_1.11.1
## [61] BiocManager_1.30.26         foreach_1.5.2
## [63] ggplot2_4.0.0               scales_1.4.0
## [65] glue_1.8.0                  tools_4.5.1
## [67] SparseM_1.84-2              locfit_1.5-9.12
## [69] Cairo_1.7-0                 cowplot_1.2.0
## [71] tidyr_1.3.1                 edgeR_4.8.0
## [73] colorspace_2.1-2            nlme_3.1-168
## [75] cli_3.6.5                   S4Arrays_1.10.0
## [77] ggdendro_0.2.0              dplyr_1.1.4
## [79] gtable_0.3.6                logging_0.10-108
## [81] sass_0.4.10                 digest_0.6.37
## [83] SparseArray_1.10.0          ggrepel_0.9.6
## [85] rjson_0.2.23                farver_2.1.2
## [87] htmltools_0.5.8.1           lifecycle_1.0.4
## [89] GlobalOptions_0.1.2         statmod_1.5.1
## [91] MASS_7.3-65
```