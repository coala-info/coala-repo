# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 100
)

## ----warning = FALSE, message = FALSE-----------------------------------------
library(maser)
library(rtracklayer)

# path to Hypoxia data
path <- system.file("extdata", file.path("MATS_output"),
                    package = "maser")
hypoxia <- maser(path, c("Hypoxia 0h", "Hypoxia 24h"), ftype = "ReadsOnTargetAndJunctionCounts")

## ----warning = FALSE, message = FALSE-----------------------------------------
hypoxia

## ----warning = FALSE, message = FALSE, eval=FALSE-----------------------------
# head(summary(hypoxia, type = "SE")[, 1:8])

## ----warning = FALSE, message = FALSE, echo=FALSE-----------------------------
knitr::kable(
  head(summary(hypoxia, type = "SE")[, 1:8])
)

## ----warning = FALSE, message = FALSE-----------------------------------------
hypoxia_filt <- filterByCoverage(hypoxia, avg_reads = 5)

## ----warning = FALSE, message = FALSE-----------------------------------------
hypoxia_top <- topEvents(hypoxia_filt, fdr = 0.05, deltaPSI = 0.1)
hypoxia_top


## ----warning = FALSE, message = FALSE-----------------------------------------
hypoxia_mib2 <- geneEvents(hypoxia_filt, geneS = "MIB2", fdr = 0.05, deltaPSI = 0.1)
print(hypoxia_mib2)

## ----warning = FALSE, message = FALSE-----------------------------------------

maser::display(hypoxia_mib2, "SE")


## ----warning = FALSE, message = FALSE-----------------------------------------
plotGenePSI(hypoxia_mib2, type = "SE", show_replicates = TRUE)

## ----warning = FALSE, message = FALSE, fig.small = TRUE-----------------------
volcano(hypoxia_filt, fdr = 0.05, deltaPSI = 0.1, type = "SE")

## ----warning = FALSE, message = FALSE, fig.small = TRUE-----------------------
dotplot(hypoxia_top, type = "SE")

## ----warning = FALSE, message = FALSE-----------------------------------------
## Ensembl GTF annotation
gtf_path <- system.file("extdata", file.path("GTF","Ensembl85_examples.gtf.gz"),
                        package = "maser")
ens_gtf <- rtracklayer::import.gff(gtf_path)


## ----warning = FALSE, message = FALSE-----------------------------------------
## Retrieve SRSF6 splicing events
srsf6_events <- geneEvents(hypoxia_filt, geneS = "SRSF6", fdr = 0.05, 
                           deltaPSI = 0.1 )

## Dislay affected transcripts and PSI levels
plotTranscripts(srsf6_events, type = "SE", event_id = 33209,
                gtf = ens_gtf, zoom = FALSE, show_PSI = TRUE)


## ----warning = FALSE, message = FALSE-----------------------------------------
stat2_events <- geneEvents(hypoxia_filt, geneS = "STAT2", fdr = 0.05, deltaPSI = 0.1 )
plotTranscripts(stat2_events, type = "RI", event_id = 3785, 
                gtf = ens_gtf, zoom = FALSE)


## ----warning = FALSE, message = FALSE-----------------------------------------
il32_events <- geneEvents(hypoxia_filt, geneS = "IL32", fdr = 0.05, deltaPSI = 0.1 )
plotTranscripts(il32_events, type = "MXE", event_id = 1136,
                gtf = ens_gtf, zoom = FALSE)

## ----warning = FALSE, message = FALSE-----------------------------------------
#A5SS event
bcs1l_gene <- geneEvents(hypoxia_filt, geneS = "BCS1L", fdr = 0.05, deltaPSI = 0.1 )
plotTranscripts(bcs1l_gene, type = "A5SS", event_id = 3988, 
                gtf = ens_gtf, zoom = TRUE)


## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

