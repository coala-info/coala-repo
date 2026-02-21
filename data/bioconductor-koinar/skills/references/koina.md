# Using R client for Koina

Ludwig Lautenbacher1\* and Christian Panse2,3

1Computational Mass Spectrometry, Technical University of Munich (TUM), Freising, Germany
2Functional Genomics Center Zurich (FGCZ) - University of Zurich | ETH Zurich, Winterthurerstrasse 190, CH-8057 Zurich, Switzerland
3Swiss Institute of Bioinformatics (SIB), Quartier Sorge - Batiment Amphipole, CH-1015 Lausanne, Switzerland

\*ludwig.lautenbacher@tum.de

#### 30 October 2025

#### Abstract

How to use *[KoinaR](https://bioconductor.org/packages/3.22/KoinaR)* to fetch predictions from [Koina](https://koina.wilhelmlab.org/)

#### Package

koinar 1.4.0

# 1 Introduction

Koina is a repository of machine learning models enabling the remote execution of models. Predictions are generated as a response to HTTP/S requests, the standard protocol used for nearly all web traffic. As such, HTTP/S requests can be easily generated in any programming language without requiring specialized hardware. This design enables users to easily access ML/DL models that would normally require specialized hardware from any device and in any programming language. It also means that the hardware is used more efficiently and it allows for easy horizontal scaling depending on the demand of the user base.

To minimize the barrier of entry and “democratize” access to ML models, we provide a public network of Koina instances at koina.wilhelmlab.org. The computational workload is automatically distributed to processing nodes hosted at different research institutions and spin-offs across Europe. Each processing node provides computational resources to the service network, always aiming at just-in-time results delivery.

In the spirit of open and collaborative science, we envision that this public Koina-Network can be scaled to meet the community’s needs by various research groups or institutions dedicating hardware. This can also vastly improve latency if servers are available geographically nearby. Alternatively, if data security is a concern, private instances within a local network can be easily deployed using the provided docker image.

Koina is a community driven project. It is fully open-source. We welcome all contributions and feedback! Feel free to reach out to us or open an issue on our GitHub repository.

At the moment Koina mostly focuses on the Proteomics domain but the design can be easily extended to any machine learning model. Active development to expand it into Metabolomics is underway. If you are interested in using Koina to interface with a machine learning model not currently available feel free to [create a request](https://github.com/wilhelm-lab/koina/issues).

Here we take a look at KoinaR the R package to simplify getting predictions from Koina.

# 2 Install

```
if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

BiocManager::install("koinar")
```

# 3 Basic usage

Here we show the basic usage principles of KoinaR. The first step to interact with Koina is to pick a model and server you wish to use.
Here we use the model Prosit\_2019\_intensity published by Gessulat et al (Gessulat et al. [2019](#ref-prosit2019)) and the public Koina network available via koina.wilhelmlab.org.
For a complete overview of models available on Koina have a look at the documentation available at <https://koina.wilhelmlab.org/docs>.

```
# Create a client tied to a specific server & model
# Here we use the model published by Gessulat et al [@prosit2019]
# And the public server available at koina.wilhelmlab.org
# All available models can be found at https://koina.wilhelmlab.org/docs
prosit2019 <- koinar::Koina(
  model_name = "Prosit_2019_intensity",
  server_url = "koina.wilhelmlab.org"
)
prosit2019
```

```
## Koina Model class:
##  Model name:  Prosit_2019_intensity
##  Server URL:  koina.wilhelmlab.org
```

After you created the model you need to prepare your inputs. Here we prepare a simple data.frame with three different inputs
`peptide_sequences`, `collision_energies`, and `precursor_charges`.

```
# Create example inputs
# Here we look at two different peptide sequences with charge 1 and 2 respectively
input <- data.frame(
  peptide_sequences = c("LGGNEQVTR", "GAGSSEPVTGLDAK"),
  collision_energies = c(25, 25),
  precursor_charges = c(1, 2)
)
```

After preparing the input you can start predicting by calling `prosit2019$predict(input)`.

```
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
```

```
##      peptide_sequences collision_energies precursor_charges annotation       mz
## 1            LGGNEQVTR                 25                 1       y1+1 175.1190
## 1.3          LGGNEQVTR                 25                 1       b1+1 114.0913
## 1.6          LGGNEQVTR                 25                 1       y2+1 276.1666
## 1.9          LGGNEQVTR                 25                 1       b2+1 171.1128
## 1.12         LGGNEQVTR                 25                 1       y3+1 375.2350
## 1.15         LGGNEQVTR                 25                 1       b3+1 228.1343
##      intensities
## 1    0.246388033
## 1.3  0.006869315
## 1.6  0.467457831
## 1.9  0.157304466
## 1.12 0.648119807
## 1.15 0.081853107
```

Alternatively if you prefer pass by value semantic you can use the `predictWithKoinaModel` function to predict with a Koina model.

```
prediction_results <- koinar::predictWithKoinaModel(prosit2019, input)
```

# 4 Example 1: Reproducing Fig.1d from (Gessulat et al. [2019](#ref-prosit2019))

One common use case for most of the models available through Koina is the prediction
of peptide properties to improve peptide identification rates in Proteomics experiments.
One of the properties that is most beneficial in this context is the peptide fragment intensity pattern.

In this example we have a look at the model published by Gessulat et al (Gessulat et al. [2019](#ref-prosit2019)) and attempt to reproduce a figure 1d published in the manuscript.
In this Figure the authors exemplify the prediction accuracy of their model by comparing the experimentally aquired mass spectra with the predictions of their model.

![Screenshot of Fig.1d [@prosit2019] https://www.nature.com/articles/s41592-019-0426-7](data:image/jpeg;base64...)

Figure 1: Screenshot of Fig.1d (Gessulat et al
[2019](#ref-prosit2019)) <https://www.nature.com/articles/s41592-019-0426-7>

We prepare the inputs for the model, all of them can be found in the header of the figure.

```
input <- data.frame(
  peptide_sequences = c("LKEATIQLDELNQK"),
  collision_energies = c(35),
  precursor_charges = c(3)
)
```

We reuse the model instance (`prosit2019`) created in the previous chapter.
To fetch the predictions we call the `predict` method of the model instance.

```
prediction_results <- prosit2019$predict(input)
```

Here we create a simple mass spectrum to visually compare against Figure 1d of Gessulat et al (Gessulat et al. [2019](#ref-prosit2019)).
We can see that the predicted spectrum we just generated is identical to the predicted spectrum shown in the publication.

```
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
```

![](data:image/png;base64...)

Example 2: Compare spectral similarity between models

Fragment ion prediction models can have major difference in the predictions they generate.
Impacting the peptide identification performance. We show this here by predicting the Biognosys iRT peptides,
a commonly used set of synthetic spike in reference peptides, with the Prosit\_intensity\_2019 and the ms2pip\_2021HCD models.

We follow the same steps as before.(1) Prepare the input.

```
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
```

2. Predict

```
pred_prosit <- prosit2019$predict((input))
pred_prosit$model <- "Prosit_2019_intensity"

ms2pip <- koinar::Koina(
  model_name = "ms2pip_HCD2021",
  server_url = "koina.wilhelmlab.org"
)

pred_ms2pip <- ms2pip$predict(input)
pred_ms2pip$model <- "ms2pip_HCD2021"
```

After generating the plots for all iRT peptides we can observe that the predicted mass spectra are quite different.
Which model is better depends on the data set that is being analyzed.

```
lattice::xyplot(intensities ~ mz | model * peptide_sequences,
  group = grepl("y", annotation),
  data = rbind(
    pred_prosit[, names(pred_ms2pip)],
    pred_ms2pip
  ),
  type = "h"
)
```

![iRT peptides fragment ions prediction using  AlphaPept and Prosit_intensity_2019](data:image/png;base64...)

Figure 2: iRT peptides fragment ions prediction using AlphaPept and Prosit\_intensity\_2019

We can also use the `OrgMassSpecR` package to generate a mirror spectrum using the `SpectrumSimilarity` function.
This not only provides a better visualization to compare spectra but also calculates a similarity score.

```
peptide_sequence <- "ADVTPADFSEWSK"

sim <- OrgMassSpecR::SpectrumSimilarity(pred_prosit[pred_prosit$peptide_sequences == peptide_sequence, c("mz", "intensities")],
  pred_ms2pip[pred_ms2pip$peptide_sequences == peptide_sequence, c("mz", "intensities")],
  top.lab = "Prosit",
  bottom.lab = "MS2PIP",
  b = 25
)
title(main = paste(peptide_sequence, "| Spectrum similarity", round(sim, 3)))
```

![Spectral similarity ms2pip vs prosit plot created with OrgMassSpecR](data:image/png;base64...)

Figure 3: Spectral similarity ms2pip vs prosit plot created with OrgMassSpecR

# 5 Example 3: Loading rawdata with the Spectra package

The main application of predicted fragment mass spectra is to be compared with experimental spectra.
Here we use the `Spectra` package to read a rawfile (provided by the `msdata` package).

```
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
```

The data we are using was searched using Mascot to map spectra to Mascot-queries we need to sort the Spectra by precursor MZ.

```
# Sort data by precursor mass since Mascot-queries are sorted by mass
metadata$mass <- (metadata$precursorMz * metadata$precursorCharge)
peptide_mass_order <- order(metadata$mass)
metadata <- metadata[peptide_mass_order, ]
sorted_spectra <- spectra[peptide_mass_order]
```

Once we sorted the data we can find the corresponding identification in this file on [Pride](https://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD000001/F063721.dat).
To illustrate the workflow we pick the random Spectrum 4128.
Searching for `q4128` in the Pride file gives us the `peptide_sequence` (`[UNIMOD:737]-AAVEEGVVAGGGVALIR`) and `precursor_charge` (`3`) Mascot identified.
To validate the identification we fetch predictions from Koina using the `Prosit_2020_intensity_TMT` model.

```
input <- data.frame(
  peptide_sequences = c("[UNIMOD:737]-AAVEEGVVAGGGVALIR"),
  collision_energies = c(45),
  precursor_charges = c(3),
  fragmentation_types = c("HCD")
)
prosit <- koinar::Koina("Prosit_2020_intensity_TMT")
pred_prosit <- prosit$predict(input)
```

We use `SpectrumSimilarity` from `OrgMassSpecR` to visualize the spectrum and get a similarity score to the prediction.
We can observe high agreement between the experimental and predicted spectrum. Validating this identification.

```
sim <- OrgMassSpecR::SpectrumSimilarity(sorted_spectra[[4128]],
  pred_prosit[, c("mz", "intensities")],
  top.lab = "Experimental",
  bottom.lab = "Prosit",
  t = 0.01
)
title(main = paste("Spectrum similarity", round(sim, 3)))
```

![](data:image/png;base64...)

# References

Gessulat, Siegfried, Tobias Schmidt, Daniel Paul Zolg, Patroklos Samaras, Karsten Schnatbaum, Johannes Zerweck, Tobias Knaute, et al. 2019. “Prosit: Proteome-Wide Prediction of Peptide Tandem Mass Spectra by Deep Learning.” *Nature Methods* 16 (6): 509–18. <https://doi.org/10.1038/s41592-019-0426-7>.

# Appendix

# Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] msdata_0.49.0       Spectra_1.20.0      BiocParallel_1.44.0
##  [4] S4Vectors_0.48.0    BiocGenerics_0.56.0 generics_0.1.4
##  [7] curl_7.0.0          httptest_4.2.2      testthat_3.2.3
## [10] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10            MsCoreUtils_1.22.0     koinar_1.4.0
##  [4] lattice_0.22-7         digest_0.6.37          magrittr_2.0.4
##  [7] evaluate_1.0.5         grid_4.5.1             bookdown_0.45
## [10] fastmap_1.2.0          jsonlite_2.0.0         ProtGenerics_1.42.0
## [13] mzR_2.44.0             brio_1.1.5             tinytex_0.57
## [16] BiocManager_1.30.26    httr_1.4.7             OrgMassSpecR_0.5-3
## [19] codetools_0.2-20       jquerylib_0.1.4        cli_3.6.5
## [22] rlang_1.1.6            Biobase_2.70.0         cachem_1.1.0
## [25] yaml_2.3.10            tools_4.5.1            parallel_4.5.1
## [28] ncdf4_1.24             R6_2.6.1               lifecycle_1.0.4
## [31] magick_2.9.0           fs_1.6.6               IRanges_2.44.0
## [34] clue_0.3-66            MASS_7.3-65            cluster_2.1.8.1
## [37] bslib_0.9.0            Rcpp_1.1.0             xfun_0.53
## [40] knitr_1.50             htmltools_0.5.8.1      rmarkdown_2.30
## [43] compiler_4.5.1         MetaboCoreUtils_1.18.0
```