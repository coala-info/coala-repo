# Intro\_to\_Marker\_Enrichment\_Modeling\_Analysis

#### Kirsten Diggins, Sierra Lima, Jonathan Irish

## Intro to Marker Enrichment Modeling

Marker Enrichment Modeling (MEM) is an analysis method for automatically generating quantitative labels for cell populations. The labels include measured features that are specifically enriched on the population compared to a reference population or set of populations.

The equation is as follows:

\(MEM = |MAGpop-MAGref| + IQRref/IQRpop -1\); If MAGpop-MAGref <0, MEM = -MEM

The scores are normalized to a -10 to +10 scale in order to facilitate comparison across datasets, data types, and platforms.

For example, the label generated for CD4+ T cells in comparison to other blood cells is:

CD4+4 CD3+4 CD44+2 CD61+1 CD45+1 CD33+1
CD16-9 CD8-7 CD11c-5 HLADR-5 CD69-3 CD11b-2 CD20-2 CD38-1 CD56-1

This label means that in the context of normal human blood, this cell population is specifically enriched for CD4, CD3, CD44, CD61, CD45, and CD3 while it lacks enrichment of CD16, CD8, CD11c, HLA-DR, CD69, CD11b, CD20, CD38, and CD56.

### Installing MEM

To install MEM, run the following code:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("cytoMEM")
```

### Example Data: Normal Human Peripheral Blood Cells (PBMC)

As an example, a dataset from the mass cytometry characterization of normal human blood is shown here. 25 surface markers were measured on approximately 50K cells (post-cleanup gating) to generate these data.

7 major blood cell populations were identified by expert biaxial gating: CD4+ T cells (cluster 1), CD8+ T cells (cluster 2), IgM+ B cells (cluster 5), IgM- B cells (cluster 4), dendritic cells (DCs) (cluster 3), natural killer (NK) cells (cluster 7), and monocytes (cluster 6). The single-cell data from these gates were merged into one file that includes an additional column specifying the cluster ID (gate) of each cell.

| Cluster | Cell population |
| --- | --- |
| 1 | CD4+ T cells |
| 2 | CD8+ T cells |
| 3 | DCs |
| 4 | IgM- B cells |
| 5 | IgM+ B cells |
| 6 | Monocytes |
| 7 | NK cells |

```
library(cytoMEM)
data(PBMC)
head(PBMC)
```

```
##                CD19      CD117      CD11b         CD4        CD8        CD20
## 34776 228.397949219  7.5046458 -0.9150130  -0.2774475 19.5639267 72.83031464
## 24019  -0.132328644 -0.3033659  1.8847632 210.0684814  9.7968664 -0.08022045
## 16288  -0.052747775 -0.3950237  5.6076398 279.7434692  0.7161499 -0.28644082
## 20080  -0.006922856 -0.6971378  0.8639542 222.2871552  4.8340611 -0.50484931
## 2795   -0.130458266 -0.5786674 -0.5515317 168.1178284  6.4676809 -0.30329800
## 42843  -0.455609500 -0.9955425 19.5426483  -0.4268070  3.4530685 -0.20784166
##             CD34        CD61       CD123     CD45RA     CD45       CD10
## 34776 12.5207195 -0.40058744 -0.07129496  82.092789 689.7737  5.1752467
## 24019 -0.6508371 -0.84006447 -0.17981683   8.382261 488.5262 11.5378046
## 16288 -0.3778218  2.26188397 -0.58151388 214.990265 946.5264  5.1995435
## 20080 -0.1224543 -0.09539251 -0.60980731  20.322187 619.9553 -0.7068613
## 2795  -0.3869398  0.67348033 -0.55655158 152.076248 346.0350 -0.5322152
## 42843 -0.2831804 -0.08337180 -0.33748615  60.164875 576.0743 -0.8543764
##             CD33      CD11c       CD14        CD69       CD15        CD16
## 34776  5.5634279 -0.6485761 -0.1669585  0.53545767  1.8927699  -0.5835396
## 24019 -0.1477257 -0.7465935  3.0520153 -0.40952709 -0.8505481   6.1292162
## 16288 -0.8284602 -0.1544797 -0.6179111 -0.63483632  0.1009932  -0.3244779
## 20080  0.8591875 -0.8049483 -0.8027710  8.82421875 -0.1086400   4.5313282
## 2795  -0.6559110 -0.7710050  0.4461933  0.69180661 -0.7268596  -0.8876948
## 42843 -0.0539494 -0.7829651 -0.4304854 -0.03877449  2.6627660 844.5389404
##            CD44      CD38        CD25         CD3         IgM      HLADR
## 34776  84.50186 31.794935  1.29871488  -0.5886221 74.17253113 91.3828659
## 24019 397.93457 11.492667  2.99961948  64.7258148 -0.80473328 -0.4379718
## 16288 325.31021 25.313175  1.62456477 292.4138489 -0.02986890  0.6092911
## 20080 483.35672 13.429344 15.27015018  99.1597366  0.08114051 -0.6701981
## 2795  103.83817 35.024025  1.58465934  96.7151718 -0.48192909 17.5168056
## 42843  72.14079  4.988808 -0.05385961   3.1720824 -0.40776855 -0.9950773
##              CD56 cluster
## 34776 -0.04730700       5
## 24019 -0.09216285       1
## 16288  0.20110747       1
## 20080 -0.70026368       1
## 2795  -0.81669140       1
## 42843  6.11005735       7
```

For additional details about the measured features and further references, see `?PBMC`.

### Input data: File format and structure

The `MEM()` function accepts matrix and data frame objects and file types .txt, .csv, and .fcs.

### Multiple Files

#### Reading files in to R

If you have multiple files and each file contains cells from one cluster (i.e. what you would get from exporting gates as files from a flow data analysis platform), you can enter a list of file names as input. The easiest way to do this is infiles <- dir() MEM\_values <- MEM(infiles,…)

In the above example, `infiles` will contain a list of all the file names in your working directory. Subfolders will be ignored during the analysis. This method assumes that the only files in the folder are those meant to be analyzed and therefore expects them to be of the same file type. If you have multiple file types in the folder you can use `infiles <- dir(pattern="*.[ext]")` to only select files of type [ext]. For example, to only read the .txt files, use `pattern="*.txt"`.

#### Use of `file.is.clust` and `add.fileID`

If you have multiple files, you will need to specify whether each file is a cluster using the `file.is.clust` argument of the MEM function. If `file.is.clust=TRUE`, this means that each file contains cells from only one cluster.

If `file.is.clust=FALSE`, this means that each file contains cells from multiple clusters **and** that the last column of each file specifies the cells’ cluster IDs. This might be the case if, for example, you ran a cluster analysis on multiple files together and then separated the files back out to compare clusters across conditions, timepoints, etc.

Additionally, if `file.is.clust=FALSE`, you can use the `add.fileID` argument to specify (`TRUE` or `FALSE`) if a file ID should be appended to each cell’s cluster ID. For example, if you had 3 files and each file contained a mix of cells from 5 clusters (1-5), the new cluster IDs for the cells from cluster 1 would be 1.1, 1.2, and 1.3 depending on which file they came from (file 1, file 2, or file 3). This may be particularly useful in cases where a cluster analysis was run across files from multiple experimental conditions. The `add.fileID=TRUE` option will keep cells separate depending on the experimental condition, making it easier to compare feature enrichment changes that occur both between clusters and between conditions.

If `file.is.clust=TRUE` or `add.fileID=TRUE`, a folder called `output files` will be created in the user’s working directory and a txt file will be written that specifies which file corresponds to each cluster ID.

### Data Format

In all cases, whether data is in the form of multiple files, a single file, or a data frame or matrix object, the cells must be in the rows and the markers or measured features must be in the columns, where the last column is the cluster ID (unless `file.is.clust=TRUE`).

Ex)

| Feature A | Feature B | Feature C | cluster |
| --- | --- | --- | --- |
| Cell 1A | Cell 1B | Cell 1C | Cell 1 clust |
| Cell 2A | Cell 2B | Cell 2C | Cell 2 clust |
| Cell 3A | Cell 3B | Cell 3C | Cell 3 clust |

### Arcsinh Transformation

You can optionally apply a hyperbolic arcsine transformation to your data. This is a log-like transformation commonly applied to flow cytometry data. If `transform=TRUE`, the transformation will be applied across all non-clusterID channels in the dataset. The `cofactor` argument species what cofactor to use in this transformation. For `PBMC`, the transformation is applied with a cofactor of 15.

`MEM_values = (PBMC, transform=TRUE, cofactor=15,...)`

If you prefer to use a different type of transformation or need to apply different cofactors to different channels (as is often the case for fluorescence flow cytometry data), you should apply these transformations to the data prior to MEM analysis and then set `transform=FALSE`.

### Reference Population Selection

The argument `choose.ref` should be set to `TRUE` if you wish to choose an alternative reference population. A prompt will appear in the console asking which population(s) to use as reference. These should be referred to by their cluster IDs. For example, to use populations 1 and 2 as reference, when prompted the user should enter `1,2`. These populations will subsequently be combined into one merged reference population that will be used for all populations in the dataset.

By default, the reference population will be all non-population cells in the dataset. For example, if there are 5 clusters or populations (1-5), population 1 will be compared to populations 2-5. In this case, populations 2-5 will be automatically combined into one merged cluster that is referred to as reference population 1. The same is done for all other populations in the dataset.

However, it may sometimes be useful to compare populations to a single population or subset of populations using `choose.ref=TRUE`. For example, in an analysis of bone marrow cells, one might compare all the cells to the hematopoeitic stem cell population in order to determine changes that occur in cell surface marker enrichment over the course of blood cell differentiation.

You can also set the reference to be a zero, or synthetic negative, reference using `zero.ref=TRUE`. This is useful when you want to see the positive enrichements of each population. For example, if all of your samples are CD45+, the MEM label and heatmap will show this enrichment for all of the populations instead of the CD45 not appearing due to the comparison between populations.

### IQR Thresholding

Given that population and reference IQR values are compared in a ratio in the MEM equation, if a population has a very small IQR due to background level expression on a channel, this can artificially inflate the MEM value for that marker on the population. In order to avoid this, a threshold of 0.5 is automatically set.

The user can also enter their own IQR threshold value; however, this is not recommended unless the analyst understands the implications of changing the IQR value and has a deep understanding of the dataset.

### Putting it all together: MEM analysis of PBMC

To run the `PBMC` example directly, use `example(MEM)`. It is not necessary to choose or rename the markers to run the analysis on this dataset. However, to illustrate the workflow, example code and console output is shown below for the `PBMC` dataset using `choose.markers=TRUE` and `rename.markers=TRUE`.

Version 1 (with user input in console)

MEM( PBMC, transform=TRUE, cofactor=15, choose.markers=TRUE, markers=“all”, rename.markers=TRUE, new.marker.names="none, choose.ref=FALSE, zero.ref=FALSE, IQR.thresh=NULL)

# Column names in your file will be printed to the console

Enter column numbers to include (e.g. 1:5,6,8:10). 1:25

Enter new marker names, in same order they appear above, separated by commas. No spaces allowed in name. CD19,CD117,CD11b,CD4,CD8,CD20,CD34,CD61,CD123,CD45RA,CD45,CD10,CD33,CD11c,CD14,CD69,CD15,CD16,CD44,CD38,CD25,CD3,IgM,HLADR,CD56

Version 2 (passing character strings through MEM)

MEM( PBMC, transform=TRUE, cofactor=15, choose.markers=FALSE, markers=“1:25”, choose.ref=FALSE, zero.ref=FALSE, rename.markers=FALSE, new.marker.names=“CD19,CD117,CD11b,CD4,CD8,CD20,CD34,CD61,CD123,CD45RA,CD45,CD10,CD33,CD11c,CD14,CD69,CD15,CD16,CD44,CD38,CD25,CD3,IgM,HLADR,CD56”,IQR.thresh=NULL)

When successfully executed, the `MEM` function returns a list of matrices:

| Matrix | Values |
| --- | --- |
| MAGpop | population medians for each marker |
| MAGref | medians for each population’s reference population |
| IQRpop | population interquartile ranges for each marker |
| IQRref | IQRs for each population’s reference population |

See `?MEM_values` for more details.

The output for MEM analysis of the `PBMC` dataset is shown below.

```
MEM_values <-
  MEM(
    PBMC,
    transform = TRUE,
    cofactor = 15,
    # Change choose.markers to TRUE to see and select channels in console
    choose.markers = FALSE,
    markers = "all",
    choose.ref = FALSE,
    zero.ref = FALSE,
    # Change rename.markers to TRUE to see and choose new names for channels in console
    rename.markers = FALSE,
    new.marker.names = "none",
    IQR.thresh = NULL
  )

