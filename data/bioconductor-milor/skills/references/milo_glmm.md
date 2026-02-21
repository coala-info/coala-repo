# Mixed effect models for Milo DA testing

Mike Morgan

#### 14/03/2023

#### Package

miloR 2.6.0

```
library(miloR)
library(SingleCellExperiment)
library(scater)
library(scran)
library(dplyr)
library(patchwork)
library(scRNAseq)
library(scuttle)
library(irlba)
library(BiocParallel)
library(ggplot2)
library(sparseMatrixStats)
```

# 1 Introduction

Our first implementation of Milo used a negative binomial GLM to perform hypothesis testing and identify differentially abundant neighbourhoods. GLMs are incredibly powerful,
but they have certain limitations. Notably, they assume that the dependent variable (nhood counts) are (conditionally) independently and identically distributed - that means
there can’t be any relationship between the individual counts e.g. they can’t be derived from the same individual. This creates a dependency between count observations in the
same nhood and can lead to inflated type I error rates. This is especially problematic when considering genetic analyses and organisms of the same species share a genetic
ancestry, which in humans only goes back ~100,000 years. In the simplest example, imagine we performed single-cell experiments on individuals from multiple families, and from
each family we included siblings and parents. Within a family the individuals would share on average 50% of their DNA, so the observations for DA testing wouldn’t be independent.
For more distantly related individuals the relationships are smaller, but can be non-trivial, particularly as sample sizes increase. It’s not just genetics that leads to
dependencies, multiple measurements from the same individual, e.g. multiple time points or from different organs, can also introduce dependency between observations.

We have opted to use GLMM to address this problem as they are very powerful and can explicitly account for fairly arbitrary dependencies, as long as they can be encoded either
as a multi-level factor variable (sometimes referred to as clusters in the mixed effect model literature) or by an nXn matrix.

For the purpose of demonstrating how to use Milo in GLMM mode I’ll use a data set `KotliarovPBMC` from the `scRNAseq` package. These data are derived from SLE patients with
variable treatment responses. This should allow us to model the batching as a random effect variable while testing for differential abundance between the high and low drug
responders.

# 2 Load data

We will use the `KotliarovPBMCData` data set as there are multiple groups that we can compare.

```
# uncomment the row below to allow multi-processing and comment out the SerialParam line.
# bpparam <- MulticoreParam(workers=4)
bpparam <- SerialParam()
register(bpparam)

pbmc.sce <- KotliarovPBMCData(mode="rna", ensembl=TRUE) # download the PBMC data from Kotliarov _et al._
```

```
## see ?scRNAseq and browseVignettes('scRNAseq') for documentation
```

```
## loading from cache
## loading from cache
```

```
## require("ensembldb")
```

```
## Warning: Unable to map 11979 of 32738 requested IDs.
```

```
## see ?scRNAseq and browseVignettes('scRNAseq') for documentation
```

```
## loading from cache
```

```
# downsample cells to reduce compute time
prop.cells <- 0.75
n.cells <- floor(ncol(pbmc.sce) * prop.cells)
set.seed(42)
keep.cells <- sample(colnames(pbmc.sce), size=n.cells)
pbmc.sce <- pbmc.sce[, colnames(pbmc.sce) %in% keep.cells]

# downsample the number of samples
colData(pbmc.sce)$ObsID <- paste(colData(pbmc.sce)$tenx_lane, colData(pbmc.sce)$sampleid, sep="_")
n.samps <- 80
keep.samps <- sample(unique(colData(pbmc.sce)$ObsID), size=n.samps)
keep.cells <- rownames(colData(pbmc.sce))[colData(pbmc.sce)$ObsID %in% keep.samps]
pbmc.sce <- pbmc.sce[, colnames(pbmc.sce) %in% keep.cells]

pbmc.sce
```

```
## class: SingleCellExperiment
## dim: 20759 28105
## metadata(0):
## assays(1): counts
## rownames(20759): ENSG00000284557 ENSG00000237613 ... ENSG00000274412
##   ENSG00000283767
## rowData names(1): originalName
## colnames(28105): AAACCTGAGAGCCCAA_H1B1ln1 AAACCTGCAGTATCTG_H1B1ln1 ...
##   TTTGTCATCGGTTCGG_H1B2ln6 TTTGTCATCTACCTGC_H1B2ln6
## colData names(25): nGene nUMI ... timepoint ObsID
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

# 3 Data processing and normalisation

```
set.seed(42)
# remove sparser cells
drop.cells <- colSums(counts(pbmc.sce)) < 1000
pbmc.sce <- computePooledFactors(pbmc.sce[, !drop.cells], BPPARAM=bpparam)
pbmc.sce <- logNormCounts(pbmc.sce)

