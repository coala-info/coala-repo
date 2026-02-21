# Visualize Differential Expression results

David Barrios and Carlos Prieto

#### 22 December 2025

#### Abstract

`Rvisdiff` is an R/Bioconductor package which generates an interactive interface for the interpretation of differential expression results. It generates a local Web page which enables the exploration of statistical analysis results with the generation of auto-analytical visualizations. The package supports as input the output of popular differential expression packages such as *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*, *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* and *[limma](https://bioconductor.org/packages/3.22/limma)*.

#### Package

Rvisdiff 1.8.1

# 1 Getting started

`Rvisdiff` is an R package distributed as part of the Bioconductor project.
To install the package, start R and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("Rvisdiff")
```

The GitHub repository for `Rvisdiff` is <https://github.com/BioinfoUSAL/Rvisdiff>.
This is the place to file an issue, report a bug, or provide a pull request.

Once `Rvisdiff` is installed, it can be loaded by the following command.

```
library("Rvisdiff")
```

# 2 Introduction

Differential expression analysis generates a big report which needs a manual
inspection for the optimization and interpretation of results. Researchers have
designed visualization techniques to facilitate these tasks but their generation
with code or statistics packages avoids the quick and massive exploration of
results. We have designed `Rvisdiff` to integrate graphs in an easy to use and
interactive web page.The user can explore the differential expression results
and the source expression data in the same view.

As input data the package receives two tables with the differential expression
results and the raw/normalized expression data. It detects the default output of
*[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*, *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* and
*[limma](https://bioconductor.org/packages/3.22/limma)* packages and no data conversion is needed. The
user can also generate a custom data frame which integrates a statistical
testing output with a fold change and mean calculation for each variable.

As output the package generates a local HTML page that can be seen in a Web
browser. It is not necessary the installation of additional software such as
application servers or programming languages. This feature ensures portability
and ease of use. Moreover, results are stored in the local computer, avoiding
any network sharing or data upload to external servers, which ensures the data
privacy.

# 3 Input data

In this example we use as input the *[airway](https://bioconductor.org/packages/3.22/airway)* data
package which contains the read counts in genes for an RNA-Seq experiment on
four human airway smooth muscle cell lines treated with dexamethasone. The code
below shows how to load the package and the data extraction of main data
features that we need for the differential expression analysis and the posterior
visualization with `Rvisdiff`. The `countdata` variable contains a data frame
with the number of sequence counts for each gene (rows) and sample (columns).
The `coldata` variable contains input phenotypes for the differential expression
analysis and its posterior representation.

The following code loads the necessary libraries and formats the input sample
conditions.

```
library(Rvisdiff)
library(airway)
data("airway")
se <- airway
se$dex <- relevel(se$dex, ref="untrt")
countdata <- assay(se)
coldata <- colData(se)
```

# 4 Generating the Report

## 4.1 Generating Report From *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* results

The code below shows how to perform a differential expression analysis with
*[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* and its representation with `Rvisdiff`.

```
library(DESeq2)
dds <- DESeqDataSet(se, design = ~ cell + dex)
dds <- DESeq(dds)
dres <- results(dds, independentFiltering = FALSE)
DEreport(dres, countdata, coldata$dex)
```

## 4.2 Generating Report From *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* results

The code below shows how to perform a differential expression analysis with
*[edgeR](https://bioconductor.org/packages/3.22/edgeR)* and its representation with `Rvisdiff`.

```
library(edgeR)
design <- model.matrix(~ cell + dex, data = coldata)
dl <- DGEList(counts = countdata, group = coldata$dex)
dl <- calcNormFactors(dl)
dl <- estimateDisp(dl, design=design)
de <- exactTest(dl,pair=1:2)
tt <- topTags(de, n = Inf, adjust.method = "BH", sort.by = "none")
DEreport(tt, countdata, coldata$dex)
```

## 4.3 Generating Report From *[limma](https://bioconductor.org/packages/3.22/limma)* results

The code below shows how to perform a differential expression analysis with
*[limma](https://bioconductor.org/packages/3.22/limma)* and its representation with `Rvisdiff`.

```
library(limma)
design <- model.matrix(~ 0 + dex + cell, data = coldata)
contr <- makeContrasts(dextrt - dexuntrt,levels=colnames(design))
limmaexprs <- voom(countdata, design)
fit <- lmFit(limmaexprs, design)
fit <- contrasts.fit(fit, contrasts=contr)
fit <- eBayes(fit)
limmares <- topTable(fit, coef = 1, number = Inf, sort.by = "none",
    adjust.method = "BH")
DEreport(limmares, countdata, coldata$dex)
```

## 4.4 Generating Report From Differential test results

The code below shows how to perform a Wilcoxon test with expression data and its
representation with `Rvisdiff`. This example can be also followed for the
representation of resulting analysis from differential means tests.

```
untrt <- countdata[,coldata$dex=="untrt"]
trt <- countdata[,coldata$dex=="trt"]

library(matrixTests)
wilcox <- col_wilcoxon_twosample(t(untrt), t(trt))
stat <- wilcox$statistic
p <- wilcox$pvalue
log2FoldChange <- log2(rowMeans(trt)+1) - log2(rowMeans(untrt)+1)
wilcox <- cbind(stat = stat, pvalue = round(p, 6),
    padj = p.adjust(wilcox[,2], method = "BH"),
    baseMean = rowMeans(countdata),
    log2FoldChange = log2FoldChange)
rownames(wilcox) <- rownames(countdata)

DEreport(wilcox, countdata, coldata$dex)
```

# 5 Resulting Graphical User Interface

Figure 1 shows the resulting Web page generated with the `DEreport` function.
The user can select which genes appear in the graphs selecting them in the
results table. It contains the following graphs:

* Volcano Plot: It is a scatter plot in which the values of rate of change are
  plotted in logarithmic scale (log2foldchange) versus the p-value resulting from
  the contrast test is scale minus logarithm 10 (-log10pvalue). Points are
  highlighted when the mouse is hovered over the results table. Variable name
  appears on point mouse over.
* MA-Plot: is a scatter plot showing mean expression values versus rate of
  change, both are plotted in logarithmic scale to avoid excessive scatter. It has
  the same interactivity features as Volcano plots.
* Line diagram: the gene expression levels (ordinates) in each sample
  (abscissae) are represented as a line. Diagram is divided based on input
  phenotype.
* Box plot: they allow us to visualize the distribution, degree of asymmetry,
  extreme values and value of the median. It is also useful for comparing two
  distributions if we represent them in the same graph. The resulting graphs show
  the difference in expression between genes or conditions.
* Cluster Heatmap: expression data are displayed in a grid where each row
  represents a gene and each column represents a sample. The color and intensity
  of the boxes are used to represent changes (usually scaled per gene, avoiding
  absolute values) in gene expression. The heatmap shows also a clustering tree
  that groups genes and samples based on the similarity of their gene expression
  pattern. The user can change the color scale and toggle rendering from raw to
  scaled values. Moreover, the graph provides a zoom feature which enables to set
  the focus on a set of samples or genes.

![](data:image/png;base64...)
**Figure 1** web interface

# SessionInfo

```
sessionInfo()
```

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] matrixTests_0.2.3.1         edgeR_4.8.1
##  [3] limma_3.66.0                DESeq2_1.50.2
##  [5] airway_1.30.0               SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.1
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           Rvisdiff_1.8.1
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         SparseArray_1.10.8  lattice_0.22-7
##  [4] magrittr_2.0.4      digest_0.6.39       evaluate_1.0.5
##  [7] grid_4.5.2          RColorBrewer_1.1-3  bookdown_0.46
## [10] fastmap_1.2.0       jsonlite_2.0.0      Matrix_1.7-4
## [13] BiocManager_1.30.27 scales_1.4.0        codetools_0.2-20
## [16] jquerylib_0.1.4     abind_1.4-8         cli_3.6.5
## [19] rlang_1.1.6         XVector_0.50.0      cachem_1.1.0
## [22] DelayedArray_0.36.0 yaml_2.3.12         otel_0.2.0
## [25] S4Arrays_1.10.1     tools_4.5.2         parallel_4.5.2
## [28] BiocParallel_1.44.0 dplyr_1.1.4         ggplot2_4.0.1
## [31] locfit_1.5-9.12     vctrs_0.6.5         R6_2.6.1
## [34] lifecycle_1.0.4     pkgconfig_2.0.3     pillar_1.11.1
## [37] bslib_0.9.0         gtable_0.3.6        glue_1.8.0
## [40] Rcpp_1.1.0          statmod_1.5.1       tidyselect_1.2.1
## [43] tibble_3.3.0        xfun_0.55           knitr_1.51
## [46] dichromat_2.0-0.1   farver_2.1.2        htmltools_0.5.9
## [49] rmarkdown_2.30      compiler_4.5.2      S7_0.2.1
```