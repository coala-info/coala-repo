# Code example from 'MCbiclust_vignette' vignette. See references/ for full tutorial.

## ----results = "hide",warning = FALSE, message=FALSE--------------------------
library(MCbiclust)

## ----results = "hide",warning = FALSE,message=FALSE---------------------------
library(ggplot2)
library(gplots)
library(dplyr)
library(gProfileR)
library(MASS)
library(devtools)

## -----------------------------------------------------------------------------
data(CCLE_small)
data(Mitochondrial_genes)

## -----------------------------------------------------------------------------
mito.loc <- which(row.names(CCLE_small) %in% Mitochondrial_genes)
CCLE.mito <- CCLE_small[mito.loc,]

## ----results='hide', eval=FALSE-----------------------------------------------
# set.seed(102)
# CCLE.seed <- FindSeed(gem = CCLE.mito,
#                       seed.size = 10,
#                       iterations = 10000,
#                       messages = 1000)

## ----results='hide', eval=TRUE, echo=FALSE------------------------------------
CCLE.seed <- MCbiclust:::Vignette_seed

## -----------------------------------------------------------------------------
set.seed(103)
random.seed <- sample(seq(length = dim(CCLE.mito)[2]), 10)
CorScoreCalc(CCLE.mito,random.seed)
CorScoreCalc(CCLE.mito,CCLE.seed)

## ----dev='png'----------------------------------------------------------------
CCLE.random.cor <- cor(t(CCLE.mito[,random.seed]))
heatmap.2(CCLE.random.cor,trace = "none")

## ----dev='png'----------------------------------------------------------------
CCLE.mito.cor <- cor(t(CCLE.mito[,CCLE.seed]))
heatmap.2(CCLE.mito.cor,trace = "none")

## ----dev='png'----------------------------------------------------------------
CCLE.hicor.genes <- as.numeric(HclustGenesHiCor(CCLE.mito,
                                                CCLE.seed,
                                                cuts = 8))
CCLE.mito.cor2 <- cor(t(CCLE.mito[CCLE.hicor.genes, CCLE.seed]))
CCLE.heat <- heatmap.2(CCLE.mito.cor2,trace = "none")

## -----------------------------------------------------------------------------
CCLE.groups <- list(labels(CCLE.heat$rowDendrogram[[1]]),
                    labels(CCLE.heat$rowDendrogram[[2]]))

## -----------------------------------------------------------------------------
CCLE.cor.vec <- CVEval(gem.part = CCLE.mito,
                        gem.all = CCLE_small,
                        seed = CCLE.seed, splits = 10)

## ----results='hide', eval=FALSE-----------------------------------------------
# GSE.MW <- GOEnrichmentAnalysis(gene.names = row.names(CCLE_small),
#                                gene.values = CCLE.cor.vec,
#                                sig.rate = 0.05)

## ----results='hide', eval=TRUE, echo=FALSE------------------------------------
GSE.MW <- MCbiclust:::Vignette_GSE

## ----results = "asis"---------------------------------------------------------
row.names(GSE.MW) <- NULL
pander::pandoc.table(GSE.MW[1:10,],row.names = FALSE)

## ----results = "asis"---------------------------------------------------------
top200 <- row.names(CCLE_small)[order(CCLE.cor.vec,
                                             decreasing = TRUE)[seq(200)]]

# top200.gprof <- gprofiler(top200)
# dim(top200.gprof)

## ----results = "asis"---------------------------------------------------------
# pander::pandoc.table(top200.gprof[seq(10),-c(1,2,7,8,11,14)],
#                     row.names = FALSE)

## ----results='hide', eval=FALSE-----------------------------------------------
# CCLE.samp.sort <- SampleSort(CCLE.mito[as.numeric(CCLE.hicor.genes),],
#                              seed = CCLE.seed)

## ----results='hide', eval=TRUE, echo=FALSE------------------------------------
CCLE.samp.sort <- MCbiclust:::Vignette_sort[[1]]

## -----------------------------------------------------------------------------
top.mat <- CCLE.mito[as.numeric(CCLE.hicor.genes),]

pc1.vec <- PC1VecFun(top.gem = top.mat,
                     seed.sort = CCLE.samp.sort, n = 10)

## -----------------------------------------------------------------------------
CCLE.bic <- ThresholdBic(cor.vec = CCLE.cor.vec,
                         sort.order = CCLE.samp.sort,
                         pc1 = pc1.vec, samp.sig = 0.05)