pbmc.hvg <- modelGeneVar(pbmc.sce)
pbmc.hvg$FDR[is.na(pbmc.hvg$FDR)] <- 1

pbmc.sce <- runPCA(pbmc.sce, subset_row=rownames(pbmc.sce)[pbmc.hvg$FDR < 0.1], scale=TRUE, ncomponents=50, assay.type="logcounts", name="PCA", BPPARAM=bpparam)
pbmc.sce
```

```
## class: SingleCellExperiment
## dim: 20759 24712
## metadata(0):
## assays(2): counts logcounts
## rownames(20759): ENSG00000284557 ENSG00000237613 ... ENSG00000274412
##   ENSG00000283767
## rowData names(1): originalName
## colnames(24712): AAACCTGAGAGCCCAA_H1B1ln1 AAACCTGCAGTATCTG_H1B1ln1 ...
##   TTTGTCATCGAGAACG_H1B2ln6 TTTGTCATCTACCTGC_H1B2ln6
## colData names(26): nGene nUMI ... ObsID sizeFactor
## reducedDimNames(1): PCA
## mainExpName: NULL
## altExpNames(0):
```

# 4 Define cell neighbourhoods

```
set.seed(42)
pbmc.sce <- runUMAP(pbmc.sce, n_neighbors=30, pca=50, BPPARAM=bpparam) # add a UMAP for plotting results later

pbmc.milo <- Milo(pbmc.sce) # from the SCE object
reducedDim(pbmc.milo, "UMAP") <- reducedDim(pbmc.sce, "UMAP")

