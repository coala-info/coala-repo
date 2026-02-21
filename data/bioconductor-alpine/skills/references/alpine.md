# Modeling and correcting fragment sequence bias

##

###

# Modeling and correcting fragment sequence bias

Here we show a brief example of using the *alpine* package to model
bias parameters and then using those parameters to estimate transcript
abundance. We load a metadata table and a subset of reads from four
samples from the GEUVADIS project. For more details on these files,
see `?alpineData` in the *alpineData* package.

```
library(alpineData)
```

```
## Warning: Package 'alpineData' is deprecated and will be removed from
##   Bioconductor version 3.18
```

```
dir <- system.file("extdata",package="alpineData")
metadata <- read.csv(file.path(dir,"metadata.csv"),
                     stringsAsFactors=FALSE)
metadata[,c("Title","Performer","Date","Population")]
```

```
##       Title Performer   Date Population
## 1 ERR188297     UNIGE 111124        TSI
## 2 ERR188088     UNIGE 111124        TSI
## 3 ERR188204  CNAG_CRG 111215        TSI
## 4 ERR188317  CNAG_CRG 111215        TSI
```

A subset of the reads from one of the samples:

```
library(GenomicAlignments)
ERR188297()
```

```
## GAlignmentPairs object with 25531 pairs, strandMode=1, and 0 metadata columns:
##           seqnames strand   :              ranges  --              ranges
##              <Rle>  <Rle>   :           <IRanges>  --           <IRanges>
##       [1]        1      +   : 108560389-108560463  -- 108560454-108560528
##       [2]        1      -   : 108560454-108560528  -- 108560383-108560457
##       [3]        1      +   : 108560534-108600608  -- 108600626-108606236
##       [4]        1      -   : 108569920-108569994  -- 108569825-108569899
##       [5]        1      -   : 108587954-108588028  -- 108587881-108587955
##       ...      ...    ... ...                 ... ...                 ...
##   [25527]        X      +   : 119790596-119790670  -- 119790717-119790791
##   [25528]        X      +   : 119790988-119791062  -- 119791086-119791160
##   [25529]        X      +   : 119791037-119791111  -- 119791142-119791216
##   [25530]        X      +   : 119791348-119791422  -- 119791475-119791549
##   [25531]        X      +   : 119791376-119791450  -- 119791481-119791555
##   -------
##   seqinfo: 194 sequences from an unspecified genome
```

Before we start, we need to write these paired-end reads, here stored
in a R/Bioconductor data object, out to a BAM file, because the *alpine*
software works with alignments stored as BAM files. *This is
not a typical step*, as you would normally have BAM files already on
disk. We write out four BAM files for each of the four samples
contained in *alpineData*. So you can ignore the following code chunk
if you are working with your own BAM files.

```
library(rtracklayer)
dir <- tempdir()
for (sample.name in metadata$Title) {
  # the reads are accessed with functions named
  # after the sample name. the following line calls
  # the function with the sample name and saves
  # the reads to `gap`
  gap <- match.fun(sample.name)()
  file.name <- file.path(dir,paste0(sample.name,".bam"))
  export(gap, con=file.name)
}
bam.files <- file.path(dir, paste0(metadata$Title, ".bam"))
names(bam.files) <- metadata$Title
stopifnot(all(file.exists(bam.files)))
```

Now we continue with the typical steps in an *alpine* workflow.
To fit the bias model, we need to identify single-isoform genes.
We used the following chunk of code (here not evaluated) to generate a
*GRangesList* of exons per single-isoform gene.

```
library(ensembldb)
gtf.file <- "Homo_sapiens.GRCh38.84.gtf"
txdb <- EnsDb(gtf.file) # already an EnsDb
txdf <- transcripts(txdb, return.type="DataFrame")
tab <- table(txdf$gene_id)
one.iso.genes <- names(tab)[tab == 1]
# pre-selected genes based on medium to high counts
# calculated using Rsubread::featureCounts
selected.genes <- scan("selected.genes.txt", what="char")
one.iso.txs <- txdf$tx_id[txdf$gene_id %in%
                          intersect(one.iso.genes, selected.genes)]
ebt0 <- exonsBy(txdb, by="tx")
ebt.fit <- ebt0[one.iso.txs]
```

Here we pick a subset of single-isoform genes based on the
number of exons, and the length. We show in comments the recommended
parameters to use in selecting this subset of genes,
although here we use different parameters to ensure the building of
the vignette takes only a short period of time and does not use much memory.

