# SoupX PBMC Demonstration

#### Matthew Daniel Young

#### 2022-11-01

# Introduction

Before we get started with the specifics of example data sets and
using the R package, it is worth understanding at a broad level what the
problem this package aims to solve is and how it goes about doing it. Of
course, the best way of doing this is by [reading the
pre-print](https://www.biorxiv.org/content/10.1101/303727v1), it’s not long I promise. But if you can’t be bothered
doing that or just want a refresher, I’ll try and recap the main
points.

In droplet based, single cell RNA-seq experiments, there is always a
certain amount of background mRNAs present in the dilution that gets
distributed into the droplets with cells and sequenced along with them.
The net effect of this is to produce a background contamination that
represents expression not from the cell contained within a droplet, but
the solution that contained the cells.

This collection of cell free mRNAs floating in the input solution
(henceforth referred to as “the soup”) is created from cells in the
input solution being lysed. Because of this, the soup looks different
for each input solution and strongly resembles the expression pattern
obtained by summing all the individual cells.

The aim of this package is to provide a way to estimate the
composition of this soup, what fraction of UMIs are derived from the
soup in each droplet and produce a corrected count table with the soup
based expression removed.

The method to do this consists of three parts:

1. Calculate the profile of the soup.
2. Estimate the cell specific contamination fraction.
3. Infer a corrected expression matrix.

In previous versions of SoupX, the estimation of the contamination
fraction (step 2) was the part that caused the most difficulty for the
user. The contamination fraction is parametrised as `rho` in
the code, with `rho=0` meaning no contamination and
`rho=1` meaning 100% of UMIs in a droplet are soup.

From version 1.3.0 onwards, an automated routine for estimating the
contamination fraction is provided, which should be suitable is most
circumstances. However, this vignette will still spend a lot of effort
explaining how to calculate the contamination fraction “manually”. This
is because there are still circumstances where manually estimating
`rho` is preferable or the only option and it is important to
understanding how the method works and how it can fail.

While it is possible to run SoupX without clustering information, you
will get far better results if some basic clustering is provided.
Therefore, it is **strongly** recommended that you provide
some clustering information to SoupX. If you are using 10X data mapped
with cellranger, the default clustering produced by cellranger is
automatically loaded and used. The results are not strongly sensitive to
the clustering used. Seurat with default parameters will also yield
similar results.

# Quickstart

If you have some 10X data which has been mapped with cellranger, the
typical SoupX work flow would be.

```
install.packages("SoupX")
library(SoupX)
# Load data and estimate soup profile
sc = load10X("Path/to/cellranger/outs/folder/")
# Estimate rho
sc = autoEstCont(sc)
# Clean the data
out = adjustCounts(sc)
```

which would produce a new matrix that has had the contaminating reads
removed. This can then be used in any downstream analysis in place of
the original matrix. Note that by default `adjustCounts` will
return non-integer counts. If you require integers for downstream
processing either pass out through `round` or set
`roundToInt=TRUE` when running `adjustCounts`.

# Getting started

You install this package like any other R package. The simplest way
is to use the CRAN version by running,

```
install.packages("SoupX")
```

If you want to use the latest experimental features, you can install
the development version from github using the [devtools](https://devtools.r-lib.org/)
`install_github` function as follows:

```
devtools::install_github("constantAmateur/SoupX", ref = "devel")
```

Once installed, you can load the package in the usual way,

```
library(SoupX)
```

```
## This version of 'bslib' is designed to work with 'shiny' >= 1.6.0.
##     Please upgrade via install.packages('shiny').
```

# PBMC dataset

Like every other single cell tool out there, we are going to use one
of the 10X PBMC data sets to demonstrate how to use this package.
Specifically, we will use this [PBMC
dataset](https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/pbmc4k). The starting point is to download the [raw](https://cf.10xgenomics.com/samples/cell-exp/2.1.0/pbmc4k/pbmc4k_raw_gene_bc_matrices.tar.gz)
and [filtered](https://cf.10xgenomics.com/samples/cell-exp/2.1.0/pbmc4k/pbmc4k_filtered_gene_bc_matrices.tar.gz)
cellranger output and extract them to a temporary folder as follows.

```
tmpDir = tempdir(check = TRUE)
download.file("https://cf.10xgenomics.com/samples/cell-exp/2.1.0/pbmc4k/pbmc4k_raw_gene_bc_matrices.tar.gz",
    destfile = file.path(tmpDir, "tod.tar.gz"))
download.file("https://cf.10xgenomics.com/samples/cell-exp/2.1.0/pbmc4k/pbmc4k_filtered_gene_bc_matrices.tar.gz",
    destfile = file.path(tmpDir, "toc.tar.gz"))
untar(file.path(tmpDir, "tod.tar.gz"), exdir = tmpDir)
untar(file.path(tmpDir, "toc.tar.gz"), exdir = tmpDir)
```

## Loading the data

SoupX comes with a convenience function for loading 10X data
processed using cellranger. If you downloaded the data as above you can
use it to get started by running,

```
sc = load10X(tmpDir)
```

This will load the 10X data into a `SoupChannel` object.
This is just a list with some special properties, storing all the
information associated with a single 10X channel. A
`SoupChannel` object can also be created manually by
supplying a table of droplets and a table of counts. Assuming you have
followed the above code to download the PBMC data, you could manually
construct a `SoupChannel` by running,

```
toc = Seurat::Read10X(file.path(tmpDir, "filtered_gene_bc_matrices", "GRCh38"))
tod = Seurat::Read10X(file.path(tmpDir, "raw_gene_bc_matrices", "GRCh38"))
sc = SoupChannel(tod, toc)
```

To avoid downloading or including large data files, this vignette
will use a pre-loaded and processed object `PBMC_sc`.

```
data(PBMC_sc)
sc = PBMC_sc
sc
```

```
## Channel with 33694 genes and 2170 cells
```

## Profiling the soup

Having loaded our data, the first thing to do is to estimate what the
expression profile of the soup looks like. This is actually done for us
automatically by the object construction function
`SoupChannel` called by `load10X`. Usually, the
default estimation is fine, but it can be done explicitly by setting
`calcSoupProfile=FALSE` as follows

```
sc = SoupChannel(tod, toc, calcSoupProfile = FALSE)
sc = estimateSoup(sc)
```

Note that we cannot perform this operation using our pre-saved
`PBMC_sc` data as the table of droplets is dropped once the
soup profile has been generated to save memory. Generally, we don’t need
the full table of droplets once we have determined what the soup looks
like.

Usually the only reason to not have `estimateSoup` run
automatically is if you want to change the default parameters or have
some other way of calculating the soup profile. One case where you may
want to do the latter is if you only have the table of counts available
and not the empty droplets. In this case you can proceed by running

```
library(Matrix)
toc = sc$toc
scNoDrops = SoupChannel(toc, toc, calcSoupProfile = FALSE)
# Calculate soup profile
soupProf = data.frame(row.names = rownames(toc), est = rowSums(toc)/sum(toc), counts = rowSums(toc))
scNoDrops = setSoupProfile(scNoDrops, soupProf)
```

In this case the `setSoupProfile` command is used instead
of `estimateSoup` and directly adds the custom estimation of
the soup profile to the `SoupChannel` object. Note that we
have loaded the `Matrix` library to help us manipulate the
sparse matrix `toc`.

## Adding extra meta data to the SoupChannel object

We have some extra meta data that it is essential we include in our
`SoupChannel` object. In general you can add any meta data by
providing a `data.frame` with row names equal to the column
names of the `toc` when building the `SoupChannel`
object.

However, there are some bits of meta data that are so essential that
they have their own special loading functions. The most essential is
clustering information. Without it, SoupX will still work, but you won’t
be able to automatically estimate the contamination fraction and the
correction step will be far less effective. Metadata associated with our
PBMC dataset is also bundled with SoupX. We can use it to add clustering
data by running,

```
data(PBMC_metaData)
sc = setClusters(sc, setNames(PBMC_metaData$Cluster, rownames(PBMC_metaData)))
```

It can also be very useful to be able to visualise our data by
providing some kind of dimension reduction for the data. We can do this
by running,

```
sc = setDR(sc, PBMC_metaData[colnames(sc$toc), c("RD1", "RD2")])
```

This is usually not needed when using the `load10X`
function as the cellranger produced values are automatically loaded.

## Visual sanity checks

It is often the case that really what you want is to get a rough
sense of whether the expression of a gene (or group of genes) in a set
of cells is derived from the soup or not. At this stage we already have
enough information to do just this. Before proceeding, we will briefly
discuss how to do this.

Let’s start by getting a general overview of our PBMC data by
plotting it with the provided annotation.

```
library(ggplot2)
dd = PBMC_metaData[colnames(sc$toc), ]
mids = aggregate(cbind(RD1, RD2) ~ Annotation, data = dd, FUN = mean)
gg = ggplot(dd, aes(RD1, RD2)) + geom_point(aes(colour = Annotation), size = 0.2) +
    geom_label(data = mids, aes(label = Annotation)) + ggtitle("PBMC 4k Annotation") +
    guides(colour = guide_legend(override.aes = list(size = 1)))
plot(gg)
```

![](data:image/png;base64...)

SoupX does not have any of its own functions for generating tSNE (or
any other reduced dimension) co-ordinates, so it is up to us to generate
them using something else. In this case I have run [Seurat](https://satijalab.org/seurat/) in a standard way and
produced a tSNE map of the data (see `?PBMC`).

Suppose that we are interested in the expression of the gene
*IGKC*, a key component immunoglobulins (i.e., antibodies) highly
expressed by B-cells. We can quickly visualise which cells express
*IGKC* by extracting the counts for it from the
`SoupChannel` object.

```
dd$IGKC = sc$toc["IGKC", ]
gg = ggplot(dd, aes(RD1, RD2)) + geom_point(aes(colour = IGKC > 0))
plot(gg)
```

![](data:image/png;base64...)

Wow! We know from prior annotation that the cells in the cluster at
the bottom are B-cells so should express *IGKC*. But the cluster
on the right is a T-cell population. Taken at face value, we appear to
have identified a scattered population of T-cells that are producing
antibodies! Start preparing the nature paper!

Before we get too carried away though, perhaps it’s worth checking if
the expression of *IGKC* in these scattered cells is more than we
would expect by chance from the soup. To really answer this properly, we
need to know how much contamination is present in each cell, which will
be the focus of the next sections. But we can get a rough idea just by
calculating how many counts we would expect for *IGKC* in each
cell, by assuming that cell contained nothing but soup. The function
`soupMarkerMap` allows you to visualise the ratio of observed
counts for a gene (or set of genes) to this expectation value. Let’s try
it out,

```
gg = plotMarkerMap(sc, "IGKC")
plot(gg)
```

![](data:image/png;base64...)

There is no need to pass the tSNE coordinates to this function as we
stored them in the `sc` object when we ran `setDR`
above. Looking at the resulting plot, we see that the cells in the
B-cell cluster have a reddish colour, indicating that they are expressed
far more than we would expect by chance, even if the cell was nothing
but background. Our paradigm changing, antibody producing T-cells do not
fare so well. They all have a decidedly bluish hue, indicating that is
completely plausible that the expression of *IGKC* in these cells
is due to contamination from the soup. Those cells that are shown as
dots have zero expression for *IGKC*.

We have made these plots assuming each droplet contains nothing but
background contamination, which is obviously not true. Nevertheless,
this can still be a useful quick and easy sanity check to perform.

## Estimating the contamination fraction

Probably the most difficult part of using SoupX is accurately
estimating the level of background contamination (represented as
`rho`) in each channel. There are two ways to do this: using
the automatic `autoEstCont` method, or manually providing a
list of “non expressed genes”. This vignette will demonstrate both
methods, but we anticipate that the automatic method will be used in
most circumstances. Before that we will describe the idea that underpins
both approaches; identifying genes that are not expressed by some cells
in our data and the expression that we observe for these genes in these
cells must be due to contamination.

This is the most challenging part of the method to understand and we
have included a lot of detail here. But successfully applying SoupX does
not depend on understanding all these details. The key thing to
understand is that the contamination fraction estimate is the fraction
of your data that will be discarded. If this value is set too low, your
“corrected” data will potentially still be highly contaminated. If you
set it too high, you will discard real data, although there are good
reasons to want to do this at times (see section below). If the
contamination fraction is in the right ball park, SoupX will remove most
of the contamination. It will generally not matter if this number if off
by a few percent.

Note that all modes of determining the contamination fraction add an
entry titled `fit` to the `SoupChannel` object
which contains details of how the final estimate was reached.

### Manually specifying the contamination fraction

It is worth considering simply manually fixing the contamination
fraction at a certain value. This seems like a bad thing to do
intuitively, but there are actually good reasons you might want to. When
the contamination fraction is set too high, true expression will be
removed from your data. However, this is done in such a way that the
counts that are most specific to a subset of cells (i.e., good marker
genes) will be the absolute last thing to be removed. Because of this,
it can be a sensible thing to set a high contamination fraction for a
set of experiments and be confident that the vast majority of the
contamination has been removed.

Even when you have a good estimate of the contamination fraction, you
may want to set the value used artificially higher. SoupX