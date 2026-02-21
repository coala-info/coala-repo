# Code example from 'bsseq_analysis' vignette. See references/ for full tutorial.

## ----dependencies, warning=FALSE, message=FALSE-------------------------------
library(bsseq)
library(bsseqData)

## ----showData-----------------------------------------------------------------
data(BS.cancer.ex)
BS.cancer.ex <- updateObject(BS.cancer.ex)
BS.cancer.ex
pData(BS.cancer.ex)

## ----smooth,eval=FALSE--------------------------------------------------------
# BS.cancer.ex.fit <- BSmooth(
#     BSseq = BS.cancer.ex,
#     BPPARAM = MulticoreParam(workers = 1),
#     verbose = TRUE)

## ----showDataFit--------------------------------------------------------------
data(BS.cancer.ex.fit)
BS.cancer.ex.fit <- updateObject(BS.cancer.ex.fit)
BS.cancer.ex.fit

## ----cpgNumbers---------------------------------------------------------------
## The average coverage of CpGs on the two chromosomes
round(colMeans(getCoverage(BS.cancer.ex)), 1)
## Number of CpGs in two chromosomes
length(BS.cancer.ex)
## Number of CpGs which are covered by at least 1 read in all 6 samples
sum(rowSums(getCoverage(BS.cancer.ex) >= 1) == 6)
## Number of CpGs with 0 coverage in all samples
sum(rowSums(getCoverage(BS.cancer.ex)) == 0)

## ----poisson------------------------------------------------------------------
logp <- ppois(0, lambda = 4, lower.tail = FALSE, log.p = TRUE)
round(1 - exp(6 * logp), 3)

## ----smoothSplit,eval=FALSE---------------------------------------------------
# ## Split datag
# BS1 <- BS.cancer.ex[, 1]
# save(BS1, file = "BS1.rda")
# BS2 <- BS.cancer.ex[, 2]
# save(BS1, file = "BS1.rda")
# ## done splitting
# 
# ## Do the following on each node
# 
# ## node 1
# load("BS1.rda")
# BS1.fit <- BSmooth(BS1)
# save(BS1.fit)
# save(BS1.fit, file = "BS1.fit.rda")
# ## done node 1
# 
# ## node 2
# load("BS2.rda")
# BS2.fit <- BSmooth(BS2)
# save(BS2.fit, file = "BS2.fit.rda")
# ## done node 2
# 
# ## join; in a new R session
# load("BS1.fit.rda")
# load("BS2.fit.rda")
# BS.fit <- combine(BS1.fit, BS2.fit)

## ----keepLoci-----------------------------------------------------------------
BS.cov <- getCoverage(BS.cancer.ex.fit)
keepLoci.ex <- which(rowSums(BS.cov[, BS.cancer.ex$Type == "cancer"] >= 2) >= 2 &
                     rowSums(BS.cov[, BS.cancer.ex$Type == "normal"] >= 2) >= 2)
length(keepLoci.ex)
BS.cancer.ex.fit <- BS.cancer.ex.fit[keepLoci.ex,]

## ----BSmooth.tstat------------------------------------------------------------
BS.cancer.ex.tstat <- BSmooth.tstat(BS.cancer.ex.fit, 
                                    group1 = c("C1", "C2", "C3"),
                                    group2 = c("N1", "N2", "N3"), 
                                    estimate.var = "group2",
                                    local.correct = TRUE,
                                    verbose = TRUE)
BS.cancer.ex.tstat

## ----plotTstat,fig.width=4,fig.height=4---------------------------------------
plot(BS.cancer.ex.tstat)

## ----dmrs---------------------------------------------------------------------
dmrs0 <- dmrFinder(BS.cancer.ex.tstat, cutoff = c(-4.6, 4.6))
dmrs <- subset(dmrs0, n >= 3 & abs(meanDiff) >= 0.1)
nrow(dmrs)
head(dmrs, n = 3)

## ----plotSetup----------------------------------------------------------------
pData <- pData(BS.cancer.ex.fit)
pData$col <- rep(c("red", "blue"), each = 3)
pData(BS.cancer.ex.fit) <- pData

## ----plotDmr,fig.width=8,fig.height=4-----------------------------------------
plotRegion(BS.cancer.ex.fit, dmrs[1,], extend = 5000, addRegions = dmrs)

## ----plotManyRegions,eval=FALSE-----------------------------------------------
# pdf(file = "dmrs_top200.pdf", width = 10, height = 5)
# plotManyRegions(BS.cancer.ex.fit, dmrs[1:200,], extend = 5000,
#                 addRegions = dmrs)
# dev.off()

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