```
library(GenomicRanges)
```

```
library(alpine)
```

```
## Warning: Package 'alpine' is deprecated and will be removed from Bioconductor
##   version 3.18
```

```
data(preprocessedData)
# filter small genes and long genes
min.bp <- 600
max.bp <- 7000
gene.lengths <- sum(width(ebt.fit))
summary(gene.lengths)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##    66.0   689.8  1585.0  2147.0  3352.5  6103.0
```

```
ebt.fit <- ebt.fit[gene.lengths > min.bp & gene.lengths < max.bp]
length(ebt.fit)
```

```
## [1] 25
```

```
set.seed(1)
# better to use ~100 genes
ebt.fit <- ebt.fit[sample(length(ebt.fit),10)]
```

## Defining a set of fragment types

Robust fitting of these bias parameters is best with ~100 medium to
high count genes, e.g. mean count across samples between 200 and
10,000. These counts can be identified by *featureCounts* from the
*Rsubread* Bioconductor package, for example.
It is required to specify a minimum and maximum fragment size
which should be lower and upper quantiles of the fragment length
distribution. The `minsize` and `maxsize`
arguments are recommended to be roughly the 2.5% and 97.5% of the
fragment length distribution. This can be quickly estimated using the
helper function *getFragmentWidths*, iterating over a few
single-isoform genes with sufficient counts:

```
w <- getFragmentWidths(bam.files[1], ebt.fit[[1]])
c(summary(w), Number=length(w))
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.   Number
## 105.0000 154.0000 179.0000 192.7765 220.0000 357.0000  85.0000
```

```
quantile(w, c(.025, .975))
```

```
##  2.5% 97.5%
## 125.1 351.2
```

It is also required to specify the read length. Currently *alpine*
only supports unstranded, paired-end RNA-seq with fixed read
length. Differences of +/- 1 bp in read length across samples can be
ignored.

```
getReadLength(bam.files)
```

```
## ERR188297 ERR188088 ERR188204 ERR188317
##        75        75        76        76
```

Here we use a very limited range of fragment lengths for speed, but
for a real analysis we would suggest using the minimum and maximum
of the quantiles computed above across all samples (the minimum of the
lower quantiles and the maximum of the upper quantiles).

```
library(alpine)
library(BSgenome.Hsapiens.NCBI.GRCh38)
readlength <- 75
minsize <- 125 # better 80 for this data
maxsize <- 175 # better 350 for this data
gene.names <- names(ebt.fit)
names(gene.names) <- gene.names
```

The following function builds a list of *DataFrames* which store
information about the fragment types from each gene in our
training set.

```
system.time({
fragtypes <- lapply(gene.names, function(gene.name) {
                      buildFragtypes(exons=ebt.fit[[gene.name]],
                                     genome=Hsapiens,
                                     readlength=readlength,
                                     minsize=minsize,
                                     maxsize=maxsize,
                                     gc.str=FALSE)
                    })
})
```

```
##    user  system elapsed
##  15.288   1.716  17.020
```

```
print(object.size(fragtypes), units="auto")
```

```
## 110.3 Mb
```

We can examine the information for a single gene:

```
head(fragtypes[[1]], 3)
```

```
## DataFrame with 3 rows and 14 columns
##       start       end    relpos   fraglen        id fivep.test          fivep
##   <integer> <integer> <numeric> <integer> <IRanges>  <logical> <DNAStringSet>
## 1         1       125 0.0405405       125     1-125      FALSE  GTCCATACACAGA
## 2         1       126 0.0405405       126     1-126      FALSE  GTCCATACACAGA
## 3         1       127 0.0411840       127     1-127      FALSE  GTCCATACACAGA
##   threep.test                threep        gc    gstart      gend gread1end
##     <logical>        <DNAStringSet> <numeric> <integer> <integer> <integer>
## 1        TRUE CAAGTCCAGAAATCTACAACC  0.424000 187368332 187368456 187368406
## 2        TRUE CCAAGTCCAGAAATCTACAAC  0.420635 187368332 187368457 187368406
## 3        TRUE CCCAAGTCCAGAAATCTACAA  0.425197 187368332 187368458 187368406
##   gread2start
##     <integer>
## 1   187368382
## 2   187368383
## 3   187368384
```

## Defining and fitting bias models

