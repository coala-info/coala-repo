# Splat simulation parameters

Luke Zappia

#### Last updated: 19 October 2020

#### Package

splatter 1.34.0

This vignette describes the Splat simulation model and the parameters it uses
in more detail.

```
library("splatter")
library("scater")
library("ggplot2")
```

# 1 The base Splat model

This figure, taken from the Splatter publication, describes the core of the
Splat simulation model.

![](data:image/png;base64...)

Splat simulation model

The Splat simulation uses a hierarchical probabilistic where different aspects
of a dataset are generated from appropriate statistical distributions. The
first stage generates a mean expression level for each gene. These are
originally chosen from a Gamma distribution. For some genes that are selected
to be outliers with high expression a factor is generated from a log-normal
distribution. These factors are then multiplied by the median gene mean to
create new means for those genes.

The next stage incorporates variation in the counts per cell. An expected
library size (total counts) is chosen for each cell from a log-normal
distribution. The library sizes are then used to scale the gene means for each
cell, resulting in a range a counts per cell in the simulated dataset. The gene
means are then further adjusted to enforce a relationship between the mean
expression level and the variability.

The final cell by gene matrix of gene means is then used to generate a count
matrix using a Poisson distribution. The result is a synthetic dataset
consisting of counts from a Gamma-Poisson (or negative-binomial) distribution.
An additional optional step can be used to replicate a “dropout” effect. A
probability of dropout is generated using a logistic function based on the
underlying mean expression level. A Bernoulli distribution is then used to
create a dropout matrix which sets some of the generated counts to zero.

The model described here will generate a single population of cells but the
Splat simulation has been designed to be as flexible as possible and can
create scenarios including multiple groups of cells (cell types), continuous
paths between cell types and multiple experimental batches. The parameters used
to create these types of simulations and how they interact with the model are
described below.

# 2 Splat simulation parameters

Within Splatter the parameters for the Splat simulation model are held in the
`SplatParams` object. Let’s create one of these objects and see what it looks
like.

```
params <- newSplatParams()
params
#> A Params object of class SplatParams
#> Parameters can be (estimable) or [not estimable], 'Default' or  'NOT DEFAULT'
#> Secondary parameters are usually set during simulation
#>
#> Global:
#> (Genes)  (Cells)   [SEED]
#>   10000      100   568524
#>
#> 29 additional parameters
#>
#> Batches:
#>     [Batches]  [Batch Cells]     [Location]        [Scale]       [Remove]
#>             1            100            0.1            0.1          FALSE
#>
#> Mean:
#>  (Rate)  (Shape)
#>     0.3      0.6
#>
#> Library size:
#> (Location)     (Scale)      (Norm)
#>         11         0.2       FALSE
#>
#> Exprs outliers:
#> (Probability)     (Location)        (Scale)
#>          0.05              4            0.5
#>
#> Groups:
#>      [Groups]  [Group Probs]
#>             1              1
#>
#> Diff expr:
#> [Probability]    [Down Prob]     [Location]        [Scale]
#>           0.1            0.5            0.1            0.4
#>
#> BCV:
#> (Common Disp)          (DoF)
#>           0.1             60
#>
#> Dropout:
#>     [Type]  (Midpoint)     (Shape)
#>       none           0          -1
#>
#> Paths:
#>         [From]         [Steps]          [Skew]    [Non-linear]  [Sigma Factor]
#>              0             100             0.5             0.1             0.8
```

Like all the parameter objects in Splatter printing this object displays all the
parameters required for this simulation. As we haven’t set any of the parameters
the default values are shown but if we were to change any of them they would be
highlighted. We can also see which parameters can be estimated by the Splat
estimation procedure and which can’t. The default values have been chosen to be
fairly realistic but it is recommended that estimation is used to get a
simulation that is more like the data you are interested in. Parameters can be
modified by setting them in the `SplatParams` object or by providing them
directly to the simulation function.

The rest of this section provides details of all this parameters and explains
how they can be used with examples.

## 2.1 Global parameters

These parameters are used in every simulation model and control global features
of the dataset produced.

### 2.1.1 `nGenes` - Number of genes

The number of genes to simulate.