## -----------------------------------------------------------------------------
pc1.vec <- PC1Align(gem = CCLE_small, pc1 = pc1.vec,
                    sort.order = CCLE.samp.sort,
                    cor.vec = CCLE.cor.vec, bic = CCLE.bic)


## -----------------------------------------------------------------------------
av.genes.group1 <- colMeans(CCLE.mito[CCLE.groups[[1]],
                                      CCLE.samp.sort])
av.genes.group2 <- colMeans(CCLE.mito[CCLE.groups[[2]],
                                      CCLE.samp.sort])

## -----------------------------------------------------------------------------

CCLE.names <- colnames(CCLE_small)[CCLE.samp.sort]
fork.status <- ForkClassifier(pc1.vec, samp.num = length(CCLE.bic[[2]]))

CCLE.df <- data.frame(CCLE.name = CCLE.names,
                      PC1 = pc1.vec,
                      Fork = fork.status,
                      Average.Group1 = av.genes.group1,
                      Average.Group2 = av.genes.group2,
                      Order = seq(length = length(pc1.vec)))

ggplot(CCLE.df, aes(Order,PC1)) +
  geom_point(aes(colour = Fork)) + ylab("PC1")

ggplot(CCLE.df, aes(Order,Average.Group1)) +
  geom_point(aes(colour = Fork)) + ylab("Average Group 1")

ggplot(CCLE.df, aes(Order,Average.Group2)) +
  geom_point(aes(colour = Fork)) + ylab("Average Group 2")

## -----------------------------------------------------------------------------
data(CCLE_samples)

## -----------------------------------------------------------------------------
CCLE.samples.names <- as.character(CCLE_samples[,1])
CCLE.samples.names[c(1:15)] <- paste("X",CCLE.samples.names[c(1:15)],
                                     sep="")
CCLE_samples$CCLE.name <- CCLE.samples.names

## -----------------------------------------------------------------------------

rownames(CCLE_samples) <- as.character(CCLE_samples[,1])

CCLE.data.names <- colnames(CCLE_small)
CCLE_small_samples <- CCLE_samples[CCLE.data.names,]


## ----warning=FALSE,message=FALSE----------------------------------------------
CCLE.df.samples <- inner_join(CCLE.df,CCLE_samples,by="CCLE.name")

ggplot(CCLE.df.samples, aes(Order,PC1)) +
  geom_point(aes(colour=factor(Site.Primary))) + ylab("PC1")

## -----------------------------------------------------------------------------
rare.sites <- names(which(summary(CCLE.df.samples$Site.Primary) < 15))
CCLE.df.samples$Site.Primary2 <- as.character(CCLE.df.samples$Site.Primary)

rare.sites.loc <- which(CCLE.df.samples$Site.Primary2 %in% rare.sites)
CCLE.df.samples$Site.Primary2[rare.sites.loc] <- "Other"

ggplot(CCLE.df.samples, aes(Order,PC1)) +
  geom_point(aes(colour=factor(Site.Primary2))) + ylab("PC1")

## ----warning=FALSE,message=FALSE----------------------------------------------
ggplot(CCLE.df.samples, aes(Order,PC1)) +
  geom_point(aes(colour=factor(Gender))) + ylab("PC1")

## -----------------------------------------------------------------------------
library(MASS)

# create contingency tables
ctable.site <- table(CCLE.df.samples$Fork,
                     CCLE.df.samples$Site.Primary)

ctable.gender <- table(CCLE.df.samples$Fork,
                       CCLE.df.samples$Gender,
                       exclude = "U")

chisq.test(ctable.site)
chisq.test(ctable.gender)

## ----results='hide', message=FALSE, eval=FALSE--------------------------------
# CCLE.multi.seed <- list()
# initial.seed1 <- list()
# 
# for(i in seq(100)){
#   set.seed(i)
#   initial.seed1[[i]] <- sample(seq(length = dim(CCLE_small)[2]),10)
#   CCLE.multi.seed[[i]] <- FindSeed(gem = CCLE_small[c(501:1000), ],
#                                    seed.size = 10,
#                                    iterations = 500,
#                                    initial.seed = initial.seed1[[i]])
# }

## ----results='hide', eval=TRUE, echo=FALSE------------------------------------
CCLE.multi.seed <- MCbiclust:::Vignette_multi_seed
initial.seed1 <- MCbiclust:::Vignette_initial_seed