plotUMAP(pbmc.milo, colour_by="adjmfc.time") + plotUMAP(pbmc.milo, colour_by="sampleid")
```

![](data:image/png;base64...)

These UMAPs shows how the different constituent cell types of PBMCs distributed across the drug response categories (left) and samples (right). Next we build the KNN graph and
define neighbourhoods to quantify cell abundance across our experimental samples.

```
set.seed(42)
# we build KNN graph
pbmc.milo <- buildGraph(pbmc.milo, k = 60, d = 30)
```

```
## Constructing kNN graph with k:60
```

```
pbmc.milo <- makeNhoods(pbmc.milo, prop = 0.05, k = 60, d=30, refined = TRUE, refinement_scheme="graph") # make nhoods using graph-only as this is faster
```

```
## Checking valid object
```

```
## Running refined sampling with graph
```

```
colData(pbmc.milo)$ObsID <- paste(colData(pbmc.milo)$tenx_lane, colData(pbmc.milo)$sampleid, sep="_")
pbmc.milo <- countCells(pbmc.milo, meta.data = data.frame(colData(pbmc.milo)), samples="ObsID") # make the nhood X sample counts matrix
```

```
## Checking meta.data validity
```

```
## Counting cells in neighbourhoods
```

```
pbmc.milo
```

```
## class: Milo
## dim: 20759 24712
## metadata(0):
## assays(2): counts logcounts
## rownames(20759): ENSG00000284557 ENSG00000237613 ... ENSG00000274412
##   ENSG00000283767
## rowData names(1): originalName
## colnames(24712): AAACCTGAGAGCCCAA_H1B1ln1 AAACCTGCAGTATCTG_H1B1ln1 ...
##   TTTGTCATCGAGAACG_H1B2ln6 TTTGTCATCTACCTGC_H1B2ln6
## colData names(26): nGene nUMI ... ObsID sizeFactor
## reducedDimNames(2): PCA UMAP
## mainExpName: NULL
## altExpNames(0):
## nhoods dimensions(2): 24712 1094
## nhoodCounts dimensions(2): 1094 80
## nhoodDistances dimension(1): 0
## graph names(1): graph
## nhoodIndex names(1): 1094
## nhoodExpression dimension(2): 1 1
## nhoodReducedDim names(0):
## nhoodGraph names(0):
## nhoodAdjacency dimension(2): 1 1
```

Do we have a good distribution of nhood sizes?

```
plotNhoodSizeHist(pbmc.milo)
```

![](data:image/png;base64...)

The smallest nhood is 60 (we used k=60) - that should be sufficient for the number of samples (N~120)

# 5 Demonstrating the GLMM syntax

Now we have the pieces in place for DA testing to demonstrate how to use the GLMM. We should first consider what our random effect variable is. There is a fair bit of debate on
what constitutes a random effect vs. a fixed effect. As a rule of thumb, we can ask if the groups are randomly selected from a larger population of possible groups. For instance,
if we recruited patients from 5 hospitals, could we consider the hospital as a random effect if there are actually 500 hospitals that we could have chosen? For these PBMC data
we don’t have a variable in the experiment that fits this decision *per se*, so the `tenx_lane` will be arbitrarily selected (assuming cells were randomly assigned to batches).

```
pbmc.design <- data.frame(colData(pbmc.milo))[,c("tenx_lane", "adjmfc.time", "sample", "sampleid", "timepoint", "ObsID")]
pbmc.design <- distinct(pbmc.design)
rownames(pbmc.design) <- pbmc.design$ObsID
## Reorder rownames to match columns of nhoodCounts(milo)
pbmc.design <- pbmc.design[colnames(nhoodCounts(pbmc.milo)), , drop=FALSE]
table(pbmc.design$adjmfc.time)
```

```
##
## d0 high  d0 low
##      41      39
```

We encode the fixed effect variables as normal - but the random effects are different. We encode them as `(1|variable)` which tells the model that this is a random intercept. There
are also random slopes GLMMs, but Milo doesn’t currently work with these. There are few other arguments we have to pass to `testNhoods`. We need to consider what solver we use, as
the parameter estimation is a little more complex. The options are ‘Fisher’, ‘HE’ or ‘HE-NNLS’; the latter refers to a constrained optimisation for the variance components. If at
any point during the optimisation negative variance estimates are encountered, then Milo will produce a warning message and automatically switch to ‘HE-NNLS’. These negative variance
estimates are usually due to estimates close to zero, which is nonsensical for a variance parameter (they are bounded [0, +\(\infty\)). To prevent negative variances from the Fisher
solver, the constrained HE-NNLS re-frames the parameter estimation as a non-negative least squares problem, constraining negative estimates to ~0 (10\(^{-8}\) by default). This has a
knock-on effect that the model solving might be close to singular - Milo will generate a warning for each nhood where this is the case. We therefore recommend you set `warning=FALSE`
if running in an Rstudio notebook, or wrap the function call in `suppressWarnings()`.

As a guideline, we recommend that you use `solver="Fisher"` in `testNhoods` with a GLMM - if the system is well conditioned then the performance is superior to the HE/HE-NNLS
approaches and faster.

As we are estimating variances, we also want these to be unbiased, so we use restricted maximum likelihood (`REML=TRUE`). Note that NB-GLMMs are by construction slower than
NB-GLMs as there are additional matrix inversion steps that don’t scale very nicely. While we have made every effort to reduce the computational burden we are still limited by the bounds of matrix algebra!

```
set.seed(42)
rownames(pbmc.design) <- pbmc.design$ObsID

da_results <- testNhoods(pbmc.milo, design = ~ adjmfc.time + (1|tenx_lane), design.df = pbmc.design, fdr.weighting="graph-overlap",
                         glmm.solver="Fisher", REML=TRUE, norm.method="TMM", BPPARAM = bpparam, fail.on.error=FALSE)
```

```
## Random effects found
```

```
## Using TMM normalisation
```

```
## Running GLMM model - this may take a few minutes
```

```
## Performing spatial FDR correction with graph-overlap weighting
```

```
table(da_results$SpatialFDR < 0.1)
```

```
##
## FALSE  TRUE
##   763   331
```

We can see that the GLMM produces a warning if parameters don’t converge - this is important because we want to know if we can trust our estimates or not. One way to handle this
is to increase `max.iters` (default is 50) - the downside is that this will increase the compute time and doesn’t guarantee convergence. If the nhood counts are very sparse then this
can cause problems as there isn’t much information/variance from which to learn the (locally) optimal parameter values. An additional point is that the GLMM may fail on some nhoods,
likely due to singular Hessian matrices during parameter estimation. These nhoods will have results with all `NA` values.

```
which(is.na(da_results$logFC))
```

```
## integer(0)
```

In this analysis there are 0 nhood models that failed. If this happens to a large number of nhoods then there may be issues with the
combination of variables in the model, nhood counts might have a lot of zero-values, or there could be separation. For the latter `checkSeparation` can be used to check for all-zero
values in the testing variables of interest. If any nhoods have perfect separation between zero and non-zero counts on a variable level then these nhoods can be excluded from the
analysis.

```
which(checkSeparation(pbmc.milo, design.df=pbmc.design, condition="adjmfc.time", min.val=10))
```

```
## 161 308
## 161 308
```

Here we can see that nhood 161, 308 can be separated into counts >= 10 and < 10 on our test variable `adjmfc.time` - this is the same nhood that encounters a model failure in our GLMM. We
can also visualise the count distribution to confirm this using `plotNhoodCounts` (kindly contributed by Nick Hirschmüller).

```
plotNhoodCounts(pbmc.milo, which(checkSeparation(pbmc.milo, design.df=pbmc.design, condition="adjmfc.time", min.val=10)),
                design.df=pbmc.design, condition="adjmfc.time")