str(MEM_values)
```

```
## List of 6
##  $ MAGpop    :List of 1
##   ..$ : num [1:7, 1:25] 2.5086 0.0251 0.0287 2.5251 0.0185 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:7] "5" "1" "7" "4" ...
##   .. .. ..$ : chr [1:25] "CD19" "CD117" "CD11b" "CD4" ...
##  $ MAGref    :List of 1
##   ..$ : num [1:7, 1:25] 0.0231 0.0143 0.0185 0.021 0.0206 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:7] "5" "1" "7" "4" ...
##   .. .. ..$ : chr [1:25] "CD19" "CD117" "CD11b" "CD4" ...
##  $ IQRpop    :List of 1
##   ..$ : num [1:7, 1:25] 0.649 0.5 0.5 0.641 0.5 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:7] "5" "1" "7" "4" ...
##   .. .. ..$ : chr [1:25] "CD19" "CD117" "CD11b" "CD4" ...
##  $ IQRref    :List of 1
##   ..$ : num [1:7, 1:25] 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:7] "5" "1" "7" "4" ...
##   .. .. ..$ : chr [1:25] "CD19" "CD117" "CD11b" "CD4" ...
##  $ MEM_matrix:List of 1
##   ..$ : num [1:7, 1:25] 3.3093 0.0144 0.0136 3.3341 -0.0029 ...
##   .. ..- attr(*, "dimnames")=List of 2
##   .. .. ..$ : chr [1:7] "5" "1" "7" "4" ...
##   .. .. ..$ : chr [1:25] "CD19" "CD117" "CD11b" "CD4" ...
##  $ File Order:List of 1
##   ..$ : num 0
```

## Generating MEM labels and heatmaps

The `build_heatmaps()` function is meant to be used along with the `MEM` function to generate labels and heatmaps from the MEM function output.

```
MEM_values = MEM(infiles,...)
build_heatmaps(MEM_values,...)
```

The `build_heatmaps` function will output a heatmap of population medians and a heatmap of MEM scores with population MEM labels as the heatmap row names. Additionally, files can be automatically written to the `output files` folder that is automatically created in the user’s working directory.

Output files include

* PDF of MEM heatmap (“MEM heatmap.pdf”)
* Txt file containing the population MEM labels (“enrichment score-rownames.txt”)
* Txt file containing the population median values displayed in the heatmap (“Medians matrix.txt”)
* Txt file containing unrounded population MEM scores displayed in the heatmap(“MEM matrix.txt”)
* Txt file containing the population IQR values displayed in the heatmap (“IQR matrix.txt”)

### Arguments of `build_heatmaps()`

`build_heatmaps( MEM_values, cluster.MEM="both", cluster.medians="none", display.thresh=0, output.files=TRUE, labels = TRUE)`

Heatmaps are generated by an internal call to the function `heatmap.2()` in the package `{gplots}`. The user is given the option to cluster the rows, columns, or both of the median and MEM heatmap. If `cluster.medians=FALSE`, the order of the median heatmap rows and columns will be ordered to match the order of the MEM heatmap rows and columns. The heatmaps will open in new R windows. If you want the MEM labels on the generated MEM heatmap, set `labels=TRUE`.

The heatmaps will also be written to file if user has entered `output.files=TRUE`. Note that due to the window dimensions the rownames will likely be cut off in the displayed heatmap. To view the full rownames, save the image as a pdf file and open it in a pdf editing program. You can also access the full MEM label in the output text file “enrichment score-rownames.txt”.

The `display.thresh` argument must be numeric, 0-10. The MEM label that is displayed for each population will include all markers with a MEM score equal to or greater than `display.thresh`. `display.thresh` defaults to 0, meaning that all markers will be displayed, including those with an enrichment score of 0.

An example of this function can be run directly using `example(build_heatmaps)`. This will generate heatmaps using output from the MEM analysis of `PBMC`.

```
build_heatmaps(
  MEM_values,
  cluster.MEM = "both",
  cluster.medians = "none",
  cluster.IQRs = "none",
  display.thresh = 1,
  output.files = FALSE,
  labels = FALSE,
  only.MEMheatmap = FALSE)
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

