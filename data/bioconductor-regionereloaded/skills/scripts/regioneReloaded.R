# Code example from 'regioneReloaded' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
 fig.width=6, 
 fig.height=6,
 fig.align = "center"
)

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----eval=FALSE---------------------------------------------------------------
# 
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("regioneReloaded")
# 

## ----setup--------------------------------------------------------------------
library("regioneReloaded")

## ----load _data, eval=FALSE---------------------------------------------------
# #NOT RUN
# 
#   set.seed(42)
#   cw_Alien_ReG<-crosswisePermTest(Alist = AlienRSList_narrow,
#                             sampling = FALSE,
#                             mc.cores= 25,
#                             ranFUN = "resampleGenome",
#                             evFUN = "numOverlaps",
#                             genome = AlienGenome,
#                             ntimes= 1000
#   )
# #

## -----------------------------------------------------------------------------

data("cw_Alien")

cw_Alien_ReG<-makeCrosswiseMatrix(cw_Alien_ReG, pvcut = 1)

plotCrosswiseMatrix(cw_Alien_ReG)


## -----------------------------------------------------------------------------

AlienGenome <-
  toGRanges(data.frame(
    chr = c("AlChr1", "AlChr2", "AlChr3", "AlChr4"),
    start = c(rep(1, 4)),
    end = c(2e6, 1e6, 5e5, 1e5)
  ))



## -----------------------------------------------------------------------------
gnm <- AlienGenome

nreg=100

regA <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = gnm
  )

regB <-
  createRandomRegions(
    nregions = nreg,
    length.mean =  100,
    length.sd = 50 ,
    non.overlapping = TRUE,
    genome = gnm
  )

regC <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = gnm
  )


## -----------------------------------------------------------------------------

vectorPerc <- seq(0.1, 0.9, 0.1)

RsetA <-
  similarRegionSet(
    GR = regA,
    name = "regA",
    genome = gnm,
    vectorPerc = vectorPerc
  )
RsetB <-
  similarRegionSet(
    GR = regB,
    name = "regB",
    genome = gnm,
    vectorPerc = vectorPerc
  )
RsetC <-
  similarRegionSet(
    GR = regC,
    name = "regC",
    genome = gnm,
    vectorPerc = vectorPerc
  )


## -----------------------------------------------------------------------------

vectorPerc2 <- seq(0.2, 0.8, 0.2)
regAB <- c(sample(regA, nreg / 2), sample(regB, nreg / 2))
RsetAB <-
  similarRegionSet(
    GR = regAB,
    name = "regAB",
    genome = gnm,
    vectorPerc = vectorPerc2
  )


## -----------------------------------------------------------------------------

reg_no_A <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, regA)
  )

reg_no_B <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, regB)
  )

reg_no_C <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, regC)
  )

reg_no_AB <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, c(regA, regB))
  )

reg_no_ABC <-
  createRandomRegions(
    nregions = nreg,
    length.mean = 100,
    length.sd = 50,
    non.overlapping = TRUE,
    genome = subtractRegions(gnm, c(regA, regB, regC))
  )


## -----------------------------------------------------------------------------

dst <- sample(c(-300,300),length(regA),replace = TRUE)
regD <- regioneR::toGRanges(
                    data.frame(
                      chr=as.vector(GenomeInfoDb::seqnames(regA)),
                      start = start(regA) + dst,
                      end = end (regA) + dst
                      )
                    )

RsetD <-
  similarRegionSet(
    GR = regD,
    name = "regD",
    genome = gnm,
    vectorPerc = vectorPerc2
  )


## -----------------------------------------------------------------------------

Rset_NO <- list(reg_no_A, reg_no_B, reg_no_C, reg_no_AB, reg_no_ABC)

names(Rset_NO) <- c("reg_no_A", "reg_no_B", "reg_no_C", "reg_no_AB", "reg_no_ABC")

AlienRSList_narrow <- c(RsetA, RsetB, RsetC, RsetD, RsetAB, Rset_NO)

summary(AlienRSList_narrow)


## -----------------------------------------------------------------------------

data("cw_Alien")
getParameters(cw_Alien_ReG)


## ----eval=FALSE---------------------------------------------------------------
# 
# #NOT RUN
# 
# set.seed(42)
# cw_Alien_RaR <-  crosswisePermTest(
#   Alist = AlienRSList_narrow,
#   Blist = AlienRSList_narrow,
#   sampling = FALSE,
#   genome = AlienGenome,
#   per.chromosome=TRUE,
#   ranFUN = "randomizeRegions",
#   evFUN = "numOverlaps",
#   ntimes= 1000,
#   mc.cores = 20
# )
# 
# 
# set.seed(42)
# cw_Alien_ReR <-  crosswisePermTest(
#   Alist = AlienRSList_narrow,
#   Blist = AlienRSList_narrow,
#   sampling = FALSE,
#   genome = AlienGenome,
#   per.chromosome=TRUE,
#   ranFUN = "resampleRegions",
#   evFUN = "numOverlaps",
#   ntimes= 1000,
#   mc.cores = 20
# )
# 
# set.seed(42)
# cw_Alien_ReG <-  crosswisePermTest(
#   Alist = AlienRSList_narrow,
#   Blist = AlienRSList_narrow,
#   sampling = FALSE,
#   genome = AlienGenome,
#   per.chromosome=TRUE,
#   ranFUN = "resampleGenome",
#   evFUN = "numOverlaps",
#   ntimes= 100,
#   mc.cores = 20
# )
# 
# #
# 

## -----------------------------------------------------------------------------

cw_Alien_RaR <- makeCrosswiseMatrix(cw_Alien_RaR)

cw_Alien_ReG <- makeCrosswiseMatrix(cw_Alien_ReG)

