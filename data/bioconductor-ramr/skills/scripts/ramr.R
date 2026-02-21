# Code example from 'ramr' vignette. See references/ for full tutorial.

## ----include = FALSE------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  width = 100
)
options(width=100)

## ----fig.width=10, fig.height=4, out.width="100%", out.height="100%"------------------------------
library(GenomicRanges)
library(ggplot2)
library(ramr)
data(ramr)

head(ramr.samples)
ramr.data[1:10,ramr.samples[1:3]]
plotAMR(data.ranges=ramr.data, amr.ranges=ramr.tp.unique[1])
plotAMR(data.ranges=ramr.data, amr.ranges=ramr.tp.nonunique[c(1,6,11)])

## ----fig.width=10, fig.height=6, out.width="100%", out.height="100%"------------------------------
# set the seed if reproducible results required
  set.seed(999)

# unique random AMRs
  amrs.unique <-
    simulateAMR(template.ranges=ramr.data, nsamples=25, regions.per.sample=2,
                min.cpgs=5, merge.window=1000, dbeta=0.2)

# non-unique AMRs outside of regions with unique AMRs
  amrs.nonunique <-
    simulateAMR(template.ranges=ramr.data, nsamples=4, exclude.ranges=amrs.unique,
                sample.names=sprintf("sample%02i", c(2, 4, 8, 16)),
                samples.per.region=2, min.cpgs=5, merge.window=1000)
  
# random noise outside of AMR regions
  noise <-
    simulateAMR(ramr.data, nsamples=25, regions.per.sample=20,
                exclude.ranges=c(amrs.unique, amrs.nonunique),
                min.cpgs=1, max.cpgs=1, merge.window=1, dbeta=0.5)

# "smooth" methylation data without AMRs (negative control)
  smooth.data <-
    simulateData(template.ranges=ramr.data, nsamples=25)
  
# methylation data with AMRs and noise
  noisy.data <-
    simulateData(template.ranges=ramr.data, nsamples=25,
                 amr.ranges=c(amrs.unique, amrs.nonunique, noise))
  
# that's how regions look like
  library(gridExtra)

  do.call("grid.arrange", c(plotAMR(data.ranges=noisy.data, amr.ranges=amrs.unique[1:4]), ncol=2))
  do.call("grid.arrange", c(plotAMR(data.ranges=noisy.data, amr.ranges=sort(amrs.nonunique)[1:8]), ncol=2))
  do.call("grid.arrange", c(plotAMR(data.ranges=noisy.data, amr.ranges=noise[1:4]), ncol=2))
  
# can we find them?
  system.time(
    found <- getAMR(
      data.ranges=noisy.data,
      compute="beta+binom", compute.estimate="amle", compute.weights="logInvDist",
      combine.min.cpgs=5, combine.threshold=1e-2, combine.window=1000
    )
  )
  
# all possible regions
  all.ranges <- getUniverse(noisy.data, min.cpgs=5, merge.window=1000)
  
# true positives
  tp <- sum(found %over% c(amrs.unique, amrs.nonunique))
  
# false positives
  fp <- sum(found %outside% c(amrs.unique, amrs.nonunique))

# true negatives
  tn <- length(all.ranges %outside% c(amrs.unique, amrs.nonunique))
  
# false negatives
  fn <- sum(c(amrs.unique, amrs.nonunique) %outside% found)
  
# accuracy, MCC
  acc <- (tp+tn) / (tp+tn+fp+fn)
  mcc <- (tp*tn - fp*fn) / (sqrt(tp+fp)*sqrt(tp+fn)*sqrt(tn+fp)*sqrt(tn+fn))
  setNames(c(tp, fp, tn, fn), c("TP", "FP", "TN", "FN"))
  setNames(c(acc, mcc), c("accuracy", "MCC"))

## ----fig.width=10, fig.height=6, out.width="100%", out.height="100%"------------------------------
# identify AMRs
amrs <- getAMR(
  data.ranges=ramr.data, data.samples=ramr.samples, compute="beta+binom",
      combine.min.cpgs=5, combine.threshold=1e-2, combine.window=1000
)

# inspect
sort(amrs)

do.call("grid.arrange", c(plotAMR(data.ranges=ramr.data, amr.ranges=amrs[1:10]), ncol=2))

## -------------------------------------------------------------------------------------------------
# annotating AMRs using R library annotatr
library(annotatr)
annotation.types <- c("hg19_cpg_inter", "hg19_cpg_islands", "hg19_cpg_shores",
                      "hg19_cpg_shelves", "hg19_genes_intergenic", "hg19_genes_promoters",
                      "hg19_genes_5UTRs", "hg19_genes_firstexons", "hg19_genes_3UTRs")
annotations <- build_annotations(genome='hg19', annotations=annotation.types)
amrs.annots <- annotate_regions(regions=amrs, annotations=annotations, ignore.strand=TRUE, quiet=FALSE)
summarize_annotations(annotated_regions=amrs.annots, quiet=FALSE)

## ----session--------------------------------------------------------------------------------------
sessionInfo()