```
# Set the number of genes to 1000
params <- setParam(params, "nGenes", 1000)

sim <- splatSimulate(params, verbose = FALSE)
dim(sim)
#> [1] 1000  100
```

### 2.1.2 `nCells` - Number of cells

The number of genes to simulate. In the Splat simulation this cannot be set
directly but must be controlled using the `batchCells` parameter.

### 2.1.3 `seed` - Random seed

Seed to use for generating random numbers including selecting values from
distributions. By changing this value multiple simulated datasets with the same
parameters can be produced. Simulations produced using the same set of
parameters and random seed should be identical but there may be differences
between operating systems, software versions etc.

## 2.2 Batch parameters

These parameters control experimental batches in the simulated dataset. The
overall effect of how batch effects are included in the model is similar to
technical replicates (i.e. the same biological sample sequenced multiple times).
This means that the underlying structure is consistent between batches but a
global technical signature is added may separate them.

### 2.2.1 `nBatches` - Number of batches

The number of batches in the simulation. This cannot be set directly but is
controlled by setting `batchCells`.

### 2.2.2 `batchCells` - Cells per batch

A vector specifying the number of cells in each batch. The number of batches
(`nBatches`) is equal to the length of the vector and the number of cells
(`nCells`) is equal to the sum.

```
# Simulation with two batches of 100 cells
sim <- splatSimulate(params, batchCells = c(100, 100), verbose = FALSE)

# PCA plot using scater
sim <- logNormCounts(sim)
sim <- runPCA(sim)
plotPCA(sim, colour_by = "Batch")
```

![](data:image/png;base64...)

### 2.2.3 `batch.facLoc` - Batch factor location and `batch.facScale` - Batch factor scale

Batches are specified by generating a small scaling factor for each gene in
each batch from a log-normal distribution. These factors are then applied to the
underlying gene means in each batch. Modifying these parameters affects how
different the batches are from each other by generating bigger or smaller
factors.

```
# Simulation with small batch effects
sim1 <- splatSimulate(
    params,
    batchCells = c(100, 100),
    batch.facLoc = 0.001,
    batch.facScale = 0.001,
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Batch") + ggtitle("Small batch effects")
```

![](data:image/png;base64...)

```
# Simulation with big batch effects
sim2 <- splatSimulate(
    params,
    batchCells = c(100, 100),
    batch.facLoc = 0.5,
    batch.facScale = 0.5,
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Batch") + ggtitle("Big batch effects")
```

![](data:image/png;base64...)

### 2.2.4 `batch.rmEffect` - Remove batch effect

Setting `batch.rmEffect` to `TRUE` produces a dataset that is (approximately)
identical to when `batch.rmEffect` is `FALSE` but with the batch effect removed.
This can be used as the ground truth for evaluating batch correction.

```
sim1 <- splatSimulate(
    params,
    batchCells = c(100, 100),
    batch.rmEffect = FALSE,
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Batch") + ggtitle("With batch effects")
```

![](data:image/png;base64...)

```
sim2 <- splatSimulate(
    params,
    batchCells = c(100, 100),
    batch.rmEffect = TRUE,
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Batch") + ggtitle("Batch effects removed")
```

![](data:image/png;base64...)

## 2.3 Mean parameters

These parameters control the distribution that is used to generate the
underlying original gene means.

### 2.3.1 `mean.shape` - Mean shape and `mean.rate` - Mean rate

These parameters control the Gamma distribution that gene means are drawn from.
The relationship between shape and rate can be complex and it is often better
to use values estimated from a real dataset than to try and manually set them.
Although these parameters control the base gene means the means in the final
simulation will depend upon other parts of the model, particularly the simulated
total counts per cell (library sizes).

## 2.4 Library size parameters

These parameters control the expected number of counts for each cell. Note that
because of sampling the actual counts per cell in the final simulation may be
different. Turning on the dropout effect will also effect this. We use the term
“library size” here for consistency but expected total counts would be more
appropriate.

### 2.4.1 `lib.loc` - Library size location and `lib.scale` - Library size scale

These parameters control the shape of the distribution that is used to generate
library sizes for each cell. Increasing `lib.loc` will lead to more counts per
cell and increasing `lib.scale` will result in more variability in the counts
per cell.

