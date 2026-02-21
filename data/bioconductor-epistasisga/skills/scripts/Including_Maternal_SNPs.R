# Code example from 'Including_Maternal_SNPs' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE, cache = FALSE, dev = "png", message = FALSE,
                      error = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(epistasisGA)
data(case.mci)
case <- as.matrix(case.mci)
data(dad.mci)
dad <- as.matrix(dad.mci)
data(mom.mci)
mom <- as.matrix(mom.mci)
data(snp.annotations.mci)

## -----------------------------------------------------------------------------
pseudo.sib <- mom + dad - case

## -----------------------------------------------------------------------------
input.case <- cbind(case[ , 1:6], mom[ , 1:6], 
                    case[ , 7:12], mom[ , 7:12], 
                    case[ , 13:18], mom[ , 13:18],
                    case[ , 19:24], mom[ , 19:24])


## -----------------------------------------------------------------------------
input.control <- cbind(pseudo.sib[ , 1:6], dad[ , 1:6], 
                    pseudo.sib[ , 7:12], dad[ , 7:12], 
                    pseudo.sib[ , 13:18], dad[ , 13:18],
                    pseudo.sib[ , 19:24], dad[ , 19:24])


## -----------------------------------------------------------------------------
ld.block.vec <- rep(12, 4)

## -----------------------------------------------------------------------------
pp.list <- preprocess.genetic.data(case.genetic.data = input.case,
                                   complement.genetic.data = input.control,
                                   ld.block.vec = ld.block.vec, 
                                   child.snps = c(1:6, 13:18, 25:30, 37:42), 
                                   mother.snps = c(7:12, 19:24, 31:36, 43:48))

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

## -----------------------------------------------------------------------------
snp.anno <- snp.annotations.mci[c(rep(1:6, 2), 
                       rep(7:12, 2), 
                       rep(13:18, 2), 
                       rep(19:24, 2)), ]
size3.combined.res <- combine.islands("size3_res", snp.anno,
                                      pp.list)
size4.combined.res <- combine.islands("size4_res", snp.anno,
                                      pp.list)


## -----------------------------------------------------------------------------
library(magrittr)
library(knitr)
library(kableExtra)
kable(head(size3.combined.res)) %>%
  kable_styling() %>%
  scroll_box(width = "750px")


## -----------------------------------------------------------------------------
top.snps <- as.vector(t(size3.combined.res[1, 1:3]))
set.seed(10)
epi.test.res <- epistasis.test(top.snps, pp.list, maternal.fetal.test = TRUE)
epi.test.res$pval

## ----fig.width = 14, fig.height = 12------------------------------------------
obs.res.list <- list(size3.combined.res, size4.combined.res)
set.seed(10)
graphical.scores <- compute.graphical.scores(obs.res.list, pp.list)
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 2, 
             node.shape = c("circle", "square"))


## ----results="hide"-----------------------------------------------------------
#remove all example directories 
lapply(c("size3_res", "size3_reg", "size4_res", "size4_reg"), 
       unlink, recursive = TRUE)


## -----------------------------------------------------------------------------
#session information 
sessionInfo()


