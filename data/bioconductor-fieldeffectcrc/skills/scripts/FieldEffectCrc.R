# Code example from 'FieldEffectCrc' vignette. See references/ for full tutorial.

## ----install-packages, eval=FALSE---------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install(c("SummarizedExperiment", "ExperimentHub", "FieldEffectCrc"))

## ----load-hub-----------------------------------------------------------------
library(SummarizedExperiment)
library(ExperimentHub)

## ----find-data----------------------------------------------------------------
hub = ExperimentHub()
## simply list the resource names
ns <- listResources(hub, "FieldEffectCrc")
ns
## query the hub for full metadata
crcData <- query(hub, "FieldEffectCrc")
crcData
## extract metadata
df <- mcols(crcData)
df
## see where the cache is stored
hc <- hubCache(crcData)
hc

## ----explore-file-------------------------------------------------------------
md <- hub["EH3524"]
md

## ----download-data------------------------------------------------------------
## using resource ID
data1 <- hub[["EH3524"]]
data1
## using loadResources()
data2 <- loadResources(hub, "FieldEffectCrc", "cohort A")
data2

## ----phenotypes---------------------------------------------------------------
summary(colData(data1)$sampType)

## ----quick-start-1------------------------------------------------------------
se <- data1
counts1 <- assays(se)[["counts"]]

## ----quick-start-2------------------------------------------------------------
counts2 <- assay(se, 2)

## ----quick-start-3------------------------------------------------------------
all(counts1==counts2)

## ----make-txi-----------------------------------------------------------------
## manual construction
txi <- as.list(assays(se))
txi$countsFromAbundance <- "no"
## convenience function construction
txi <- make_txi(se)

## ----make-dds-----------------------------------------------------------------
if (!requireNamespace("DESeq2", quietly=TRUE)) {
    BiocManager::install("DESeq2")
}
library(DESeq2)
dds <- DESeqDataSetFromTximport(txi, colData(se), ~ sampType)

## ----typical-filter-----------------------------------------------------------
countLimit <- 10
sampleLimit <- (1/3) * ncol(dds)
keep <- rowSums( counts(dds) > countLimit ) >= sampleLimit
dds <- dds[keep, ]

## ----special-filter-----------------------------------------------------------
r <- sample(seq_len(nrow(dds)), 6000)
c <- sample(seq_len(ncol(dds)), 250)
dds <- dds[r, c]
r <- rowSums(counts(dds)) >= 10
dds <- dds[r, ]

## ----size-factors-------------------------------------------------------------
dds <- DESeq(dds)

## ----prep-input---------------------------------------------------------------
dat <- counts(dds, normalized=TRUE)  ## extract the normalized counts
mod <- model.matrix(~sampType, data=colData(dds))  ## set the full model
mod0 <- model.matrix(~1, data=colData(dds))  ## set the null model

## ----get-nsv------------------------------------------------------------------
if (!requireNamespace("sva", quietly=TRUE)) {
    BiocManager::install("sva")
}
library(sva)
nsv <- num.sv(dat, mod, method=c("be"), B=20, seed=1)  ## Buja Eyuboglu method

## ----get-svs------------------------------------------------------------------
svs <- svaseq(dat, mod, mod0, n.sv=nsv)

## ----add-svs------------------------------------------------------------------
for (i in seq_len(svs$n.sv)) {
    newvar <- paste0("sv", i)
    colData(dds)[ , newvar] <- svs$sv[, i]
}
nvidx <- (ncol(colData(dds)) - i + 1):ncol(colData(dds))
newvars <- colnames(colData(dds))[nvidx]
d <- formula(
    paste0("~", paste(paste(newvars, collapse="+"), "sampType", sep="+"))
)
design(dds) <- d

## ----test-de------------------------------------------------------------------
dds <- DESeq(dds)

## ----results------------------------------------------------------------------
cons <- list()
m <- combn(levels(colData(dds)$sampType), 2)
for (i in seq_len(ncol(m))) {
    cons[[i]] <- c("sampType", rev(m[, i]))
    names(cons) <- c(
        names(cons)[seq_len(length(cons) - 1)], paste(rev(m[, i]), collapse="v")
    )
}
res <- list()
for (i in seq_len(length(cons))) {
    res[[i]] <- results(dds, contrast=cons[[i]], alpha=0.05)  ## default alpha is 0.1
}
names(res) <- names(cons)

## ----display------------------------------------------------------------------
lapply(res, head)
lapply(res, summary)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

