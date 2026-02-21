# Running `MultiRNAflow` on a RNA-seq raw counts with different time points and several biological conditions

Rodolphe Loubaton1, Nicolas Champagnat2, Pierre Vallois2 and Laurent Vallat3,4

1Université Clermont Auvergne, INRAE, VetAgro Sup, UMR-1213 Herbivores, F-63122 Saint-Genès-Champanelle, France
2Université de Lorraine, CNRS, Inria, IECL, F-54000 Nancy, France
3Université de Strasbourg, CNRS, UMR-7242 Biotechnology and cell signaling, F-67400 Illkirch, France
4Department of molecular genetic of cancers, Strasbourg University Hospital, F-67200 Strasbourg, France

#### 30/10/2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Quick description of the document](#quick-description-of-the-document)
  + [1.2 Dataset used as example](#dataset-used-as-example)
* [2 Quick workflow](#quick-workflow)
  + [2.1 Load package, example dataset and preamble](#load-package-example-dataset-and-preamble)
  + [2.2 Preprocessing](#preprocessing)
  + [2.3 Exploratory data analysis](#exploratory-data-analysis)
  + [2.4 Supervised statistical analysis](#supervised-statistical-analysis)
* [3 SessionInfo](#sessioninfo)

# 1 Introduction

## 1.1 Quick description of the document

This document is a quick workflow describing how to use our R package
MultiRNAflow on one dataset (see [Dataset used as example](#dataset-used-as-example)).
For a more complete description of our package and complete outputs with graphs,
the user must read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".

## 1.2 Dataset used as example

The **Mouse dataset 2** (Weger et al. [2021](#ref-Weger2021TemporalMouseLiver)) is accessible on the
Gene Expression Omnibus (GEO) database with the accession number GSE135898.

This dataset contains the temporal transcription profile of 16 mice with Bmal1
and Cry1/2 knocked-down under an ad libitum (AL) or night restricted feeding
(RF) regimen. Data were collected at 0, 4h, 8h, 16, 20h and 24h.
Therefore, there are six time points and eight biological conditions.
As there are only two mice per biological condition, we decided not to take
into account the effect of the regimen.
The dataset contains temporal expression data of 40327 genes.

To illustrate the use of our package, we take 500 genes, over the global 40327
genes in the original dataset.
This sub dataset is saved in the file **RawCounts\_Weger2021\_MOUSEsub500**.

# 2 Quick workflow

## 2.1 Load package, example dataset and preamble

1. Load MultiRNAflow

```
library(MultiRNAflow)
```

2. Load **Mouse dataset 2**

```
data("RawCounts_Weger2021_MOUSEsub500")
```

3. Structure of the dataset (Preamble)

The dataset must be a data.frame containing raw counts data.
If it is not the case, the functions `DATAnormalization()` and
`DEanalysisGlobal()` will stop and print an error.
Each line should correspond to a gene, each column to a sample,
except a particular column that may contain strings of characters
describing the names of the genes.
The first line of the data.frame should contain the names of the columns
(strings of characters) that must have the following structure.

```
head(colnames(RawCounts_Weger2021_MOUSEsub500), n=5)
#> [1] "Gene"       "BmKo_t1_r1" "BmKo_t2_r1" "BmKo_t0_r1" "BmKo_t3_r1"
```

In this example, “Gene” indicates the column which contains the names of
the different genes.
The other column names contain all kind of information about the sample,
including the biological condition, the time of measurement and the name of
the individual (e.g patient, replicate, mouse, yeasts culture…).
Other kinds of information can be stored in the column names
(such as patient information), but they will not be used by the package.
The various information in the column names must be separated by underscores.
The order of these information is arbitrary but must be the same
for all columns. For instance, the sample “BmKo\_t0\_r1” corresponds to the first
replicate (r1) of the biological condition BmKo at time t0 (reference time).

The information located to the left of the first underscore will be considered
to be in position 1, the information located between the first underscore and
the second one will be considered to be in position 2, and so on.
In the previous example, the biological condition is in position 1,
the time is in position 2 and the replicate is in position 3.
In most of the functions of our package, the order of the previous information
in the column names will be indicated with the inputs `Group.position`,
`Time.position` and `Individual.position`.
Similarly the input `Column.gene` will indicate the number of
the column containing gene names.

## 2.2 Preprocessing

4. Preprocessing with `DATAprepSE()`

```
resDATAprepSE <- DATAprepSE(RawCounts=RawCounts_Weger2021_MOUSEsub500,
                            Column.gene=1,
                            Group.position=1,
                            Time.position=2,
                            Individual.position=3)
```

* **Output**: The function realizes the normalization step and returns
  a SummarizeExperiment object containing
  + all information about the raw counts data
  + a DESeqDataSet object to be used by the function `DEanalysisGlobal`
    for the statistical (supervised) analysis.
* **Input**:
  + The dataset must be RNA-seq raw counts (`RawCounts`)
  + The argument `Column.gene=1` means that the first column of the dataset
    contain genes name, `Time.position=2` means that the time of measurements
    is between the first and the second underscores in the columns names,
    `Individual.position=3` means that the name of the individual is between
    the second and the third underscores in the columns names and
    `Group.position=NULL` means that there is only one biological condition
    in the dataset. Similarly, `Time.position=NULL` would mean that
    there is only one time of measurement for each individual and
    `Column.gene=NULL` would mean that there is no column containing gene names.
* **Other**:
  + Write `?DATAprepSE` in your console for more information about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled “MultiRNAflow\_vignette-knitr.pdf”.

## 2.3 Exploratory data analysis

5. Normalization with `DATAnormalization()`

```
resNorm <- DATAnormalization(SEres=resDATAprepSE,
                             Normalization="vst",
                             Blind.rlog.vst=FALSE,
                             Plot.Boxplot=FALSE,
                             Colored.By.Factors=TRUE,
                             Color.Group=NULL,
                             path.result=NULL)
```

* **Output**: The function realizes the normalization step and
  + returns the same SummarizedExperiment class object `resDATAprepSE` but with
    the normalized data
  + plots a boxplot (if `Plot.Boxplot=TRUE`) showing the distribution of
    the normalized expression (`Normalization="vst"` means that the vst method
    is used) of genes for each sample.
* **Input**:
  + The results of the function `DATAprepSE()`.
  + In order to display the output graph, set `Plot.Boxplot=TRUE`.
  + If `Colored.By.Factors=TRUE`, the color of the boxplots would be different
    for different biological conditions.
  + In order to save the different results in a folder, select a folder path
    in `path.result`.
* **Other**:
  + Write `?DATAnormalization` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled “MultiRNAflow\_vignette-knitr.pdf”.

6. Principal component analysis (PCA) with `PCAanalysis()`

```
resPCA <- PCAanalysis(SEresNorm=resNorm,
                      DATAnorm=TRUE,
                      gene.deletion=NULL,
                      sample.deletion=NULL,
                      Plot.PCA=FALSE,
                      Mean.Accross.Time=FALSE,
                      Color.Group=NULL,
                      Cex.label=0.6,
                      Cex.point=0.7, epsilon=0.2,
                      Phi=25,Theta=140,
                      motion3D=FALSE,
                      path.result=NULL)
```

* **Output**: When samples belong to different biological conditions and
  different time points, the previous lines of code return
  + the same SummarizedExperiment class object `resNorm` but with
    the results of the function `PCA()` of the package `FactoMineR`.
  + One 2D PCA graph, one 3D PCA graph and the same 3D PCA graph in a rgl window
    (only if `motion3D=FALSE`) where samples are colored with different colors
    for different biological conditions. Furthermore, lines are drawn
    between each pair of consecutive points for each sample
    (if `Mean.Accross.Time=FALSE`, otherwise it will be only between means).
  + One 2D PCA graph, one 3D PCA graph and the same 3D PCA graph in a
    rgl window (only if `motion3D=FALSE`) for each biological condition,
    where samples are colored with different colors for different time points.
    Furthermore, lines are drawn between each pair of consecutive points
    for each sample (if `Mean.Accross.Time=FALSE`, otherwise it will be only
    between means).
  + The same graphs describe above but without lines.
* **Input**:
  + The results of the function `DATAnormalization()`.
  + We recommend the use of the normalized data (`DATAnorm=TRUE`) for the PCA
    analysis.
  + By default (if `Color.Group=NULL`), a color will be automatically applied
    for each biological condition. If you want to change the colors,
    read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".
  + If you want to delete, for instance, the genes ’ENSMUSG00000025921’ and
    ’ENSMUSG00000026113’ (respectively the second and sixth gene) and/or delete
    the samples ‘BmKo\_t2\_r1’ and ‘BmKo\_t5\_r2’, set
    - `gene.deletion=c("ENSMUSG00000025921", "ENSMUSG00000026113")` and/or
      `sample.deletion=c("BmKo_t2_r1", "BmKo_t5_r2")`
    - `gene.deletion=c(2,6)` and/or `sample.deletion=c(3,13)`.
      The integers in `gene.deletion` and `sample.deletion` represent
      respectively the row numbers and the column numbers of `ExprData`
      where the selected genes and samples are located.
  + In order to display the different output graph, set `Plot.PCA=TRUE`.
  + In order to save the different results in a folder,
    select a folder path in `path.result`.
* **Other**:
  + Write `?PCAanalysis` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled “MultiRNAflow\_vignette-knitr.pdf”.

7. Hierarchical Clustering on Principle Components (HCPC) with `HCPCanalysis()`

```
resHCPC <- HCPCanalysis(SEresNorm=resNorm,
                        DATAnorm=TRUE,
                        gene.deletion=NULL,
                        sample.deletion=NULL,
                        Plot.HCPC=FALSE,
                        Phi=25,Theta=140,
                        Cex.point=0.6,
                        epsilon=0.2,
                        Cex.label=0.6,
                        motion3D=FALSE,
                        path.result=NULL)
```

* **Output**:
  + the same SummarizedExperiment class object `resNorm` but with
    the results of the function `HCPCanalysis()` of the package `FactoMineR`
  + A dendrogram to illustrate how each cluster is composed
  + A graph indicating by color for each sample, its cluster,
    the biological condition and the time point associated to the sample.
  + One 2D PCA graph, one 3D PCA graph and the same 3D PCA graph in a rgl window
    (only if `motion3D=FALSE`). These PCA graphs are identical to the outputs
    of `PCAanalysis()` with all samples but samples are colored with different
    colors for different clusters.
* **Input**:
  + The results of the function `DATAnormalization()`.
  + We recommend the use of the normalized data (`DATAnorm=TRUE`)
    for the HCPC analysis.
  + In order to display the different output graph, set `Plot.HCPC=TRUE`.
  + In order to save the different results in a folder, select a folder path in `path.result`.
* **Other**:
  + The optimal number of clusters is automatically computed by the
    R function `HCPC()`.
  + Write `?HCPCanalysis` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled “MultiRNAflow\_vignette-knitr.pdf”.

8. Temporal clustering analysis with `MFUZZanalysis()`.

```
resMFUZZ <- MFUZZanalysis(SEresNorm=resNorm,
                          DATAnorm=TRUE,
                          DataNumberCluster=NULL,
                          Method="hcpc",
                          Membership=0.5,
                          Min.std=0.1,
                          Plot.Mfuzz=FALSE,
                          path.result=NULL)
```

* **Output**:
  + the same SummarizedExperiment class object `resNorm` but with
    - The summary of the results of the function `mfuzz()`
    - The number of clusters automatically computed
      (if `DataNumberCluster=NULL`). If `Method="hcpc"`, the function plots
      the scaled within-cluster inertia, but if `Method="kmeans"`,
      the function plots the scaled within-cluster inertia.
      As the number of genes can be very high, we recommend to select
      `Method="hcpc"` which is by default.
  + the output graph from the function `mfuzz()` which represents the most
    common temporal behavior among all genes for the biological condition ‘BmKo’.
* **Input**:
  + The results of the function `DATAnormalization()`.
  + We recommend the use of the normalized data (`DATAnorm=TRUE`)
    for the clustering analysis.
  + For each cluster, genes with membership values below the threshold
    `Membership` (numeric value between 0 and 1) will not be displayed.
    The membership values correspond to the probability of gene to belong
    to each cluster.
  + All genes where their standard deviations are smaller than the threshold
    `Min.std` (numeric positive value) will be excluded.
  + In order to display the different output graph, set `Plot.Mfuzz=TRUE`.
  + In order to save the different results in a folder, select a folder path in `path.result`.
* **Other**:
  + Write `?MFUZZanalysis` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled “MultiRNAflow\_vignette-knitr.pdf”.

9. Plot temporal expression with with `DATAplotExpressionGenes()`

```
resEXPR <- DATAplotExpressionGenes(SEresNorm=resNorm,
                                   DATAnorm=TRUE,
                                   Vector.row.gene=c(17),
                                   Color.Group=NULL,
                                   Plot.Expression=FALSE,
                                   path.result=NULL)
```

* **Output**: A graph plotting for each biological condition:
  the evolution of the 17th gene expression of the three replicates across time
  and the evolution of the mean and the standard deviation of the 17th gene
  expression across time. The color of the different lines are different
  for different biological conditions.
* **Input**:
  + The results of the function `DATAnormalization()`.
  + We recommend the use of the normalized data (`DATAnorm=TRUE`).
  + If the user wants to select several genes, for instance the 97th, the 192th,
    the 194th and the 494th, he needs to set `Vector.row.gene=c(97,192,194,494)`.
  + By default (if `Color.Group=NULL`), a color will be automatically applied
    for each biological condition. If you want to change the colors,
    read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".
  + In order to display the different output graph, set `Plot.Expression=TRUE`.
  + In order to save the different results in a folder,
    select a folder path in `path.result`.
* **Other**:
  + Write `?DATAplotExpressionGenes` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".

## 2.4 Supervised statistical analysis

10. Differential Expresion (DE) analysis with `DEanalysisGlobal()`

For the speed of the algorithm, we will take only three biological conditions
and three times

```
Sub3bc3T <- RawCounts_Weger2021_MOUSEsub500
Sub3bc3T <- Sub3bc3T[, seq_len(73)]
SelectTime <- grep("_t0_", colnames(Sub3bc3T))
SelectTime <- c(SelectTime, grep("_t1_", colnames(Sub3bc3T)))
SelectTime <- c(SelectTime, grep("_t2_", colnames(Sub3bc3T)))
Sub3bc3T <- Sub3bc3T[, c(1, SelectTime)]

resSEsub <- DATAprepSE(RawCounts=Sub3bc3T,
                       Column.gene=1,
                       Group.position=1,
                       Time.position=2,
                       Individual.position=3)
```

```
resDE <- DEanalysisGlobal(SEres=resSEsub,
                          pval.min=0.05,
                          log.FC.min=1,
                          Plot.DE.graph=FALSE,
                          path.result=NULL)
#> [1] "Preprocessing"
#> [1] "Differential expression step with DESeq2::DESeq()"
#> [1] "Case 3 analysis : Biological conditions and Times."
#> [1] "DE time analysis for each biological condition."
#> [1] "DE group analysis for each time measurement."
#> [1] "Combined time and group results."
```

* **Output**:
  + The results of the function `DESeq()`
  + a data.frame (output `Results`) which contains
    - gene names
    - pvalues, log2 fold change and DE genes between each pairs of
      biological conditions for each fixed time.
    - pvalues, log2 fold change and DE genes between each time versus the
      reference time t0 for each biological condition.
    - Temporal pattern (succession of 0 and 1) for each biological condition.
      The positions of 1 in one of these two columns, indicate the set of times ti
      such that the gene is DE between ti and the reference time t0,
      for the biological condition associated to the given column.
    - Specific genes for each biological condition at each time.
      A 1 in one of these columns means the gene is specific to the biological
      condition at a fixed time associated to the given column. 0 otherwise.
      A gene is called specific to a given biological condition BC1 at a time ti,
      if the gene is DE between BC1 and any other biological conditions
      at time ti, but not DE between any pair of other biological conditions
      at time ti.
    - Signature genes the signatures genes for each biological condition
      at each time. A 1 in one of these columns means the gene is signature gene
      to the biological condition at a fixed time associated to the given column.
      0 otherwise. A gene is called signature of a biological condition BC1
      at a given time ti, if the gene is specific to the biological condition BC1
      at time ti and DE between ti versus the reference time t0
      for the biological condition BC1.
  + the following plots from the temporal statistical analysis
    - a barplot which gives the number of DE genes between ti and the reference
      time t0, for each time ti (except the reference time t0) and
      biological condition.
    - alluvial graphs of DE genes, one per biological condition.
    - \(N\_{bc}\) graphs showing the number of DE genes as a function of time
      for each temporal group, one per biological condition. By temporal group,
      we mean the sets of genes which are first DE at the same time.
    - \(2\times N\_{bc}\) UpSet plot showing the number of DE genes
      belonging to each DE temporal pattern, for each biological condition.
      By temporal pattern, we mean the set of times ti such that the gene is
      DE between ti and the reference time t0 (see `DEplotVennBarplotTime()`).
    - an alluvial graph for DE genes which are DE at least one time for
      each group.
  + the following plots from the statistical analysis by biological condition
    - a barplot which gives the number of specific DE genes for each
      biological condition and time (see `DEplotBarplotFacetGrid()`).
    - \(N\_{bc}(N\_{bc}-1)/2\) UpSet plot which give the number of genes
      for each possible intersection (set of pairs of biological conditions),
      one per time (see `DEplotVennBarplotGroup()`).
    - an alluvial graph of genes which are specific at least one time
      (see `DEplotAlluvial()`).
  + the following plots from the combination of temporal and biological
    statistical analysis
    - a barplot which gives the number of signature genes for each biological
      condition and time (see `DEplotBarplotFacetGrid()`).
    - a barplot showing the number of genes which are DE at at least one time,
      specific at at least one time and signature at at least one time,
      for each biological condition.
    - an alluvial graph of genes which are signature at least one time
      (see `DEplotAlluvial()`).
* **Input**:
  + A gene is considered as DE if the pvalue associated to the gene is inferior
    to `pval.min` (numeric value between 0 and 1) and if the absolute
    log fold change associated to the gene is superior to `log.FC.min`
    (numeric positive value).
  + In order to display the different output graph, set `Plot.DE.graph=TRUE`.
  + In order to save the different results in a folder,
    select a folder path in `path.result`.
  + Set `RawCounts=RawCounts_Weger2021_MOUSEsub500` in order to use
    the complete dataset.
* **Other**:
  + Write `?DEanalysisGlobal` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".

11. Volcano and ratio intensity (MA) plots with `DEplotVolcanoMA()`

```
resMAvolcano <- DEplotVolcanoMA(SEresDE=resDE,
                                NbGene.plotted=2,
                                SizeLabel=3,
                                Display.plots=FALSE,
                                Save.plots=FALSE)
```

* **Output**: The function returns Volcano plots and MA plots from the results
  of our function `DEanalysisGlobal()`.
* **Input**:
  + In order to display the different output graph, set `Display.plots=TRUE`.
  + In order to save the different results in a folder, set `Save.plots=TRUE`
    and and a folder path in the input `path.result`
    in the function `DEanalysisGlobal()`.
* **Other**:
  + Write `?DEplotVolcanoMA` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".

12. Heatmaps with `DEplotHeatmaps()`

```
resHEAT <- DEplotHeatmaps(SEresDE=resDE,
                          ColumnsCriteria=2,
                          Set.Operation="union",
                          NbGene.analysis=20,
                          SizeLabelRows=5,
                          SizeLabelCols=5,
                          Display.plots=FALSE,
                          Save.plots=TRUE)
```

* **Output**: The function returns two heatmaps: one heatmap of gene expressions
  between samples and selected genes; and a correlation heatmap between samples.
* **Input**:
  + If `Set.Operation="union"` then the rows extracted from the different
    datasets included in `SEresDE` are those such that the sum of the selected
    columns of `SummarizedExperiment::rowData(SEresDE)` by `ColumnsCriteria`
    is >0. For example, the selected genes can be those DE at least at t1 or t2
    (versus the reference time t0).
  + In order to display the different output graph, set `Display.plots=TRUE`.
  + In order to save the different results in a folder, set `Save.plots=TRUE`
    and and a folder path in the input `path.result`
    in the function `DEanalysisGlobal()`.
* **Other**:
  + Write `?DEplotHeatmaps` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".

13. GO enrichment analysis with `GSEAQuickAnalysis()` and `GSEApreprocessing()`

```
resRgprofiler2 <- GSEAQuickAnalysis(Internet.Connection=FALSE,
                                    SEresDE=resDE,
                                    ColumnsCriteria=2,
                                    ColumnsLog2ordered=NULL,
                                    Set.Operation="union",
                                    Organism="mmusculus",
                                    MaxNumberGO=20,
                                    Background=FALSE,
                                    Display.plots=FALSE,
                                    Save.plots=TRUE)
```

* **Output**: The function realizes, from the outputs of `DEanalysisGlobal()`,
  an enrichment analysis (GSEA) of a subset of genes with the R package
  `gprofiler2`.
  + A data.frame which contains the outputs of `gprofiler2::gost()`
  + A Manhattan plot showing all GO names according to their pvalue.
  + A lollipop graph showing the `MaxNumberGO` most important GO.
* **Input**:
  + If `Set.Operation="union"` then the rows extracted from the different
    datasets included in `SEresDE` are those such that the sum of the selected
    columns of `SummarizedExperiment::rowData(SEresDE)` by `ColumnsCriteria`
    is >0. For example, the selected genes can be those DE at least at t1 or t2
    (versus the reference time t0).
  + In order to display the different output graph, set `Display.plots=TRUE`.
  + In order to save the different results in a folder, set `Save.plots=TRUE`
    and a folder path in the input `path.result`
    in the function `DEanalysisGlobal()`.
* **Other**:
  + Write `?GSEAQuickAnalysis` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".

```
resGSEApreprocess <- GSEApreprocessing(SEresDE=resDE,
                                       ColumnsCriteria=2,
                                       Set.Operation="union",
                                       Rnk.files=FALSE,
                                       Save.files=FALSE)
```

* **Output**:
  + A vector of character containing gene names specified by `ColumnsCriteria`
    and `Set.Operation`.
  + A vector of character containing all gene names
  + And, in case where `Save.files=TRUE` and the path.result of
    `DEanalysisGlobal()` is not NULL, specific files designed to be used as input
    for the following online tools and software : GSEA, DAVID, WebGestalt,
    gProfiler, Panther, ShinyGO, Enrichr, GOrilla
* **Input**: If `Set.Operation="union"` then the rows extracted from the
  different datasets included in `SEresDE` are those such that the sum of
  the selected columns of `SummarizedExperiment::rowData(SEresDE)`
  by `ColumnsCriteria` is >0.
  For example, the selected genes can be those DE at least at t1 or t2
  (versus the reference time t0).
* **Other**:
  + Write `?GSEApreprocessing` in your console for more information
    about the function.
  + For a more complete description of the function and package,
    the user must read our pdf file entitled ’MultiRNAflow\_vignette-knitr.pdf".

# 3 SessionInfo

Here is the output of `sessionInfo()` on the system on which this document
was compiled.

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] tcltk     stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#> [1] MultiRNAflow_1.8.0  Mfuzz_2.70.0        DynDoc_1.88.0
#> [4] widgetTools_1.88.0  e1071_1.7-16        Biobase_2.70.0
#> [7] BiocGenerics_0.56.0 generics_0.1.4      BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
#>   [3] shape_1.4.6.1               magrittr_2.0.4
#>   [5] magick_2.9.0                TH.data_1.1-4
#>   [7] estimability_1.5.1          farver_2.1.2
#>   [9] rmarkdown_2.30              GlobalOptions_0.1.2
#>  [11] fs_1.6.6                    vctrs_0.6.5
#>  [13] Cairo_1.7-0                 base64enc_0.1-3
#>  [15] rstatix_0.7.3               htmltools_0.5.8.1
#>  [17] S4Arrays_1.10.0             broom_1.0.10
#>  [19] Formula_1.2-5               SparseArray_1.10.0
#>  [21] gridGraphics_0.5-1          sass_0.4.10
#>  [23] bslib_0.9.0                 htmlwidgets_1.6.4
#>  [25] plyr_1.8.9                  sandwich_3.1-1
#>  [27] emmeans_2.0.0               plotly_4.11.0
#>  [29] zoo_1.8-14                  cachem_1.1.0
#>  [31] misc3d_0.9-1                lifecycle_1.0.4
#>  [33] iterators_1.0.14            pkgconfig_2.0.3
#>  [35] Matrix_1.7-4                R6_2.6.1
#>  [37] fastmap_1.2.0               MatrixGenerics_1.22.0
#>  [39] clue_0.3-66                 digest_0.6.37
#>  [41] colorspace_2.1-2            S4Vectors_0.48.0
#>  [43] DESeq2_1.50.0               GenomicRanges_1.62.0
#>  [45] ggpubr_0.6.2                labeling_0.4.3
#>  [47] httr_1.4.7                  abind_1.4-8
#>  [49] compiler_4.5.1              proxy_0.4-27
#>  [51] withr_3.0.2                 doParallel_1.0.17
#>  [53] backports_1.5.0             S7_0.2.0
#>  [55] BiocParallel_1.44.0         viridis_0.6.5
#>  [57] carData_3.0-5               UpSetR_1.4.0
#>  [59] dendextend_1.19.1           Rttf2pt1_1.3.14
#>  [61] ggsignif_0.6.4              MASS_7.3-65
#>  [63] rappdirs_0.3.3              tkWidgets_1.88.0
#>  [65] DelayedArray_0.36.0         rjson_0.2.23
#>  [67] scatterplot3d_0.3-44        flashClust_1.01-2
#>  [69] tools_4.5.1                 extrafontdb_1.1
#>  [71] FactoMineR_2.12             glue_1.8.0
#>  [73] grid_4.5.1                  cluster_2.1.8.1
#>  [75] reshape2_1.4.4              gtable_0.3.6
#>  [77] class_7.3-23                tidyr_1.3.1
#>  [79] data.table_1.17.8           car_3.1-3
#>  [81] XVector_0.50.0              ggrepel_0.9.6
#>  [83] foreach_1.5.2               pillar_1.11.1
#>  [85] stringr_1.5.2               yulab.utils_0.2.1
#>  [87] circlize_0.4.16             splines_4.5.1
#>  [89] dplyr_1.1.4                 lattice_0.22-7
#>  [91] survival_3.8-3              tidyselect_1.2.1
#>  [93] ComplexHeatmap_2.26.0       locfit_1.5-9.12
#>  [95] knitr_1.50                  gridExtra_2.3
#>  [97] bookdown_0.45               IRanges_2.44.0
#>  [99] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
#> [101] stats4_4.5.1                xfun_0.53
#> [103] plot3Drgl_1.0.5             factoextra_1.0.7
#> [105] matrixStats_1.5.0           DT_0.34.0
#> [107] stringi_1.8.7               lazyeval_0.2.2
#> [109] yaml_2.3.10                 evaluate_1.0.5
#> [111] codetools_0.2-20            extrafont_0.20
#> [113] tibble_3.3.0                BiocManager_1.30.26
#> [115] multcompView_0.1-10         ggplotify_0.1.3
#> [117] cli_3.6.5                   xtable_1.8-4
#> [119] jquerylib_0.1.4             dichromat_2.0-0.1
#> [121] Rcpp_1.1.0                  gprofiler2_0.2.3
#> [123] coda_0.19-4.1               png_0.1-8
#> [125] parallel_4.5.1              leaps_3.2
#> [127] rgl_1.3.24                  ggplot2_4.0.0
#> [129] ggalluvial_0.12.5           viridisLite_0.4.2
#> [131] mvtnorm_1.3-3               plot3D_1.4.2
#> [133] scales_1.4.0                purrr_1.1.0
#> [135] crayon_1.5.3                GetoptLong_1.0.5
#> [137] rlang_1.1.6                 multcomp_1.4-29
```

Weger, Benjamin D., Cedric Gobet, Fabrice P. A. David, Florian Atger, Eva Martin, Nicholas E. Phillips, Aline Charpagne, Meltem Weger, Felix Naef, and Frederic Gachon. 2021. “Systematic Analysis of Differential Rhythmic Liver Gene Expression Mediated by the Circadian Clock and Feeding Rhythms.” *Proceedings of the National Academy of Sciences* 118 (3): e2015803118. <https://doi.org/10.1073/pnas.2015803118>.