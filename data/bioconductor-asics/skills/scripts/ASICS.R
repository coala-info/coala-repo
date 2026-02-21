# Code example from 'ASICS' vignette. See references/ for full tutorial.

## ----userguide, warning=FALSE-------------------------------------------------
library(ASICS)
ASICSUsersGuide(view = FALSE)

## ----data_import, results='hide'----------------------------------------------
current_path <- system.file("extdata", "example_spectra", package = "ASICS")
spectra_data <- importSpectraBruker(current_path)

## ----create_spectra, results='hide'-------------------------------------------
spectra_obj <- createSpectra(spectra_data)

## ----quantification-----------------------------------------------------------
to_exclude <- matrix(c(4.5, 10), ncol = 2)
resASICS <- ASICS(spectra_obj, exclusion.areas = to_exclude, verbose = FALSE)

