# Code example from 'HarmanData' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## -----------------------------------------------------------------------------
## load package
library(HarmanData)
data(IMR90)
data(NPM)
data(OLF)
data(Infinium5)
olf.data[1:5, 1:5]
dim(olf.data)
table(olf.info)

## -----------------------------------------------------------------------------
## load package
library(HarmanData)
data(Infinium5)
lvr.harman["cg01381374", ]
md.harman["cg01381374", ]

## -----------------------------------------------------------------------------
library(Harman)
data(episcope)
bad_batches <- c(1, 5, 9, 17, 25)
is_bad_sample <- episcope$pd$array_num %in% bad_batches
myK <- discoverClusteredMethylation(episcope$original[, !is_bad_sample])
mykClust = kClusterMethylation(episcope$original, row_ks=myK)
res = clusterStats(pre_betas=episcope$original,
                   post_betas=episcope$harman,
                   kClusters = mykClust)
all.equal(episcope$ref_md$meandiffs_harman, res$meandiffs)
all.equal(episcope$ref_lvr$var_ratio_harman, res$log2_var_ratio)