```

![](data:image/png;base64...)

This shows the extremely low counts in the d0 high group, or specifically, that only a single observation is non-zero.

As with the GLM implementation, the GLMM calculates a log fold-change and corrected P-value for each neighbourhood, which indicates whether there is significant differential
abundance between conditions for 331 neighbourhoods. The hypothesis testing is slightly different - for the GLM we use `edgeR::glmQLFTest` which
performs an F-test on the quasi-likelihood negative binomial fit. In the GLMM we use a pseudo-likelihood, so we instead we opt for a Wald-type test on the fixed effect variable
log-fold change; FDR correction is performed the same.

The output of `testNhoods` with a GLMM has some additional columns that are worth exploring.

```
head(da_results[!is.na(da_results$logFC), ])
```

```
##        logFC    logCPM        SE     tvalue       PValue tenx_lane_variance
## 1  1.6968195  9.776328 0.3161084  5.3678404 8.057539e-08        0.000000010
## 2  0.4102221 10.102911 0.2781063  1.4750550 1.402016e-01        0.008583322
## 3 -0.6810862 10.248240 0.2493657 -2.7312753 6.310333e-03        0.028519148
## 4 -0.2759066  9.207067 0.2879083 -0.9583143 3.379075e-01        0.013969456
## 5 -0.6624880  9.789836 0.2613097 -2.5352596 1.123815e-02        0.000000010
## 6  0.5206940 10.113321 0.2770071  1.8797140 6.015036e-02        0.013334845
##   Converged Logliklihood Nhood   SpatialFDR
## 1     FALSE     82.68052     1 8.464776e-06
## 2     FALSE     90.65401     2 2.862186e-01
## 3     FALSE     76.09395     3 3.348022e-02
## 4      TRUE     48.51839     4 5.063165e-01
## 5      TRUE     36.98252     5 5.164729e-02
## 6     FALSE    106.22375     6 1.581554e-01
```

Due to the way parameter estimation is performed in the GLMM, we can directly compute standard errors (SE column) - these are used to compute the subequent test statistic (tvalue)
and p-value. We next have the variance parameter estimate for each random effect variable (here ‘tenx\_lane variance’). As we use constrained optimisation to prevent negative
estimates some of these values will be bounded at 1e-8. We then have a column that determines which nhoods have converged - this can be useful for checking if, for example, the
inference is different between converged and not-converged nhoods. We also return the estimated dispersion value and the log pseudo-likelihood in addition the same columns in
the results table when using the GLM.

We can inspect the distribution of the variance parameter estimates, and compare between the converged vs. not converged nhoods.

```
ggplot(da_results, aes(x=Converged, y=`tenx_lane_variance`)) +
    geom_boxplot() +
    scale_y_log10() +
    NULL
```

![](data:image/png;base64...)

This shows that the nhoods where the model didn’t converge appear to have huge variance estimates - likely these are poorly conditioned systems, so the variance estimates aren’t easy
to estimate. This can happen when the likelihood is not especially curved near the true value, so there’s not much of a gradient to use for the solver.

We can also inspect our results as we would for the GLM, by using the neighbourhood graph produced by `buildNhoodGraph`

```
pbmc.milo <- buildNhoodGraph(pbmc.milo, overlap=25)

# we need to subset the plotting results as it can't handle the NAs internally.
plotUMAP(pbmc.milo, colour_by="adjmfc.time") + plotNhoodGraphDA(pbmc.milo, da_results,
                                                                alpha=0.1) +
  plot_layout(guides="auto" )
