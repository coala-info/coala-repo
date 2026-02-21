# Code example from 'recountmethylation_pwrewas' vignette. See references/ for full tutorial.

## ----chunk_settings, eval = T, echo = F---------------------------------------
library(knitr)
library(ggplot2)
library(recountmethylation)
knitr::opts_chunk$set(eval = FALSE, echo = TRUE, 
                      warning = FALSE, message = FALSE)

## ----setup, eval = T, echo = F------------------------------------------------
# get the system load paths
dpath <- system.file(package = "recountmethylation", 
                     "extdata", "pwrewas_files")
# load example summary statistics
dfpwr <- get(load(file.path(dpath, "dfpwr_test_pwrewas.rda")))
lpwr <- get(load(file.path(dpath, "lpwr-results_pwrewas-example.rda")))

## -----------------------------------------------------------------------------
# revised_function_url <- paste0("https://github.com/metamaden/pwrEWAS/", "blob/master/inst/revised_functions/pwrEWAS_revised.R?raw=TRUE")
# devtools::source_url(revised_function_url)

## -----------------------------------------------------------------------------
# library(minfiData)
# data("MsetEx") # load MethylSet
# ms <- MsetEx
# bval <- getBeta(ms) # get DNAm fractions
# # get the summary data frame
# dfpwr <- data.frame(mu = rowMeans(bval, na.rm = T),
#                     var = rowVars(bval, na.rm = T))

## ----eval = T, message = T----------------------------------------------------
head(dfpwr)

## -----------------------------------------------------------------------------
# ttype <- dfpwr               # tissueType
# mintss <- 10                 # minTotSampleSize
# maxtss <- 1000               # maxTotSampleSize
# sstep <- 100                 # SampleSizeSteps
# tdeltav <- c(0.05, 0.1, 0.2) # targetDelta
# dmethod <- "limma"           # DMmethod
# fdr <- 0.05                  # FDRcritVal
# nsim <- 20                   # sims
# j <- 1000                    # J
# ndmp <- 50                   # targetDmCpGs
# detlim <- 0.01               # detectionLimit
# maxctau <- 100               # maxCnt.tau
# ncntper <- 0.5               # NcntPer

## -----------------------------------------------------------------------------
# set.seed(0)
# lpwr.c2 <- pwrEWAS_itable(core = 2,
#                           tissueType = ttype, minTotSampleSize = mintss,
#                           maxTotSampleSize = maxtss, SampleSizeSteps = sstep,
#                           NcntPer = ncntper, targetDelta = tdeltav, J = j,
#                           targetDmCpGs = ndmp, detectionLimit = detlim,
#                           DMmethod = dmethod, FDRcritVal = fdr,
#                           sims = nsim, maxCnt.tau = maxctau)
# # [2022-02-17 13:44:51] Finding tau...done [2022-02-17 13:45:06]
# # [1] "The following taus were chosen: 0.013671875, 0.02734375, 0.0546875"
# # [2022-02-17 13:45:06] Running simulation
# # [2022-02-17 13:45:06] Running simulation ... done [2022-02-17 13:48:23]

## ----eval = T-----------------------------------------------------------------
lpwr <- lpwr.c1           # get results from an above example
mp <- lpwr[["meanPower"]] # get the mean power table

## -----------------------------------------------------------------------------
# dim(mp) # get the dimensions of mean power table

## -----------------------------------------------------------------------------
# head(mp) # get first rows of mean power table

## ----eval = T-----------------------------------------------------------------
pa <- lpwr$powerArray # get power array

## ----eval = T-----------------------------------------------------------------
length(pa) # get length of power array

## ----eval = T-----------------------------------------------------------------
mean(pa[1:20]) == mp[1,1] # compare means, power array vs. mean power table

## ----eval = T-----------------------------------------------------------------
# extract power values from the array of matrices
parr <- pa
m1 <- data.frame(power = parr[1:200])   # first delta power values
m2 <- data.frame(power = parr[201:400]) # second delta power values
m3 <- data.frame(power = parr[401:600]) # third delta power values
# assign total samples to power values
m1$total.samples <- m2$total.samples <- 
  m3$total.samples <- rep(seq(10, 910, 100), each = 20)
# add delta labels
m1$`Delta\nDNAm` <- rep("0.05", 200)
m2$`Delta\nDNAm` <- rep("0.1", 200)
m3$`Delta\nDNAm` <- rep("0.2", 200)
# make the tall data frame for plotting
dfp <- rbind(m1, rbind(m2, m3))

## ----eval = T-----------------------------------------------------------------
ggplot(dfp, aes(x = total.samples, y = power, color = `Delta\nDNAm`)) +
  geom_smooth(se = T, method = "loess") + theme_bw() + xlab("Total samples") + 
  ylab("Power") + geom_hline(yintercept = 0.8, color = "black", linetype = "dotted")

## ----eval = T-----------------------------------------------------------------
utils::sessionInfo()

