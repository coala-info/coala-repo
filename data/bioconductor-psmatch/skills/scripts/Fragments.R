# Code example from 'Fragments' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----setup, message = FALSE, echo = FALSE-------------------------------------
library("PSMatch")

## ----message = FALSE----------------------------------------------------------
(spf <- msdata::proteomics(pattern = "2014", full.names = TRUE))
library(Spectra)
sp <- Spectra(spf)

## -----------------------------------------------------------------------------
(idf <- msdata::ident(pattern = "2014", full.names = TRUE))
id <- PSM(idf) |> filterPSMs()
id

## -----------------------------------------------------------------------------
sp <- joinSpectraData(sp, id, by.x = "spectrumId", by.y = "spectrumID")
sp

## -----------------------------------------------------------------------------
sp1158 <- filterPrecursorScan(sp, 1158)

## -----------------------------------------------------------------------------
plotSpectra(sp1158[1], xlim = c(400, 600))
abline(v = precursorMz(sp1158)[2], col = "red", lty = "dotted")

## -----------------------------------------------------------------------------
sp1158$sequence

## -----------------------------------------------------------------------------
calculateFragments(sp1158$sequence[2])

## -----------------------------------------------------------------------------
calculateFragments(sp1158$sequence[2], 
                   fixed_modifications = NULL,
                   variable_modifications = c(C = 57.02146, 
                                              T = 79.966))

## -----------------------------------------------------------------------------
plotSpectra(sp1158[2])

## -----------------------------------------------------------------------------
dataOrigin(sp1158)[2] <- "TMT_Erwinia" ## Reduces the mzspec text
plotSpectraPTM(sp1158[2],
               main = "Scan 1158 with carbamidomethylation")

## -----------------------------------------------------------------------------
plotSpectraPTM(sp1158[2], 
               fixed_modifications = NULL,
               variable_modifications = NULL,
               main = "Scan 1158 without modifications")

## ----fig.width = 8, fig.height = 8, out.width="1000px"------------------------
plotSpectraPTM(sp1158[2], 
               fixed_modifications = NULL,
               variable_modifications = c(C = 57.02146),
               deltaMz = FALSE)

## ----si-----------------------------------------------------------------------
sessionInfo()