### 2.4.2 `lib.norm` - Library size distribution

The default (and recommended) distribution used for library sizes in the Splat
simulation is a log-normal. However, in rare cases a normal distribution might
be more appropriate. Setting `lib.norm` to `TRUE` will use a normal distribution
instead of a log-normal.

## 2.5 Expression outlier parameters

When developing the Splat simulation we found that while the Gamma distribution
was generally a good match for gene means for some datasets it did not properly
capture highly expressed genes. For this reason we added expression outliers to
the Splat model.

### 2.5.1 `out.prob` - Expression outlier probability

This parameter controls the probability that genes will be selected to be
expression outliers. Higher values will results in more outlier genes.

```
# Few outliers
sim1 <- splatSimulate(out.prob = 0.001, verbose = FALSE)
ggplot(
    as.data.frame(rowData(sim1)),
    aes(x = log10(GeneMean), fill = OutlierFactor != 1)
) +
    geom_histogram(bins = 100) +
    ggtitle("Few outliers")
```

![](data:image/png;base64...)

```
# Lots of outliers
sim2 <- splatSimulate(out.prob = 0.2, verbose = FALSE)
ggplot(
    as.data.frame(rowData(sim2)),
    aes(x = log10(GeneMean), fill = OutlierFactor != 1)
) +
    geom_histogram(bins = 100) +
    ggtitle("Lots of outliers")
```

![](data:image/png;base64...)

### 2.5.2 `out.facLoc` - Expression outlier factor location and `out.facScale` - Expression outlier factor scale

The expression outlier factors are drawn from a log-normal distribution
controlled by these parameters. The generated factors are applied to the median
mean expression rather than the existing mean for the selected genes. This is
to be consistent with the estimation procedure for these factors and to make
sure that the final means are outliers. For example to avoid the situation where
a factor is applied to a lowly expressed gene, making it just moderately
expressed rather than an expression outlier.

### 2.5.3 Group parameters

Up until this stage of the simulation only a single population of cells is
considered but we often want to simulate datasets with multiple kinds of cells.
We do this by assigning cells to groups.

### 2.5.4 `nGroups` - Number of groups

The number of groups to simulate. This parameter cannot be set directly and is
controlled using `group.prob`.

### 2.5.5 `group.prob` - Group probabilities

A vector giving the probability that cells will be assigned to groups. The
length of the vector gives the number of groups (`nGroups`) and the
probabilities must sum to 1. Adjusting the number and relative values of the
probabilities changes the number and relative sizes of the groups. To simulate
groups we also need to use the `splatSimulateGroups` function or set
`method = "groups"`.

```
params.groups <- newSplatParams(batchCells = 500, nGenes = 1000)

# One small group, one big group
sim1 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.9, 0.1),
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Group") + ggtitle("One small group, one big group")
```

![](data:image/png;base64...)

```
# Five groups
sim2 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.2, 0.2, 0.2, 0.2, 0.2),
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Group") + ggtitle("Five groups")
```

![](data:image/png;base64...)

**Note:** Once there are more than three or four groups it becomes difficult to
properly view them in PCA space. We use PCA here for simplicity but generally a
non-linear dimensionality reduction such as t-SNE or UMAP is a more useful way
to visualise the groups.

### 2.5.6 Differential expression parameters

Different groups are created by modifying the base expression levels of selected
genes. The process for doing this is to simulate differential expression (DE)
between each group and a fictional base cell. Altering the differential
expression parameters controls how similar groups are to each other.

### 2.5.7 `de.prob` - DE probability

This parameter controls the probability that a gene will be selected to be
differentially expressed.

```
# Few DE genes
sim1 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.5, 0.5),
    de.prob = 0.01,
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Group") + ggtitle("Few DE genes")
```

![](data:image/png;base64...)

```
# Lots of DE genes
sim2 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.5, 0.5),
    de.prob = 0.3,
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Group") + ggtitle("Lots of DE genes")
```

![](data:image/png;base64...)

### 2.5.8 `de.downProb` - Down-regulation probability

A selected DE gene can be either down-regulated (has a factor less than one) or
up-regulated (has a factor greater than one). This parameter controls the
probability that a selected gene will be down-regulated.

