# Code example from 'E_GADGETS' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE, cache = FALSE, dev = "png", message = FALSE,
                      error = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(epistasisGA)
data("case.gxe")
case <- as.matrix(case.gxe)
data("dad.gxe")
dad <- as.matrix(dad.gxe)
data("mom.gxe")
mom <- as.matrix(mom.gxe)
data("exposure")

## -----------------------------------------------------------------------------
ld.block.vec <- rep(6, 4)

## -----------------------------------------------------------------------------
pp.list <- preprocess.genetic.data(case, father.genetic.data = dad,
                                   mother.genetic.data = mom,
                                   ld.block.vec = ld.block.vec, 
                                   categorical.exposures = exposure)

## ----message = FALSE----------------------------------------------------------
set.seed(100)
run.gadgets(pp.list, n.chromosomes = 5, chromosome.size = 3, 
       results.dir = "size3_res", cluster.type = "interactive",
       registryargs = list(file.dir = "size3_reg", seed = 1300),
       n.islands = 8, island.cluster.size = 4, 
       n.migrations = 2)

run.gadgets(pp.list, n.chromosomes = 5, chromosome.size = 4, 
       results.dir = "size4_res", cluster.type = "interactive", 
       registryargs = list(file.dir = "size4_reg", seed = 1400),
       n.islands = 8, island.cluster.size = 4, 
       n.migrations = 2)

## -----------------------------------------------------------------------------
data(snp.annotations.mci)
size3.combined.res <- combine.islands("size3_res", snp.annotations.mci,
                                      pp.list)
size4.combined.res <- combine.islands("size4_res", snp.annotations.mci,
                                      pp.list)


## -----------------------------------------------------------------------------
library(magrittr)
library(knitr)
library(kableExtra)
kable(head(size3.combined.res)) %>%
  kable_styling() %>%
  scroll_box(width = "750px")


## -----------------------------------------------------------------------------
set.seed(1400)
permute.dataset(pp.list, 
                permutation.data.file.path = "perm_data",
                n.permutations = 4)


## -----------------------------------------------------------------------------
#pre-process permuted data 
preprocessed.lists <- lapply(seq_len(4), function(permutation){
  
  exp.perm.file <- file.path("perm_data", 
                             paste0("exposure.permute", permutation, ".rds"))
  exp.perm <- readRDS(exp.perm.file)
  preprocess.genetic.data(case, father.genetic.data = dad,
                          mother.genetic.data = mom,
                          ld.block.vec = ld.block.vec,
                          categorical.exposures = exp.perm)
})


#specify chromosome sizes
chrom.sizes <- 3:4

#specify a different seed for each permutation
seeds <- 4:7

#run GADGETS for each permutation and size 
perm.res <- lapply(chrom.sizes, function(chrom.size){
  
  # grab standardization info 
  orig.res.dir <- paste0("size", chrom.size, "_res")
  st.info <- readRDS(file.path(orig.res.dir, "null.mean.sd.info.rds"))
  st.means <- st.info$null.mean
  st.sd <- st.info$null.se
  
  lapply(seq_len(4), function(permutation){
  
    perm.data.list <- preprocessed.lists[[permutation]]
    seed.val <- chrom.size*seeds[permutation]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    reg.dir <- paste0("perm", permutation, "_size", chrom.size, "_reg")
    run.gadgets(perm.data.list, n.chromosomes = 5, 
           chromosome.size = chrom.size,
           results.dir = res.dir, cluster.type = "interactive", 
           registryargs = list(file.dir = reg.dir, seed = seed.val),
           n.islands = 8, island.cluster.size = 4,
           n.migrations = 2, null.mean.vec = st.means, 
           null.sd.vec = st.sd)
    
  })
  
})

#condense the results 
perm.res.list <- lapply(chrom.sizes, function(chrom.size){
  
  lapply(seq_len(4), function(permutation){
  
    perm.data.list <- preprocessed.lists[[permutation]]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    combine.islands(res.dir, snp.annotations.mci, perm.data.list)
    
  })
  
})


## -----------------------------------------------------------------------------
# chromosome size 3 results

# function requires a list of vectors of
# permutation based fitness scores
chrom3.perm.fs <- lapply(perm.res.list[[1]], 
                         function(x) x$fitness.score)
chrom3.list <- list(observed.data = size3.combined.res$fitness.score,
                     permutation.list = chrom3.perm.fs)

# chromosome size 4 results
chrom4.perm.fs <- lapply(perm.res.list[[2]], 
                         function(x) x$fitness.score)
chrom4.list <- list(observed.data = size4.combined.res$fitness.score,
                     permutation.list = chrom4.perm.fs)

# list of results across chromosome sizes, with each list 
# element corresponding to a chromosome size
final.results <- list(chrom3.list, chrom4.list)

# run global test
global.test.res <- global.test(final.results, n.top.scores = 1)
global.test.res$pval


## -----------------------------------------------------------------------------
top.snps <- as.vector(t(size3.combined.res[1, 1:3]))
d3.st.info <- readRDS(file.path("size3_res/null.mean.sd.info.rds"))
d3.st.means <- d3.st.info$null.mean
d3.st.sd <- d3.st.info$null.se
set.seed(10)
GxE.test.res <- GxE.test(top.snps, pp.list, 
                         null.mean.vec = d3.st.means, 
                         null.sd.vec = d3.st.sd)
GxE.test.res$pval

## ----fig.width = 14, fig.height = 12------------------------------------------
# vector of 95th percentile of null fitness scores max
chrom.size.thresholds <- global.test.res$max.perm.95th.pctl

# chromosome size 3 threshold
d3.t <- chrom.size.thresholds[1]

# chromosome size 4 threshold
d4.t <- chrom.size.thresholds[2]

# create results list 
obs.res.list <- list(size3.combined.res[size3.combined.res$fitness.score >= 
                                          d3.t, ], 
                     size4.combined.res[size4.combined.res$fitness.score >= 
                                          d4.t, ])

# list of standardization information for each chromosome size
d4.st.info <- readRDS(file.path("size4_res/null.mean.sd.info.rds"))
d4.st.means <- d4.st.info$null.mean
d4.st.sd <- d4.st.info$null.se
null.means.list <- list(d3.st.means, d4.st.means)
null.sds.list <- list(d3.st.sd, d4.st.sd)

set.seed(10)
graphical.scores <- compute.graphical.scores(obs.res.list, pp.list, 
                                             null.mean.vec.list = null.means.list,
                                             null.sd.vec.list = null.sds.list)
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 2)


## ----results="hide"-----------------------------------------------------------
#remove all example directories 
chrom.sizes <- 3:4
perm.reg.dirs <- as.vector(outer(paste0("perm", 1:4), 
                                 paste0("_size", chrom.sizes, "_reg"), 
                                 paste0))
perm.res.dirs <- as.vector(outer(paste0("perm", 1:4), 
                                 paste0("_size", chrom.sizes, "_res"), 
                                 paste0))
lapply(c("size3_res", "size3_reg", "size4_res", "size4_reg",
         perm.reg.dirs, perm.res.dirs, 
         "perm_data"), unlink, recursive = TRUE)



## -----------------------------------------------------------------------------
#session information 
sessionInfo()


