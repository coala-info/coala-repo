# Code example from 'mvtests' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"------------------------------------------------------------
knitr::opts_chunk$set(
  tidy = FALSE,
  cache = TRUE,
  dev = "png",
  package.startup.message = FALSE,
  message = FALSE,
  error = FALSE,
  warning = FALSE
)
options(width = 100)

## ----import---------------------------------------------------------------------------------------
library(readr)
library(tximport)
library(tximportData)

# specify directory
path <- system.file("extdata", package = "tximportData")

# read sample meta-data
samples <- read.table(file.path(path, "samples.txt"), header = TRUE)
samples.ext <- read.table(file.path(path, "samples_extended.txt"), header = TRUE, sep = "\t")

# read assignment of transcripts to genes
# remove genes on the PAR, since these are present twice
tx2gene <- read_csv(file.path(path, "tx2gene.gencode.v27.csv"))
tx2gene <- tx2gene[grep("PAR_Y", tx2gene$GENEID, invert = TRUE), ]

# read transcript-level quatifictions
files <- file.path(path, "salmon", samples$run, "quant.sf.gz")
txi <- tximport(files, type = "salmon", txOut = TRUE)

# Create metadata simulating two conditions
sampleTable <- data.frame(condition = factor(rep(c("A", "B"), each = 3)))
rownames(sampleTable) <- paste0("Sample", 1:6)

## ----dream----------------------------------------------------------------------------------------
library(variancePartition)
library(edgeR)

# Prepare transcript-level reads
dge <- DGEList(txi$counts)
design <- model.matrix(~condition, data = sampleTable)
isexpr <- filterByExpr(dge, design)
dge <- dge[isexpr, ]
dge <- calcNormFactors(dge)

# Estimate precision weights
vobj <- voomWithDreamWeights(dge, ~condition, sampleTable)

# Fit regression model one transcript at a time
fit <- dream(vobj, ~condition, sampleTable)
fit <- eBayes(fit)

## ----mvTest---------------------------------------------------------------------------------------
# Prepare transcript to gene mapping
# keep only transcripts present in vobj
# then convert to list with key GENEID and values TXNAMEs
keep <- tx2gene$TXNAME %in% rownames(vobj)
tx2gene.lst <- unstack(tx2gene[keep, ])

# Run multivariate test on entries in each feature set
# Default method is "FE.empirical", but use "FE" here to reduce runtime
res <- mvTest(fit, vobj, tx2gene.lst, coef = "conditionB", method = "FE")

# truncate gene names since they have version numbers
# ENST00000498289.5 -> ENST00000498289
res$ID.short <- gsub("\\..+", "", res$ID)

## ----zenith---------------------------------------------------------------------------------------
# must have zenith > v1.0.2
library(zenith)
library(GSEABase)

gs <- get_MSigDB("C1", to = "ENSEMBL")

df_gsa <- zenithPR_gsa(res$stat, res$ID.short, gs, inter.gene.cor = .05)

head(df_gsa)

## ----sessionInfo, echo=FALSE----------------------------------------------------------------------
sessionInfo()

