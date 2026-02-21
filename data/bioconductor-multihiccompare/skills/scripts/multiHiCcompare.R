# Code example from 'multiHiCcompare' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, message=FALSE------------------------------------------------
library(multiHiCcompare)

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("multiHiCcompare")
# library(multiHiCcompare)

## ----eval=FALSE---------------------------------------------------------------
# # read in files
# mat <- read.table("hic_1000000.matrix")
# bed <- read.table("hic_1000000_abs.bed")
# # convert to BEDPE
# dat <- HiCcompare::hicpro2bedpe(mat, bed)
# # NOTE: hicpro2bedpe returns a list of lists.
# #   The first list, dat$cis, contains the intrachromosomal contact matrices
# # NOTE: dat$trans contains the interchromosomal
# #   contact matrix which is not used in multiHiCcompare.

## ----eval = FALSE-------------------------------------------------------------
# library(BiocParallel)
# numCores <- 20
# register(MulticoreParam(workers = numCores), default = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# library(BiocParallel)
# numCores <- 20
# register(SnowParam(workers = numCores), default = TRUE)

## -----------------------------------------------------------------------------
data("HCT116_r1") # load example sparse matrix
head(HCT116_r1)
colnames(HCT116_r1) <- c('chr', 'region1', 'region2', 'IF') # rename columns
head(HCT116_r1) # matrix ready to be input into multiHiCcompare

## -----------------------------------------------------------------------------
data("HCT116_r1", "HCT116_r2", "HCT116_r3", "HCT116_r4")
hicexp1 <- make_hicexp(HCT116_r1, HCT116_r2, HCT116_r3, HCT116_r4, 
                       groups = c(0, 0, 1, 1), 
                       zero.p = 0.8, A.min = 5, filter = TRUE,
                       remove.regions = hg19_cyto)
hicexp1

## -----------------------------------------------------------------------------
data("hg19_cyto")
data("hg38_cyto")

hg19_cyto

## ----eval=FALSE---------------------------------------------------------------
# data("hicexp2")
# hicexp2 <- hic_scale(hicexp2)

## -----------------------------------------------------------------------------
hicexp1 <- cyclic_loess(hicexp1, verbose = FALSE, 
                        parallel = FALSE, span = 0.2)
# make MD plot
MD_hicexp(hicexp1)

## -----------------------------------------------------------------------------
hic_table(hicexp1)

## -----------------------------------------------------------------------------
data("hicexp2")
# perform fastlo normalization
hicexp2 <- fastlo(hicexp2, verbose = FALSE, parallel = FALSE)
# make MD plot
MD_hicexp(hicexp2)

## -----------------------------------------------------------------------------
hicexp1 <- hic_exactTest(hicexp1, p.method = 'fdr', 
                         parallel = FALSE)

# plot results
MD_composite(hicexp1)

## -----------------------------------------------------------------------------
results(hicexp1)

## -----------------------------------------------------------------------------
batch <- c(1,2,1,2)
# produce design matrix
d <- model.matrix(~factor(meta(hicexp2)$group) + factor(batch))

## ----eval=FALSE---------------------------------------------------------------
# hicexp2 <- hic_glm(hicexp2, design = d, coef = 2, method = "QLFTest", p.method = "fdr", parallel = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# # use Treat option
# hicexp2 <- hic_glm(hicexp2, design = d, coef = 2, method = "Treat",
#                   M = 0.5, p.method = "fdr", parallel = FALSE)

## -----------------------------------------------------------------------------
td <- topDirs(hicexp1, logfc_cutoff = 0.5, logcpm_cutoff = 0.5,
        p.adj_cutoff = 0.2, return_df = 'pairedbed')
head(td)

## -----------------------------------------------------------------------------
counts <- topDirs(hicexp1, logfc_cutoff = 0.5, logcpm_cutoff = 0.5, 
                  p.adj_cutoff = 0.2, return_df = 'bed', pval_aggregate = "max")
head(counts)

## -----------------------------------------------------------------------------
plot_pvals(counts)

## -----------------------------------------------------------------------------
plot_counts(counts)

## -----------------------------------------------------------------------------
manhattan_hicexp(hicexp1, p.adj_cutoff = "standard")

## -----------------------------------------------------------------------------
MD_hicexp(hicexp1, prow = 2, pcol = 3)

## -----------------------------------------------------------------------------
MD_composite(hicexp1)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