### 2.5.9 `de.facLoc` - DE factor location and `de.facScale` - DE factor scale

Differential expression factors are produced from a log-normal distribution in
a similar way to batch effect factors and expression outlier factors. Changing
these parameters can result in more or less extreme differences between groups.

```
# Small DE factors
sim1 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.5, 0.5),
    de.facLoc = 0.01,
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Group") + ggtitle("Small DE factors")
```

![](data:image/png;base64...)

```
# Big DE factors
sim2 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.5, 0.5),
    de.facLoc = 0.3,
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Group") + ggtitle("Big DE factors")
```

![](data:image/png;base64...)

Just looking at the PCA plots this effect seems similar to adjusting `de.prob`
but the effect is achieved in a different way. A higher `de.prob` means that
more genes are differentially expressed but changing the DE factors changes the
level of DE for the same number of genes.

### 2.5.10 Complex differential expression

Each of the differential expression parameters can be specified for each group
by providing a vector of values. These vectors must be the same length as
`group.prob`. Specifying parameters as vectors allows more complex simulations
where groups are more or less different to each other rather than being equally
distinct. Here are some examples of different DE scenarios.

```
# Different DE probs
sim1 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.2, 0.2, 0.2, 0.2, 0.2),
    de.prob = c(0.01, 0.01, 0.1, 0.1, 0.3),
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Group") +
    labs(
        title = "Different DE probabilities",
        caption = paste(
            "Groups 1 and 2 have very few DE genes,",
            "Groups 3 and 4 have the default number,",
            "Group 5 has many DE genes"
        )
    )
```

![](data:image/png;base64...)

```
# Different DE factors
sim2 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.2, 0.2, 0.2, 0.2, 0.2),
    de.facLoc = c(0.01, 0.01, 0.1, 0.1, 0.2),
    de.facScale = c(0.2, 0.5, 0.2, 0.5, 0.4),
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Group") +
    labs(
        title = "Different DE factors",
        caption = paste(
            "Group 1 has factors with small location (value),",
            "and scale (variability),",
            "Group 2 has small location and greater scale.\n",
            "Groups 3 and 4 have greater location with small,",
            "and large scales",
            "Group 5 has bigger factors with moderate",
            "variability"
        )
    )
```

![](data:image/png;base64...)

```
# Combination of everything
sim3 <- splatSimulateGroups(
    params.groups,
    group.prob = c(0.05, 0.2, 0.2, 0.2, 0.35),
    de.prob = c(0.3, 0.1, 0.2, 0.01, 0.1),
    de.downProb = c(0.1, 0.4, 0.9, 0.6, 0.5),
    de.facLoc = c(0.6, 0.1, 0.1, 0.01, 0.2),
    de.facScale = c(0.1, 0.4, 0.2, 0.5, 0.4),
    verbose = FALSE
)
sim3 <- logNormCounts(sim3)
sim3 <- runPCA(sim3)
plotPCA(sim3, colour_by = "Group") +
    labs(
        title = "Different DE factors",
        caption = paste(
            "Group 1 is small with many very up-regulated DE genes,",
            "Group 2 has the default DE parameters,\n",
            "Group 3 has many down-regulated DE genes,",
            "Group 4 has very few DE genes,",
            "Group 5 is large with moderate DE factors"
        )
    )
```

![](data:image/png;base64...)

## 2.6 Biological Coefficient of Variation (BCV) parameters

The BCV parameters control the variability of the genes in the simulated
dataset.

### 2.6.1 `bcv.common` - Common BCV

The `bcv.common` parameter controls the underlying common variability across
all genes in the dataset.

### 2.6.2 `bcv.df` - BCV Degrees of Freedom

This parameter sets the degrees of freedom used in the BCV inverse chi-squared
distribution. Changing this changes the effect of mean expression on the
variability of a gene.

## 2.7 Dropout parameters

These parameters control whether additional dropout is added to increase the
number of zeros in the simulated dataset and if it is how that is applied.

### 2.7.1 `dropout.type` - Dropout type

This parameter determines the kind of dropout effect to simulate. Setting it to
`"none"` means no dropout, “`experiment`” is global dropout using the same set
of parameters for every cell, `"batch"` uses the same parameters for every cell
in the same batch, `"group"` uses the same parameters for every cell in the
same group and `"cell"` uses a different set of parameters for every cell.