```
## [1] "MEM label for cluster 2 : ▲ CD8+7 CD3+4 CD69+2 CD20+1 CD45RA+1 HLADR+1 ▼ CD4-10 CD38-2 CD44-1"
## [2] "MEM label for cluster 6 : ▲ CD33+5 CD11c+5 CD61+4 CD14+4 CD11b+3 CD44+3 HLADR+3 CD123+1 CD38+1 ▼ CD3-7 CD4-5 CD8-3"
## [3] "MEM label for cluster 3 : ▲ CD11c+4 HLADR+4 CD123+2 CD45RA+1 CD33+1 CD16+1 CD44+1 ▼ CD3-8 CD4-3 CD8-3 CD11b-1"
## [4] "MEM label for cluster 7 : ▲ CD16+6 CD11b+1 CD45RA+1 CD11c+1 CD38+1 HLADR+1 CD56+1 ▼ CD4-10 CD3-6 CD44-2 CD45-1"
## [5] "MEM label for cluster 5 : ▲ HLADR+5 IgM+4 CD19+3 CD20+3 CD45RA+1 ▼ CD4-10 CD3-8 CD8-4 CD11b-1 CD69-1 CD44-1"
## [6] "MEM label for cluster 4 : ▲ HLADR+4 CD19+3 CD20+3 CD45RA+1 CD44+1 ▼ CD4-9 CD3-8 CD8-3 CD11b-1"
## [7] "MEM label for cluster 1 : ▲ CD4+4 CD3+4 CD44+2 CD61+1 CD45+1 CD33+1 ▼ CD16-9 CD8-7 CD11c-5 HLADR-5 CD69-3 CD11b-2 CD20-2 CD38-1 CD56-1"
```

