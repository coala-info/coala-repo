# Code example from 'zFPKM' vignette. See references/ for full tutorial.

## ----reproducible_settings, echo=FALSE----------------------------------------
rm(list=ls())
set.seed(8675309)
options(stringsAsFactors=FALSE)
library(printr)

knitr::opts_chunk$set(message=FALSE, fig.align="center", fig.width=8, fig.height=6)

## -----------------------------------------------------------------------------
library(dplyr)
library(GEOquery)
library(stringr)
library(SummarizedExperiment)
library(tidyr)

getSpecificGEOSupp <- function(url) {
  temp <- tempfile()
  download.file(url, temp)
  out <- read.csv(gzfile(temp), row.names=1, check.names=FALSE)
  out <- select(out, -MGI_Symbol)
  return(out)
}

gse94802_fpkm <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE94nnn/GSE94802/suppl/GSE94802_Minkina_etal_normalized_FPKM.csv.gz"
gse94802_counts <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE94nnn/GSE94802/suppl/GSE94802_Minkina_etal_raw_counts.csv.gz"

if (file.exists("gse94802.rds")) {
  esetlist <- readRDS("gse94802.rds")
} else {
  esetlist <- getGEO("gse94802")
}

doe <- pData(esetlist[[1]])

colData <- DataFrame(
  condition=ifelse(str_detect(doe$title, regex("control", ignore_case=TRUE)), "control", "mutant"),
  sample_id=str_match(doe$title, "rep\\d_(.+)")[, 2],
  row.names=str_match(doe$title, "rep\\d_(.+)")[, 2])

se <- SummarizedExperiment(assays=SimpleList(fpkm=getSpecificGEOSupp(gse94802_fpkm),
                                             counts=getSpecificGEOSupp(gse94802_counts)),
                           colData=colData)

# clear namespace
rm(esetlist, gse94802_fpkm, gse94802_counts, doe, colData, getSpecificGEOSupp)

## -----------------------------------------------------------------------------
library(zFPKM)
assay(se, "zfpkm") <- zFPKM(se)

## -----------------------------------------------------------------------------
zFPKMPlot(se)

## -----------------------------------------------------------------------------
activeGenes <- assay(se, "zfpkm") %>%
  mutate(gene=rownames(assay(se, "zfpkm"))) %>%
  gather(sample_id, zfpkm, -gene) %>%
  left_join(select(as.data.frame(colData(se)), sample_id, condition), by="sample_id") %>%
  group_by(gene, condition) %>%
  summarize(median_zfpkm=median(zfpkm)) %>%
  ungroup() %>%
  mutate(active=(median_zfpkm > -3)) %>%
  filter(active) %>%
  select(gene) %>%
  distinct()

seActive <- SummarizedExperiment(
  assays=SimpleList(counts=as.matrix(assay(se, "counts")[activeGenes$gene, ])),
  colData=colData(se))

## -----------------------------------------------------------------------------
library(limma)
library(edgeR)

# Generate normalized log2CPM from counts AFTER we filter for protein-coding
# genes that are detectably expressed.
dge <- DGEList(counts=assay(seActive, "counts"))
dge <- calcNormFactors(dge)
design <- model.matrix(~ 0 + condition, data=colData(seActive))
vq <- voomWithQualityWeights(dge, design, plot=TRUE)
fit <- lmFit(vq, design)
contrastMatrix <- makeContrasts(conditioncontrol - conditionmutant, levels=design)
fit <- contrasts.fit(fit, contrastMatrix)
fit <- eBayes(fit, robust=TRUE)
deGenes <- topTable(fit, number=Inf)

## -----------------------------------------------------------------------------
sessionInfo()