The definition of bias models is extremely flexible in *alpine*. The
`models` argument should be given as a list, where each element is
model. The model itself should be provided as a list with elements
`formula` and `offset`. Either `formula` or `offset` can be set to
`NULL` for a given model.
The allowable offsets are `fraglen` and/or `vlmm` which should be
provided in a character vector.
Offsets are only estimated once for all models, so setting
`formula=NULL` only makes sense if extra offsets are desired
which were not already calculated by other models.

Any kind of R formula can be provided to `formula`, making use of the
fragment features:

* `gc` (fragment GC content from 0 to 1)
* `relpos` (fragment midpoint relative position from 0 to 1)
* `GC40.80`, `GC40.90`, `GC20.80`, `GC20.90` (indicator variables
  indicating the presence of, e.g. a 40 bp stretch of 80% or higher GC
  content within the fragment)

These fragment features reference columns of information stored in
`fragtypes`. Interactions between these terms and offsets are also
possible, e.g. `gc:fraglen`.

**Note:** It is required to provide formula as
character strings, which are converted internally into formula, due to
details in how R formula make copies of objects from the environment.

```
models <- list(
  "GC" = list(
    formula = "count ~ ns(gc,knots=gc.knots,Boundary.knots=gc.bk) + ns(relpos,knots=relpos.knots,Boundary.knots=relpos.bk) + gene",
    offset=c("fraglen")
  ),
  "all" = list(
    formula = "count ~ ns(gc,knots=gc.knots,Boundary.knots=gc.bk) + ns(relpos,knots=relpos.knots,Boundary.knots=relpos.bk) + gene",
    offset=c("fraglen","vlmm")
  )
)
```

Here we fit one bias model, `GC`, using fragment length, fragment GC
content, relative position, and a term for differences in expression
across the genes (`+ gene`).

We fit another bias model, `all`, with all the terms of the first but
additionally with read start bias (encoded by a Variable Length Markov
Model, or VLMM).

**Note:** It is required if a formula is provided that it end with `+ gene` to account for differences in base expression levels while
fitting the bias parameters.

The knots and boundary knots for GC content (`gc`) and relative
position (`relpos`) splines have reasonable default values, but they
can be customized using arguments to the *fitBiasModels* function.

The returned object, `fitpar`, stores the information as a list of
fitted parameters across samples.

```
system.time({
fitpar <- lapply(bam.files, function(bf) {
                   fitBiasModels(genes=ebt.fit,
                                 bam.file=bf,
                                 fragtypes=fragtypes,
                                 genome=Hsapiens,
                                 models=models,
                                 readlength=readlength,
                                 minsize=minsize,
                                 maxsize=maxsize)
                 })
})
```

```
## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
```

```
##    user  system elapsed
##  60.275   3.356  63.633
```

```
# this object saved was 'fitpar.small' for examples in alpine man pages
# fitpar.small <- fitpar
```

## Visually exploring the bias parameters

Note that with more basepairs between `minsize` and `maxsize` and with
more genes used for estimation, the bias parameters would be more
precise. As estimated here, the curves look a bit wobbly. Compare to
the curves that are fit in the *alpine* paper (see `citation("alpine")`).
The estimated spline coefficients have high variance from too few
observations (paired-end fragments) across too few genes.

First we set a palette to distinguish between samples

```
library(RColorBrewer)
palette(brewer.pal(8,"Dark2"))
```

The fragment length distribution:

```
perf <- as.integer(factor(metadata$Performer))
plotFragLen(fitpar, col=perf)
```

![plot of chunk fraglen](data:image/png;base64...)

The fragment GC bias curves:

```
plotGC(fitpar, model="all", col=perf)
```

![plot of chunk gccurve](data:image/png;base64...)

The relative position curves:

```
plotRelPos(fitpar, model="all", col=perf)
```

![plot of chunk relpos](data:image/png;base64...)

A 0-order version of the VLMM (note that the VLMM that is used in the
model includes positions that are 1- and 2-order, so this plot does
not represent the final VLMM used in bias estimation or in estimation
of abundances).

```
plotOrder0(fitpar[["ERR188297"]][["vlmm.fivep"]][["order0"]])
```

![plot of chunk vlmm](data:image/png;base64...)

```
plotOrder0(fitpar[["ERR188297"]][["vlmm.threep"]][["order0"]])
```

![plot of chunk vlmm](data:image/png;base64...)

A coefficient table for the terms in `formula`:

```
print(head(fitpar[["ERR188297"]][["summary"]][["all"]]), row.names=FALSE)
```