### 2.7.2 `dropout.mid` - Dropout mid point and `dropout.shape` - Dropout shape

The probability that a particular count in a particular cell is set to zero is
related to the mean expression of that gene in that cell. This relationship is
represented using a logistic function with these parameters. The `dropout.mid`
parameter control the point at which the probability is equal to 0.5 and the
`dropout.shape` controls how it changes with increasing expression. These
parameters must be vectors of the appropriate length depending on the selected
dropout type.

## 2.8 Path parameters

For many uses simulating groups is sufficient but in some cases it is more
appropriate to simulate continuous changes between cell types. The number of
paths and the probability of assigning cells to them is still controlled by the
`group.prob` parameter and the amount of change along a path is controlled by
the DE parameters but other aspects of the `splatSimulatePaths` model are
controlled by these parameters.

### 2.8.1 `path.from` - Path origin

This parameter controls the order of differentiation paths. It is a vector the
same length as `group.prob` giving the starting position of each path. For
example a `path.from` of `c(0, 1, 1, 3)` would indicate the Path 1 starts at
the origin (0), Path 2 starts at the end of Path 1, Path 3 also starts at the
end of Path 1 (a branch point) and Path 4 starts at the end of Path 3.

```
# Linear paths
sim1 <- splatSimulatePaths(
    params.groups,
    group.prob = c(0.25, 0.25, 0.25, 0.25),
    de.prob = 0.5,
    de.facLoc = 0.2,
    path.from = c(0, 1, 2, 3),
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Group") + ggtitle("Linear paths")
```

![](data:image/png;base64...)

```
# Branching path
sim2 <- splatSimulatePaths(
    params.groups,
    group.prob = c(0.25, 0.25, 0.25, 0.25),
    de.prob = 0.5,
    de.facLoc = 0.2,
    path.from = c(0, 1, 1, 3),
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Group") + ggtitle("Branching path")
```

![](data:image/png;base64...)

### 2.8.2 `path.nSteps` - Number of steps

A path is created by using the same differential expression procedure as used
for groups to generate an end point. Interpolation is then used to create a
series of steps between the start and end points. This parameter controls the
number of steps along a path and therefore how discrete or smooth it is.

```
# Few steps
sim1 <- splatSimulatePaths(
    params.groups,
    path.nSteps = 3,
    de.prob = 0.5,
    de.facLoc = 0.2,
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Step") + ggtitle("Few steps")
```

![](data:image/png;base64...)

```
# Lots of steps
sim2 <- splatSimulatePaths(
    params.groups,
    path.nSteps = 1000,
    de.prob = 0.5,
    de.facLoc = 0.2,
    verbose = FALSE
)
sim2 <- logNormCounts(sim2)
sim2 <- runPCA(sim2)
plotPCA(sim2, colour_by = "Step") + ggtitle("Lots of steps")
```

![](data:image/png;base64...)

### 2.8.3 `path.skew` - Path skew

By default cells are evenly distributed along a path but it sometimes be useful
to introduce a skew in the distribution, For example you may want to simulate
a scenario with few stem-like cells and many differentiated cells. Setting
`path.skew` to 0 will mean that all cells come from the end point while
higher values up to 1 will skew them towards the start point.

```
# Skew towards the end
sim1 <- splatSimulatePaths(
    params.groups,
    path.skew = 0.1,
    de.prob = 0.5,
    de.facLoc = 0.2,
    verbose = FALSE
)
sim1 <- logNormCounts(sim1)
sim1 <- runPCA(sim1)
plotPCA(sim1, colour_by = "Step") + ggtitle("Skewed towards the end")
```

![](data:image/png;base64...)

### 2.8.4 `path.nonlinearProb` - Non-linear probability

Most genes are interpolated in a linear way along a path but in reality this
may not always be the case. For example it is easy to imagine a gene that
is lowly-expressed at the start of a process, highly-expressed in the middle
and lowly-expressed again at the end. The `path.nonlinearProb` parameter
controls the probability that a gene will change in a non-linear way along a
path.

