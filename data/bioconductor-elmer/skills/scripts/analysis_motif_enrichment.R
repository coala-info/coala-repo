# Code example from 'analysis_motif_enrichment' vignette. See references/ for full tutorial.

## ----echo = FALSE,hide=TRUE, message=FALSE, warning=FALSE---------------------
library(ELMER.data)
library(ELMER)
library(DT)
library(dplyr)
library(BiocStyle)

## ----eval=TRUE, message=FALSE, warning = FALSE,results = "hide"---------------
# Load results from previous sections
mae <- get(load("mae.rda"))
sig.diff <- read.csv("result/getMethdiff.hypo.probes.significant.csv")
pair <- read.csv("result/getPair.hypo.pairs.significant.csv")
head(pair) # significantly hypomethylated probes with putative target genes

# Identify enriched motif for significantly hypomethylated probes which 
# have putative target genes.

enriched.motif <- get.enriched.motif(
  data = mae,
  probes = pair$Probe, 
  dir.out = "result", 
  label = "hypo",
  min.incidence = 10,
  lower.OR = 1.1
)

## ----eval=TRUE, message=FALSE, warning = FALSE--------------------------------
names(enriched.motif) # enriched motifs
head(enriched.motif[names(enriched.motif)[1]]) ## probes in the given set that have the first motif.

# get.enriched.motif automatically save output files. 
# getMotif.hypo.enriched.motifs.rda contains enriched motifs and the probes with the motif. 
# getMotif.hypo.motif.enrichment.csv contains summary of enriched motifs.
dir(path = "result", pattern = "getMotif") 

# motif enrichment figure will be automatically generated.
dir(path = "result", pattern = "motif.enrichment.pdf") 