## ----results='hide', message=FALSE, eval=FALSE--------------------------------
# CCLE.cor.vec.multi <- list()
# 
# for(i in seq(100)){
#   CCLE.cor.vec.multi[[i]] <- CVEval(gem.part = CCLE_small[c(501:1000), ],
#                                     gem.all = CCLE_small,
#                                     seed = CCLE.multi.seed[[i]],
#                                     splits = 10)
# 
# }

## ----results='hide', eval=TRUE, echo=FALSE------------------------------------
CCLE.cor.vec.multi <- MCbiclust:::Vignette_multi_cv

## -----------------------------------------------------------------------------
len.a <- length(CCLE.cor.vec.multi[[1]])
len.b <- length(CCLE.cor.vec.multi)
multi.run.cor.vec.mat <- matrix(0,len.a,len.b)
for(i in 1:100){
  multi.run.cor.vec.mat[,i] <- CCLE.cor.vec.multi[[i]]
}
rm(CCLE.cor.vec.multi)


## ----dev='png'----------------------------------------------------------------
CV.cor.mat1 <- abs(cor((multi.run.cor.vec.mat)))
cor.dist <- function(c){as.dist(1 - abs(c))}

routput.corvec.matrix.cor.heat <- heatmap.2(CV.cor.mat1,
                                            trace="none",
                                            distfun = cor.dist)

## -----------------------------------------------------------------------------
multi.clust.groups <- SilhouetteClustGroups(multi.run.cor.vec.mat,
                                            max.clusters = 20,
                                            plots = TRUE,rand.vec = FALSE)

## ----dev='png'----------------------------------------------------------------
gene.names <- row.names(CCLE_small)
av.corvec.fun <- function(x) rowMeans(multi.run.cor.vec.mat[,x])
average.corvec <- lapply(X = multi.clust.groups,
                         FUN = av.corvec.fun)

CVPlot(cv.df = as.data.frame(average.corvec),
        geneset.loc = mito.loc,
        geneset.name = "Mitochondrial",
        alpha1 = 0.1)

## -----------------------------------------------------------------------------
GOfun <- function(x) GOEnrichmentAnalysis(gene.names = gene.names,
                                          gene.values = x,
                                          sig.rate = 0.05)

## ----results='hide', message=FALSE, eval=FALSE--------------------------------
# corvec.gsea <- lapply(X = average.corvec,
#                       FUN = GOfun)

## ----results='hide', eval=TRUE, echo=FALSE------------------------------------
corvec.gsea <- MCbiclust:::Vignette_multi_gsea

## -----------------------------------------------------------------------------
CCLE.samp.multi.sort <- list()
multi.prep <- MultiSampleSortPrep(gem = CCLE_small,
                                  av.corvec = average.corvec,
                                  top.genes.num = 750,
                                  groups = multi.clust.groups,
                                  initial.seeds =  CCLE.multi.seed)


## ----eval=FALSE---------------------------------------------------------------
# CCLE.samp.multi.sort[[1]] <- SampleSort(gem = multi.prep[[1]][[1]],
#                                         seed = multi.prep[[2]][[1]])
# 
# CCLE.samp.multi.sort[[2]] <- SampleSort(gem = multi.prep[[1]][[2]],
#                                         seed = multi.prep[[2]][[2]])

## ----results='hide', echo=FALSE-----------------------------------------------
CCLE.samp.multi.sort <- list()
CCLE.samp.multi.sort[[1]] <- MCbiclust:::Vignette_sort[[2]][[1]]
CCLE.samp.multi.sort[[2]] <- MCbiclust:::Vignette_sort[[2]][[2]]

## -----------------------------------------------------------------------------
pc1.vec.multi <- list()
 
pc1.vec.multi[[1]] <- PC1VecFun(top.gem =  multi.prep[[1]][[1]],
                     seed.sort = CCLE.samp.multi.sort[[1]], n = 10)
pc1.vec.multi[[2]] <- PC1VecFun(top.gem =  multi.prep[[1]][[2]],
                     seed.sort = CCLE.samp.multi.sort[[2]], n = 10)

## -----------------------------------------------------------------------------
CCLE.bic.multi <- list()
CCLE.bic.multi[[1]] <- ThresholdBic(cor.vec = average.corvec[[1]],
                         sort.order = CCLE.samp.multi.sort[[1]],
                         pc1 = pc1.vec.multi[[1]], samp.sig = 0.05)
