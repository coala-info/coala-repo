# Code example from 'GADGETS' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE, cache = FALSE, dev = "png", message = FALSE,
                      error = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(epistasisGA)
data(case)
case <- as.matrix(case)
data(dad)
dad <- as.matrix(dad)
data(mom)
mom <- as.matrix(mom)

## -----------------------------------------------------------------------------
ld.block.vec <- rep(25, 4)

## -----------------------------------------------------------------------------
pp.list <- preprocess.genetic.data(case, father.genetic.data = dad,
                                   mother.genetic.data = mom,
                                   ld.block.vec = ld.block.vec)

## ----eval=F-------------------------------------------------------------------
# ### FOR ILLUSTRATION ONLY, DO NOT TRY TO RUN THIS CHUNK ###
# pp.list <- preprocess.genetic.data(affected.sibling.genotypes,
#                                    complement.genetic.data = unaffected.sibling.genotypes,
#                                    ld.block.vec = ld.block.vec)
# 

## -----------------------------------------------------------------------------
complement <- mom + dad - case

## ----eval = FALSE-------------------------------------------------------------
# ### STILL JUST FOR ILLUSTRATION ###
# combined.case <- rbind(case, affected.sibling.genotypes)
# combined.complement <- rbind(complement, unaffected.sibling.genotypes)
# pp.list <- preprocess.genetic.data(case.genetic.data = combined.case,
#                                    complement.genetic.data = combined.complement,
#                                    ld.block.vec = ld.block.vec)
# 

## ----message = FALSE----------------------------------------------------------
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

## ----eval=F-------------------------------------------------------------------
# ### FOR ILLUSTRATION ONLY, DO NOT TRY TO RUN THIS CHUNK ###
# 
# library(BiocParallel)
# fname <- batchtoolsTemplate("slurm")
# run.gadgets(pp.list, n.chromosomes = 20, chromosome.size = 3,
#        results.dir = "size3_res", cluster.type = "slurm",
#        registryargs = list(file.dir = "size3_reg", seed = 1300),
#        cluster.template = fname,
#        resources = list(chunks.as.arrayjobs = TRUE),
#        n.islands = 12,
#        island.cluster.size = 4)
# 

## -----------------------------------------------------------------------------
data(snp.annotations)
size3.combined.res <- combine.islands("size3_res", snp.annotations,
                                      pp.list)
size4.combined.res <- combine.islands("size4_res", snp.annotations,
                                      pp.list)


## -----------------------------------------------------------------------------
library(magrittr)
library(knitr)
library(kableExtra)
kable(head(size4.combined.res)) %>%
  kable_styling() %>%
  scroll_box(width = "750px")


## -----------------------------------------------------------------------------
set.seed(1400)
permute.dataset(pp.list, 
                permutation.data.file.path = "perm_data",
                n.permutations = 4)


## -----------------------------------------------------------------------------
preprocess.lists <- lapply(seq_len(4), function(permutation){
  
  case.perm.file <- file.path("perm_data", paste0("case.permute", permutation, ".rds"))
  comp.perm.file <- file.path("perm_data", paste0("complement.permute", permutation, ".rds"))
  case.perm <- readRDS(case.perm.file)
  comp.perm <- readRDS(comp.perm.file)
  
  preprocess.genetic.data(case.perm, 
                          complement.genetic.data = comp.perm,
                          ld.block.vec = ld.block.vec)
})


## ----results = "hide"---------------------------------------------------------
#specify chromosome sizes
chrom.sizes <- 3:4

#specify a different seed for each permutation
seeds <- 4:7

#run GADGETS for each permutation and size 
lapply(chrom.sizes, function(chrom.size){
  
  lapply(seq_len(4), function(permutation){
  
    perm.data.list <- preprocess.lists[[permutation]]
    seed.val <- chrom.size*seeds[permutation]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    reg.dir <- paste0("perm", permutation, "_size", chrom.size, "_reg")
    run.gadgets(perm.data.list, n.chromosomes = 5, 
           chromosome.size = chrom.size,
           results.dir = res.dir, cluster.type = "interactive", 
           registryargs = list(file.dir = reg.dir, seed = seed.val),
           n.islands = 8, island.cluster.size = 4,
           n.migrations = 2)
    
  })
  
})

