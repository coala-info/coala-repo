# Code example from 'koina' vignette. See references/ for full tutorial.

## ----style, results = 'asis', echo=FALSE, message=FALSE-----------------------
# Configuration of the vignette
BiocStyle::markdown()
knitr::opts_chunk$set(fig.wide = TRUE, fig.retina = 3, error = FALSE, eval = TRUE)

# httptest is used to cached responses
# This is important to compile the vignette in a CI pipeline
# If you want to use this vignette interactively you can delete this part
library(httptest)
start_vignette("mAPI")
set_requester(function(request) {
  request <- gsub_request(request, "koina.wilhelmlab.org", "k.w.org")
  request <- gsub_request(request, "dlomix.fgcz.uzh.ch", "d.f.u.ch")
  request <- gsub_request(request, "Prosit_2019_intensity", "P_29_int")
})

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("koinar")

## ----create, eval=TRUE, message=FALSE-----------------------------------------
# Create a client tied to a specific server & model
# Here we use the model published by Gessulat et al [@prosit2019]
# And the public server available at koina.wilhelmlab.org
# All available models can be found at https://koina.wilhelmlab.org/docs
prosit2019 <- koinar::Koina(
  model_name = "Prosit_2019_intensity",
  server_url = "koina.wilhelmlab.org"
)
prosit2019

## ----input, message=FALSE-----------------------------------------------------
# Create example inputs
# Here we look at two different peptide sequences with charge 1 and 2 respectively
input <- data.frame(
  peptide_sequences = c("LGGNEQVTR", "GAGSSEPVTGLDAK"),
  collision_energies = c(25, 25),
  precursor_charges = c(1, 2)
)

## -----------------------------------------------------------------------------
# Fetch the predictions by calling `$predict` of the model you want to use
# A progress bar shows you how much of the predictions are already done
# In this case this should complete instantly
prediction_results <- prosit2019$predict(input)

# Display the predictions
# The output varies depending on the chosen model
# For the intenstiy model we get a data.frame with 5 columns
# The three inputs we provided: peptide_sequences, collision_energies, precursor_charges
# and for each predicted fragment ion: annotation, mz, intensities
head(prediction_results)

## -----------------------------------------------------------------------------
prediction_results <- koinar::predictWithKoinaModel(prosit2019, input)

## ----Fig1, echo=FALSE, out.width="100%", eval=TRUE, fig.cap="Screenshot of Fig.1d [@prosit2019] https://www.nature.com/articles/s41592-019-0426-7", message=FALSE----
knitr::include_graphics("https://user-images.githubusercontent.com/4901987/237583247-a948ceb3-b525-4c30-b701-218346a30cf6.jpg")

## ----Fig2, out.width="100%", fig.cap="LKEATIQLDELNQK CE35 3+; Reproducing Fig1", fig.height=8, fig.retina=3, message=FALSE----
input <- data.frame(
  peptide_sequences = c("LKEATIQLDELNQK"),
  collision_energies = c(35),
  precursor_charges = c(3)
)

## -----------------------------------------------------------------------------
prediction_results <- prosit2019$predict(input)

## -----------------------------------------------------------------------------
prediction_results <- prosit2019$predict(input)

# Plot the spectrum
plot(prediction_results$intensities ~ prediction_results$mz,
  type = "n",
  ylim = c(0, 1.1)
)
yIdx <- grepl("y", prediction_results$annotation)
points(prediction_results$mz[yIdx], prediction_results$intensities[yIdx],
  col = "red", type = "h", lwd = 2
)
points(prediction_results$mz[!yIdx], prediction_results$intensities[!yIdx],
  col = "blue", type = "h", lwd = 2
)

text(prediction_results$mz, prediction_results$intensities,
  labels = prediction_results$annotation,
  las = 2, cex = 1, pos = 3
)

## ----defineBiognosysIrtPeptides, message=FALSE--------------------------------
input <- data.frame(
  peptide_sequences = c(
    "LGGNEQVTR", "YILAGVENSK", "GTFIIDPGGVIR", "GTFIIDPAAVIR",
    "GAGSSEPVTGLDAK", "TPVISGGPYEYR", "VEATFGVDESNAK",
    "TPVITGAPYEYR", "DGLDAASYYAPVR", "ADVTPADFSEWSK",
    "LFLQFGAQGSPFLK"
  ),
  collision_energies = 35,
  precursor_charges = 2
)

## ----AlphaPept, message=FALSE-------------------------------------------------
pred_prosit <- prosit2019$predict((input))
pred_prosit$model <- "Prosit_2019_intensity"

ms2pip <- koinar::Koina(
  model_name = "ms2pip_HCD2021",
  server_url = "koina.wilhelmlab.org"
)

pred_ms2pip <- ms2pip$predict(input)
pred_ms2pip$model <- "ms2pip_HCD2021"

## ----xyplot, out.width="100%", fig.cap="iRT peptides fragment ions prediction using  AlphaPept and Prosit_intensity_2019", fig.height=15, fig.retina=3----
lattice::xyplot(intensities ~ mz | model * peptide_sequences,
  group = grepl("y", annotation),
  data = rbind(
    pred_prosit[, names(pred_ms2pip)],
    pred_ms2pip
  ),
  type = "h"
)

## ----mssimplot, out.width="100%", fig.cap="Spectral similarity ms2pip vs prosit plot created with OrgMassSpecR", message=FALSE----
peptide_sequence <- "ADVTPADFSEWSK"

sim <- OrgMassSpecR::SpectrumSimilarity(pred_prosit[pred_prosit$peptide_sequences == peptide_sequence, c("mz", "intensities")],
  pred_ms2pip[pred_ms2pip$peptide_sequences == peptide_sequence, c("mz", "intensities")],
  top.lab = "Prosit",
  bottom.lab = "MS2PIP",
  b = 25
)
title(main = paste(peptide_sequence, "| Spectrum similarity", round(sim, 3)))

## ----message=FALSE------------------------------------------------------------
library(Spectra)
library(msdata)

fls <- c(
  system.file("proteomics",
    "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML.gz",
    package = "msdata"
  )
)

data <- Spectra(fls, source = MsBackendMzR())
data <- filterMsLevel(data, msLevel = 2) # Filter raw data for fragment ion spectra only

metadata <- spectraData(data) # Extract metadata
spectra <- peaksData(data) # Extract spectra data

## -----------------------------------------------------------------------------
# Sort data by precursor mass since Mascot-queries are sorted by mass
metadata$mass <- (metadata$precursorMz * metadata$precursorCharge)
peptide_mass_order <- order(metadata$mass)
metadata <- metadata[peptide_mass_order, ]
sorted_spectra <- spectra[peptide_mass_order]

## -----------------------------------------------------------------------------
input <- data.frame(
  peptide_sequences = c("[UNIMOD:737]-AAVEEGVVAGGGVALIR"),
  collision_energies = c(45),
  precursor_charges = c(3),
  fragmentation_types = c("HCD")
)
prosit <- koinar::Koina("Prosit_2020_intensity_TMT")
pred_prosit <- prosit$predict(input)

## -----------------------------------------------------------------------------
sim <- OrgMassSpecR::SpectrumSimilarity(sorted_spectra[[4128]],
  pred_prosit[, c("mz", "intensities")],
  top.lab = "Experimental",
  bottom.lab = "Prosit",
  t = 0.01
)
title(main = paste("Spectrum similarity", round(sim, 3)))

## ----sessioninfo, eval=TRUE---------------------------------------------------
sessionInfo()

