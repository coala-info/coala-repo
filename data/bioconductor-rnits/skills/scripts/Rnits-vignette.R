# Code example from 'Rnits-vignette' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----setup, include=FALSE, cache=FALSE----------------------------------------
library(knitr)
# set global chunk options
opts_knit$set(base.dir = '.')
opts_chunk$set(fig.path='figure/minimal-', fig.align='center', fig.show='hold')
options(replace.assign=TRUE,width=80)

## ----loaddata, cache=TRUE, warning=FALSE, tidy=TRUE, dependson='data_import'----
# Download NCBI GEO data with GEOquery
library(knitr)
rm(list = ls())
library(GEOquery)
library(stringr)
library(Rnits)
gds <- getGEO('GSE4158', AnnotGPL = FALSE)[[1]]
class(gds)
gds

# Extract non-replicate samples
pdata <- pData(gds)
filt <- pdata$characteristics_ch2 %in% names(which(table(pdata$characteristics_ch2) == 2))
gds <- gds[, filt]
pdata <- pData(gds)
time <- as.numeric(str_extract(pdata$characteristics_ch2, "\\d+"))
sample <- rep("2g/l", length(time))
sample[grep("0.2g/l", gds[["title"]])] <- "0.2g/l"

# Format phenotype data with time and sample information
gds[["Time"]] <- time
gds[["Sample"]] <- sample
dat <- gds
fData(dat)["Gene Symbol"] <- fData(dat)$ORF

## ----buildrnitsobj, tidy=TRUE, cache=TRUE, dependson='loaddata'---------------
# Build rnits data object from formatted data (samples can be in any order)
# and between-array normalization.
rnitsobj = build.Rnits(dat[, sample(ncol(dat))], logscale = TRUE, normmethod = "Between")
rnitsobj


# Alternatively, we can also build the object from just a data matrix, by supplying the "probedata" and "phenodata" tables
datdf <-  exprs(dat)
rownames(datdf) <- fData(dat)$ID
probedata <- data.frame(ProbeID=fData(dat)$ID, GeneName=fData(dat)$ORF)
phenodata <- pData(dat)
rnitsobj0 = build.Rnits(datdf, probedata = probedata, phenodata = phenodata, logscale = TRUE, normmethod = 'Between')

# Extract normalized expression values
lr <- getLR(rnitsobj)
head(lr)

# Impute missing values using K-nn imputation
lr <- getLR(rnitsobj, impute = TRUE)
head(lr)


## ----fit_model, cache=TRUE, fig.keep='first', dependson='buildrnitsobj'-------

# Fit model using gene-level summarization
rnitsobj <- fit(rnitsobj0, gene.level = TRUE, clusterallsamples = TRUE)

## ----fit_model_noclustering, eval=FALSE, dependson='buildrnitsobj'------------
# rnitsobj_nocl <- fit(rnitsobj0, gene.level = TRUE, clusterallsamples = FALSE)
# 
# opt_model <- calculateGCV(rnitsobj0)
# rnitsobj_optmodel <- fit(rnitsobj0, gene.level = TRUE, model = opt_model)

## ----modelsummary, cache=TRUE, dependson='fit_model',  tidy=TRUE--------------

# Get pvalues from fitted model
pval <- getPval(rnitsobj)
head(pval)

# Get ratio statistics from fitted model
stat <- getStat(rnitsobj)
head(stat)


# If clustering was used, check the cluster gene distribution
table(getCID(rnitsobj))

# P-values, ratio statistics and cluster ID's can be retrieved for all genes together
fitdata <- getFitModel(rnitsobj)
head(fitdata)

# View summary of top genes
summary(rnitsobj, top = 10)

# Extract data of top genes (5% FDR)
td <- topData(rnitsobj, fdr = 5)
head(td)

## ----plotresults, dependson='modelsummary', cache=TRUE, tidy=TRUE-------------
# Plot top genes trajectories
plotResults(rnitsobj, top = 16)



## ----sessionInfo--------------------------------------------------------------
sessionInfo()