CCLE.bic.multi[[2]] <- ThresholdBic(cor.vec = average.corvec[[2]],
                         sort.order = CCLE.samp.multi.sort[[2]],
                         pc1 = pc1.vec.multi[[2]], samp.sig = 0.05)


pc1.vec.multi[[1]] <- PC1Align(gem = CCLE_small, pc1 = pc1.vec.multi[[1]],
                    sort.order = CCLE.samp.multi.sort[[1]],
                    cor.vec = average.corvec[[1]], bic = CCLE.bic.multi[[1]])

pc1.vec.multi[[2]] <- PC1Align(gem = CCLE_small, pc1 = pc1.vec.multi[[2]],
                    sort.order = CCLE.samp.multi.sort[[2]],
                    cor.vec = average.corvec[[2]], bic = CCLE.bic.multi[[2]])

## -----------------------------------------------------------------------------
CCLE.multi.df <- data.frame(CCLE.name = colnames(CCLE_small),
           Bic1.order = order(CCLE.samp.multi.sort[[1]]),
           Bic2.order = order(CCLE.samp.multi.sort[[2]]),
           Bic1.PC1 = pc1.vec.multi[[1]][order(CCLE.samp.multi.sort[[1]])],
           Bic2.PC1 = pc1.vec.multi[[2]][order(CCLE.samp.multi.sort[[2]])])

CCLE.multi.df.samples <- inner_join(CCLE.multi.df,CCLE_samples,by="CCLE.name")

rare.sites <- names(which(summary(CCLE.multi.df.samples$Site.Primary) < 15))
CCLE.multi.df.samples$Site.Primary2 <- as.character(CCLE.multi.df.samples$Site.Primary)

rare.sites.loc <- which(CCLE.multi.df.samples$Site.Primary2 %in% rare.sites)
CCLE.multi.df.samples $Site.Primary2[rare.sites.loc] <- "Other"

ggplot(CCLE.multi.df.samples, aes(Bic1.order,Bic1.PC1)) +
  geom_point(aes(colour=factor(Site.Primary2))) + ylab("Bic1 PC1")

ggplot(CCLE.multi.df.samples, aes(Bic2.order,Bic2.PC1)) +
  geom_point(aes(colour=factor(Site.Primary2))) + ylab("Bic2 PC1")


## ----dev="png"----------------------------------------------------------------
cv.df <- as.data.frame(average.corvec)
cv.df$Mito1 <- CCLE.cor.vec

CVPlot(cv.df,cnames = c("R1","R2","M1"),
        geneset.loc = mito.loc,
        geneset.name = "Mitochondrial",
        alpha1 = 0.1)


## -----------------------------------------------------------------------------
gene.loc1 <- which(row.names(CCLE.mito[CCLE.hicor.genes,]) %in% CCLE.groups[[1]])
gene.loc2 <- which(row.names(CCLE.mito[CCLE.hicor.genes,]) %in% CCLE.groups[[2]])

CCLE.ps <- PointScoreCalc(CCLE.mito[CCLE.hicor.genes,], gene.loc1, gene.loc2)

## ----dev="png"----------------------------------------------------------------
CCLE.df$PointScore <- CCLE.ps[CCLE.samp.sort]

ggplot(CCLE.df, aes(Order,PC1)) +
  geom_point(aes(colour = Fork)) + ylab("PC1")
ggplot(CCLE.df, aes(Order,PointScore)) +
  geom_point(aes(colour = Fork)) + ylab("PointScore")


## -----------------------------------------------------------------------------
# library(GSVA)
# 
# ssGSEA.test <- gsva(expr = as.matrix(CCLE.mito[CCLE.hicor.genes,]),
#                     gset.idx.list = CCLE.groups,
#                     method = 'gsva',
#                     parallel.sz = 1)
# ssGSEA.test[2,] <- -ssGSEA.test[2,]
# CCLE.ssGSEA <- colMeans(ssGSEA.test)


## ----dev="png"----------------------------------------------------------------
# CCLE.df$ssGSEA <- CCLE.ssGSEA[CCLE.samp.sort]
# 
# ggplot(CCLE.df, aes(Order, PC1)) +
#   geom_point(aes(colour = Fork)) + ylab("PC1")
# ggplot(CCLE.df, aes(Order, ssGSEA)) +
#   geom_point(aes(colour = Fork)) + ylab("ssGSEA")


## ----session_info, include=TRUE, echo=TRUE, results='markup'------------------
devtools::session_info()

