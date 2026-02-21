# Code example from 'Protein_mapping' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  dpi = 100
)

## ----warning = FALSE, message = FALSE-----------------------------------------
library(maser)
library(rtracklayer)

# Creating maser object using hypoxia dataset
path <- system.file("extdata", file.path("MATS_output"),
                    package = "maser")
hypoxia <- maser(path, c("Hypoxia 0h", "Hypoxia 24h"))

# Remove low coverage events
hypoxia_filt <- filterByCoverage(hypoxia, avg_reads = 5)


## ----warning = FALSE, message = FALSE, echo=FALSE-----------------------------
knitr::kable(
  head(availableFeaturesUniprotKB(), 10)
)


## ----warning = FALSE, message = FALSE-----------------------------------------
## Ensembl GTF annotation
gtf_path <- system.file("extdata", file.path("GTF","Ensembl85_examples.gtf.gz"),
                        package = "maser")
ens_gtf <- rtracklayer::import.gff(gtf_path)


## ----warning = FALSE, message = FALSE-----------------------------------------
# Retrieve gene specific splicing events
srsf6_events <- geneEvents(hypoxia_filt, "SRSF6")
srsf6_events


## ----warning = FALSE, message = FALSE-----------------------------------------
# Map transcripts to splicing events
srsf6_mapped <- mapTranscriptsToEvents(srsf6_events, ens_gtf)


## ----warning = FALSE, message = FALSE, eval=FALSE-----------------------------
# head(annotation(srsf6_mapped, "SE"))

## ----warning = FALSE, message = FALSE, echo=FALSE-----------------------------
knitr::kable(
  head(annotation(srsf6_mapped, "SE"))
)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Annotate splicing events with protein features
srsf6_annot <- mapProteinFeaturesToEvents(srsf6_mapped, c("Domain_and_Sites", "Topology"), by="category")


## ----warning = FALSE, message = FALSE, eval=FALSE-----------------------------
# head(annotation(srsf6_annot, "SE"))

## ----warning = FALSE, message = FALSE, echo=FALSE-----------------------------
knitr::kable(
  head(annotation(srsf6_annot, "SE"))
)


## ----warning = FALSE, message = FALSE-----------------------------------------

# Plot splice event, transcripts and protein features
plotUniprotKBFeatures(srsf6_mapped, "SE", event_id = 33209, gtf = ens_gtf, 
   features = c("domain", "chain"), show_transcripts = TRUE)


## ----warning = FALSE, message = FALSE-----------------------------------------

ripk2_events <- geneEvents(hypoxia_filt, "RIPK2")
ripk2_mapped <- mapTranscriptsToEvents(ripk2_events, ens_gtf)
ripk2_annot <- mapProteinFeaturesToEvents(ripk2_mapped, 
                                          tracks = c("Domain_and_Sites"), 
                                          by = "category")


## ----warning = FALSE, message = FALSE-----------------------------------------
plotUniprotKBFeatures(ripk2_annot, type = "SE", event_id = 14319, 
                      features = c("domain", "binding", "act-site"), gtf = ens_gtf, 
                      zoom = FALSE, show_transcripts = TRUE)


## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