```

```
## Adding nhood effect sizes to neighbourhood graph attributes
```

![](data:image/png;base64...)

We can see that there are some complex differences between the high and low responder patients. How does this compare to running the same analysis with a GLM using the batching
variable as a fixed effect?

```
set.seed(42)
# we need to use place the test variable at the end of the formula
glm_results <- testNhoods(pbmc.milo, design = ~ tenx_lane + adjmfc.time, design.df = pbmc.design, fdr.weighting="graph-overlap",
                          REML=TRUE, norm.method="TMM", BPPARAM = bpparam)
```

```
## Using TMM normalisation
```

```
## Running with model contrasts
```

```
## Performing spatial FDR correction with graph-overlap weighting
```

```
table(glm_results$SpatialFDR < 0.1)
```

```
##
## FALSE  TRUE
##   981   113
```

The first and obvious difference is that we have fewer DA nhoods. We can attribute this to the fact that the GLM uses more degrees of freedom to model the batching variable which
reduces the overall statistical power.

```
plotUMAP(pbmc.milo, colour_by="adjmfc.time") + plotNhoodGraphDA(pbmc.milo, glm_results, alpha=0.1) +
  plot_layout(guides="auto" )
```

```
## Adding nhood effect sizes to neighbourhood graph attributes
```

![](data:image/png;base64...)

We can do a side-by-side comparison of the estimated log fold changes from the GLM and GLMM.

```
comp.da <- merge(da_results, glm_results, by='Nhood')
comp.da$Sig <- "none"
comp.da$Sig[comp.da$SpatialFDR.x < 0.1 & comp.da$SpatialFDR.y < 0.1] <- "Both"
comp.da$Sig[comp.da$SpatialFDR.x >= 0.1 & comp.da$SpatialFDR.y < 0.1] <- "GLM"
comp.da$Sig[comp.da$SpatialFDR.x < 0.1 & comp.da$SpatialFDR.y >= 0.1] <- "GLMM"

ggplot(comp.da, aes(x=logFC.x, y=logFC.y)) +
    geom_point(data=comp.da[, c("logFC.x", "logFC.y")], aes(x=logFC.x, y=logFC.y),
               colour='grey80', size=1) +
    geom_point(aes(colour=Sig)) +
    labs(x="GLMM LFC", y="GLM LFC") +
    facet_wrap(~Sig) +
    NULL