```
##    Estimate Std. Error    z value     Pr(>|z|)
##  -8.0392253  1.4287075 -5.6269215 1.834541e-08
##   3.0528291  1.3758104  2.2189315 2.649139e-02
##   2.3036411  0.9614427  2.3960255 1.657394e-02
##   2.3202070  2.8075134  0.8264277 4.085615e-01
##  -8.4460516  2.4108983 -3.5032799 4.595662e-04
##   0.8173695  0.1801123  4.5381109 5.676042e-06
```

## Estimating transcript abundances

We pick a subset of genes for estimating transcript abundances. If
the gene annotation includes genes with transcripts which span
multiple chromosomes or which do not have any overlap and are very far
apart, *splitGenesAcrossChroms* and *splitLongGenes*, respectively,
can be used to split these. For again merging any overlapping
transcripts into “genes”, the *mergeGenes* function can be used. Here
we use the ENSEMBL gene annotation as is.

The following code chunk is not evaluated but was used to select
a few genes for demonstrating *estimateAbundance*:

```
one.iso.genes <- intersect(names(tab)[tab == 1], selected.genes)
two.iso.genes <- intersect(names(tab)[tab == 2], selected.genes)
three.iso.genes <- intersect(names(tab)[tab == 3], selected.genes)
set.seed(1)
genes.theta <- c(sample(one.iso.genes, 2),
                 sample(two.iso.genes, 2),
                 sample(three.iso.genes, 2))
txdf.theta <- txdf[txdf$gene_id %in% genes.theta,]
ebt.theta <- ebt0[txdf.theta$tx_id]
```

Next we specify the set of models we want to use, referring back by
name to the models that were fit in the previous step. Additionally,
we can include any of the following models: `null`, `fraglen`, `vlmm`,
or `fraglen.vlmm` which are the four models that can be fit using only
offsets (none, either or both of the offsets).

```
model.names <- c("null","fraglen.vlmm","GC")
```

Here we estimate FPKM-scale abundances for multiple genes and multiple
samples. If `lib.sizes` is not specified, a default value of 1e6
is used. *estimateAbundance* works one gene at a time, where the
`transcripts` argument expects a *GRangesList* of the exons for each
transcript (multiple if the gene has multiple isoforms).

```
system.time({
res <- lapply(genes.theta, function(gene.name) {
         txs <- txdf.theta$tx_id[txdf.theta$gene_id == gene.name]
         estimateAbundance(transcripts=ebt.theta[txs],
                           bam.files=bam.files,
                           fitpar=fitpar,
                           genome=Hsapiens,
                           model.names=model.names)
       })
})
```

```
## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
```

```
##    user  system elapsed
##  68.725   1.881  70.609
```

Each element of this list has the abundances (`theta`) and average
bias (`lambda`) for a single gene across all samples, all models, and all
isoforms of the gene:

```
res[[1]][["ERR188297"]][["GC"]]
```

```
## $theta
## ENST00000259030
##       0.1391081
##
## $lambda
## ENST00000259030
##        180.5817
```

```
res[[6]][["ERR188297"]][["GC"]]
```

```
## $theta
## ENST00000477403 ENST00000468844 ENST00000361575
##     2.672585887     0.003433643     1.505349764
##
## $lambda
## ENST00000477403 ENST00000468844 ENST00000361575
##        197.9365        179.7152        194.5621
```

The *extractAlpine* function can be used to collate estimates from
across all genes. *extractAlpine* will scale the estimates such that
the total bias observed over all transcripts is centered at 1. The
estimates produce by *estimateAbundance* presume a default library size of
1e6, but will be rescaled using the total number of fragments across
genes when using *extractAlpine* (if this library size rescaling is
not desired, choose `divide.out=FALSE`).

```
mat <- extractAlpine(res, model="GC")
mat
```

```
##                    ERR188297   ERR188088   ERR188204    ERR188317
## ENST00000259030 5.704452e+03  18378.4952  10299.9466 1.285493e+04
## ENST00000304788 4.776647e+03   6175.9163   8685.6395 7.801971e+03
## ENST00000295025 1.491921e+04  10656.4726  19468.9189 1.613049e+04
## ENST00000394479 5.985733e+03   1526.6587   8665.0830 4.420286e+03
## ENST00000330871 1.234001e+04  28592.3208   9371.2926 1.068433e+04
## ENST00000587578 0.000000e+00      0.0000      0.0000 0.000000e+00
## ENST00000264254 3.702044e+04  50025.8993  53897.6927 6.125760e+04
## ENST00000416255 1.798118e+03   5465.0089   4544.2589 2.019189e+03
## ENST00000450127 2.241558e-32   1559.6821    491.1888 6.773453e-31
## ENST00000477403 1.095956e+05 118849.8546 241663.0463 1.602984e+05
## ENST00000468844 1.408046e+02    663.3915   1171.7669 1.169378e+03
## ENST00000361575 6.173038e+04  62695.2889  90782.3104 1.860873e+05
```