#condense the results 
perm.res.list <- lapply(chrom.sizes, function(chrom.size){
  
  lapply(seq_len(4), function(permutation){
  
    perm.data.list <- preprocess.lists[[permutation]]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    combine.islands(res.dir, snp.annotations, perm.data.list)
    
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
global.test.res <- global.test(final.results, n.top.scores = 5)

# examine how many chromosomes were used for each  chromosome size 
global.test.res$chrom.size.k

# look at the global test stat and p-value 
global.test.res$obs.test.stat
global.test.res$pval


## ----echo = FALSE-------------------------------------------------------------
library(ggplot2)
plot.data <- data.frame(distance_type = c(rep("original", 4), rep("log", 4)), 
                        data = rep(rep("Permuted", 4), 2), 
                        distance = c(global.test.res$perm.test.stats, log(global.test.res$perm.test.stats)))
obs.plot.data <- data.frame(distance_type = c("original", "log"), 
                        data = rep("Observed", 2), 
                        distance = c(global.test.res$obs.test.stat, log(global.test.res$obs.test.stat)))

ggplot(plot.data, aes(x = factor(""), y = distance, color = data)) + geom_boxplot() + geom_point() +
  geom_point(data = obs.plot.data, aes(x = factor(""), y = distance, color = data)) +
  facet_wrap(distance_type ~ ., scales = "free_y",  
             strip.position = "left", nrow = 2, 
             labeller = as_labeller(c(original = "T",
                                      log = "log(T)"))) +
  ylab(NULL) + xlab(NULL) +
  theme(strip.background = element_blank(),
        strip.placement = "outside", 
        axis.ticks.x = element_blank(), 
        axis.text.x = element_blank()) +
  guides(color=guide_legend(title="Data Type"))


## -----------------------------------------------------------------------------
global.test.res$obs.marginal.test.stats
global.test.res$marginal.pvals


## -----------------------------------------------------------------------------
global.test.res$max.obs.fitness
global.test.res$max.order.pvals


## ----fig.width=6--------------------------------------------------------------
library(grid)
grid.draw(global.test.res$boxplot.grob)


## -----------------------------------------------------------------------------
top.snps <- as.vector(t(size4.combined.res[1, 1:4]))
set.seed(10)
epi.test.res <- epistasis.test(top.snps, pp.list)
epi.test.res$pval

## -----------------------------------------------------------------------------
# vector of 95th percentile of null fitness scores max
chrom.size.thresholds <- global.test.res$max.perm.95th.pctl

# chromosome size 3 threshold
d3.t <- chrom.size.thresholds[1]

# chromosome size 4 threshold
d4.t <- chrom.size.thresholds[2]

# create results list 
obs.res.list <- list(size3.combined.res[size3.combined.res$fitness.score >= d3.t, ], 
                     size4.combined.res[size4.combined.res$fitness.score >= d4.t, ])


## -----------------------------------------------------------------------------
obs.res.list.no.permutes <- list(size3.combined.res[1:5, ], size4.combined.res[1:5, ])


## -----------------------------------------------------------------------------
set.seed(10)
graphical.scores <- compute.graphical.scores(obs.res.list, pp.list)


## ----fig.width = 14, fig.height = 12------------------------------------------
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 2)

## ----fig.width = 14, fig.height = 12------------------------------------------
network.plot(graphical.scores, pp.list, 
             n.top.scoring.pairs = 2, graph.area = 10,
             node.size = 40, vertex.label.cex = 2)


## -----------------------------------------------------------------------------
head(graphical.scores[["pair.scores"]])
head(graphical.scores[["snp.scores"]])

## ----fig.width = 14, fig.height = 12------------------------------------------
risk.numbers <- c(51, 52, 76, 77)
graphical.scores[[1]]$SNP1.rsid <- ifelse(graphical.scores[[1]]$SNP1 %in% risk.numbers, 
                                          "*", "")
graphical.scores[[1]]$SNP2.rsid <- ifelse(graphical.scores[[1]]$SNP2 %in% risk.numbers,
                                          "*", "")
graphical.scores[[2]]$rsid <- ifelse(graphical.scores[[2]]$SNP %in% risk.numbers, "*", "")
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 10)


## ----results="hide"-----------------------------------------------------------
#remove all example directories 
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


