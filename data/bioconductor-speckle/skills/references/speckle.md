# speckle: statistical methods for analysing single cell RNA-seq data

Belinda Phipson

#### 30 October 2025

#### Package

speckle 1.10.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Finding significant differences in cell type proportions using propeller](#finding-significant-differences-in-cell-type-proportions-using-propeller)
* [4 Load the libraries](#load-the-libraries)
* [5 Loading data into R](#loading-data-into-r)
* [6 Bootstrap additional samples](#bootstrap-additional-samples)
* [7 Combine all SingleCellExperiment objects](#combine-all-singlecellexperiment-objects)
* [8 Visualise the data](#visualise-the-data)
* [9 Test for differences in cell line proportions in the three technologies](#test-for-differences-in-cell-line-proportions-in-the-three-technologies)
* [10 Visualise the results](#visualise-the-results)
* [11 Fitting linear models using the transformed proportions directly](#fitting-linear-models-using-the-transformed-proportions-directly)
* [12 More complex (or just different) experimental designs](#more-complex-or-just-different-experimental-designs)
  + [12.1 Fitting a continuous variable rather than groups](#fitting-a-continuous-variable-rather-than-groups)
  + [12.2 Including random effects](#including-random-effects)
* [13 Using propeller on any proportions data](#using-propeller-on-any-proportions-data)
* [14 Tips for clustering](#tips-for-clustering)
* [15 Session Info](#session-info)

# 1 Introduction

The *[speckle](https://bioconductor.org/packages/3.22/speckle)* package contains functions to analyse
differences in cell type proportions in single cell RNA-seq data. As our
research into specialised analyses of single cell data continues we anticipate
that the package will be updated with new functions.

The propeller method has now been published in *Bioinformatics*:
Belinda Phipson, Choon Boon Sim, Enzo R Porrello, Alex W Hewitt, Joseph Powell, Alicia Oshlack, propeller: testing for differences in cell type proportions in single cell data, Bioinformatics, 2022;, btac582, <https://doi.org/10.1093/bioinformatics/btac582>

The analysis of single cell RNA-seq data consists of a large number of steps,
which can be iterative and also depend on the research question. There are many
R packages that can do some or most of these steps. The analysis steps are
described here briefly.

Once the sequencing data has been summarised into counts over genes, quality
control is performed to remove poor quality cells. Poor quality cells are often
characterised as having very low total counts (library size) and very few genes
detected. Lowly expressed and uninformative genes are filtered out, followed by
appropriate normalisation. Dimensionality reduction and clustering of the cells
is then performed. Cells that have similar transcriptional profiles cluster
together, and these clusters (hopefully) correspond to something biologically
relevant, such as different cell types. Differential expression between each
cluster compared to all other clusters can highlight genes that are more highly
expressed in each cluster. These marker genes help to determine the cell type
each cluster corresponds to. Cell type identification is a process that often
uses marker genes as well as a list of curated genes that are known to be
expressed in each cell type. It is always helpful to visualise the data in a lot
of different ways to aid in interpretation of the clusters using tSNE/UMAP
plots, clustering trees and heatmaps of known marker genes. An alternative to
clustering is classification or label transfer approaches, where
reference datasets can be used to annotate new datasets.

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("speckle")
```

# 3 Finding significant differences in cell type proportions using propeller

In order to determine whether there are statistically significant compositional
differences between groups, there must be some form of biological replication in
the experiment. This is so that we can estimate the variability of the cell type
proportion estimates for each group. A classical statistical test for
differences between two proportions is typically very sensitive to small changes
and will almost always yield a significant p-value. Hence `propeller` is only
suitable to use in single cell experiments where there are multiple groups and
multiple biological replicates in at least one of the groups. The absolute
minimum sample size is 2 in one group and 1 in the other group/s. Variance
estimates are obtained from the group with more than 1 biological replicate
which assumes that the cell type proportion variances estimates are similar
between experimental conditions.

The `propeller` test is performed after initial analysis of the single cell data
has been done, i.e. after clustering and cell type assignment. The `propeller`
function can take a `SingleCellExperiment` or `Seurat` object and extract the
necessary information from the metadata. The basic model for `propeller` is that
the cell type proportions for each sample are estimated based on the clustering
information provided by the user or extracted from the relevant slots in the
data objects. The proportions are then transformed using either an arcsin square
root transformation, or logit transformation. For
each cell type \(i\), we fit a linear model with group as the explanatory variable
using functions from the R Bioconductor package *[limma](https://bioconductor.org/packages/3.22/limma)*.
Using *[limma](https://bioconductor.org/packages/3.22/limma)* to obtain p-values has the added benefit
of performing empirical Bayes shrinkage of the variances. For every cell type
we obtain a p-value that indicates whether that cell type proportion is
statistically significantly different between two (or more) groups.

# 4 Load the libraries

```
library(speckle)
library(SingleCellExperiment)
library(CellBench)
library(limma)
library(ggplot2)
library(scater)
library(patchwork)
library(edgeR)
library(statmod)
```

# 5 Loading data into R

We are using single cell data from the *[CellBench](https://bioconductor.org/packages/3.22/CellBench)*
package to illustrate how `propeller` works. This is an artificial dataset that
is made up of an equal mixture of 3 different cell lines. There are three
datasets corresponding to three different technologies: 10x genomics, CelSeq and
DropSeq.

```
sc_data <- load_sc_data()
```

The way that `propeller` is designed to be used is in the context of a designed
experiment where there are multiple biological replicates and multiple groups.
Comparing cell type proportions without biological replication should be done
with caution as there will be a large degree of variability in the cell type
proportions between samples due to technical factors (cell capture bias,
sampling, clustering errors), as well as biological variability. The
*[CellBench](https://bioconductor.org/packages/3.22/CellBench)* dataset does not have biological
replication, so we will create several artificial biological replicates by
bootstrapping the data. Bootstrapping has the advantage that it induces
variability between bootstrap samples by sampling with replacement. Here we will
treat the three technologies as the groups, and create artifical biological
replicates within each group. Note that bootstrapping only induces sampling
variability between our biological replicates, which will almost certainly be
much smaller than biological variability we would expect to see in a real
dataset.

The three single cell experiment objects in `sc_data` all have differing numbers
of genes. The first step is to find all the common genes between all three
experiments in order to create one large dataset.

```
commongenes1 <- rownames(sc_data$sc_dropseq)[rownames(sc_data$sc_dropseq) %in%
                                                rownames(sc_data$sc_celseq)]
commongenes2 <-  commongenes1[commongenes1 %in% rownames(sc_data$sc_10x)]

sce_10x <- sc_data$sc_10x[commongenes2,]
sce_celseq <- sc_data$sc_celseq[commongenes2,]
sce_dropseq <- sc_data$sc_dropseq[commongenes2,]

dim(sce_10x)
```

```
## [1] 13575   902
```

```
dim(sce_celseq)
```

```
## [1] 13575   274
```

```
dim(sce_dropseq)
```

```
## [1] 13575   225
```

```
table(rownames(sce_10x) == rownames(sce_celseq))
```

```
##
##  TRUE
## 13575
```

```
table(rownames(sce_10x) == rownames(sce_dropseq))
```

```
##
##  TRUE
## 13575
```

# 6 Bootstrap additional samples

This dataset does not have any biological replicates, so we will bootstrap
additional samples and pretend that they are biological replicates.
Bootstrapping won’t replicate true biological variation between samples, but we
will ignore that for the purpose of demonstrating how `propeller` works. Note
that we don’t need to simulate gene expression measurements; `propeller` only
uses cluster information, hence we simply bootstrap the column indices of the
single cell count matrices.

```
i.10x <- seq_len(ncol(sce_10x))
i.celseq <- seq_len(ncol(sce_celseq))
i.dropseq <- seq_len(ncol(sce_dropseq))

set.seed(10)
boot.10x <- sample(i.10x, replace=TRUE)
boot.celseq <- sample(i.celseq, replace=TRUE)
boot.dropseq <- sample(i.dropseq, replace=TRUE)

sce_10x_rep2 <- sce_10x[,boot.10x]
sce_celseq_rep2 <- sce_celseq[,boot.celseq]
sce_dropseq_rep2 <- sce_dropseq[,boot.dropseq]
```

# 7 Combine all SingleCellExperiment objects

The `SingleCellExperiment` objects don’t combine very easily, so I will create a
new object manually, and retain only the information needed to run `propeller`.

```
sample <- rep(c("S1","S2","S3","S4","S5","S6"),
                c(ncol(sce_10x),ncol(sce_10x_rep2),ncol(sce_celseq),
                ncol(sce_celseq_rep2),
                ncol(sce_dropseq),ncol(sce_dropseq_rep2)))
cluster <- c(sce_10x$cell_line,sce_10x_rep2$cell_line,sce_celseq$cell_line,
                sce_celseq_rep2$cell_line,sce_dropseq$cell_line,
                sce_dropseq_rep2$cell_line)
group <- rep(c("10x","celseq","dropseq"),
                c(2*ncol(sce_10x),2*ncol(sce_celseq),2*ncol(sce_dropseq)))

allcounts <- cbind(counts(sce_10x),counts(sce_10x_rep2),
                    counts(sce_celseq), counts(sce_celseq_rep2),
                    counts(sce_dropseq), counts(sce_dropseq_rep2))

sce_all <- SingleCellExperiment(assays = list(counts = allcounts))
sce_all$sample <- sample
sce_all$group <- group
sce_all$cluster <- cluster
```

# 8 Visualise the data

Here I am going to use the Bioconductor package *[scater](https://bioconductor.org/packages/3.22/scater)*
to visualise the data. The *[scater](https://bioconductor.org/packages/3.22/scater)* vignette goes
quite deeply into quality
control of the cells and the kinds of QC plots we like to look at. Here we will
simply log-normalise the gene expression counts, perform dimensionality
reduction (PCA) and generate PCA/TSNE/UMAP plots to visualise the relationships
between the cells.

```
sce_all <- scater::logNormCounts(sce_all)
sce_all <- scater::runPCA(sce_all)
sce_all <- scater::runUMAP(sce_all)
```

Plot PC1 vs PC2 colouring by cell line and technology:

```
pca1 <- scater::plotReducedDim(sce_all, dimred = "PCA", colour_by = "cluster") +
    ggtitle("Cell line")
pca2 <- scater::plotReducedDim(sce_all, dimred = "PCA", colour_by = "group") +
    ggtitle("Technology")
pca1 + pca2
```

![](data:image/png;base64...)

Plot UMAP highlighting cell line and technology:

```
umap1 <- scater::plotReducedDim(sce_all, dimred = "UMAP",
                                colour_by = "cluster") +
    ggtitle("Cell line")
umap2 <- scater::plotReducedDim(sce_all, dimred = "UMAP", colour_by = "group") +
    ggtitle("Technology")
umap1 + umap2
```

![](data:image/png;base64...)

For this dataset UMAP is a little bit of an overkill, the PCA plots show the
relationships between the cells quite well. PC1 separates cells based on
technology, and PC2 separates cells based on the cell line (clusters). From the
PCA plots we can see that 10x is quite different to CelSeq and DropSeq, and the
H2228 cell line is quite different to the remaining 2 cell lines.

# 9 Test for differences in cell line proportions in the three technologies

In order to demonstrate `propeller` I will assume that the cell line information
corresponds to clusters and all the analysis steps have beeen performed. Here we
are interested in testing whether there are compositional differences between
the three technologies: 10x, CelSeq and DropSeq. Since there are more than 2
groups, `propeller` will perform an ANOVA to determine whether there is a
significant shift in the cell type proportions between these three groups.

The `propeller` function can take a `SingleCellExperiment` object or `Seurat`
object as input and extract the three necessary pieces of information from the
cell information stored in `colData`. The three essential pieces of information
are

* cluster
* sample
* group

If these arguments are not explicitly passed to the `propeller` function, then
these are extracted from the `SingleCellExperiment` or `Seurat` object. Upper
or lower case is acceptable, but
the variables need to be named exactly as stated in the list above. For a
`Seurat` object, the cluster information is extracted from `Idents(x)`.

The default of propeller is to perform the logit transformation:

```
# Perform logit transformation
propeller(sce_all)
```

```
##        BaselineProp PropMean.10x PropMean.celseq PropMean.dropseq Fstatistic
## H1975     0.3579586    0.3392461       0.3941606        0.3888889  3.9948367
## H2228     0.3322627    0.3481153       0.2974453        0.3111111  3.4005262
## HCC827    0.3097787    0.3126386       0.3083942        0.3000000  0.2076966
##           P.Value        FDR
## H1975  0.01841045 0.05003357
## H2228  0.03335571 0.05003357
## HCC827 0.81245349 0.81245349
```

An alternative variance stabilising transformation is the arcsin square root
transformation.

```
# Perform arcsin square root transformation
propeller(sce_all, transform="asin")
```

```
##        BaselineProp PropMean.10x PropMean.celseq PropMean.dropseq Fstatistic
## H1975     0.3579586    0.3392461       0.3941606        0.3888889  4.1485415
## H2228     0.3322627    0.3481153       0.2974453        0.3111111  3.3063237
## HCC827    0.3097787    0.3126386       0.3083942        0.3000000  0.2024889
##           P.Value        FDR
## H1975  0.01578743 0.04736228
## H2228  0.03665067 0.05497600
## HCC827 0.81669558 0.81669558
```

The results from using the two different transforms are a little bit different,
with the H1975 cell line being statistically significant using the arc sin
square root transform, and not significant after using the logit transform.

Another option for running `propeller` is for the user to supply the cluster,
sample and group information explicitly to the `propeller` function.

```
propeller(clusters=sce_all$cluster, sample=sce_all$sample, group=sce_all$group)
```

```
##        BaselineProp PropMean.10x PropMean.celseq PropMean.dropseq Fstatistic
## H1975     0.3579586    0.3392461       0.3941606        0.3888889  3.9948367
## H2228     0.3322627    0.3481153       0.2974453        0.3111111  3.4005262
## HCC827    0.3097787    0.3126386       0.3083942        0.3000000  0.2076966
##           P.Value        FDR
## H1975  0.01841045 0.05003357
## H2228  0.03335571 0.05003357
## HCC827 0.81245349 0.81245349
```

The cell lines were mixed together in roughly equal proportions (~0.33) and
hence we don’t expect to see significant differences between the three
clusters. However, because bootstrapping the samples doesn’t incorporate
enough variability between the samples to mimic true biological variability,
we can see that the H1975 cluster looks significantly different between
the three technologies. The proportion of this cell line is closer to 0.4
for CelSeq and DropSeq, and 0.34 for the 10x data.

# 10 Visualise the results

In the *[speckle](https://bioconductor.org/packages/3.22/speckle)* package there is a plotting function
`plotCellTypeProps` that takes a `Seurat` or `SingleCellExperiment` object,
extracts sample and cluster information and outputs a barplot of cell type
proportions between the samples. The user also has the option of supplying the
cluster and sample cell information instead of an R object. The output is a
`ggplot2` object that the user can then manipulate however they please.

```
plotCellTypeProps(sce_all)
```

![](data:image/png;base64...)

Alternatively, we can obtain the cell type proportions and transformed
proportions directly by running the `getTransformedProps` function which takes
the cluster and sample information as input. The output from
`getTransformedProps` is a list with the cell type counts, transformed
proportions and proportions as elements.

```
props <- getTransformedProps(sce_all$cluster, sce_all$sample, transform="logit")
barplot(props$Proportions, col = c("orange","purple","dark green"),legend=TRUE,
        ylab="Proportions")
```

![](data:image/png;base64...)

Call me old-school, but I still like looking at stripcharts to visualise results
and see whether the significant p-values make sense.

```
par(mfrow=c(1,3))
for(i in seq(1,3,1)){
stripchart(props$Proportions[i,]~rep(c("10x","celseq","dropseq"),each=2),
            vertical=TRUE, pch=16, method="jitter",
            col = c("orange","purple","dark green"),cex=2, ylab="Proportions")
title(rownames(props$Proportions)[i])
}
```

![](data:image/png;base64...)

If you are interested in seeing which models best fit the data in terms of the
cell type variances, there are two plotting functions that can do this:
`plotCellTypeMeanVar` and `plotCellTypePropsMeanVar`. For this particular
dataset it isn’t very informative because there are only three cell “types”
and no biogical variability.

```
par(mfrow=c(1,1))
plotCellTypeMeanVar(props$Counts)
```

![](data:image/png;base64...)

```
plotCellTypePropsMeanVar(props$Counts)
```

![](data:image/png;base64...)

# 11 Fitting linear models using the transformed proportions directly

If you are like me, you won’t feel very comfortable with a black-box approach
where one function simply spits out a table of results. If you would like to
have more control over your linear model and include extra covariates then you
can fit a linear model in a more direct way using the transformed proportions
that can be obtained by running the `getTransformedProps` function.

We have already obtained the proportions and transformed proportions when we ran
the `getTransformedProps` function above. This function outputs a list object
with three elements: `Counts`, `TransformedProps` and `Proportions`. These are
all matrices with clusters/cell types in the rows and samples in the columns.

```
names(props)
```

```
## [1] "Counts"           "TransformedProps" "Proportions"
```

```
props$TransformedProps
```

```
##         sample
## clusters         S1         S2         S3         S4         S5         S6
##   H1975  -0.6323232 -0.7014598 -0.3408295 -0.5234288 -0.3706312 -0.5379980
##   H2228  -0.6225683 -0.6323232 -0.8672551 -0.8498919 -0.8993542 -0.6931472
##   HCC827 -0.8291800 -0.7467614 -0.9023576 -0.7150060 -0.8357613 -0.8567766
```

First we need to set up our sample information in much the same way we would if
we were analysing bulk RNA-seq data. We can pretend that we have pairing
information which corresponds to our original vs bootstrapped samples to make
our model a little more complicated for demonstration purposes.

```
group <- rep(c("10x","celseq","dropseq"),each=2)
pair <- rep(c(1,2),3)
data.frame(group,pair)
```

```
##     group pair
## 1     10x    1
## 2     10x    2
## 3  celseq    1
## 4  celseq    2
## 5 dropseq    1
## 6 dropseq    2
```

We can set up a design matrix taking into account group and pairing information.
Please note that the way that `propeller` has been designed is such that the
group information is *always* first in the design matrix specification, and
there is NO intercept. If you are new to design matrices and linear modelling, I
would highly recommend reading the *[limma](https://bioconductor.org/packages/3.22/limma)* manual, which
is incredibly extensive and covers a variety of different experimental set ups.

```
design <- model.matrix(~ 0 + group + pair)
design
```

```
##   group10x groupcelseq groupdropseq pair
## 1        1           0            0    1
## 2        1           0            0    2
## 3        0           1            0    1
## 4        0           1            0    2
## 5        0           0            1    1
## 6        0           0            1    2
## attr(,"assign")
## [1] 1 1 1 2
## attr(,"contrasts")
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

In our example, we have three groups, 10x, CelSeq and DropSeq. In order to
perform an ANOVA to test for cell type composition differences between these
3 technologies, we can use the `propeller.anova` function. The `coef` argument
tells the function which columns of the design matrix correspond to the groups
we are interested in testing. Here we are interested in the first three columns.

```
propeller.anova(prop.list=props, design=design, coef = c(1,2,3),
                robust=TRUE, trend=FALSE, sort=TRUE)
```

```
##        PropMean.group10x PropMean.groupcelseq PropMean.groupdropseq Fstatistic
## H1975          0.3392461            0.3941606             0.3888889  7.0766800
## H2228          0.3481153            0.2974453             0.3111111  6.0238846
## HCC827         0.3126386            0.3083942             0.3000000  0.3679255
##             P.Value         FDR
## H1975  0.0008445725 0.002533718
## H2228  0.0024202496 0.003630374
## HCC827 0.6921687242 0.692168724
```

Note that the p-values are smaller here than before because we have specified
a pairing vector that states which samples were bootstrapped and which are the
original samples.

If we were interested in testing only 10x versus DropSeq we could alternatively
use the `propeller.ttest` function and specify a contrast that tests for this
comparison with our design matrix.

```
design
```

```
##   group10x groupcelseq groupdropseq pair
## 1        1           0            0    1
## 2        1           0            0    2
## 3        0           1            0    1
## 4        0           1            0    2
## 5        0           0            1    1
## 6        0           0            1    2
## attr(,"assign")
## [1] 1 1 1 2
## attr(,"contrasts")
## attr(,"contrasts")$group
## [1] "contr.treatment"
```

```
mycontr <- makeContrasts(group10x-groupdropseq, levels=design)
propeller.ttest(props, design, contrasts = mycontr, robust=TRUE, trend=FALSE,
                sort=TRUE)
```

```
##        PropMean.group10x PropMean.groupdropseq PropRatio Tstatistic    P.Value
## H1975          0.3392461             0.3888889 0.8723472 -3.0851275 0.02152145
## H2228          0.3481153             0.3111111 1.1189420  2.4498658 0.04979982
## HCC827         0.3126386             0.3000000 1.0421286  0.8460825 0.42995196
##               FDR
## H1975  0.06456434
## H2228  0.07469974
## HCC827 0.42995196
```

Finally note that the `robust` and `trend` parameters are parameters for the
`eBayes` function in *[limma](https://bioconductor.org/packages/3.22/limma)*. When `robust = TRUE`,
robust empirical Bayes shrinkage of the variances is performed which mitigates
the effects of outlying observations. We set `trend = FALSE` as we don’t expect
a mean-variance trend after performing our variance stabilising transformation.
There may also be an error when `trend` is set to TRUE because there are often
not enough data points to estimate the trend.

# 12 More complex (or just different) experimental designs

## 12.1 Fitting a continuous variable rather than groups

Let us assume that we expect that the different technologies have a meaningful
ordering to them, and we would like to find the cell types that are increasing
or decreasing along this trend. In more complex scenarios beyond group
comparisons I would recommend taking the transformed proportions from the
`getTransformedProps` function and using the linear model fitting functions
from the *[limma](https://bioconductor.org/packages/3.22/limma)* package directly.

Let us assume that the ordering of the technologies is 10x->celseq->dropseq.
Then we can recode them 1, 2, 3 and treat the technologies as a
continuous variable. Obviously this scenario doesn’t make much sense
biologically, but we will continue for demonstration purposes.

```
group
```

```
## [1] "10x"     "10x"     "celseq"  "celseq"  "dropseq" "dropseq"
```

```
dose <- rep(c(1,2,3), each=2)

des.dose <- model.matrix(~dose)
des.dose
```

```
##   (Intercept) dose
## 1           1    1
## 2           1    1
## 3           1    2
## 4           1    2
## 5           1    3
## 6           1    3
## attr(,"assign")
## [1] 0 1
```

```
fit <- lmFit(props$TransformedProps,des.dose)
fit <- eBayes(fit, robust=TRUE)
topTable(fit)
```

```
##              logFC    AveExpr          t    P.Value adj.P.Val         B
## H1975   0.10628845 -0.5177784  2.0704318 0.06064165 0.1819250 -3.687156
## H2228  -0.08440249 -0.7607566 -1.6441071 0.12607773 0.1891166 -4.324650
## HCC827 -0.02914913 -0.8143071 -0.5678067 0.58063487 0.5806349 -5.283017
```

Here the log fold changes are reported on the transformed data, so they are
not as easy to interpret directly. The positive logFC indicates that the cell
type proportions are increasing (for example for H1975), and a negative
logFC indicates that the proportions are decreasing across the ordered
technologies 10x -> celseq -> dropseq.

You can get the estimates from the model on the proportions directly by fitting
the same model to the proportions. Here the `logFC` is the slope of the trend
line on the proportions, and the `AveExpr` is the average of the proportions
across all technologies.

```
fit.prop <- lmFit(props$Proportions,des.dose)
fit.prop <- eBayes(fit.prop, robust=TRUE)
topTable(fit.prop)
```

```
##              logFC   AveExpr         t   P.Value adj.P.Val         B
## H1975   0.02482138 0.3740985  2.142542 0.0533486 0.1600458 -4.492397
## H2228  -0.01850209 0.3188906 -1.597071 0.1362331 0.2043497 -5.498815
## HCC827 -0.00631929 0.3070109 -0.545471 0.5954236 0.5954236 -6.610444
```

You could plot the continuous variable `dose` against the proportions and add
trend lines, for example.

```
fit.prop$coefficients
```

```
##        (Intercept)        dose
## H1975    0.3244558  0.02482138
## H2228    0.3558947 -0.01850209
## HCC827   0.3196495 -0.00631929
```

```
par(mfrow=c(1,3))
for(i in seq(1,3,1)){
    plot(dose, props$Proportions[i,], main = rownames(props$Proportions)[i],
        pch=16, cex=2, ylab="Proportions", cex.lab=1.5, cex.axis=1.5,
        cex.main=2)
    abline(a=fit.prop$coefficients[i,1], b=fit.prop$coefficients[i,2], col=4,
            lwd=2)
}
```

![](data:image/png;base64...)

What I recommend in this instance is using the p-values from the analysis on the
transformed data, and the reported statistics (i.e. the coefficients from the
model) obtained from the analysis on the proportions for visualisation
purposes.

## 12.2 Including random effects

If you have a random effect that you would like to account for in your
analysis, for example repeated measures on the same individual, then you
can use the `duplicateCorrelation` function from
the *[limma](https://bioconductor.org/packages/3.22/limma)*.

For illustration purposes, let us assume that `pair` indicates samples taken
from the same individual (or they could represent technical replicates), and we
would like to account for this in our analysis
using a random effect. Again, we fit our models on the transformed proportions
in order to obtain the p-values.

We will formulate the design matrix with an intercept for this example, and test
the differences in technologies relative to 10x. The `block` parameter will be
the `pair` variable. Note that the design matrix now does not include `pair` as
a fixed effect.

```
des.tech <- model.matrix(~group)

dupcor <- duplicateCorrelation(props$TransformedProps, design=des.tech,
                                block=pair)
dupcor
```

```
## $consensus.correlation
## [1] 0.4487241
##
## $cor
## [1] 0.4487241
##
## $atanh.correlations
## [1] 1.18162437 0.03262062 0.23505963
```

The consensus correlation is quite high (0.4487241),
which we expect because we bootstrapped these additional samples.

```
# Fitting the linear model accounting for pair as a random effect
fit1 <- lmFit(props$TransformedProps, design=des.tech, block=pair,
                correlation=dupcor$consensus)
fit1 <- eBayes(fit1)
summary(decideTests(fit1))
```

```
##        (Intercept) groupcelseq groupdropseq
## Down             3           1            0
## NotSig           0           1            2
## Up               0           1            1
```

```
# Differences between celseq vs 10x
topTable(fit1,coef=2)
```

```
##              logFC    AveExpr          t     P.Value  adj.P.Val          B
## H1975   0.23476231 -0.5177784  3.4283447 0.007527919 0.01228234 -0.5326733
## H2228  -0.23112780 -0.7607566 -3.3752682 0.008188225 0.01228234 -0.7050810
## HCC827 -0.02071113 -0.8143071 -0.3024544 0.769179122 0.76917912 -6.1005579
```

```
# Differences between dropseq vs 10x
topTable(fit1, coef=3)
```

```
##              logFC    AveExpr          t    P.Value  adj.P.Val         B
## H1975   0.21257690 -0.5177784  3.1043607 0.01263326 0.03789977 -1.480722
## H2228  -0.16880498 -0.7607566 -2.4651387 0.03585510 0.05378264 -3.158016
## HCC827 -0.05829827 -0.8143071 -0.8513571 0.41664753 0.41664753 -5.679554
```

For celseq vs 10x, H1975 and H2228 are significantly different, with a greater
proportion of H1975
cells detected in celseq, and fewer H2228 cells. For dropseq vs 10x, there is a
higher proportion of H1975 cells.

If you want to do an ANOVA between the three groups:

```
topTable(fit1, coef=2:3)
```

```
##        groupcelseq groupdropseq    AveExpr         F      P.Value   adj.P.Val
## H1975   0.23476231   0.21257690 -0.5177784 7.1651895 0.0007730325 0.002319097
## H2228  -0.23112780  -0.16880498 -0.7607566 6.0992266 0.0022446030 0.003366904
## HCC827 -0.02071113  -0.05829827 -0.8143071 0.3725273 0.6889908724 0.688990872
```

Generally, you can perform any analysis on the transformed proportions that you
would normally do when using limma (i.e. on roughly normally distributed data).
For more complex random effects models with 2 or more random effects, you can
use the `*[lme4](https://bioconductor.org/packages/3.22/lme4)* package. You could also try the`*[dream](https://bioconductor.org/packages/3.22/dream)* package.

# 13 Using propeller on any proportions data

The statistical methods used in propeller are generalisable to any proportions
data. For example, we have successfully applied propeller to Nanostring GeoMx
data, where cell type proportions were inferred using deconvolution methods.

An example of how to do this analysis is shown here for single cell data from
young and old PBMC single cell data, where only the cell type proportions data
is included as a resource in the following paper:
Huang Z. et al. (2021) Effects of sex and aging on the immune cell landscape
as assessed by single-cell transcriptomic analysis. Proc. Natl. Acad. Sci. USA,
118, e2023216118.

The proportions data is available in the *[speckle](https://bioconductor.org/packages/3.22/speckle)*
package and can be accessed with the `data` function. It is a list object that
contains three components: a data frame of cell type proportions, a data frame
of sample information including sex and age, and the total number of cells.

```
data("pbmc_props")
pbmc.props <- pbmc_props$proportions
pbmc.sample.info <- pbmc_props$sample_info
tot.cells <- pbmc_props$total_cells
```

```
par(mfrow=c(1,1))
barplot(as.matrix(pbmc.props),col=ggplotColors(nrow(pbmc.props)),
        ylab="Cell type proportions", xlab="Samples")
```

![](data:image/png;base64...)

We can convert the proportions data into the list object that the `propeller`
functions expect using the `convertDataToList` function. This function can take
either counts or proportions, specified with the `data.type` parameter.

```
prop.list <- convertDataToList(pbmc.props,data.type="proportions",
                               transform="logit", scale.fac=tot.cells/20)
```

The `scale.fac` parameter can be a vector or scalar. It is the number of cells
sequenced per sample. Here we are taking a best guess because from the published
paper all we know is that in total 1.7468410^{5} were sequenced for the whole
dataset. As there are 20 samples, we divide the total number of cells by 20
to get a rough estimate of total number of cells per sample. This is used
specifically when the logit transform is used, but not needed for the arcsin
square root transformation. If `scale.fac` is a vector, it should be the same
length as the number of samples in the study.

We can now test young vs old, taking sex into account.

```
designAS <- model.matrix(~0+pbmc.sample.info$age + pbmc.sample.info$sex)
colnames(designAS) <- c("old","young","MvsF")

# Young vs old
mycontr <- makeContrasts(young-old, levels=designAS)
propeller.ttest(prop.list = prop.list,design = designAS, contrasts = mycontr,
                robust=TRUE,trend=FALSE,sort=TRUE)
```

```
##           PropMean.old PropMean.young PropRatio  Tstatistic      P.Value
## CD8.Naive 0.0251316033   0.0901386289 3.5866645  4.56531629 0.0001655915
## CD16      0.0346697484   0.0184110417 0.5310405 -3.53845105 0.0019313526
## T-mito    0.0050757865   0.0030999505 0.6107330 -2.70564864 0.0130970606
## INTER     0.0237901860   0.0160354568 0.6740366 -2.34264441 0.0288651941
## CD4-CD8-  0.0160339954   0.0301971880 1.8833227  2.26893189 0.0338557770
## TREG      0.0224289338   0.0173984106 0.7757128 -2.26167176 0.0342259694
## CD14      0.1381079661   0.1087546814 0.7874613 -1.75042587 0.0943497196
## ABC       0.0042268748   0.0024242272 0.5735271 -1.53059704 0.1406904913
## CD4.Naive 0.1048008357   0.1320789977 1.2602857  1.46557604 0.1574740245
## MBC       0.0358736549   0.0452983191 1.2627183  1.33884893 0.1948341805
## CD8.CTL   0.1154952554   0.0782456785 0.6774796 -1.31085637 0.2039626408
## PC        0.0054708831   0.0049397487 0.9029162 -1.26307895 0.2203089287
## pre-DC    0.0002285096   0.0003193005 1.3973177  1.24144109 0.2280358887
## CDC1      0.0005479607   0.0008647764 1.5781725  1.19434388 0.2455671742
## CD8.Tem   0.0639345157   0.0802785262 1.2556367  1.14556222 0.2646082927
## NK3       0.0886767142   0.0704022112 0.7939199 -1.02022467 0.3191513408
## NK1       0.0125858088   0.0102540186 0.8147286 -0.64532282 0.5256577519
## NBC       0.0487575349   0.0498363513 1.0221261  0.49890406 0.6229966249
## CD4.Tem   0.0873700973   0.0832684783 0.9530547 -0.40297138 0.6909611645
## CD4.Tcm   0.0799349205   0.0746146497 0.9334425  0.23348683 0.8176285211
## PDC       0.0031666984   0.0034597825 1.0925519  0.20366298 0.8405637766
## CD4+CD8+  0.0142514516   0.0133167354 0.9344126 -0.11420442 0.9101389532
## NK2       0.0568274310   0.0528156246 0.9294037  0.04492635 0.9645875142
## CDC2      0.0126126342   0.0135472159 1.0740989  0.03134858 0.9752816776
##                   FDR
## CD8.Naive 0.003974195
## CD16      0.023176231
## T-mito    0.104776485
## INTER     0.136903877
## CD4-CD8-  0.136903877
## TREG      0.136903877
## CD14      0.323484753
## ABC       0.419930732
## CD4.Naive 0.419930732
## MBC       0.420972299
## CD8.CTL   0.420972299
## PC        0.420972299
## pre-DC    0.420972299
## CDC1      0.420972299
## CD8.Tem   0.423373268
## NK3       0.478727011
## NK1       0.742105062
## NBC       0.830662167
## CD4.Tem   0.872793050
## CD4.Tcm   0.960644316
## PDC       0.960644316
## CD4+CD8+  0.975281678
## NK2       0.975281678
## CDC2      0.975281678
```

We see that the CD8 naive cells are enriched in the young samples, while CD16
cells are enriched in the old samples. We can visualise the significant cell
types to check they make sense:

```
group.immune <- paste(pbmc.sample.info$sex, pbmc.sample.info$age, sep=".")
par(mfrow=c(1,2))
stripchart(as.numeric(pbmc.props["CD8.Naive",])~group.immune,
           vertical=TRUE, pch=c(8,16), method="jitter",
           col = c(ggplotColors(20)[20],"hotpink",4, "darkblue"),cex=2,
           ylab="Proportions", cex.axis=1.25, cex.lab=1.5,
           group.names=c("F.Old","F.Young","M.Old","M.Young"))
title("CD8.Naive: Young Vs Old", cex.main=1.5, adj=0)

stripchart(as.numeric(pbmc.props["CD16",])~group.immune,
           vertical=TRUE, pch=c(8,16), method="jitter",
           col = c(ggplotColors(20)[20],"hotpink",4, "darkblue"),cex=2,
           ylab="Proportions", cex.axis=1.25, cex.lab=1.5,
           group.names=c("F.Old","F.Young","M.Old","M.Young"))
title("CD16: Young Vs Old", cex.main=1.5, adj=0)
```

![](data:image/png;base64...)

# 14 Tips for clustering

The experimental groups are likely to contribute large sources of variation in
the data. In the *[CellBench](https://bioconductor.org/packages/3.22/CellBench)* data the technology effect
is larger than the cell line effect. In order to cluster the data to produce
meaningful cell types that will then feed into meaningful tests for
proportions, the cell types should be represented in as many samples as
possible. Users should consider using integration techniques on their
single cell data prior to clustering, integrating on biological sample or
perhaps experimental group. See methods such as Harmony, Liger and Seurat’s
integration technique for more information.

Cell type label assignment should not be too refined such that every sample has
many unique cell types. The `propeller` function can handle proportions of 0 and
1 without breaking, but it is not very meaningful if every cell type difference
is statistically significant. Consider testing cell type categories that are
broader for more meaningful results, perhaps by combining clusters that are
highly similar. The refined clusters can always be explored in terms of gene
expression differences later on. One can also test for cell type proportion
differences within a broader cell type lineage using `propeller`.

It may be appropriate to perform cell type assignment using classification
methods rather than clustering. This allows
the user to classify cells into known cell types, but you may run the risk of
missing novel cell types.
A combination of approaches may be necessary depending on the dataset.
Good luck. The more heterogenous the dataset, the more tricky this becomes.

# 15 Session Info

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
##  [1] statmod_1.5.1               edgeR_4.8.0
##  [3] patchwork_1.3.2             scater_1.38.0
##  [5] scuttle_1.20.0              ggplot2_4.0.0
##  [7] limma_3.66.0                CellBench_1.26.0
##  [9] tibble_3.3.0                magrittr_2.0.4
## [11] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [13] Biobase_2.70.0              GenomicRanges_1.62.0
## [15] Seqinfo_1.0.0               IRanges_2.44.0
## [17] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [19] generics_0.1.4              MatrixGenerics_1.22.0
## [21] matrixStats_1.5.0           speckle_1.10.0
## [23] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22       splines_4.5.1          later_1.4.4
##   [4] filelock_1.0.3         polyclip_1.10-7        fastDummies_1.7.5
##   [7] lifecycle_1.0.4        httr2_1.2.1            globals_0.18.0
##  [10] lattice_0.22-7         MASS_7.3-65            plotly_4.11.0
##  [13] sass_0.4.10            rmarkdown_2.30         jquerylib_0.1.4
##  [16] yaml_2.3.10            httpuv_1.6.16          otel_0.2.0
##  [19] Seurat_5.3.1           sctransform_0.4.2      spam_2.11-1
##  [22] sp_2.2-0               spatstat.sparse_3.1-0  reticulate_1.44.0
##  [25] cowplot_1.2.0          pbapply_1.7-4          DBI_1.2.3
##  [28] RColorBrewer_1.1-3     lubridate_1.9.4        abind_1.4-8
##  [31] Rtsne_0.17             purrr_1.1.0            rappdirs_0.3.3
##  [34] ggrepel_0.9.6          irlba_2.3.5.1          listenv_0.9.1
##  [37] spatstat.utils_3.2-0   goftest_1.2-3          RSpectra_0.16-2
##  [40] spatstat.random_3.4-2  fitdistrplus_1.2-4     parallelly_1.45.1
##  [43] codetools_0.2-20       DelayedArray_0.36.0    tidyselect_1.2.1
##  [46] farver_2.1.2           viridis_0.6.5          ScaledMatrix_1.18.0
##  [49] BiocFileCache_3.0.0    spatstat.explore_3.5-3 jsonlite_2.0.0
##  [52] BiocNeighbors_2.4.0    progressr_0.17.0       ggridges_0.5.7
##  [55] survival_3.8-3         tools_4.5.1            ica_1.0-3
##  [58] Rcpp_1.1.0             glue_1.8.0             gridExtra_2.3
##  [61] SparseArray_1.10.0     xfun_0.53              dplyr_1.1.4
##  [64] withr_3.0.2            BiocManager_1.30.26    fastmap_1.2.0
##  [67] rsvd_1.0.5             digest_0.6.37          timechange_0.3.0
##  [70] R6_2.6.1               mime_0.13              scattermore_1.2
##  [73] tensor_1.5.1           dichromat_2.0-0.1      spatstat.data_3.1-9
##  [76] RSQLite_2.4.3          tidyr_1.3.1            data.table_1.17.8
##  [79] FNN_1.1.4.1            httr_1.4.7             htmlwidgets_1.6.4
##  [82] S4Arrays_1.10.0        uwot_0.2.3             pkgconfig_2.0.3
##  [85] gtable_0.3.6           blob_1.2.4             lmtest_0.9-40
##  [88] S7_0.2.0               XVector_0.50.0         htmltools_0.5.8.1
##  [91] dotCall64_1.2          bookdown_0.45          SeuratObject_5.2.0
##  [94] scales_1.4.0           png_0.1-8              spatstat.univar_3.1-4
##  [97] knitr_1.50             reshape2_1.4.4         nlme_3.1-168
## [100] curl_7.0.0             cachem_1.1.0           zoo_1.8-14
## [103] stringr_1.5.2          KernSmooth_2.23-26     vipor_0.4.7
## [106] parallel_4.5.1         miniUI_0.1.2           pillar_1.11.1
## [109] grid_4.5.1             vctrs_0.6.5            RANN_2.6.2
## [112] promises_1.4.0         BiocSingular_1.26.0    dbplyr_2.5.1
## [115] beachmat_2.26.0        xtable_1.8-4           cluster_2.1.8.1
## [118] beeswarm_0.4.0         evaluate_1.0.5         magick_2.9.0
## [121] tinytex_0.57           cli_3.6.5              locfit_1.5-9.12
## [124] compiler_4.5.1         rlang_1.1.6            future.apply_1.20.0
## [127] labeling_0.4.3         ggbeeswarm_0.7.2       plyr_1.8.9
## [130] stringi_1.8.7          viridisLite_0.4.2      deldir_2.0-4
## [133] BiocParallel_1.44.0    assertthat_0.2.1       lazyeval_0.2.2
## [136] spatstat.geom_3.6-0    Matrix_1.7-4           RcppHNSW_0.6.0
## [139] bit64_4.6.0-1          future_1.67.0          shiny_1.11.1
## [142] ROCR_1.0-11            igraph_2.2.1           memoise_2.0.1
## [145] bslib_0.9.0            bit_4.6.0
```