### 2.8.5 `path.sigmaFac` - Path skew

Non-linear changes along a path are achieved by building a Brownian bridge
between the two end points. A Brownian bridge is Brownian motion controlled in
such a way that the end points are fixed. The `path.sigmaFac` parameter controls
how extreme each step in the Brownian motion is and therefore how much the
interpolation differs from a linear path.

# Session information

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] VariantAnnotation_1.56.0    Rsamtools_2.26.0
#>  [3] Biostrings_2.78.0           XVector_0.50.0
#>  [5] scater_1.38.0               ggplot2_4.0.0
#>  [7] scuttle_1.20.0              splatter_1.34.0
#>  [9] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
#> [11] Biobase_2.70.0              GenomicRanges_1.62.0
#> [13] Seqinfo_1.0.0               IRanges_2.44.0
#> [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
#> [17] generics_0.1.4              MatrixGenerics_1.22.0
#> [19] matrixStats_1.5.0           BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                bitops_1.0-9             gridExtra_2.3
#>   [4] rlang_1.1.6              magrittr_2.0.4           compiler_4.5.1
#>   [7] RSQLite_2.4.3            GenomicFeatures_1.62.0   png_0.1-8
#>  [10] vctrs_0.6.5              pkgconfig_2.0.3          crayon_1.5.3
#>  [13] fastmap_1.2.0            magick_2.9.0             backports_1.5.0
#>  [16] labeling_0.4.3           rmarkdown_2.30           UCSC.utils_1.6.0
#>  [19] preprocessCore_1.72.0    ggbeeswarm_0.7.2         tinytex_0.57
#>  [22] bit_4.6.0                xfun_0.53                cachem_1.1.0
#>  [25] beachmat_2.26.0          cigarillo_1.0.0          GenomeInfoDb_1.46.0
#>  [28] jsonlite_2.0.0           blob_1.2.4               DelayedArray_0.36.0
#>  [31] BiocParallel_1.44.0      irlba_2.3.5.1            parallel_4.5.1
#>  [34] R6_2.6.1                 bslib_0.9.0              RColorBrewer_1.1-3
#>  [37] limma_3.66.0             rtracklayer_1.70.0       jquerylib_0.1.4
#>  [40] Rcpp_1.1.0               bookdown_0.45            knitr_1.50
#>  [43] splines_4.5.1            Matrix_1.7-4             tidyselect_1.2.1
#>  [46] dichromat_2.0-0.1        abind_1.4-8              yaml_2.3.10
#>  [49] viridis_0.6.5            codetools_0.2-20         curl_7.0.0
#>  [52] lattice_0.22-7           tibble_3.3.0             withr_3.0.2
#>  [55] KEGGREST_1.50.0          S7_0.2.0                 evaluate_1.0.5
#>  [58] survival_3.8-3           fitdistrplus_1.2-4       pillar_1.11.1
#>  [61] BiocManager_1.30.26      checkmate_2.3.3          RCurl_1.98-1.17
#>  [64] scales_1.4.0             glue_1.8.0               tools_4.5.1
#>  [67] BiocIO_1.20.0            BiocNeighbors_2.4.0      ScaledMatrix_1.18.0
#>  [70] BSgenome_1.78.0          GenomicAlignments_1.46.0 locfit_1.5-9.12
#>  [73] XML_3.99-0.19            cowplot_1.2.0            grid_4.5.1
#>  [76] edgeR_4.8.0              AnnotationDbi_1.72.0     beeswarm_0.4.0
#>  [79] BiocSingular_1.26.0      restfulr_0.0.16          vipor_0.4.7
#>  [82] cli_3.6.5                rsvd_1.0.5               S4Arrays_1.10.0
#>  [85] viridisLite_0.4.2        dplyr_1.1.4              gtable_0.3.6
#>  [88] sass_0.4.10              digest_0.6.37            SparseArray_1.10.0
#>  [91] ggrepel_0.9.6            rjson_0.2.23             farver_2.1.2
#>  [94] memoise_2.0.1            htmltools_0.5.8.1        lifecycle_1.0.4
#>  [97] httr_1.4.7               statmod_1.5.1            MASS_7.3-65
#> [100] bit64_4.6.0-1
```