cw_Alien_ReR <- makeCrosswiseMatrix(cw_Alien_ReR)


## -----------------------------------------------------------------------------

modX <- getHClust(cw_Alien_ReG,hctype = "rows")
modY <- getHClust(cw_Alien_ReG,hctype = "cols")



X<-modX$labels[modX$order]
Y<-modY$labels[modX$order]

ord<-list(X=X,Y=Y)

p_ReG <- plotCrosswiseMatrix(cw_Alien_ReG, matrix_type = "association", ord_mat = ord)
p_ReR <- plotCrosswiseMatrix(cw_Alien_ReR, matrix_type = "association", ord_mat = ord)


plot(p_ReG)
plot(p_ReR)


## -----------------------------------------------------------------------------

plot(modX,cex = 0.8)


## -----------------------------------------------------------------------------

p_ReG_cor <- plotCrosswiseMatrix(cw_Alien_ReG, matrix_type = "correlation", ord_mat = ord)
# p_ReR_cor <- plotCrosswiseMatrix(cw_Alien_ReR, matrix_type = "correlation", ord_mat = ord)

plot(p_ReG_cor)
# plot(p_ReR_cor)


## -----------------------------------------------------------------------------
plotSinglePT(cw_Alien_ReG, RS1 = "regA", RS2 = "regA_05")

## -----------------------------------------------------------------------------
  p_sPT1 <- plotSinglePT(cw_Alien_ReG, RS1 = "regA", RS2 = "regC")

plot(p_sPT1)

## -----------------------------------------------------------------------------

set.seed(42)

plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA")


## -----------------------------------------------------------------------------
set.seed(42)
p_cdr_hc <- plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA", clust_met = "hclust")

# set.seed(42)
# p_cdr_pam <- plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA", clust_met = "pam")

plot(p_cdr_hc) 
# plot(p_cdr_pam)
          

## -----------------------------------------------------------------------------

lsRegSet<-list(regA="regA",regB="regB",regC="regC")

set.seed(42)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA",listRS = lsRegSet)

set.seed(42)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="PCA",listRS = lsRegSet,ellipse = TRUE, emphasize =TRUE)

set.seed(67)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="tSNE",listRS = lsRegSet,ellipse = TRUE, emphasize =TRUE)

set.seed(67)
plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="UMAP",listRS = lsRegSet,ellipse = TRUE, emphasize =TRUE)


## -----------------------------------------------------------------------------
set.seed(67)
silTable <- plotCrosswiseDimRed(cw_Alien_ReG, nc = 6, type="UMAP",listRS = lsRegSet,return_table = TRUE)

silTable

## ----eval=FALSE---------------------------------------------------------------
# 
# #NOT RUN
# mlz_Alien_ReG<-multiLocalZscore(A = AlienRSList_narrow$regA,
#                  Blist = AlienRSList_narrow,
#                  ranFUN = "resampleGenome",
#                  evFUN = "numOverlaps",
#                  window = 100,
#                  step = 1,
#                  max_pv = 1,
#                  genome = AlienGenome)

## -----------------------------------------------------------------------------
getParameters(mLZ_regA_ReG)

mlz_Me <- getMultiEvaluation(rR = mLZ_regA_ReG )

head(mlz_Me$resumeTable)

## -----------------------------------------------------------------------------

mLZ_regA_ReG <- makeLZMatrix(mLZ_regA_ReG)

plot(getHClust(mLZ_regA_ReG),cex = 0.8)

## -----------------------------------------------------------------------------
plotLocalZScoreMatrix(mLZ_regA_ReG, maxVal = "max")

## -----------------------------------------------------------------------------
plotSingleLZ(mLZ = mLZ_regA_ReG, RS =c("regA"), smoothing = TRUE)

## -----------------------------------------------------------------------------
plotSingleLZ(mLZ = mLZ_regA_ReG,RS =c("regA","regA_02","regA_06","regA_08","regD"),smoothing = TRUE)

## -----------------------------------------------------------------------------
# average of the widths of AlienRSList_narrow
do.call("c",lapply(lapply(AlienRSList_narrow, width),mean))
# average of the widths of AlienRSList_broad
do.call("c",lapply(lapply(AlienRSList_broad, width),mean))

## ----eval=FALSE---------------------------------------------------------------
# 
# ##NOT RUN
# cw_Alien_RaR_no_Square <-  crosswisePermTest(
#   Alist = AlienRSList_narrow,
#   Blist = AlienRSList_broad,
#   sampling = FALSE,
#   genome = AlienGenome,
#   per.chromosome=TRUE,
#   ranFUN = "resampleGenome",
#   evFUN = "numOverlaps",
#   ntimes= 100,
#   mc.cores = 6
# )
# 
# ###

## -----------------------------------------------------------------------------
cw_Alien_ReG_no_Square <- makeCrosswiseMatrix(cw_Alien_ReG_no_Square)

plotCrosswiseMatrix(cw_Alien_ReG_no_Square)

## ----eval=FALSE---------------------------------------------------------------
# 
# #NOT RUN
# mLZ_regA_ReG_br<-multiLocalZscore(A =
#                                     AlienRSList_narrow$regA,
#                                   Blist = AlienRSList_broad,
#                                   ranFUN = "resampleGenome",
#                                   genome = AlienGenome,
#                                   window = 5000,
#                                   step =100)
# ##

## -----------------------------------------------------------------------------
mLZ_regA_ReG_br<-makeLZMatrix(mLZ_regA_ReG_br)

plotLocalZScoreMatrix(mLZ_regA_ReG_br)

## -----------------------------------------------------------------------------
plotSingleLZ(mLZ = mLZ_regA_ReG_br,RS =c("regA_br","regA_br_02","regA_br_06","regA_br_08","regD_br"), smoothing = TRUE)


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

