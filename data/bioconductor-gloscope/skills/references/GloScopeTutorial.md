# scRNA-Seq Population-level Analysis using GloScope

Hao Wang1\*, William Torous1 and Elizabeth Purdom1

1University of California, Berkeley, California, USA

\*hao\_wang@berkeley.edu

#### 2025-11-20

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation](#installation)
* [2 Example](#example)
  + [2.1 Data Input](#data-input)
  + [2.2 Divergence Matrix Calculation](#divergence-matrix-calculation)
  + [2.3 More on the density method:](#more-on-the-density-method)
  + [2.4 More on the divergence method](#more-on-the-divergence-method)
* [3 Visualization](#visualization)
* [4 Testing and Confidence intervals](#testing-and-confidence-intervals)
* [5 Parallelization and Random Seeds](#parallelization-and-random-seeds)
  + [5.1 Random seed](#random-seed)
* [6 References](#references)
* **Appendix**
* [SessionInfo](#sessioninfo)

# 1 Introduction

This vignette will review the steps needed to implement the `GloScope` methodology. `GloScope` is a framework for creating profiles of scRNA-Seq samples in order to globally compare and analyze them across patients or tissue samples. First this methodology estimates a global gene expression distribution for each sample, and then it calculates how divergent pairs of samples are from each other. The output from the package’s main function, `gloscope()`, is a \(n\times n\) divergence matrix containing the pairwise statistical divergences between all samples. This divergence matrix can be the input to other downstream statistical and machine learning tools. This package has been submitted to Bioconductor because we believe it may be of particular interest to the bioinformatic community and because it depends on other packages from Bioconductor.

`GloScope` estimates the gene expression density from a low dimensional embedding of the UMI count measurements, such as PCA or scVI embeddings. Users must provide `GloScope` with a `data.frame` containing each cell’s embedding coordinates, along with the metadata which identifies to which sample each cell belongs to.

The package provides a helper function `plotMDS` which allows the user to visualize the divergence matrix with multidimensional scaling (MDS), but the divergence matrix can also be visualized with other algorithms as well.

A standard workflow for `GloScope` consists of:

1. Obtain the dimension reduction embedding of the cells and specify how many dimensions to keep. This is computed outside of the `GloScope` package.
2. Choose a density estimation method (Gaussian mixture or k-nearest neighbours) to estimate each sample’s latent distribution.
3. Calculate the symmetric KL divergence or Jensen-Shannon divergence between all pairs of samples.
4. Visualize the distance matrix with the first two dimensions of MDS using the `plotMDS` function.

## 1.1 Installation

You can install the latest stable release of `GloScope` from Bioconductor. Make sure that you have the `BiocManager` package installed to proceed.

```
if (!require("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("GloScope")
```

# 2 Example

In this section, we use a toy example to illustrate the input, output and visualization steps of the `GloScope` pipeline.

The data is a subset of that presented in Stephenson et al. ([2021](#ref-stephenson2021single)), and was obtained from [this hyperlinked URL](https://www.ebi.ac.uk/biostudies/arrayexpress/studies/E-MTAB-10026). The dataset has a total of 647,366 peripheral blood mononuclear cells (PBMCs) from 130 patients, whose phenotypes are COVID-infected, healthy control donor, patients with other non-COVID respiratory disease, and volunteers administered with intravenous lipopolysaccharide (IV-LPS). To enable faster computation in this tutorial, we subset this dataset to 20 random COVID and healthy control donors and further subsample each patient’s count matrix to 500 random cells. This subsampled data is provided in the SingleCellExperiment object `example_SCE`. We emphasize that this subsampling procedure is only for demonstration purposes and is not a recommended step in normal analyses.

## 2.1 Data Input

We first load the `GloScope` package and the aforementioned example dataset.

```
library(GloScope)
data("example_SCE")
```

The example SingleCellExperiment object contains the first \(50\) principal components of the subsampled cells, as well as the sample and phenotype labels associated with each cell.

```
head(SingleCellExperiment::reducedDim(example_SCE,"PCA")[,1:10])
#>                                PC_1        PC_2        PC_3       PC_4
#> BGCV03_GCGCCAATCTGGCGTG-1 -4.677964  0.26785278 -2.68663740  1.5347402
#> BGCV03_CGTCACTTCCCAAGAT-1 -2.877392  0.04509136 12.38307762  4.5973921
#> BGCV15_TGAGGGACATCGACGC-1 -3.625502 -0.05260641  1.15989053 -5.6360350
#> BGCV03_GATCAGTAGTTACGGG-1 13.487988 -7.37058783  0.77435076 -0.8953347
#> BGCV03_TGCGGGTCACGGACAA-1 -3.740279  0.27755079  0.07352045 -4.6179056
#> BGCV03_CATGACAGTCCAGTAT-1 -2.349224  2.82407236  0.93374163 -4.7708669
#>                                 PC_5        PC_6        PC_7       PC_8
#> BGCV03_GCGCCAATCTGGCGTG-1  0.2855917 -0.39382035 -0.09173895 -1.4540112
#> BGCV03_CGTCACTTCCCAAGAT-1 -3.2936299 -0.07147141 -1.95012903 -1.1909559
#> BGCV15_TGAGGGACATCGACGC-1 -3.1034510  2.69858479  0.35455966 -0.7677660
#> BGCV03_GATCAGTAGTTACGGG-1 -7.4018416  5.53588390 -3.99845910  2.1559813
#> BGCV03_TGCGGGTCACGGACAA-1 -2.6745775  1.97423577 -0.32567784 -0.3111276
#> BGCV03_CATGACAGTCCAGTAT-1 -0.5981533  0.95109445 -1.91192818  1.6709988
#>                                 PC_9      PC_10
#> BGCV03_GCGCCAATCTGGCGTG-1 -0.6873072  3.0339348
#> BGCV03_CGTCACTTCCCAAGAT-1  0.9220569 -1.0549433
#> BGCV15_TGAGGGACATCGACGC-1  0.2317176 -1.9861494
#> BGCV03_GATCAGTAGTTACGGG-1 -2.9655695  3.9789870
#> BGCV03_TGCGGGTCACGGACAA-1  0.4197560 -0.8079447
#> BGCV03_CATGACAGTCCAGTAT-1 -1.9040219 -2.5736504
head(SingleCellExperiment::colData(example_SCE))
#> DataFrame with 6 rows and 3 columns
#>                           sample_id phenotype cluster_id
#>                            <factor>  <factor>   <factor>
#> BGCV03_GCGCCAATCTGGCGTG-1    CV0176     Covid     CD8
#> BGCV03_CGTCACTTCCCAAGAT-1    CV0176     Covid     B_cell
#> BGCV15_TGAGGGACATCGACGC-1    CV0176     Covid     CD4
#> BGCV03_GATCAGTAGTTACGGG-1    CV0176     Covid     CD14
#> BGCV03_TGCGGGTCACGGACAA-1    CV0176     Covid     CD8
#> BGCV03_CATGACAGTCCAGTAT-1    CV0176     Covid     RBC
```

The following table confirms that each donor provides \(500\) cells, and that both phenotypes are represented.

```
table(SingleCellExperiment::colData(example_SCE)$sample_id, SingleCellExperiment::colData(example_SCE)$phenotype)
#>
#>                  Covid Healthy LPS Non_covid
#>   AP1                0       0   0         0
#>   AP2                0       0   0         0
#>   AP3                0       0   0         0
#>   AP4                0       0   0         0
#>   AP5                0       0   0         0
#>   AP6                0       0   0         0
#>   AP8                0       0   0         0
#>   AP9                0       0   0         0
#>   AP10               0       0   0         0
#>   AP11               0       0   0         0
#>   AP12               0       0   0         0
#>   CV0025           500       0   0         0
#>   CV0037           500       0   0         0
#>   CV0050           500       0   0         0
#>   CV0052             0       0   0         0
#>   CV0058           500       0   0         0
#>   CV0059             0       0   0         0
#>   CV0062             0       0   0         0
#>   CV0068             0       0   0         0
#>   CV0073             0       0   0         0
#>   CV0074             0       0   0         0
#>   CV0084             0       0   0         0
#>   CV0094             0       0   0         0
#>   CV0100           500       0   0         0
#>   CV0104             0       0   0         0
#>   CV0120           500       0   0         0
#>   CV0128           500       0   0         0
#>   CV0134             0       0   0         0
#>   CV0137           500       0   0         0
#>   CV0144           500       0   0         0
#>   CV0155           500       0   0         0
#>   CV0160           500       0   0         0
#>   CV0164             0       0   0         0
#>   CV0171             0       0   0         0
#>   CV0176           500       0   0         0
#>   CV0178             0       0   0         0
#>   CV0180           500       0   0         0
#>   CV0198             0       0   0         0
#>   CV0200             0       0   0         0
#>   CV0201             0       0   0         0
#>   CV0231             0       0   0         0
#>   CV0234           500       0   0         0
#>   CV0257           500       0   0         0
#>   CV0262             0       0   0         0
#>   CV0279           500       0   0         0
#>   CV0284             0       0   0         0
#>   CV0326             0       0   0         0
#>   CV0902             0       0   0         0
#>   CV0904             0       0   0         0
#>   CV0911             0       0   0         0
#>   CV0915             0     500   0         0
#>   CV0917             0     500   0         0
#>   CV0926             0       0   0         0
#>   CV0929             0       0   0         0
#>   CV0934             0       0   0         0
#>   CV0939             0       0   0         0
#>   CV0940             0     500   0         0
#>   CV0944             0     500   0         0
#>   MH8919176          0       0   0         0
#>   MH8919177          0       0   0         0
#>   MH8919178          0       0   0         0
#>   MH8919179          0       0   0         0
#>   MH8919226          0       0   0         0
#>   MH8919227          0       0   0         0
#>   MH8919228          0       0   0         0
#>   MH8919229          0       0   0         0
#>   MH8919230          0       0   0         0
#>   MH8919231          0       0   0         0
#>   MH8919232          0       0   0         0
#>   MH8919233          0       0   0         0
#>   MH8919276          0       0   0         0
#>   MH8919277          0       0   0         0
#>   MH8919278          0       0   0         0
#>   MH8919279          0       0   0         0
#>   MH8919280          0       0   0         0
#>   MH8919281          0       0   0         0
#>   MH8919282          0       0   0         0
#>   MH8919283          0       0   0         0
#>   MH8919326          0       0   0         0
#>   MH8919327          0       0   0         0
#>   MH8919328          0       0   0         0
#>   MH8919329          0       0   0         0
#>   MH8919330          0       0   0         0
#>   MH8919331          0       0   0         0
#>   MH8919332          0       0   0         0
#>   MH8919333          0       0   0         0
#>   MH9143270          0       0   0         0
#>   MH9143271          0       0   0         0
#>   MH9143272          0       0   0         0
#>   MH9143273          0       0   0         0
#>   MH9143274          0       0   0         0
#>   MH9143275          0       0   0         0
#>   MH9143276          0       0   0         0
#>   MH9143277          0       0   0         0
#>   MH9143320          0       0   0         0
#>   MH9143321          0       0   0         0
#>   MH9143322          0       0   0         0
#>   MH9143323          0       0   0         0
#>   MH9143324          0       0   0         0
#>   MH9143325          0       0   0         0
#>   MH9143326          0       0   0         0
#>   MH9143327          0       0   0         0
#>   MH9143370          0       0   0         0
#>   MH9143371          0       0   0         0
#>   MH9143372          0       0   0         0
#>   MH9143373          0       0   0         0
#>   MH9143420          0       0   0         0
#>   MH9143421          0       0   0         0
#>   MH9143422          0       0   0         0
#>   MH9143423          0       0   0         0
#>   MH9143424          0       0   0         0
#>   MH9143425          0       0   0         0
#>   MH9143426          0       0   0         0
#>   MH9143427          0       0   0         0
#>   MH9179821          0       0   0         0
#>   MH9179822          0       0   0         0
#>   MH9179823          0       0   0         0
#>   MH9179824          0       0   0         0
#>   MH9179825          0       0   0         0
#>   MH9179826          0       0   0         0
#>   MH9179827          0       0   0         0
#>   MH9179828          0       0   0         0
#>   newcastle004v2     0       0   0         0
#>   newcastle20        0       0   0         0
#>   newcastle21        0       0   0         0
#>   newcastle21v2      0       0   0         0
#>   newcastle49        0       0   0         0
#>   newcastle59        0       0   0         0
#>   newcastle65        0       0   0         0
#>   newcastle74        0       0   0         0
```

`GloScope` expects that the user provides `GloScope` with a `data.frame` containing each cell’s low-dimensional embedding (with cells in rows), along with a vector which contains the sample from which each cell in the embedding matrix is drawn. The PCA embeddings in the example dataset are provided by the authors of Stephenson et al. ([2021](#ref-stephenson2021single)). In general, users of `GloScope` can input any dimensionality reduction to the method. UMI counts are often provided as `Seurat` or `SingleCellExperiment` objects, and many dimensionality reduction strategies, including PCA and scVI (Lopez et al. ([2018](#ref-lopez2018deep))) can be computed and saved within those data structures. This is recommended, as it will allow the user to keep the counts, embeddings, and the meta data (like the sample from which each cell was isolated) in the same structure and will minimize the change of inadvertently mislabelling the sample of a cell.

The following code, which is only pseudo-code and not evaluated (since we do not provide the `seurat_object`), demonstrates how PCA embeddings and sample labels can be extracted from a `Seurat` object for input into the `gloscope` function.

```
embedding_df <- seurat_object@reductions$pca@cell.embeddings
sample_ids <- seurat_object@meta.data$sample_id
```

## 2.2 Divergence Matrix Calculation

With the cell embeddings and the sample labels in the proper format, the `gloscope` function is simple to setup and run. For simplicity, we will save these as separate objects, though for real datasets, this would not be recommended since it would unnecessarily make copies of the data and increase memory usage:

```
embedding_matrix <- SingleCellExperiment::reducedDim(example_SCE,"PCA")[,1:10]
sample_ids <- SingleCellExperiment::colData(example_SCE)$sample_id
```

Although the example data contains the first 50 principal components, we chose to use only the first 10 for calculations. Large number of latent variables will make the density estimation unstable, so we do not recommend large increases to the number of latent variables.

The base function call is `gloscope(embedding_df, sample_ids)`.

```
# Can take a couple of minutes to run:
gmm_divergence <- gloscope(embedding_matrix, sample_ids)
```

The default implementation, run above, implements the `GMM` option for density estimation; this is the method primarily considered in the manuscript, but can take longer to run so we haven’t evaluated it here. (You can evaluate it by changing `eval=FALSE` to `eval=TRUE`).

An alternative methods uses a non-parametric alternative for density estimation based on a \(k\)-nearest neighbours algorithm and can be chosen with the argument `dens`. We will use this on our examples simply to make the tutorial run quickly:

```
knn_divergence <- gloscope(embedding_matrix, sample_ids, dens="KNN")
knn_divergence[1:5,1:5]
#>          CV0176   CV0257   CV0279   CV0120   CV0917
#> CV0176 0.000000 2.388813 1.893389 2.024262 2.333317
#> CV0257 2.388813 0.000000 1.608448 3.048070 4.432494
#> CV0279 1.893389 1.608448 0.000000 2.414725 1.690126
#> CV0120 2.024262 3.048070 2.414725 0.000000 2.465142
#> CV0917 2.333317 4.432494 1.690126 2.465142 0.000000
```

Note, that unlike PCA, not every dimensionality reduction method retains its statistical properties when only a subset of the coordinates is retained, with scVI being an example. For methods like scVI, you should choose the number of latent variables you will want to use *when calculating the latent variables* and not subset them after the fact.

## 2.3 More on the density method:

If the user chooses the default GMM method (`dens="GMM"`), `gloscope` fits sample-level densities with Gaussian mixture models (GMMs) implemented by `mclust`. The `mclust` package uses the Bayesian information criterion (BIC) to select a GMM from a family of models, and the user of `GloScope` can specify how many centroids should be considered in that family. By default GMMs with \(5,10,15,20\) centroids are compared. Note that the previous default was \(1,\dots,9\) centroids, with this change being implemented in development version 1.7. With the `num_components` optional vector to `gloscope` the user can specify the possible number of centroids for `mclust` to compute, with the one with the best BIC value being the final choice.

The default Gaussian mixture model fit in GloScope is `VVE` of `mclust`. The user can set any optional arguments to control the `mclust::densityMclust` used for estimation through the `GMM_params` optional argument in the `gloscope` function. For example, `GMM_params = list(modelNames=c("VVV","VVE"),plot=TRUE)`, would fit both a `VVV` and `VVE` model for each sample and then return a single model chosen via BIC. The `plot` Boolean would cause `mclust` density plots to be printed during compilation.

When GMMs are used for density fitting, a Monte-Carlo approximation is then used to compute the pairwise divergences from the estimated densities. This means that the resulting estimate is stochastic, and details about controlling the random seed appear later in this vignette. The number of Monte-Carlo draws from the density of each sample is \(10,000\) by default, and this is controlled by the optional parameter \(r\) in the `gloscope` function.

```
# Can take a couple of minutes to run:
gmm_divergence_alt<-gloscope(embedding_matrix, sample_ids, dens = "GMM",  num_components = c(2,4,6),r=20000)
```

A non-parametric alternative for density and divergence estimation is the \(k\)-nearest neighbours algorithm. To use this technique, the optional argument `dens="KNN"` should be set. The number of neighbors is a hyperparameter, equal to \(50\) by default, and governed by the optional argument `k`. It is important to note that negative divergences between similar samples are possible with this density estimation choice. The `gloscope` function does not censor or round any negative values in the output matrix, leaving that decision to the user. Analgous to the optional argument `GMM_params` above, the user may specify an optional list `KNN_params` in the `gloscope` function call. This list will pass through optional arguments for either `FNN::KL.dist` (for KL) or `RANN::nn2` ( for JS).

```
knn_divergence_alt <- gloscope(embedding_matrix, sample_ids,
    dens = "KNN", k = 25)
```

## 2.4 More on the divergence method

The default divergence for `GloScope` is the symmetric KL divergence, but the Jensen-Shannon divergence is also implemented. This can be controlled by setting the argument `dist_metric="KL"` or `dist_metric="JS"`, respectively. One beneficial property of the Jensen-Shannon divergence is that its square root is a proper distance metric. Note that `gloscope` returns a matrix of untransformed divergences, and the user must take the square root of matrix entries themselves if this is desired.

# 3 Visualization

The `plotMDS` function provided by this package visualizes the output divergence matrix with multidimensional scaling. The `plotMDS` function utilizes the `isoMDS` function from the package `MASS`, and then creates a scatter plot with samples color-coded by a user-specified covariate such as phenotype

This function requires a `data.frame` with the relevant metadata at the sample level, rather than at the cell level. This can easily be obtained by applying the `unique` function from base R to the cell-level metadata `data.frame`.

```
pat_info <- as.data.frame(unique(SingleCellExperiment::colData(example_SCE)[,-c(3)]))
head(pat_info)
#>                           sample_id phenotype
#> BGCV03_GCGCCAATCTGGCGTG-1    CV0176     Covid
#> BGCV11_AGGCCGTCATCGATGT-1    CV0257     Covid
#> BGCV09_AGCTTGAGTACTTAGC-1    CV0279     Covid
#> BGCV05_CATGCCTGTGTCGCTG-1    CV0120     Covid
#> BGCV09_ATCATCTAGTGATCGG-1    CV0917   Healthy
#> BGCV08_CCACTACGTTAAGGGC-1    CV0915   Healthy
```

Here we plot the MDS representation with each sample color-coded by the `phenotype` variable. Note the function call returns both a matrix of MDS embeddings and a `ggplot` visualization of the first two dimensions.

```
mds_result <- plotMDS(dist_mat = knn_divergence, metadata = pat_info, "sample_id",color_by="phenotype", k = 2)
mds_result$plot
```

![](data:image/png;base64...)

Another classical way to visualize a divergence matrix is with a heatmap. The following code demonstrates that the output of `gloscope` is easily used in plotting functions beyond the package.

```
heatmap(knn_divergence)
```

![](data:image/png;base64...)

We also provide a simple wrapper to the more powerful `pheatmap` function in the `pheatmap` package that can also plot additional annotation information with the heatmap:

```
plotHeatmap(knn_divergence, metadata = pat_info, "sample_id",color_by="phenotype")
```

![](data:image/png;base64...)

# 4 Testing and Confidence intervals

The `GloScope` package also provides functions to do simple inference on the resulting distance matrices, both permutation tests and bootstrap confidence intervals. There are currently three different test statistics we calculate: `anosim` and `adonis2` implemented in the `vegan` package, and `silhouette` implemented in the `cluster` package. Our functions are only applicable for testing differences between a simple grouping factor and provided for the convenience of the user. The `vegan` package provides greater options for more complex inference for distance matrices.

The function `getMetrics` calculates any combination of these three statistics and optionally performs a permutation test (if `permuteTest=TRUE`). We would note that for permutation tests, `adonis2` is recommended by the authors over `anosim` (see their accompanying help files).

```
permResults <- getMetrics(dist_mat = knn_divergence, metadata = pat_info, sample_id="sample_id", group_vars="phenotype", permuteTest = TRUE)
permResults
#>       metric  grouping statistic       pval
#> 1     anosim phenotype 0.2936508 0.05940594
#> 2    adonis2 phenotype 2.9679896 0.06930693
#> 3 silhouette phenotype 0.1731741 0.01980198
```

We also provide a wrapper function for bootstrap confidence intervals of these statistics with the function `bootCI` which has the same input arguments. We only recommend using `anosim` and `silhouette` since the statistic from `adonis2` is a F statistic, and less interpretable for confidence intervals.

```
bootCIResults <- bootCI(dist_mat = list("KNN k=50"=knn_divergence, "KNN k=25"=knn_divergence_alt), metadata = pat_info, metrics=c("anosim","silhouette"), sample_id="sample_id", group_vars="phenotype")
bootCIResults
#>   distance  grouping     metric statistic      lower     upper
#> 1 KNN k=50 phenotype     anosim 0.2936508 0.04531339 0.7805581
#> 2 KNN k=25 phenotype     anosim 0.3355655 0.08702690 0.7540328
#> 3 KNN k=50 phenotype silhouette 0.1731741 0.03454593 0.4918373
#> 4 KNN k=25 phenotype silhouette 0.1768286 0.04953637 0.4548145
```

`bootCI` allows the user to give a list of multiple distance matrices to make it easy to plot comparative confidence intervals. (This option of looping over multiple distances is not available for `getMetrics`). `plotCI` gives a function that will create a `ggplot` object for plotting the confidence intervals

```
ppg<-plotCI(bootCIResults,color_by="distance",group_by="metric")
ppg
```

![](data:image/png;base64...)

# 5 Parallelization and Random Seeds

To speed-up calculations of the pair-wise divergences, `GloScope` allows for parallelizing the calculation. The argument `BPPARAM` controls the parameters of the parallelization (see `bplapply`).

The default is no parallelization, but the iteration across sample-pairs will still via the function `bplapply`. In this case (i.e. no parallelization), the argument is simply `BPPARAM = BiocParallel::SerialParam()`.

IMPORTANT: Due to the construction of the NAMESPACE file, it is essential that any setting of the BPPARAM optional argument uses the `BiocParallel::` namespace prefix. For example, `gloscope(...,BPPARAM = MulticoreParam()` will raise an error, and `gloscope(...,BPPARAM = BiocParallel::MulticoreParam()` should be used instead.

## 5.1 Random seed

The calculation of the KL divergence from the GMM density estimate uses Monte-Carlo approximation, and hence has to randomly sample from the estimated density. To set the seed for the pseudo-random number generator used in the simulation, the seed needs to be set within the argument to `BPPARAM` and **not** by a call to `set.seed` (see <https://bioconductor.org/packages/release/bioc/vignettes/BiocParallel/inst/doc/Random_Numbers.html> for more information).

This is how the seed must be set, *even if there is no parallelization* chosen (the default), because the iteration over sample pairs is sent through `bplapply` function regardless, as noted above. Setting the seed outside the function via `set.seed` will not have an effect on the function.

The following is an example of how to set the random seed when running the `GMM` option, using the default of no parallelization:

```
gmm_divergence <- gloscope(embedding_matrix, sample_ids, dens = "GMM", dist_metric = "KL",
    BPPARAM = BiocParallel::SerialParam(RNGseed = 2))
```

The same argument (`RNGseed`) can be added to other `BPPARAM` arguments to set the seed.

Note that the `KNN` estimation procedure does not have any Monte-Carlo approximation steps, and thus does not need to have a random seed.

# 6 References

Lopez, Romain, Jeffrey Regier, Michael B Cole, Michael I Jordan, and Nir Yosef. 2018. “Deep Generative Modeling for Single-Cell Transcriptomics.” *Nature Methods* 15 (12): 1053–8.

Stephenson, Emily, Gary Reynolds, Rachel A Botting, Fernando J Calero-Nieto, Michael D Morgan, Zewen Kelvin Tuong, Karsten Bach, et al. 2021. “Single-Cell Multi-Omics Analysis of the Immune Response in Covid-19.” *Nature Medicine* 27 (5): 904–16.

# Appendix

# SessionInfo

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] GloScope_2.0.1   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
#>  [3] xfun_0.54                   bslib_0.9.0
#>  [5] ggplot2_4.0.1               Biobase_2.70.0
#>  [7] lattice_0.22-7              vctrs_0.6.5
#>  [9] tools_4.5.2                 generics_0.1.4
#> [11] stats4_4.5.2                parallel_4.5.2
#> [13] tibble_3.3.0                cluster_2.1.8.1
#> [15] pkgconfig_2.0.3             pheatmap_1.0.13
#> [17] Matrix_1.7-4                RColorBrewer_1.1-3
#> [19] S7_0.2.1                    S4Vectors_0.48.0
#> [21] lifecycle_1.0.4             compiler_4.5.2
#> [23] farver_2.1.2                FNN_1.1.4.1
#> [25] tinytex_0.58                Seqinfo_1.0.0
#> [27] codetools_0.2-20            permute_0.9-8
#> [29] htmltools_0.5.8.1           sass_0.4.10
#> [31] yaml_2.3.10                 pillar_1.11.1
#> [33] jquerylib_0.1.4             MASS_7.3-65
#> [35] BiocParallel_1.44.0         SingleCellExperiment_1.32.0
#> [37] DelayedArray_0.36.0         cachem_1.1.0
#> [39] vegan_2.7-2                 magick_2.9.0
#> [41] boot_1.3-32                 abind_1.4-8
#> [43] mclust_6.1.2                nlme_3.1-168
#> [45] tidyselect_1.2.1            digest_0.6.39
#> [47] dplyr_1.1.4                 bookdown_0.45
#> [49] labeling_0.4.3              splines_4.5.2
#> [51] fastmap_1.2.0               grid_4.5.2
#> [53] cli_3.6.5                   SparseArray_1.10.2
#> [55] magrittr_2.0.4              S4Arrays_1.10.0
#> [57] dichromat_2.0-0.1           withr_3.0.2
#> [59] scales_1.4.0                rmarkdown_2.30
#> [61] XVector_0.50.0              matrixStats_1.5.0
#> [63] RANN_2.6.2                  mvnfast_0.2.8
#> [65] evaluate_1.0.5              knitr_1.50
#> [67] GenomicRanges_1.62.0        IRanges_2.44.0
#> [69] mgcv_1.9-4                  rlang_1.1.6
#> [71] Rcpp_1.1.0                  glue_1.8.0
#> [73] BiocManager_1.30.27         BiocGenerics_0.56.0
#> [75] jsonlite_2.0.0              R6_2.6.1
#> [77] MatrixGenerics_1.22.0
```