Code

* Show All Code
* Hide All Code

# 1 Basic DESeq2 results exploration

Project: SRP009615.

# 2 Introduction

This report is meant to help explore DESeq2 (Love, Huber, and Anders, 2014) results and was generated using the `regionReport` (Collado-Torres, Jaffe, and Leek, 2016) package. While the report is rich, it is meant to just start the exploration of the results and exemplify some of the code used to do so. If you need a more in-depth analysis for your specific data set you might want to use the `customCode` argument. This report is based on the vignette of the `DESeq2` (Love, Huber, and Anders, 2014) package which you can find [here](http://www.bioconductor.org/packages/DESeq2).

## 2.1 Code setup

This section contains the code for setting up the rest of the report.

```
## knitrBoostrap and device chunk options
library('knitr')
opts_chunk$set(bootstrap.show.code = FALSE, dev = device, crop = NULL)
if(!outputIsHTML) opts_chunk$set(bootstrap.show.code = FALSE, dev = device, echo = FALSE)
```

```
#### Libraries needed

## Bioconductor
library('DESeq2')
if(isEdgeR) library('edgeR')

## CRAN
library('ggplot2')
if(!is.null(theme)) theme_set(theme)
library('knitr')
if(is.null(colors)) {
    library('RColorBrewer')
}
library('pheatmap')
library('DT')
library('sessioninfo')

#### Code setup

## For ggplot
res.df <- as.data.frame(res)

## Sort results by adjusted p-values
ord <- order(res.df$padj, decreasing = FALSE)
res.df <- res.df[ord, ]
features <- rownames(res.df)
res.df <- cbind(data.frame(Feature = features), res.df)
rownames(res.df) <- NULL
```

# 3 PCA

```
## Transform count data
rld <- tryCatch(rlog(dds), error = function(e) { rlog(dds, fitType = 'mean') })

## Perform PCA analysis and make plot
plotPCA(rld, intgroup = intgroup)
```

```
## using ntop=500 top features by variance
```

![](data:image/png;base64...)

```
## Get percent of variance explained
data_pca <- plotPCA(rld, intgroup = intgroup, returnData = TRUE)
```

```
## using ntop=500 top features by variance
```

```
percentVar <- round(100 * attr(data_pca, "percentVar"))
```

The above plot shows the first two principal components that explain the variability in the data using the regularized log count data. If you are unfamiliar with principal component analysis, you might want to check the [Wikipedia entry](https://en.wikipedia.org/wiki/Principal_component_analysis) or this [interactive explanation](http://setosa.io/ev/principal-component-analysis/). In this case, the first and second principal component explain 65 and 15 percent of the variance respectively.

# 4 Sample-to-sample distances

```
## Obtain the sample euclidean distances
sampleDists <- dist(t(assay(rld)))
sampleDistMatrix <- as.matrix(sampleDists)
## Add names based on intgroup
rownames(sampleDistMatrix) <- apply(as.data.frame(colData(rld)[, intgroup]), 1,
    paste, collapse = ' : ')
colnames(sampleDistMatrix) <- NULL

## Define colors to use for the heatmap if none were supplied
if(is.null(colors)) {
    colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
}

## Make the heatmap
pheatmap(sampleDistMatrix, clustering_distance_rows = sampleDists,
    clustering_distance_cols = sampleDists, color = colors)
```

This plot shows how samples are clustered based on their euclidean distance using the regularized log transformed count data. This figure gives an overview of how the samples are hierarchically clustered. It is a complementary figure to the PCA plot.

# 5 MA plots

This section contains three MA plots (see [Wikipedia](https://en.wikipedia.org/wiki/MA_plot)) that compare the mean of the normalized counts against the log fold change. They show one point per feature. The points are shown in red if the feature has an adjusted p-value less than `alpha`, that is, the statistically significant features are shown in red.

```
## MA plot with alpha used in DESeq2::results()
plotMA(res, alpha = metadata(res)$alpha, main = paste('MA plot with alpha =',
    metadata(res)$alpha))
```

```
## Warning in plot.window(...): "alpha" is not a graphical parameter
```

```
## Warning in plot.xy(xy, type, ...): "alpha" is not a graphical parameter
```

```
## Warning in axis(side = side, at = at, labels = labels, ...): "alpha" is not a
## graphical parameter
## Warning in axis(side = side, at = at, labels = labels, ...): "alpha" is not a
## graphical parameter
```

```
## Warning in box(...): "alpha" is not a graphical parameter
```

```
## Warning in title(...): "alpha" is not a graphical parameter
```

![](data:image/png;base64...)

This first plot shows uses `alpha` = 0.1, which is the `alpha` value used to determine which resulting features were significant when running the function `DESeq2::results()`.

```
## MA plot with alpha = 1/2 of the alpha used in DESeq2::results()
plotMA(res, alpha = metadata(res)$alpha / 2,
    main = paste('MA plot with alpha =', metadata(res)$alpha / 2))
```

```
## Warning in plot.window(...): "alpha" is not a graphical parameter
```

```
## Warning in plot.xy(xy, type, ...): "alpha" is not a graphical parameter
```

```
## Warning in axis(side = side, at = at, labels = labels, ...): "alpha" is not a
## graphical parameter
## Warning in axis(side = side, at = at, labels = labels, ...): "alpha" is not a
## graphical parameter
```

```
## Warning in box(...): "alpha" is not a graphical parameter
```

```
## Warning in title(...): "alpha" is not a graphical parameter
```

![](data:image/png;base64...)

This second MA plot uses `alpha` = 0.05 and can be used agains the first MA plot to identify which features have adjusted p-values between 0.05 and 0.1.

```
## MA plot with alpha corresponding to the one that gives the nBest features
nBest.actual <- min(nBest, nrow(head(res.df, n = nBest)))
nBest.alpha <- head(res.df, n = nBest)$padj[nBest.actual]
plotMA(res, alpha = nBest.alpha * 1.00000000000001,
    main = paste('MA plot for top', nBest.actual, 'features'))
```

```
## Warning in plot.window(...): "alpha" is not a graphical parameter
```

```
## Warning in plot.xy(xy, type, ...): "alpha" is not a graphical parameter
```

```
## Warning in axis(side = side, at = at, labels = labels, ...): "alpha" is not a
## graphical parameter
## Warning in axis(side = side, at = at, labels = labels, ...): "alpha" is not a
## graphical parameter
```

```
## Warning in box(...): "alpha" is not a graphical parameter
```

```
## Warning in title(...): "alpha" is not a graphical parameter
```

![](data:image/png;base64...)

The third and final MA plot uses an alpha such that the top 10 features are shown in the plot. These are the features that whose details are included in the *top features* interactive table.

# 6 P-values distribution

```
## P-value histogram plot
ggplot(res.df[!is.na(res.df$pvalue), ], aes(x = pvalue)) +
    geom_histogram(alpha=.5, position='identity', bins = 50) +
    labs(title='Histogram of unadjusted p-values') +
    xlab('Unadjusted p-values') +
    xlim(c(0, 1.0005))
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](data:image/png;base64...)

This plot shows a histogram of the unadjusted p-values. It might be skewed right or left, or flat as shown in the [Wikipedia examples](https://en.wikipedia.org/wiki/Histogram#Examples). The shape depends on the percent of features that are differentially expressed. For further information on how to interpret a histogram of p-values check [David Robinson’s post on this topic](http://varianceexplained.org/statistics/interpreting-pvalue-histogram/).

```
## P-value distribution summary
summary(res.df$pvalue)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
##  0.0000  0.2070  0.5398  0.5041  0.7982  1.0000    7979
```

This is the numerical summary of the distribution of the p-values.

```
## Split features by different p-value cutoffs
pval_table <- lapply(c(1e-04, 0.001, 0.01, 0.025, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5,
    0.6, 0.7, 0.8, 0.9, 1), function(x) {
    data.frame('Cut' = x, 'Count' = sum(res.df$pvalue <= x, na.rm = TRUE))
})
pval_table <- do.call(rbind, pval_table)
if(outputIsHTML) {
    kable(pval_table, format = 'markdown', align = c('c', 'c'))
} else {
    kable(pval_table)
}
```

| Cut | Count |
| --- | --- |
| 0.0001 | 243 |
| 0.0010 | 776 |
| 0.0100 | 2371 |
| 0.0250 | 3816 |
| 0.0500 | 5468 |
| 0.1000 | 8059 |
| 0.2000 | 12278 |
| 0.3000 | 16026 |
| 0.4000 | 19662 |
| 0.5000 | 23425 |
| 0.6000 | 27385 |
| 0.7000 | 32525 |
| 0.8000 | 38160 |
| 0.9000 | 44652 |
| 1.0000 | 50058 |

This table shows the number of features with p-values less or equal than some commonly used cutoff values.

# 7 Adjusted p-values distribution

```
## Adjusted p-values histogram plot
ggplot(res.df[!is.na(res.df$padj), ], aes(x = padj)) +
    geom_histogram(alpha=.5, position='identity', bins = 50) +
    labs(title=paste('Histogram of', elementMetadata(res)$description[grep('adjusted', elementMetadata(res)$description)])) +
    xlab('Adjusted p-values') +
    xlim(c(0, 1.0005))
```

```
## Warning: Removed 2 rows containing missing values or values outside the scale range
## (`geom_bar()`).
```

![](data:image/png;base64...)

This plot shows a histogram of the BH adjusted p-values. It might be skewed right or left, or flat as shown in the [Wikipedia examples](https://en.wikipedia.org/wiki/Histogram#Examples).

```
## Adjusted p-values distribution summary
summary(res.df$padj)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's
##   0.000   0.306   0.602   0.565   0.844   1.000   33963
```

This is the numerical summary of the distribution of the BH adjusted p-values.

```
## Split features by different adjusted p-value cutoffs
padj_table <- lapply(c(1e-04, 0.001, 0.01, 0.025, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5,
    0.6, 0.7, 0.8, 0.9, 1), function(x) {
    data.frame('Cut' = x, 'Count' = sum(res.df$padj <= x, na.rm = TRUE))
})
padj_table <- do.call(rbind, padj_table)
if(outputIsHTML) {
    kable(padj_table, format = 'markdown', align = c('c', 'c'))
} else {
    kable(padj_table)
}
```

| Cut | Count |
| --- | --- |
| 0.0001 | 9 |
| 0.0010 | 36 |
| 0.0100 | 234 |
| 0.0250 | 608 |
| 0.0500 | 1114 |
| 0.1000 | 2140 |
| 0.2000 | 3960 |
| 0.3000 | 5893 |
| 0.4000 | 7937 |
| 0.5000 | 9897 |
| 0.6000 | 11992 |
| 0.7000 | 14323 |
| 0.8000 | 16814 |
| 0.9000 | 19853 |
| 1.0000 | 24074 |

This table shows the number of features with BH adjusted p-values less or equal than some commonly used cutoff values.

# 8 Top features

This interactive table shows the top 10 features ordered by their BH adjusted p-values. Use the search function to find your feature of interest or sort by one of the columns.

```
## Add search url if appropriate
if(!is.null(searchURL) & outputIsHTML) {
    res.df$Feature <- paste0('<a href="', searchURL, res.df$Feature, '">',
        res.df$Feature, '</a>')
}

for(i in which(colnames(res.df) %in% c('pvalue', 'padj'))) res.df[, i] <- format(res.df[, i], scientific = TRUE)

if(outputIsHTML) {
    datatable(head(res.df, n = nBest), options = list(pagingType='full_numbers', pageLength=10, scrollX='100%'), escape = FALSE, rownames = FALSE) %>% formatRound(which(!colnames(res.df) %in% c('pvalue', 'padj', 'Feature')), digits)
} else {
    res.df_top <- head(res.df, n = 20)
    for(i in which(!colnames(res.df) %in% c('pvalue', 'padj', 'Feature'))) res.df_top[, i] <- round(res.df_top[, i], digits)
    kable(res.df_top)
}
```

# 9 Count plots top features

This section contains plots showing the normalized counts per sample for each group of interest. Only the best 2 features are shown, ranked by their BH adjusted p-values. The Y axis is on the log10 scale and the feature name is shown in the title of each plot.

```
plotCounts_gg <- function(i, dds, intgroup) {
    group <- if (length(intgroup) == 1) {
        colData(dds)[[intgroup]]
    } else if (length(intgroup) == 2) {
        lvls <- as.vector(t(outer(levels(colData(dds)[[intgroup[1]]]),
            levels(colData(dds)[[intgroup[2]]]), function(x,
                y) paste(x, y, sep = " : "))))
        droplevels(factor(apply(as.data.frame(colData(dds)[,
            intgroup, drop = FALSE]), 1, paste, collapse = " : "),
            levels = lvls))
    } else {
        factor(apply(as.data.frame(colData(dds)[, intgroup, drop = FALSE]),
            1, paste, collapse = " : "))
    }
    data <- plotCounts(dds, gene=i, intgroup=intgroup, returnData = TRUE)
    ## Change in version 1.15.3
    ## It might not be necessary to have any of this if else, but I'm not
    ## sure that plotCounts(returnData) will always return the 'group' variable.
    if('group' %in% colnames(data)) {
        data$group <- group
    } else {
        data <- cbind(data, data.frame('group' = group))
    }

    ggplot(data, aes(x = group, y = count)) + geom_point() + ylab('Normalized count') + ggtitle(i) + coord_trans(y = "log10") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
}
for(i in head(features, nBestFeatures)) {
    print(plotCounts_gg(i, dds = dds, intgroup = intgroup))
}
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 10 Reproducibility

The input for this report was generated with DESeq2 (Love, Huber, and Anders, 2014) using version 1.50.0 and the resulting features were called significantly differentially expressed if their BH adjusted p-values were less than `alpha` = 0.1. This report was generated in path /tmp/RtmpSi45xq/Rbuild27bbd31c82fc1b/recount/vignettes using the following call to DESeq2Report():

```
## DESeq2Report(dds = dds, project = "SRP009615", intgroup = c("group",
##     "gene_target"), res = res, nBest = 10, nBestFeatures = 2,
##     outdir = ".", output = "SRP009615-results", device = "png",
##     template = "SRP009615-results-template.Rmd")
```

Date the report was generated.

```
## [1] "2025-10-30 02:01:31 EDT"
```

Wallclock time spent generating the report.

```
## Time difference of 21.071 secs
```

`R` session information.

```
## ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-30
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
##  package              * version   date (UTC) lib source
##  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
##  AnnotationDbi          1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
##  base64enc              0.1-3     2015-07-28 [2] CRAN (R 4.5.1)
##  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
##  Biobase              * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocIO                 1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
##  BiocParallel           1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  Biostrings             2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
##  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
##  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
##  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
##  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
##  BSgenome               1.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
##  bumphunter             1.52.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
##  checkmate              2.3.3     2025-08-18 [2] CRAN (R 4.5.1)
##  cigarillo              1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
##  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
##  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
##  colorspace             2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
##  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
##  crosstalk              1.2.2     2025-08-26 [2] CRAN (R 4.5.1)
##  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
##  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
##  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
##  DEFormats              1.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinder              1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinderHelper        1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  DESeq2               * 1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
##  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
##  doRNG                  1.8.6.2   2025-04-02 [2] CRAN (R 4.5.1)
##  downloader             0.4.1     2025-03-26 [2] CRAN (R 4.5.1)
##  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
##  DT                   * 0.34.0    2025-09-02 [2] CRAN (R 4.5.1)
##  edgeR                * 4.8.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
##  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
##  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
##  foreach                1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
##  foreign                0.8-90    2025-03-31 [3] CRAN (R 4.5.1)
##  Formula                1.2-5     2023-02-24 [2] CRAN (R 4.5.1)
##  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
##  GenomeInfoDb           1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicAlignments      1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFeatures        1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFiles           1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicRanges        * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GEOquery               2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  ggplot2              * 4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
##  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
##  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
##  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
##  Hmisc                  5.2-4     2025-10-05 [2] CRAN (R 4.5.1)
##  hms                    1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
##  htmlTable              2.4.3     2024-07-21 [2] CRAN (R 4.5.1)
##  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
##  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
##  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
##  IRanges              * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  iterators              1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
##  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
##  KEGGREST               1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  knitr                * 1.50      2025-03-16 [2] CRAN (R 4.5.1)
##  knitrBootstrap         1.0.3     2024-02-06 [2] CRAN (R 4.5.1)
##  labeling               0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
##  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
##  limma                * 3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  locfit                 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
##  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
##  magick                 2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
##  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
##  markdown               2.0       2025-03-23 [2] CRAN (R 4.5.1)
##  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
##  MatrixGenerics       * 1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  matrixStats          * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
##  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
##  nnet                   7.3-20    2025-01-01 [3] CRAN (R 4.5.1)
##  pheatmap             * 1.0.13    2025-06-05 [2] CRAN (R 4.5.1)
##  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
##  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
##  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
##  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
##  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
##  qvalue                 2.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
##  RColorBrewer         * 1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
##  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
##  readr                  2.1.5     2024-01-10 [2] CRAN (R 4.5.1)
##  recount              * 1.36.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
##  regionReport         * 1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  rentrez                1.2.4     2025-06-11 [2] CRAN (R 4.5.1)
##  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
##  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
##  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
##  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
##  rngtools               1.5.2     2021-09-20 [2] CRAN (R 4.5.1)
##  rpart                  4.1.24    2025-01-07 [3] CRAN (R 4.5.1)
##  Rsamtools              2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
##  rstudioapi             0.17.1    2024-10-22 [2] CRAN (R 4.5.1)
##  rtracklayer            1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
##  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
##  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
##  Seqinfo              * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
##  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
##  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
##  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
##  SummarizedExperiment * 1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
##  tidyr                  1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
##  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
##  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
##  tinytex                0.57      2025-04-15 [2] CRAN (R 4.5.1)
##  tzdb                   0.5.0     2025-03-15 [2] CRAN (R 4.5.1)
##  UCSC.utils             1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  VariantAnnotation      1.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
##  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
##  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
##  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
##  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
##  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpSi45xq/Rinst27bbd3493ddbdd
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

Pandoc version used: 2.7.3.

# 11 Bibliography

This report was created with `regionReport` (Collado-Torres, Jaffe, and Leek, 2016) using `rmarkdown` (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025) while `knitr` (Xie, 2014) and `DT` (Xie, Cheng, Tan, and Aden-Buie, 2025) were running behind the scenes. `pheatmap` (Kolde, 2025) was used to create the sample distances heatmap. Several plots were made with `ggplot2` (Wickham, 2016).

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017). The [BibTeX](http://www.bibtex.org/) file can be found [here](SRP009615-results.bib).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-colladotorres2016regionreport)
L. Collado-Torres, A. E. Jaffe, and J. T. Leek.
“regionReport: Interactive reports for region-level and feature-level genomic analyses [version2; referees: 2 approved, 1 approved with reservations]”.
In: *F1000Research* 4 (2016), p. 105.
DOI: [10.12688/f1000research.6379.2](https://doi.org/10.12688/f1000research.6379.2).
URL: <http://f1000research.com/articles/4-105/v2>.

[[3]](#cite-kolde2025pheatmap)
R. Kolde.
*pheatmap: Pretty Heatmaps*.
R package version 1.0.13.
2025.
DOI: [10.32614/CRAN.package.pheatmap](https://doi.org/10.32614/CRAN.package.pheatmap).
URL: [https://CRAN.R-project.org/package=pheatmap](https://CRAN.R-project.org/package%3Dpheatmap).

[[4]](#cite-love2014moderated)
M. I. Love, W. Huber, and S. Anders.
“Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2”.
In: *Genome Biology* 15 (12 2014), p. 550.
DOI: [10.1186/s13059-014-0550-8](https://doi.org/10.1186/s13059-014-0550-8).

[[5]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[6]](#cite-wickham2016ggplot2)
H. Wickham.
*ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York, 2016.
ISBN: 978-3-319-24277-4.
URL: <https://ggplot2.tidyverse.org>.

[[7]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.

[[8]](#cite-xie2025wrapper)
Y. Xie, J. Cheng, X. Tan, et al.
*DT: A Wrapper of the JavaScript Library ‘DataTables’*.
R package version 0.34.0.
2025.
DOI: [10.32614/CRAN.package.DT](https://doi.org/10.32614/CRAN.package.DT).
URL: [https://CRAN.R-project.org/package=DT](https://CRAN.R-project.org/package%3DDT).