```

![](data:image/png;base64...)

This shows that the parameter estimates are extremely similar - this is what we *should* expect to see. We can see that both models identify the nhoods with the strongest DA. The
difference appears in the nhoods that are more modestly DA - the GLMM has more power to identify these.

# 6 A note on when to use GLMM vs. GLM

In general, GLMMs require larger samples sizes than GLMs - the power gain comes from the narrower scope of the GLMM in it’s inference that leads to (generally) smaller standard
errors and thus bigger test statistics. That doesn’t mean that GLMMs are inherently better than GLMs - with great power comes great responsibilities, and it’s easy to abuse
a mixed effect model. In general I wouldn’t recommend using a GLMM with fewer than 50 observations and a good case for including a variable as a random effect. The simplest
case for this is where you have multiple observations per experimental individual/sample and thus the nhood counts are not i.i.d. The other obvious case, as discussed in the intro
is for genetic analysis or for time course data.

**Session Info**

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
##  [1] ensembldb_2.34.0             AnnotationFilter_1.34.0
##  [3] GenomicFeatures_1.62.0       AnnotationDbi_1.72.0
##  [5] sparseMatrixStats_1.22.0     BiocParallel_1.44.0
##  [7] irlba_2.3.5.1                Matrix_1.7-4
##  [9] scRNAseq_2.23.1              MouseGastrulationData_1.23.0
## [11] SpatialExperiment_1.20.0     MouseThymusAgeing_1.17.0
## [13] patchwork_1.3.2              dplyr_1.1.4
## [15] scran_1.38.0                 scater_1.38.0
## [17] ggplot2_4.0.0                scuttle_1.20.0
## [19] SingleCellExperiment_1.32.0  SummarizedExperiment_1.40.0
## [21] Biobase_2.70.0               GenomicRanges_1.62.0
## [23] Seqinfo_1.0.0                IRanges_2.44.0
## [25] S4Vectors_0.48.0             BiocGenerics_0.56.0
## [27] generics_0.1.4               MatrixGenerics_1.22.0
## [29] matrixStats_1.5.0            miloR_2.6.0
## [31] edgeR_4.8.0                  limma_3.66.0
## [33] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22         splines_4.5.1            BiocIO_1.20.0
##   [4] bitops_1.0-9             filelock_1.0.3           tibble_3.3.0
##   [7] polyclip_1.10-7          XML_3.99-0.19            lifecycle_1.0.4
##  [10] httr2_1.2.1              lattice_0.22-7           MASS_7.3-65
##  [13] alabaster.base_1.10.0    magrittr_2.0.4           sass_0.4.10
##  [16] rmarkdown_2.30           jquerylib_0.1.4          yaml_2.3.10
##  [19] metapod_1.18.0           cowplot_1.2.0            DBI_1.2.3
##  [22] RColorBrewer_1.1-3       abind_1.4-8              purrr_1.1.0
##  [25] ggraph_2.2.2             BumpyMatrix_1.18.0       RCurl_1.98-1.17
##  [28] pracma_2.4.6             tweenr_2.0.3             rappdirs_0.3.3
##  [31] ggrepel_0.9.6            alabaster.sce_1.10.0     dqrng_0.4.1
##  [34] codetools_0.2-20         DelayedArray_0.36.0      ggforce_0.5.0
##  [37] tidyselect_1.2.1         UCSC.utils_1.6.0         farver_2.1.2
##  [40] ScaledMatrix_1.18.0      viridis_0.6.5            BiocFileCache_3.0.0
##  [43] GenomicAlignments_1.46.0 jsonlite_2.0.0           BiocNeighbors_2.4.0
##  [46] tidygraph_1.3.1          tools_4.5.1              Rcpp_1.1.0
##  [49] glue_1.8.0               gridExtra_2.3            SparseArray_1.10.0
##  [52] xfun_0.53                GenomeInfoDb_1.46.0      HDF5Array_1.38.0
##  [55] gypsum_1.6.0             withr_3.0.2              numDeriv_2016.8-1.1
##  [58] BiocManager_1.30.26      fastmap_1.2.0            rhdf5filters_1.22.0
##  [61] bluster_1.20.0           digest_0.6.37            rsvd_1.0.5
##  [64] R6_2.6.1                 gtools_3.9.5             dichromat_2.0-0.1
##  [67] RSQLite_2.4.3            cigarillo_1.0.0          h5mread_1.2.0
##  [70] tidyr_1.3.1              FNN_1.1.4.1              rtracklayer_1.70.0
##  [73] graphlayouts_1.2.2       httr_1.4.7               S4Arrays_1.10.0
##  [76] uwot_0.2.3               pkgconfig_2.0.3          gtable_0.3.6
##  [79] blob_1.2.4               S7_0.2.0                 XVector_0.50.0
##  [82] htmltools_0.5.8.1        bookdown_0.45            ProtGenerics_1.42.0
##  [85] scales_1.4.0             alabaster.matrix_1.10.0  png_0.1-8
##  [88] knitr_1.50               rjson_0.2.23             curl_7.0.0
##  [91] cachem_1.1.0             rhdf5_2.54.0             stringr_1.5.2
##  [94] BiocVersion_3.22.0       parallel_4.5.1           vipor_0.4.7
##  [97] restfulr_0.0.16          pillar_1.11.1            grid_4.5.1
## [100] alabaster.schemas_1.10.0 vctrs_0.6.5              BiocSingular_1.26.0
## [103] dbplyr_2.5.1             beachmat_2.26.0          cluster_2.1.8.1
## [106] beeswarm_0.4.0           evaluate_1.0.5           tinytex_0.57
## [109] magick_2.9.0             cli_3.6.5                locfit_1.5-9.12
## [112] compiler_4.5.1           Rsamtools_2.26.0         rlang_1.1.6
## [115] crayon_1.5.3             labeling_0.4.3           ggbeeswarm_0.7.2
## [118] stringi_1.8.7            alabaster.se_1.10.0      viridisLite_0.4.2
## [121] Biostrings_2.78.0        lazyeval_0.2.2           ExperimentHub_3.0.0
## [124] bit64_4.6.0-1            Rhdf5lib_1.32.0          KEGGREST_1.50.0
## [127] statmod_1.5.1            alabaster.ranges_1.10.0  AnnotationHub_4.0.0
## [130] igraph_2.2.1             memoise_2.0.1            bslib_0.9.0
## [133] bit_4.6.0
```