If we provide a *GRangesList* which contains the exons for each
transcript, the returned object will be a *SummarizedExperiment*.
The *GRangesList* provided to `transcripts` does not have to be in the
correct order, the transcripts will be extracted by name to match the
rows of the FPKM matrix.

```
se <- extractAlpine(res, model="GC", transcripts=ebt.theta)
se
```

```
## class: RangedSummarizedExperiment
## dim: 12 4
## metadata(0):
## assays(1): FPKM
## rownames(12): ENST00000259030 ENST00000304788 ... ENST00000468844
##   ENST00000361575
## rowData names(0):
## colnames(4): ERR188297 ERR188088 ERR188204 ERR188317
## colData names(0):
```

The matrix of FPKM values can be scaled using the median ratio method
of DESeq with the *normalizeDESeq* function. This is a robust method
which removes systematic differences in values across samples, and is
more appropriate than using the total count which is sensitive to
very large abundance estimates for a minority of transcripts.

```
norm.mat <- normalizeDESeq(mat, cutoff=0.1)
```

## Simulating RNA-seq data with empirical GC bias

The fragment GC bias which *alpine* estimates can be used in
downstream simulations, for example in the
[polyester](http://bioconductor.org/packages/polyester) Bioconductor
package. All we need to do is to run the *plotGC* function, but
specifying that instead of a plot, we want to return a matrix of
probabilities for each percentile of fragment GC content. This matrix
can be provided to the `frag_GC_bias` argument of *simulate\_experiment*.

We load a `fitpar` object that was run with the fragment length range
[80,350] bp.

```
data(preprocessedData)
prob.mat <- plotGC(fitpar, "all", return.type=2)
head(prob.mat)
```

```
##       ERR188297 ERR188088  ERR188204  ERR188317
## 0    0.04366855 0.2561645 0.06914584 0.07234787
## 0.01 0.04936226 0.2725952 0.07667866 0.08005226
## 0.02 0.05578805 0.2900464 0.08501986 0.08856473
## 0.03 0.06302707 0.3085437 0.09424127 0.09795502
## 0.04 0.07116603 0.3281071 0.10441771 0.10829555
## 0.05 0.08029675 0.3487502 0.11562636 0.11966079
```

If `return.type=0` (the default) the function makes the plot of log
fragment rate over fragment GC content. If `return.type=1` the
function returns the matrix of log fragment rate over percentiles of
fragment GC content, and if `return.type=2`, the matrix returns
probabilities of observing fragments based on percentiles of fragment
GC content (the log fragment rate exponentiated and scaled to have a
maximum of 1). The matrix returned by `return.type=2` is appropriate
for downstream use with *polyester*.

## Plotting predicted fragment coverage

In the *alpine* paper, it was shown that models incorporating fragment
GC bias can be a better predictor of test set RNA-seq fragment
coverage, compared to models incorporating read start bias. Here we
show how to predict fragment coverage for a single-isoform gene using
a variety of fitted bias models. As with *estimateAbundace*, the
model names need to refer back to models fit using *fitBiasModels*.

```
model.names <- c("fraglen","fraglen.vlmm","GC","all")
```

The following function computes the predicted coverage for one
single-isoform gene. We load a `fitpar` object that was run
with the fragment length range [80,350] bp.

```
fitpar[[1]][["model.params"]][c("minsize","maxsize")]
```

```
## $minsize
## [1] 80
##
## $maxsize
## [1] 350
```

```
system.time({
  pred.cov <- predictCoverage(gene=ebt.fit[["ENST00000245479"]],
                              bam.files=bam.files["ERR188204"],
                              fitpar=fitpar,
                              genome=Hsapiens,
                              model.names=model.names)
})
```

```
## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored

## Warning in .local(x, row.names, optional, ...): 'optional' argument was ignored
```

```
##    user  system elapsed
##  20.462   1.460  21.922
```

We can plot the observed and predicted coverage for one of the
genes:

```
palette(brewer.pal(9, "Set1"))
frag.cov <- pred.cov[["ERR188204"]][["frag.cov"]]
plot(frag.cov, type="l", lwd=3, ylim=c(0,max(frag.cov)*1.5))
for (i in seq_along(model.names)) {
  m <- model.names[i]
  pred <- pred.cov[["ERR188204"]][["pred.cov"]][[m]]
  lines(pred, col=i, lwd=3)
}
legend("topright", legend=c("observed",model.names),
       col=c("black",seq_along(model.names)), lwd=3)
```

![plot of chunk unnamed-chunk-24](data:image/png;base64...)

## Session information

```
sessionInfo()
```

```
## R version 4.3.0 RC (2023-04-13 r84269)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 22.04.2 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.17-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
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
##  [1] RColorBrewer_1.1-3
##  [2] BSgenome.Hsapiens.NCBI.GRCh38_1.3.1000
##  [3] BSgenome_1.68.0
##  [4] alpine_1.26.0
##  [5] rtracklayer_1.60.0
##  [6] alpineData_1.26.0
##  [7] GenomicAlignments_1.36.0
##  [8] Rsamtools_2.16.0
##  [9] Biostrings_2.68.0
## [10] XVector_0.40.0
## [11] SummarizedExperiment_1.30.1
## [12] Biobase_2.60.0
## [13] MatrixGenerics_1.12.0
## [14] matrixStats_0.63.0
## [15] GenomicRanges_1.52.0
## [16] GenomeInfoDb_1.36.0
## [17] IRanges_2.34.0
## [18] S4Vectors_0.38.1
## [19] ExperimentHub_2.8.0
## [20] AnnotationHub_3.8.0
## [21] BiocFileCache_2.8.0
## [22] dbplyr_2.3.2
## [23] BiocGenerics_0.46.0
## [24] knitr_1.42
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.0              dplyr_1.1.2
##  [3] blob_1.2.4                    filelock_1.0.2
##  [5] bitops_1.0-7                  fastmap_1.1.1
##  [7] RCurl_1.98-1.12               promises_1.2.0.1
##  [9] XML_3.99-0.14                 digest_0.6.31
## [11] mime_0.12                     lifecycle_1.0.3
## [13] ellipsis_0.3.2                KEGGREST_1.40.0
## [15] interactiveDisplayBase_1.38.0 RSQLite_2.3.1
## [17] magrittr_2.0.3                compiler_4.3.0
## [19] progress_1.2.2                rlang_1.1.1
## [21] tools_4.3.0                   utf8_1.2.3
## [23] yaml_2.3.7                    prettyunits_1.1.1
## [25] S4Arrays_1.0.1                bit_4.0.5
## [27] curl_5.0.0                    DelayedArray_0.26.2
## [29] xml2_1.3.4                    BiocParallel_1.34.1
## [31] withr_2.5.0                   purrr_1.0.1
## [33] grid_4.3.0                    fansi_1.0.4
## [35] xtable_1.8-4                  MASS_7.3-60
## [37] biomaRt_2.56.0                cli_3.6.1
## [39] crayon_1.5.2                  generics_0.1.3
## [41] biglm_0.9-2.1                 httr_1.4.5
## [43] rjson_0.2.21                  DBI_1.1.3
## [45] cachem_1.0.8                  stringr_1.5.0
## [47] splines_4.3.0                 zlibbioc_1.46.0
## [49] parallel_4.3.0                AnnotationDbi_1.62.1
## [51] BiocManager_1.30.20           restfulr_0.0.15
## [53] vctrs_0.6.2                   Matrix_1.5-4
## [55] hms_1.1.3                     RBGL_1.76.0
## [57] bit64_4.0.5                   GenomicFeatures_1.52.0
## [59] speedglm_0.3-5                glue_1.6.2
## [61] codetools_0.2-19              stringi_1.7.12
## [63] BiocVersion_3.17.1            later_1.3.1
## [65] BiocIO_1.10.0                 tibble_3.2.1
## [67] pillar_1.9.0                  rappdirs_0.3.3
## [69] htmltools_0.5.5               graph_1.78.0
## [71] GenomeInfoDbData_1.2.10       R6_2.5.1
## [73] evaluate_0.21                 shiny_1.7.4
## [75] lattice_0.21-8                highr_0.10
## [77] png_0.1-8                     memoise_2.0.1
## [79] httpuv_1.6.9                  Rcpp_1.0.10
## [81] xfun_0.39                     pkgconfig_2.0.3
```