## Generating RMSD (similarity) scores

The `MEM_RMSD()` function is meant to be used after the `MEM` function to generate a score of similarity to compare MEM labels on a set of populations.

MEM\_values = MEM(infiles,…) RMSD(MEM\_values[[5]][[1]],…)

The `MEM_RMSD` function will output a heatmap of RMSD values as well as a RMSD matrix for all populations compared to one another. Additionally, files can be automatically written to the `output files` folder that is automatically created in the user’s working directory.

Output files include

* PDF of RMSD heatmap (“RMSD heatmap.pdf”)
* Txt file containing the population RMSD values (“MEM\_RMSD.txt”)

```
#data(MEM_matrix)

MEM_RMSD(
  MEM_values[[5]][[1]],
  format=NULL,
  output.matrix=FALSE)
```

![](data:image/png;base64...)

```
##           5         1         7         4         2         3         6
## 5 100.00000  75.40927  89.64126  95.56302  82.62074  89.83926  87.20540
## 1  75.40927 100.00000  74.01200  76.10357  75.15190  77.87504  76.40500
## 7  89.64126  74.01200 100.00000  90.53193  86.62810  89.79072  87.00719
## 4  95.56302  76.10357  90.53193 100.00000  83.32640  91.05033  88.28519
## 2  82.62074  75.15190  86.62810  83.32640 100.00000  82.03775  80.82818
## 3  89.83926  77.87504  89.79072  91.05033  82.03775 100.00000  91.74987
## 6  87.20540  76.40500  87.00719  88.28519  80.82818  91.74987 100.00000
```

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
## [1] cytoMEM_1.14.0
##
## loaded via a namespace (and not attached):
##  [1] gplots_3.2.0        cli_3.6.5           knitr_1.50
##  [4] rlang_1.1.6         xfun_0.53           KernSmooth_2.23-26
##  [7] generics_0.1.4      jsonlite_2.0.0      gtools_3.9.5
## [10] RProtoBufLib_2.22.0 S4Vectors_0.48.0    htmltools_0.5.8.1
## [13] sass_0.4.10         stats4_4.5.1        rmarkdown_2.30
## [16] Biobase_2.70.0      evaluate_1.0.5      jquerylib_0.1.4
## [19] caTools_1.18.3      bitops_1.0-9        fastmap_1.2.0
## [22] yaml_2.3.10         lifecycle_1.0.4     compiler_4.5.1
## [25] digest_0.6.37       R6_2.6.1            cytolib_2.22.0
## [28] bslib_0.9.0         tools_4.5.1         matrixStats_1.5.0
## [31] flowCore_2.22.0     BiocGenerics_0.56.0 cachem_1.1.0
```