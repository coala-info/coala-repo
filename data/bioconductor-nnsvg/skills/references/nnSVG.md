# nnSVG Tutorial

Lukas M. Weber1 and Stephanie C. Hicks2

1Boston University, Boston, MA, United States
2Johns Hopkins University, Baltimore, MD, United States

#### 30 October 2025

#### Package

nnSVG 1.14.0

# 1 Introduction

`nnSVG` is a method for scalable identification of spatially variable genes (SVGs) in spatially-resolved transcriptomics data.

The `nnSVG` method is based on nearest-neighbor Gaussian processes ([Datta et al., 2016](https://www.tandfonline.com/doi/full/10.1080/01621459.2015.1044091), [Finley et al., 2019](https://www.tandfonline.com/doi/full/10.1080/10618600.2018.1537924)) and uses the BRISC algorithm ([Saha and Datta, 2018](https://onlinelibrary.wiley.com/doi/full/10.1002/sta4.184)) for model fitting and parameter estimation. `nnSVG` allows identification and ranking of SVGs with flexible length scales across a tissue slide or within spatial domains defined by covariates. The method scales linearly with the number of spatial locations and can be applied to datasets containing thousands or more spatial locations.

`nnSVG` is implemented as an R package within the Bioconductor framework, and is available from [Bioconductor](https://bioconductor.org/packages/nnSVG).

More details describing the method are available in our paper, available from [Nature Communications](https://www.nature.com/articles/s41467-023-39748-z).

# 2 Installation

The following code will install the latest release version of the `nnSVG` package from Bioconductor. Additional details are shown on the [Bioconductor](https://bioconductor.org/packages/nnSVG) page.

```
install.packages("BiocManager")
BiocManager::install("nnSVG")
```

The latest development version can also be installed from the `devel` version of Bioconductor or from [GitHub](https://github.com/lmweber/nnSVG).

# 3 Input data format

In the examples below, we assume the input data are provided as a [SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment) Bioconductor object. In this case, the outputs are stored in the `rowData` of the `SpatialExperiment` object.

Alternatively, the inputs can also be provided as a numeric matrix of normalized and transformed counts (e.g. log-transformed normalized counts, also known as logcounts) and a numeric matrix of spatial coordinates.

# 4 Tutorial

## 4.1 Standard analysis

### 4.1.1 Run nnSVG

Here we show a short example demonstrating how to run `nnSVG`.

For faster runtime in this example, we subsample the dataset and run `nnSVG` on only a small number of genes. For a full analysis, the subsampling step can be skipped.

```
library(SpatialExperiment)
library(STexampleData)
library(scran)
library(nnSVG)
library(ggplot2)
```

```
# load example dataset from STexampleData package
# see '?Visium_humanDLPFC' for more details
spe <- Visium_humanDLPFC()
```

```
## see ?STexampleData and browseVignettes('STexampleData') for documentation
```

```
## loading from cache
```

```
dim(spe)
```

```
## [1] 33538  4992
```

```
# preprocessing steps

# keep only spots over tissue
spe <- spe[, colData(spe)$in_tissue == 1]
dim(spe)
```

```
## [1] 33538  3639
```

```
# skip spot-level quality control, since this has been performed previously
# on this dataset

# filter low-expressed and mitochondrial genes
# using default filtering parameters
spe <- filter_genes(spe)
```

```
## Gene filtering: removing mitochondrial genes
```

```
## removed 13 mitochondrial genes
```

```
## Gene filtering: retaining genes with at least 3 counts in at least 0.5% (n = 19) of spatial locations
```

```
## removed 30216 out of 33525 genes due to low expression
```

```
# calculate logcounts (log-transformed normalized counts) using scran package
# using library size factors
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)

assayNames(spe)
```

```
## [1] "counts"    "logcounts"
```

```
# select small set of random genes and several known SVGs for
# faster runtime in this example
set.seed(123)
ix_random <- sample(seq_len(nrow(spe)), 10)

known_genes <- c("MOBP", "PCP4", "SNAP25", "HBB", "IGKC", "NPY")
ix_known <- which(rowData(spe)$gene_name %in% known_genes)

ix <- c(ix_known, ix_random)

spe <- spe[ix, ]
dim(spe)
```

```
## [1]   16 3639
```

```
# run nnSVG

# set seed for reproducibility
set.seed(123)
# using a single thread in this example
spe <- nnSVG(spe)
```

```
## Warning in nnSVG(spe): Rows (genes) and/or columns (spots) containing all zero
## counts have been found. Please see examples in tutorial for code to filter out
## zeros and/or low-expressed genes to avoid errors.
```

```
# show results
rowData(spe)
```

```
## DataFrame with 16 rows and 17 columns
##                         gene_id   gene_name    feature_type   sigma.sq
##                     <character> <character>     <character>  <numeric>
## ENSG00000211592 ENSG00000211592        IGKC Gene Expression   0.565654
## ENSG00000168314 ENSG00000168314        MOBP Gene Expression   1.387394
## ENSG00000122585 ENSG00000122585         NPY Gene Expression   0.285674
## ENSG00000244734 ENSG00000244734         HBB Gene Expression   0.329421
## ENSG00000132639 ENSG00000132639      SNAP25 Gene Expression   0.430040
## ...                         ...         ...             ...        ...
## ENSG00000130382 ENSG00000130382       MLLT1 Gene Expression 0.00978555
## ENSG00000036672 ENSG00000036672        USP2 Gene Expression 0.00307277
## ENSG00000086232 ENSG00000086232     EIF2AK1 Gene Expression 0.00315782
## ENSG00000106278 ENSG00000106278      PTPRZ1 Gene Expression 0.00279851
## ENSG00000133606 ENSG00000133606       MKRN1 Gene Expression 0.00632245
##                    tau.sq        phi    loglik   runtime      mean       var
##                 <numeric>  <numeric> <numeric> <numeric> <numeric> <numeric>
## ENSG00000211592  0.455041   20.10688  -4531.64     1.816  0.622937  1.007454
## ENSG00000168314  0.364188    1.10202  -3663.60     1.082  0.805525  1.205673
## ENSG00000122585  0.280173   71.65329  -3995.23     1.565  0.393975  0.567383
## ENSG00000244734  0.353754   27.81410  -4044.96     1.724  0.411262  0.697673
## ENSG00000132639  0.430106    3.03385  -3912.70     0.852  3.451926  0.857922
## ...                   ...        ...       ...       ...       ...       ...
## ENSG00000130382  0.283115 50.9880748  -2927.61     1.243  0.298698  0.292976
## ENSG00000036672  0.241105 12.5382833  -2597.00     0.853  0.248384  0.244218
## ENSG00000086232  0.266973 25.9302215  -2781.47     0.852  0.275193  0.270208
## ENSG00000106278  0.367893  9.5280046  -3357.32     1.000  0.352159  0.370784
## ENSG00000133606  0.272432  0.0827087  -2831.51     1.147  0.295404  0.278806
##                     spcov    prop_sv loglik_lm   LR_stat      rank        pval
##                 <numeric>  <numeric> <numeric> <numeric> <numeric>   <numeric>
## ENSG00000211592  1.207346   0.554185  -5176.53  1289.775         3           0
## ENSG00000168314  1.462248   0.792080  -5503.33  3679.464         1           0
## ENSG00000122585  1.356646   0.504861  -4131.87   273.278         6           0
## ENSG00000244734  1.395587   0.482191  -4507.99   926.046         4           0
## ENSG00000132639  0.189973   0.499961  -4884.19  1942.986         2           0
## ...                   ...        ...       ...       ...       ...         ...
## ENSG00000130382  0.331177 0.03340915  -2929.28   3.35216        12 0.187106089
## ENSG00000036672  0.223173 0.01258414  -2598.08   2.15483        13 0.340473854
## ENSG00000086232  0.204200 0.01168999  -2782.09   1.23716        14 0.538708116
## ENSG00000106278  0.150219 0.00754943  -3357.83   1.01111        15 0.603169436
## ENSG00000133606  0.269170 0.02268111  -2839.08  15.15227         9 0.000512539
##                       padj
##                  <numeric>
## ENSG00000211592          0
## ENSG00000168314          0
## ENSG00000122585          0
## ENSG00000244734          0
## ENSG00000132639          0
## ...                    ...
## ENSG00000130382 0.24947479
## ENSG00000036672 0.41904474
## ENSG00000086232 0.61566642
## ENSG00000106278 0.64338073
## ENSG00000133606 0.00091118
```

### 4.1.2 Investigate results

The results are stored in the `rowData` of the `SpatialExperiment` object.

The main results of interest are:

* `LR_stat`: likelihood ratio (LR) statistics
* `rank`: rank of top SVGs according to LR statistics
* `pval`: p-values from asymptotic chi-squared distribution with 2 degrees of freedom
* `padj`: p-values adjusted for multiple testing, which can be used to define a cutoff for statistically significant SVGs (e.g. `padj` <= 0.05)
* `prop_sv`: effect size, defined as proportion of spatial variance out of total variance

```
# number of significant SVGs
table(rowData(spe)$padj <= 0.05)
```

```
##
## FALSE  TRUE
##     7     9
```

```
# show results for top n SVGs
rowData(spe)[order(rowData(spe)$rank)[1:10], ]
```

```
## DataFrame with 10 rows and 17 columns
##                         gene_id   gene_name    feature_type   sigma.sq
##                     <character> <character>     <character>  <numeric>
## ENSG00000168314 ENSG00000168314        MOBP Gene Expression 1.38739399
## ENSG00000132639 ENSG00000132639      SNAP25 Gene Expression 0.43003959
## ENSG00000211592 ENSG00000211592        IGKC Gene Expression 0.56565436
## ENSG00000244734 ENSG00000244734         HBB Gene Expression 0.32942113
## ENSG00000183036 ENSG00000183036        PCP4 Gene Expression 0.23102221
## ENSG00000122585 ENSG00000122585         NPY Gene Expression 0.28567358
## ENSG00000129562 ENSG00000129562        DAD1 Gene Expression 0.02389606
## ENSG00000114923 ENSG00000114923      SLC4A3 Gene Expression 0.01147170
## ENSG00000133606 ENSG00000133606       MKRN1 Gene Expression 0.00632245
## ENSG00000143543 ENSG00000143543         JTB Gene Expression 0.07547797
##                    tau.sq         phi    loglik   runtime      mean       var
##                 <numeric>   <numeric> <numeric> <numeric> <numeric> <numeric>
## ENSG00000168314  0.364188   1.1020177  -3663.60     1.082  0.805525  1.205673
## ENSG00000132639  0.430106   3.0338473  -3912.70     0.852  3.451926  0.857922
## ENSG00000211592  0.455041  20.1068839  -4531.64     1.816  0.622937  1.007454
## ENSG00000244734  0.353754  27.8140976  -4044.96     1.724  0.411262  0.697673
## ENSG00000183036  0.452735   8.2722785  -4026.22     0.778  0.687961  0.684598
## ENSG00000122585  0.280173  71.6532892  -3995.23     1.565  0.393975  0.567383
## ENSG00000129562  0.464723  10.1418819  -3842.24     1.079  0.549318  0.489167
## ENSG00000114923  0.237260  12.7656826  -2617.36     1.235  0.250768  0.248816
## ENSG00000133606  0.272432   0.0827087  -2831.51     1.147  0.295404  0.278806
## ENSG00000143543  0.463561 119.7470905  -4036.28     1.384  0.654919  0.539172
##                     spcov   prop_sv loglik_lm    LR_stat      rank        pval
##                 <numeric> <numeric> <numeric>  <numeric> <numeric>   <numeric>
## ENSG00000168314  1.462248 0.7920804  -5503.33 3679.46397         1 0.00000e+00
## ENSG00000132639  0.189973 0.4999614  -4884.19 1942.98556         2 0.00000e+00
## ENSG00000211592  1.207346 0.5541853  -5176.53 1289.77508         3 0.00000e+00
## ENSG00000244734  1.395587 0.4821910  -4507.99  926.04573         4 0.00000e+00
## ENSG00000183036  0.698656 0.3378716  -4473.57  894.68884         5 0.00000e+00
## ENSG00000122585  1.356646 0.5048608  -4131.87  273.27818         6 0.00000e+00
## ENSG00000129562  0.281410 0.0489053  -3861.98   39.49098         7 2.65854e-09
## ENSG00000114923  0.427112 0.0461207  -2632.02   29.31376         8 4.31119e-07
## ENSG00000133606  0.269170 0.0226811  -2839.08   15.15227         9 5.12539e-04
## ENSG00000143543  0.419491 0.1400231  -4039.07    5.59669        10 6.09108e-02
##                        padj
##                   <numeric>
## ENSG00000168314 0.00000e+00
## ENSG00000132639 0.00000e+00
## ENSG00000211592 0.00000e+00
## ENSG00000244734 0.00000e+00
## ENSG00000183036 0.00000e+00
## ENSG00000122585 0.00000e+00
## ENSG00000129562 6.07667e-09
## ENSG00000114923 8.62238e-07
## ENSG00000133606 9.11180e-04
## ENSG00000143543 9.74572e-02
```

```
# plot spatial expression of top-ranked SVG
ix <- which(rowData(spe)$rank == 1)
ix_name <- rowData(spe)$gene_name[ix]
ix_name
```

```
## [1] "MOBP"
```

```
df <- as.data.frame(
  cbind(spatialCoords(spe),
        expr = counts(spe)[ix, ]))

ggplot(df, aes(x = pxl_col_in_fullres, y = pxl_row_in_fullres, color = expr)) +
  geom_point(size = 0.8) +
  coord_fixed() +
  scale_y_reverse() +
  scale_color_gradient(low = "gray90", high = "blue",
                       trans = "sqrt", breaks = range(df$expr),
                       name = "counts") +
  ggtitle(ix_name) +
  theme_bw() +
  theme(plot.title = element_text(face = "italic"),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
```

![](data:image/png;base64...)

## 4.2 With covariates

### 4.2.1 Run nnSVG

`nnSVG` can also be run on datasets with known covariates, such as spatial domains or cell types. In this case, the method will identify SVGs within regions defined by the selected covariates, e.g. within spatial domains.

Here we run a short example to demonstrate this functionality.

This example dataset contains several known SVGs within spatial domains. Specifically, we are interested in SVGs with gradients of expression within the CA3 region of the mouse hippocampus. (See dataset help files for more details and references.)

As above, for faster runtime in this example, we subsample a very small subset of the data. For a full analysis, the subsampling step can be skipped.

```
library(SpatialExperiment)
library(STexampleData)
library(scran)
library(nnSVG)
library(ggplot2)
```

```
# load example dataset from STexampleData package
# see '?SlideSeqV2_mouseHPC' for more details
spe <- SlideSeqV2_mouseHPC()
```

```
## see ?STexampleData and browseVignettes('STexampleData') for documentation
```

```
## loading from cache
```

```
dim(spe)
```

```
## [1] 23264 53208
```

```
# preprocessing steps

# remove spots with NA cell type labels
spe <- spe[, !is.na(colData(spe)$celltype)]
dim(spe)
```

```
## [1] 23264 15003
```

```
# check cell type labels
table(colData(spe)$celltype)
```

```
##
##             Astrocyte                   CA1                   CA3
##                  6688                  1320                  1729
##         Cajal_Retzius               Choroid                Denate
##                    60                    21                  1713
##     Endothelial_Stalk       Endothelial_Tip           Entorihinal
##                    96                   118                   111
##             Ependymal           Interneuron Microglia_Macrophages
##                    94                   730                   299
##                 Mural          Neurogenesis        Neuron.Slc17a6
##                    26                    47                    44
##       Oligodendrocyte        Polydendrocyte
##                  1793                   114
```

```
# filter low-expressed and mitochondrial genes
# using adjusted filtering parameters for this platform
spe <- filter_genes(
  spe,
  filter_genes_ncounts = 1,
  filter_genes_pcspots = 1,
  filter_mito = TRUE
)
```

```
## Gene filtering: removing mitochondrial genes
```

```
## removed 25 mitochondrial genes
```

```
## Gene filtering: retaining genes with at least 1 counts in at least 1% (n = 151) of spatial locations
```

```
## removed 14356 out of 23239 genes due to low expression
```

```
dim(spe)
```

```
## [1]  8883 15003
```

```
# calculate log-transformed normalized counts using scran package
# using library size normalization
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)

assayNames(spe)
```

```
## [1] "counts"    "logcounts"
```

```
# select small set of random genes and several known SVGs for
# faster runtime in this example
set.seed(123)
ix_random <- sample(seq_len(nrow(spe)), 10)

known_genes <- c("Cpne9", "Rgs14")
ix_known <- which(rowData(spe)$gene_name %in% known_genes)

ix <- c(ix_known, ix_random)

spe <- spe[ix, ]
dim(spe)
```

```
## [1]    12 15003
```

```
# run nnSVG with covariates

# create model matrix for cell type labels
X <- model.matrix(~ colData(spe)$celltype)
dim(X)
```

```
## [1] 15003    17
```

```
stopifnot(nrow(X) == ncol(spe))

# set seed for reproducibility
set.seed(123)
# using a single thread in this example
spe <- nnSVG(spe, X = X)
```

```
## Warning in nnSVG(spe, X = X): Rows (genes) and/or columns (spots) containing
## all zero counts have been found. Please see examples in tutorial for code to
## filter out zeros and/or low-expressed genes to avoid errors.
```

```
# show results
rowData(spe)
```

```
## DataFrame with 12 rows and 15 columns
##          gene_name    sigma.sq    tau.sq         phi    loglik   runtime
##        <character>   <numeric> <numeric>   <numeric> <numeric> <numeric>
## Cpne9        Cpne9 6.91469e-04 0.0275984 1.28476e+01   5484.78    14.170
## Rgs14        Rgs14 2.77038e-03 0.0452680 1.90815e-06   1650.39    13.428
## Eogt          Eogt 8.52208e-05 0.0198481 7.81846e+01   8083.08     7.881
## Ergic1      Ergic1 2.54389e-04 0.0465677 9.77238e+01   1677.16     7.317
## Zfp330      Zfp330 1.21717e-04 0.0266163 1.54158e+02   5879.76     7.535
## ...            ...         ...       ...         ...       ...       ...
## Hdac11      Hdac11 3.54443e-03 0.1648232    145.2971  -7920.47    10.523
## Nab2          Nab2 3.99615e-05 0.0145549     67.5465  10421.32     8.649
## Senp3        Senp3 7.97660e-05 0.0253771     36.8022   6248.29     8.635
## Fbxo6        Fbxo6 9.53698e-05 0.0253767    168.3817   6243.54     8.041
## Ntng1        Ntng1 2.39135e-03 0.0433036     24.1539   1951.83     9.956
##             mean       var     spcov    prop_sv loglik_lm    LR_stat      rank
##        <numeric> <numeric> <numeric>  <numeric> <numeric>  <numeric> <numeric>
## Cpne9  0.0194924 0.0283971  1.349026 0.02444229   5455.66   58.23907         3
## Rgs14  0.0360053 0.0485672  1.461850 0.05767000   1515.16  270.46145         1
## Eogt   0.0125243 0.0200072  0.737089 0.00427529   8082.32    1.52763         6
## Ergic1 0.0359343 0.0471421  0.443854 0.00543309   1676.61    1.10864         8
## Zfp330 0.0201203 0.0267799  0.548330 0.00455223   5879.05    1.42306         7
## ...          ...       ...       ...        ...       ...        ...       ...
## Hdac11 0.1258726 0.1705333  0.472979 0.02105171  -7923.51   6.072553         4
## Nab2   0.0120832 0.0146742  0.523164 0.00273805  10421.82  -1.016745        12
## Senp3  0.0199706 0.0255396  0.447217 0.00313338   6248.60  -0.631638        11
## Fbxo6  0.0188249 0.0255584  0.518768 0.00374409   6243.59  -0.103463        10
## Ntng1  0.0341843 0.0466474  1.430524 0.05233303   1854.40 194.856131         2
##               pval        padj
##          <numeric>   <numeric>
## Cpne9  2.25708e-13 9.02833e-13
## Rgs14  0.00000e+00 0.00000e+00
## Eogt   4.65886e-01 8.41531e-01
## Ergic1 5.74464e-01 8.61696e-01
## Zfp330 4.90893e-01 8.41531e-01
## ...            ...         ...
## Hdac11   0.0480133     0.14404
## Nab2     1.0000000     1.00000
## Senp3    1.0000000     1.00000
## Fbxo6    1.0000000     1.00000
## Ntng1    0.0000000     0.00000
```

Note that if there are any empty levels in the factor used to create the design matrix, these can be removed when creating the design matrix, as follows:

```
# create model matrix after dropping empty factor levels
X <- model.matrix(~ droplevels(as.factor(colData(spe)$celltype)))
```

### 4.2.2 Investigate results

```
# number of significant SVGs
table(rowData(spe)$padj <= 0.05)
```

```
##
## FALSE  TRUE
##     9     3
```

```
# show results for top n SVGs
rowData(spe)[order(rowData(spe)$rank)[1:10], ]
```

```
## DataFrame with 10 rows and 15 columns
##          gene_name    sigma.sq    tau.sq         phi    loglik   runtime
##        <character>   <numeric> <numeric>   <numeric> <numeric> <numeric>
## Rgs14        Rgs14 2.77038e-03 0.0452680 1.90815e-06   1650.39    13.428
## Ntng1        Ntng1 2.39135e-03 0.0433036 2.41539e+01   1951.83     9.956
## Cpne9        Cpne9 6.91469e-04 0.0275984 1.28476e+01   5484.78    14.170
## Hdac11      Hdac11 3.54443e-03 0.1648232 1.45297e+02  -7920.47    10.523
## Cul1          Cul1 4.19371e-04 0.0688365 9.03178e+01  -1259.18     8.071
## Eogt          Eogt 8.52208e-05 0.0198481 7.81846e+01   8083.08     7.881
## Zfp330      Zfp330 1.21717e-04 0.0266163 1.54158e+02   5879.76     7.535
## Ergic1      Ergic1 2.54389e-04 0.0465677 9.77238e+01   1677.16     7.317
## Gclc          Gclc 1.22209e-04 0.0345001 1.19972e+02   3941.26     7.536
## Fbxo6        Fbxo6 9.53698e-05 0.0253767 1.68382e+02   6243.54     8.041
##             mean       var     spcov    prop_sv loglik_lm     LR_stat      rank
##        <numeric> <numeric> <numeric>  <numeric> <numeric>   <numeric> <numeric>
## Rgs14  0.0360053 0.0485672  1.461850 0.05767000   1515.16 270.4614462         1
## Ntng1  0.0341843 0.0466474  1.430524 0.05233303   1854.40 194.8561307         2
## Cpne9  0.0194924 0.0283971  1.349026 0.02444229   5455.66  58.2390704         3
## Hdac11 0.1258726 0.1705333  0.472979 0.02105171  -7923.51   6.0725529         4
## Cul1   0.0548957 0.0696223  0.373045 0.00605538  -1260.02   1.6933490         5
## Eogt   0.0125243 0.0200072  0.737089 0.00427529   8082.32   1.5276268         6
## Zfp330 0.0201203 0.0267799  0.548330 0.00455223   5879.05   1.4230584         7
## Ergic1 0.0359343 0.0471421  0.443854 0.00543309   1676.61   1.1086351         8
## Gclc   0.0256188 0.0347265  0.431513 0.00352979   3941.30  -0.0749267         9
## Fbxo6  0.0188249 0.0255584  0.518768 0.00374409   6243.59  -0.1034630        10
##               pval        padj
##          <numeric>   <numeric>
## Rgs14  0.00000e+00 0.00000e+00
## Ntng1  0.00000e+00 0.00000e+00
## Cpne9  2.25708e-13 9.02833e-13
## Hdac11 4.80133e-02 1.44040e-01
## Cul1   4.28839e-01 8.41531e-01
## Eogt   4.65886e-01 8.41531e-01
## Zfp330 4.90893e-01 8.41531e-01
## Ergic1 5.74464e-01 8.61696e-01
## Gclc   1.00000e+00 1.00000e+00
## Fbxo6  1.00000e+00 1.00000e+00
```

```
# plot spatial expression of top-ranked SVG
ix <- which(rowData(spe)$rank == 1)
ix_name <- rowData(spe)$gene_name[ix]
ix_name
```

```
## [1] "Rgs14"
```

```
df <- as.data.frame(
  cbind(spatialCoords(spe),
        expr = counts(spe)[ix, ]))

ggplot(df, aes(x = xcoord, y = ycoord, color = expr)) +
  geom_point(size = 0.1) +
  coord_fixed() +
  scale_color_gradient(low = "gray90", high = "blue",
                       trans = "sqrt", breaks = range(df$expr),
                       name = "counts") +
  ggtitle(ix_name) +
  theme_bw() +
  theme(plot.title = element_text(face = "italic"),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
```

![](data:image/png;base64...)

## 4.3 Multiple samples

For datasets consisting of multiple biological samples (e.g. multiple 10x Genomics Visium capture areas, or multiple tissue samples from other platforms), we can run nnSVG once per sample and combine the results by averaging the ranks of the SVGs identified per sample.

For this example, we use a dataset from the locus coeruleus region in postmortem human brain samples measured with the 10x Genomics Visium platform, which is available in the [WeberDivechaLCdata](https://bioconductor.org/packages/WeberDivechaLCdata) package and is described in our paper [Weber and Divecha et al. 2023](https://elifesciences.org/reviewed-preprints/84628).

### 4.3.1 Run nnSVG

```
library(SpatialExperiment)
library(WeberDivechaLCdata)
library(nnSVG)
```

```
# load example dataset from WeberDivechaLCdata package
# see '?WeberDivechaLCdata_Visium' for more details
spe <- WeberDivechaLCdata_Visium()
```

```
## see ?WeberDivechaLCdata and browseVignettes('WeberDivechaLCdata') for documentation
```

```
## loading from cache
```

```
dim(spe)
```

```
## [1] 23728 20380
```

```
# check sample IDs
table(colData(spe)$sample_id)
```

```
##
## Br6522_LC_1_round1 Br6522_LC_2_round1   Br8153_LC_round2   Br2701_LC_round2
##               2979               3054               2208               2809
##   Br6522_LC_round3   Br8079_LC_round3   Br2701_LC_round3   Br8153_LC_round3
##               2313               2473               2342               2202
```

This dataset contains a complex experimental design consisting of multiple samples (Visium capture areas) and multiple parts (contiguous tissue areas) for some of these samples, as described in our paper [Weber and Divecha et al. 2023](https://elifesciences.org/reviewed-preprints/84628).

For the simplified example here, we select two samples. For a dataset with more than two samples, this example can be extended by including more samples within the loops.

```
# select sample IDs for example
samples_keep <- c("Br6522_LC_1_round1", "Br6522_LC_2_round1")

# subset SpatialExperiment object to keep only these samples
spe <- spe[, colData(spe)$sample_id %in% samples_keep]

# remove empty levels from factor of sample IDs
colData(spe)$sample_id <- droplevels(colData(spe)$sample_id)

# check
dim(spe)
```

```
## [1] 23728  6033
```

```
table(colData(spe)$sample_id)
```

```
##
## Br6522_LC_1_round1 Br6522_LC_2_round1
##               2979               3054
```

```
# preprocessing steps

# keep only spots over tissue
spe <- spe[, colData(spe)$in_tissue == 1]
dim(spe)
```

```
## [1] 23728  6033
```

```
# skip spot-level quality control, since this has been performed previously
# on this dataset
```

```
# filter low-expressed genes

# filter out genes with extremely low expression
# using simple threshold on total UMI counts summed across all spots

# approximate threshold of 10 UMI counts per sample
n_umis <- 20
ix_low_genes <- rowSums(counts(spe)) < n_umis
table(ix_low_genes)
```

```
## ix_low_genes
## FALSE  TRUE
## 12859 10869
```

```
spe <- spe[!ix_low_genes, ]
dim(spe)
```

```
## [1] 12859  6033
```

```
# filter any new zeros created after filtering low-expressed genes

# remove genes with zero expression
ix_zero_genes <- rowSums(counts(spe)) == 0
table(ix_zero_genes)
```

```
## ix_zero_genes
## FALSE
## 12859
```

```
if (sum(ix_zero_genes) > 0) {
  spe <- spe[!ix_zero_genes, ]
}

dim(spe)
```

```
## [1] 12859  6033
```

```
# remove spots with zero expression
ix_zero_spots <- colSums(counts(spe)) == 0
table(ix_zero_spots)
```

```
## ix_zero_spots
## FALSE
##  6033
```

```
if (sum(ix_zero_spots) > 0) {
  spe <- spe[, !ix_zero_spots]
}

dim(spe)
```

```
## [1] 12859  6033
```

Run nnSVG once per sample and store the resulting lists of top SVGs. Note that we perform additional gene filtering for nnSVG individually per sample, and re-calculate logcounts after the gene filtering for each sample.

In this dataset, mitochondrial genes are of specific biological interest (see our paper [Weber and Divecha et al. 2023](https://elifesciences.org/reviewed-preprints/84628) for details), so we do not filter these genes out (`filter_mito = FALSE`). In most datasets, mitochondrial genes are not of biological interest and should be filtered out (`filter_mito = TRUE`).

For faster runtime in this example, we also subsample a small number of genes before running `nnSVG`, as in the examples above. For a full analysis, the subsampling step should be skipped.

```
# run nnSVG once per sample and store lists of top SVGs

sample_ids <- levels(colData(spe)$sample_id)

res_list <- as.list(rep(NA, length(sample_ids)))
names(res_list) <- sample_ids

for (s in seq_along(sample_ids)) {

  # select sample
  ix <- colData(spe)$sample_id == sample_ids[s]
  spe_sub <- spe[, ix]

  dim(spe_sub)

  # run nnSVG filtering for mitochondrial genes and low-expressed genes
  # (note: set 'filter_mito = TRUE' in most datasets)
  spe_sub <- filter_genes(
    spe_sub,
    filter_genes_ncounts = 3,
    filter_genes_pcspots = 0.5,
    filter_mito = FALSE
  )

  # remove any zeros introduced by filtering
  ix_zeros <- colSums(counts(spe_sub)) == 0
  if (sum(ix_zeros) > 0) {
    spe_sub <- spe_sub[, !ix_zeros]
  }

  dim(spe_sub)

  # re-calculate logcounts after filtering
  spe_sub <- computeLibraryFactors(spe_sub)
  spe_sub <- logNormCounts(spe_sub)

  # subsample small set of random genes for faster runtime in this example
  # (same genes for each sample)
  # (note: skip this step in a full analysis)
  if (s == 1) {
    set.seed(123)
    ix_random <- sample(seq_len(nrow(spe_sub)), 30)
    genes_random <- rownames(spe_sub)[ix_random]
  }
  spe_sub <- spe_sub[rownames(spe_sub) %in% genes_random, ]
  dim(spe_sub)

  # run nnSVG
  set.seed(123)
  spe_sub <- nnSVG(spe_sub)

  # store results for this sample
  res_list[[s]] <- rowData(spe_sub)
}
```

```
## Gene filtering: retaining genes with at least 3 counts in at least 0.5% (n = 15) of spatial locations
```

```
## removed 10420 out of 12859 genes due to low expression
```

```
## Warning in nnSVG(spe_sub): Rows (genes) and/or columns (spots) containing all
## zero counts have been found. Please see examples in tutorial for code to filter
## out zeros and/or low-expressed genes to avoid errors.
```

```
## Gene filtering: retaining genes with at least 3 counts in at least 0.5% (n = 16) of spatial locations
```

```
## removed 11790 out of 12859 genes due to low expression
```

```
## Warning in nnSVG(spe_sub): Rows (genes) and/or columns (spots) containing all
## zero counts have been found. Please see examples in tutorial for code to filter
## out zeros and/or low-expressed genes to avoid errors.
```

Now that we have run nnSVG once per sample, we can combine the results across multiple samples by averaging the ranks of the SVGs. This approach was applied in our recent paper [Weber and Divecha et al. 2023](https://elifesciences.org/reviewed-preprints/84628).

```
# combine results for multiple samples by averaging gene ranks
# to generate an overall ranking

# number of genes that passed filtering (and subsampling) for each sample
sapply(res_list, nrow)
```

```
## Br6522_LC_1_round1 Br6522_LC_2_round1
##                 30                 14
```

```
# match results from each sample and store in matching rows
res_ranks <- matrix(NA, nrow = nrow(spe), ncol = length(sample_ids))
rownames(res_ranks) <- rownames(spe)
colnames(res_ranks) <- sample_ids

for (s in seq_along(sample_ids)) {
  stopifnot(colnames(res_ranks)[s] == sample_ids[s])
  stopifnot(colnames(res_ranks)[s] == names(res_list)[s])

  rownames_s <- rownames(res_list[[s]])
  res_ranks[rownames_s, s] <- res_list[[s]][, "rank"]
}

# remove genes that were filtered out in all samples
ix_allna <- apply(res_ranks, 1, function(r) all(is.na(r)))
res_ranks <- res_ranks[!ix_allna, ]

dim(res_ranks)
```

```
## [1] 30  2
```

```
# calculate average ranks
# note missing values due to filtering for samples
avg_ranks <- rowMeans(res_ranks, na.rm = TRUE)

# calculate number of samples where each gene is within top 100 ranked SVGs
# for that sample
n_withinTop100 <- apply(res_ranks, 1, function(r) sum(r <= 100, na.rm = TRUE))

# summary table
df_summary <- data.frame(
  gene_id = names(avg_ranks),
  gene_name = rowData(spe)[names(avg_ranks), "gene_name"],
  gene_type = rowData(spe)[names(avg_ranks), "gene_type"],
  overall_rank = rank(avg_ranks),
  average_rank = unname(avg_ranks),
  n_withinTop100 = unname(n_withinTop100),
  row.names = names(avg_ranks)
)

# sort by average rank
df_summary <- df_summary[order(df_summary$average_rank), ]
head(df_summary)
```

```
##                         gene_id gene_name      gene_type overall_rank
## ENSG00000104435 ENSG00000104435     STMN2 protein_coding            1
## ENSG00000180176 ENSG00000180176        TH protein_coding            2
## ENSG00000197756 ENSG00000197756    RPL37A protein_coding            3
## ENSG00000005486 ENSG00000005486    RHBDD2 protein_coding            4
## ENSG00000064393 ENSG00000064393     HIPK2 protein_coding            5
## ENSG00000171724 ENSG00000171724     VAT1L protein_coding            6
##                 average_rank n_withinTop100
## ENSG00000104435          1.0              2
## ENSG00000180176          2.5              2
## ENSG00000197756          3.0              2
## ENSG00000005486          4.0              2
## ENSG00000064393          5.5              2
## ENSG00000171724          7.0              2
```

```
# top n genes
# (note: NAs in this example due to subsampling genes for faster runtime)
top100genes <- df_summary$gene_name[1:100]

# summary table of "replicated" SVGs (i.e. genes that are highly ranked in at
# least x samples)
df_summaryReplicated <- df_summary[df_summary$n_withinTop100 >= 2, ]

# re-calculate rank within this set
df_summaryReplicated$overall_rank <- rank(df_summaryReplicated$average_rank)

dim(df_summaryReplicated)
```

```
## [1] 14  6
```

```
head(df_summaryReplicated)
```

```
##                         gene_id gene_name      gene_type overall_rank
## ENSG00000104435 ENSG00000104435     STMN2 protein_coding            1
## ENSG00000180176 ENSG00000180176        TH protein_coding            2
## ENSG00000197756 ENSG00000197756    RPL37A protein_coding            3
## ENSG00000005486 ENSG00000005486    RHBDD2 protein_coding            4
## ENSG00000064393 ENSG00000064393     HIPK2 protein_coding            5
## ENSG00000171724 ENSG00000171724     VAT1L protein_coding            6
##                 average_rank n_withinTop100
## ENSG00000104435          1.0              2
## ENSG00000180176          2.5              2
## ENSG00000197756          3.0              2
## ENSG00000005486          4.0              2
## ENSG00000064393          5.5              2
## ENSG00000171724          7.0              2
```

```
# top "replicated" SVGs
topSVGsReplicated <- df_summaryReplicated$gene_name
```

```
# plot one of the top SVGs

head(df_summary, 5)
```

```
##                         gene_id gene_name      gene_type overall_rank
## ENSG00000104435 ENSG00000104435     STMN2 protein_coding            1
## ENSG00000180176 ENSG00000180176        TH protein_coding            2
## ENSG00000197756 ENSG00000197756    RPL37A protein_coding            3
## ENSG00000005486 ENSG00000005486    RHBDD2 protein_coding            4
## ENSG00000064393 ENSG00000064393     HIPK2 protein_coding            5
##                 average_rank n_withinTop100
## ENSG00000104435          1.0              2
## ENSG00000180176          2.5              2
## ENSG00000197756          3.0              2
## ENSG00000005486          4.0              2
## ENSG00000064393          5.5              2
```

```
ix_gene <- which(rowData(spe)$gene_name == df_summary[2, "gene_name"])

df <- as.data.frame(cbind(
  colData(spe),
  spatialCoords(spe),
  gene = counts(spe)[ix_gene, ]
))

ggplot(df, aes(x = pxl_col_in_fullres, y = pxl_row_in_fullres, color = gene)) +
  facet_wrap(~ sample_id, nrow = 1, scales = "free") +
  geom_point(size = 0.6) +
  scale_color_gradient(low = "gray80", high = "red", trans = "sqrt",
                       name = "counts", breaks = range(df$gene)) +
  scale_y_reverse() +
  ggtitle(paste0(rowData(spe)$gene_name[ix_gene], " expression")) +
  theme_bw() +
  theme(aspect.ratio = 1,
        panel.grid = element_blank(),
        plot.title = element_text(face = "italic"),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
```

![](data:image/png;base64...)

# 5 Troubleshooting

This section describes some common errors and solutions. Feedback on any additional issues is welcome to be provided as [GitHub issues](https://github.com/lmweber/nnSVG/issues).

## 5.1 Zeros (genes or spots)

If your dataset contains rows (genes) or columns (spots) with all zero counts and you have not performed filtering for zeros and/or low-expressed genes, you may see an error similar to the following:

```
Timing stopped at: 0.068 0.003 0.072
Error: BiocParallel errors
  1 remote errors, element index: 2
  33536 unevaluated and other errors
  first remote error:
Error in BRISC_estimation(coords = coords, y = y_i, x = X, cov.model = "exponential", : c++ error: dpotrf failed
```

After performing filtering for low-expressed genes and/or low-quality spots, it is also possible that new rows (genes) or columns (spots) of all zero counts may have been introduced. In this case, you may see the same error.

The following example code can be used to check for and remove any rows (genes) or columns (spots) with all zero counts.

```
# filter any new zeros created after filtering low-expressed genes

# remove genes with zero expression
ix_zero_genes <- rowSums(counts(spe)) == 0
table(ix_zero_genes)

if (sum(ix_zero_genes) > 0) {
  spe <- spe[!ix_zero_genes, ]
}

dim(spe)

# remove spots with zero expression
ix_zero_spots <- colSums(counts(spe)) == 0
table(ix_zero_spots)

if (sum(ix_zero_spots) > 0) {
  spe <- spe[, !ix_zero_spots]
}

dim(spe)
```

The `nnSVG()` function also checks for rows (genes) or columns (spots) of all zero counts, and will return a warning if these exist.

## 5.2 Small numbers of spots

The nnSVG model requires some minimum number of spots for reliable model fitting and parameter estimation. Running nnSVG with too few spots can return errors from the BRISC model fitting functions.

As an approximate guide, we recommend at least 100 spots (spatial locations).

In datasets with multiple samples, the minimum number of spots applies per sample.

In models with covariates for spatial domains, some minimum number of spots per spatial domain is also required. In this case, if the dataset contains too few spots, one possible solution can be to combine spatial domains into larger domains, e.g. if the main biological interest is one domain vs. all the rest (where the rest can be combined into one domain).

## 5.3 Multiple samples

In datasets with multiple samples, nnSVG can be run once per sample and the results combined by averaging the ranks of the identified SVGs per sample, as demonstrated in the example above.

In this case, ensure that:

* the loop is set up correctly (subsetting each sample within the loop)
* gene filtering is performed per sample within the loop
* any new zeros (rows/genes or columns/spots) introduced by the filtering are removed
* logcounts are re-calculated after filtering
* rows (genes) are matched correctly when combining the results from the multiple samples

# 6 Session information

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
##  [1] WeberDivechaLCdata_1.11.2   ggplot2_4.0.0
##  [3] nnSVG_1.14.0                scran_1.38.0
##  [5] scuttle_1.20.0              STexampleData_1.17.1
##  [7] ExperimentHub_3.0.0         AnnotationHub_4.0.0
##  [9] BiocFileCache_3.0.0         dbplyr_2.5.1
## [11] SpatialExperiment_1.20.0    SingleCellExperiment_1.32.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3            pbapply_1.7-4        httr2_1.2.1
##  [4] rlang_1.1.6          magrittr_2.0.4       compiler_4.5.1
##  [7] RSQLite_2.4.3        png_0.1-8            vctrs_0.6.5
## [10] pkgconfig_2.0.3      crayon_1.5.3         rdist_0.0.5
## [13] fastmap_1.2.0        magick_2.9.0         XVector_0.50.0
## [16] labeling_0.4.3       BRISC_1.0.6          rmarkdown_2.30
## [19] tinytex_0.57         purrr_1.1.0          bit_4.6.0
## [22] xfun_0.53            bluster_1.20.0       cachem_1.1.0
## [25] beachmat_2.26.0      jsonlite_2.0.0       blob_1.2.4
## [28] DelayedArray_0.36.0  BiocParallel_1.44.0  irlba_2.3.5.1
## [31] parallel_4.5.1       cluster_2.1.8.1      R6_2.6.1
## [34] RColorBrewer_1.1-3   bslib_0.9.0          limma_3.66.0
## [37] jquerylib_0.1.4      Rcpp_1.1.0           bookdown_0.45
## [40] knitr_1.50           Matrix_1.7-4         igraph_2.2.1
## [43] tidyselect_1.2.1     dichromat_2.0-0.1    abind_1.4-8
## [46] yaml_2.3.10          codetools_0.2-20     curl_7.0.0
## [49] lattice_0.22-7       tibble_3.3.0         withr_3.0.2
## [52] S7_0.2.0             KEGGREST_1.50.0      evaluate_1.0.5
## [55] Biostrings_2.78.0    pillar_1.11.1        BiocManager_1.30.26
## [58] filelock_1.0.3       BiocVersion_3.22.0   scales_1.4.0
## [61] glue_1.8.0           metapod_1.18.0       tools_4.5.1
## [64] BiocNeighbors_2.4.0  ScaledMatrix_1.18.0  locfit_1.5-9.12
## [67] RANN_2.6.2           grid_4.5.1           AnnotationDbi_1.72.0
## [70] edgeR_4.8.0          BiocSingular_1.26.0  cli_3.6.5
## [73] rsvd_1.0.5           rappdirs_0.3.3       S4Arrays_1.10.0
## [76] dplyr_1.1.4          gtable_0.3.6         sass_0.4.10
## [79] digest_0.6.37        SparseArray_1.10.0   dqrng_0.4.1
## [82] farver_2.1.2         rjson_0.2.23         memoise_2.0.1
## [85] htmltools_0.5.8.1    lifecycle_1.0.4      httr_1.4.7
## [88] statmod_1.5.1        bit64_4.6.0-1
```