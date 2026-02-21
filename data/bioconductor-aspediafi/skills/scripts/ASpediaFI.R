# Code example from 'ASpediaFI' vignette. See references/ for full tutorial.

## ----include=FALSE--------------------------------------------------------------
library(knitr)
opts_chunk$set(concordance = TRUE, comment = NA)
options(scipen = 1, digits = 2, warn = -1, width = 82)

## ----Install,message=FALSE,eval=FALSE-------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("ASpediaFI")

## ----LoadPackage,message=FALSE--------------------------------------------------
#Load the ASpediaFI package
library(ASpediaFI)
names(getSlots("ASpediaFI"))

## ----detectEvent,message=FALSE--------------------------------------------------
#Create ASpediaFI object
bamWT <- system.file("extdata/GSM3167290.subset.bam", package = "ASpediaFI")
GSE114922.ASpediaFI <- ASpediaFI(sample.names = "GSM3167290",
                                    bam.files = bamWT, conditions = "WT")

#Detect and annotate AS events from a subset of the hg38 GTF file
gtf <- system.file("extdata/GRCh38.subset.gtf", package = "ASpediaFI")
GSE114922.ASpediaFI <- annotateASevents(GSE114922.ASpediaFI,
                                        gtf.file = gtf, num.cores = 1)
sapply(events(GSE114922.ASpediaFI), length)
head(events(GSE114922.ASpediaFI)$SE)

## ----quantifyEvent,message=FALSE------------------------------------------------
#Compute PSI values of AS events
GSE114922.ASpediaFI <- quantifyPSI(GSE114922.ASpediaFI, read.type = "paired",
                                    read.length = 100, insert.size = 300,
                                    min.reads = 3, num.cores = 1)
tail(assays(psi(GSE114922.ASpediaFI))[[1]])

## ----loadData,message=FALSE-----------------------------------------------------
#Load PSI and gene expression data
data("GSE114922.fpkm")
data("GSE114922.psi")

#Update the "samples" and "psi" fields
psi(GSE114922.ASpediaFI) <- GSE114922.psi
samples(GSE114922.ASpediaFI) <- as.data.frame(colData(GSE114922.psi))

head(samples(GSE114922.ASpediaFI))

## ----prepareQuery,message=FALSE-------------------------------------------------
#Choose query genes based on differential expression
library(limma)

design <- cbind(WT = 1, MvsW = samples(GSE114922.ASpediaFI)$condition == "MUT")
fit <- lmFit(log2(GSE114922.fpkm + 1), design = design)
fit <- eBayes(fit, trend = TRUE)
tt <- topTable(fit, number = Inf, coef = "MvsW")
query <- rownames(tt[tt$logFC > 1 &tt$P.Value < 0.1,])
head(query)

## ----analyzeFI,message=FALSE,fig.height=5,fig.cap="Cross-validation performance of DRaWR",fig.pos="H"----
#Perform functional interaction analysis of AS events
GSE114922.ASpediaFI <- analyzeFI(GSE114922.ASpediaFI, query = query,
                                    expr = GSE114922.fpkm, restart = 0.9,
                                    num.folds = 5, num.feats = 200,
                                    low.expr = 1, low.var = 0, prop.na = 0.05,
                                    prop.extreme = 1, cor.threshold = 0.3)

## ----tables,message=FALSE-------------------------------------------------------
#Table of AS nodes in the final subnetwork
as.table(GSE114922.ASpediaFI)[1:5, 2:5]

#Table of GS nodes in the final subnetwork
pathway.table(GSE114922.ASpediaFI)[1:5, 1:11]

## ----Network,message=FALSE------------------------------------------------------
#Extract AS-gene interactions from the final subnetwork
library(igraph)
edges <- as_data_frame(network(GSE114922.ASpediaFI))
AS.gene.interactions <- edges[edges$type == "AS", c("from", "to")]

head(AS.gene.interactions)

## ----Export,message=FALSE-------------------------------------------------------
#Export a pathway-specific subnetwork to GML format
exportNetwork(GSE114922.ASpediaFI, node = "HALLMARK_HEME_METABOLISM",
                file = "heme_metabolism.gml")

## ----VizAS,message=FALSE,fig.pos="H",fig.cap="AS event visualization",fig.height=5.5----
#Check if any event on the HMBS gene is included in the final subnetwork 
as.nodes <- as.table(GSE114922.ASpediaFI)$EventID
HMBS.event <- as.nodes[grep("HMBS", as.nodes)]
  
#Visualize event
visualize(GSE114922.ASpediaFI, node = HMBS.event, zoom = FALSE)

## ----VizGS,message=FALSE,fig.pos="H",fig.cap="Pathway visulization",fig.height=5----
#Visualize nework pertaining to specific pathway
visualize(GSE114922.ASpediaFI, node = "HALLMARK_HEME_METABOLISM", n = 10)

## ----sessionInfo----------------------------------------------------------------
sessionInfo()

