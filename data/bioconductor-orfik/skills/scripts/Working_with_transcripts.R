# Code example from 'Working_with_transcripts' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
library(ORFik)
organism <- "Saccharomyces cerevisiae" # Baker's yeast
output_dir <- tempdir(TRUE) # Let's just store it to temp
# If you already downloaded, it will not redownload, but reuse those files.
annotation <- getGenomeAndAnnotation(
                    organism = organism,
                    output.dir = output_dir,
                    assembly_type = "toplevel"
                    )
genome <- annotation["genome"]
gtf <- annotation["gtf"]
txdb_path <- paste0(gtf, ".db")
txdb <- loadTxdb(txdb_path)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
## TSS
startSites(loadRegion(txdb, "leaders"), asGR = TRUE, is.sorted = TRUE)
# Equal to:
startSites(loadRegion(txdb, "mrna"), asGR = TRUE, is.sorted = TRUE)
## TIS
startSites(loadRegion(txdb, "cds"), asGR = TRUE, is.sorted = TRUE)
## TTS
stopSites(loadRegion(txdb, "cds"), asGR = TRUE, is.sorted = TRUE)
## TES
stopSites(loadRegion(txdb, "mrna"), asGR = TRUE, is.sorted = TRUE)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
mrna <- loadRegion(txdb, "mrna")
## TSS
startRegion(loadRegion(txdb, "mrna"), upstream = 30, downstream = 30, is.sorted = TRUE)
## TIS
startRegion(loadRegion(txdb, "cds"), mrna, upstream = 30, downstream = 30, is.sorted = TRUE)
## TTS
stopRegion(loadRegion(txdb, "cds"), mrna, upstream = 30, downstream = 30, is.sorted = TRUE)
## TES
stopRegion(loadRegion(txdb, "mrna"), upstream = 30, downstream = 30, is.sorted = TRUE)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# TSS genomic extension
extendLeaders(startRegion(mrna[1], upstream = -1, downstream = 30, is.sorted = TRUE), 30)
# TES genomic extension
extendTrailers(stopRegion(mrna[1], upstream = 30, downstream = 0, is.sorted = TRUE), 30)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
df <- ORFik.template.experiment()
df

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
df <- df[9,]
df

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
ribo <- fimport(filepath(df, "default"))

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
table(readWidths(ribo))

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
summary(score(ribo))

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
paste("Number of collapsed:", length(ribo), 
      "Number of non-collapsed:", sum(score(ribo)))
paste("duplication rate:", round(1 - length(ribo)/sum(score(ribo)), 2) * 100, "%")

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
TIS_window <- startRegion(loadRegion(df, "cds"), loadRegion(df, "mrna"), 
                is.sorted = TRUE, upstream = 20, downstream = 20)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------

countOverlapsW(TIS_window, ribo, weight = "score") # score is the number of pshifted RFP peaks at respective position
# This is shorter version (You do not need TIS_window defined first) ->
startRegionCoverage(loadRegion(df, "cds"), ribo, loadRegion(df, "mrna"), 
                    is.sorted = TRUE, upstream = 20, downstream = 20)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# TIS region coverage
coveragePerTiling(TIS_window, ribo)[1:3]

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# TIS region coverage
dt <- coveragePerTiling(TIS_window, ribo, as.data.table = TRUE)
head(dt)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# TIS region coverage
dt <- coveragePerTiling(TIS_window, ribo, as.data.table = TRUE, withFrames = TRUE)
# Rescale 0 to position 21
dt[, position := position - 21]
pSitePlot(dt)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
# Define transcript with valid UTRs and lengths
txNames <- filterTranscripts(df, 25, 25,0, longestPerGene = TRUE)
# TIS region coverage
dt <- windowPerReadLength(loadRegion(df, "cds", txNames), loadRegion(df, "mrna", txNames), ribo)
# Remember to set scoring to scoring used above for dt
coverageHeatMap(dt, scoring = "transcriptNormalized")

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
dt <- regionPerReadLength(loadRegion(df, "cds", txNames)[1], ribo, 
                          exclude.zero.cov.grl = FALSE, drop.zero.dt = FALSE)
# Remember to set scoring to scoring used above for dt
coverageHeatMap(dt, scoring = NULL)

