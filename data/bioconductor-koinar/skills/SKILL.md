---
name: bioconductor-koinar
description: The koinar package provides an R client for the Koina service to generate machine learning predictions for peptide properties like fragment intensities and retention times. Use when user asks to predict peptide properties, interface with Koina machine learning models, or compare predicted spectra against experimental data.
homepage: https://bioconductor.org/packages/release/bioc/html/koinar.html
---

# bioconductor-koinar

## Overview
The `koinar` package is an R client for the Koina service, a distributed network of machine learning models. It allows users to generate high-quality predictions for peptide properties (like fragment intensities or retention times) without requiring local GPU hardware or complex model setups. It uses a simple HTTP/S request-response workflow to interface with remote models.

## Core Workflow

### 1. Initialize a Model Client
Create a client object tied to a specific model and server. The default public server is `koina.wilhelmlab.org`.

```r
library(koinar)

# Initialize a specific model (e.g., Prosit 2019 Intensity)
prosit_model <- koinar::Koina(
  model_name = "Prosit_2019_intensity",
  server_url = "koina.wilhelmlab.org"
)
```

### 2. Prepare Input Data
Inputs must be provided as a `data.frame`. Column names must match the requirements of the specific model (e.g., `peptide_sequences`, `collision_energies`, `precursor_charges`).

```r
input_data <- data.frame(
  peptide_sequences = c("LGGNEQVTR", "GAGSSEPVTGLDAK"),
  collision_energies = c(25, 35),
  precursor_charges = c(2, 2)
)
```

### 3. Generate Predictions
You can use the R6 method `$predict()` or the functional wrapper `predictWithKoinaModel()`.

```r
# Method 1: R6 Object
results <- prosit_model$predict(input_data)

# Method 2: Functional wrapper
results <- koinar::predictWithKoinaModel(prosit_model, input_data)
```

## Common Use Cases

### Spectral Similarity Comparison
Compare predicted intensities against experimental data using `OrgMassSpecR`.

```r
# Assuming 'experimental_peaks' is a data frame with mz and intensities
# and 'results' contains the Koina predictions
sim <- OrgMassSpecR::SpectrumSimilarity(
  experimental_peaks,
  results[, c("mz", "intensities")],
  top.lab = "Experimental",
  bottom.lab = "Predicted"
)
```

### Model Benchmarking
Compare predictions from different models (e.g., Prosit vs. MS2PIP) for the same set of peptides.

```r
# Initialize second model
ms2pip_model <- koinar::Koina("ms2pip_HCD2021")
results_ms2pip <- ms2pip_model$predict(input_data)

# Combine and visualize with lattice
combined <- rbind(
  transform(results, model = "Prosit"),
  transform(results_ms2pip, model = "MS2PIP")
)
lattice::xyplot(intensities ~ mz | model * peptide_sequences, data = combined, type = "h")
```

## Tips and Best Practices
- **Model Documentation**: Visit [koina.wilhelmlab.org/docs](https://koina.wilhelmlab.org/docs) to find the exact input requirements (column names and types) for different models.
- **Modifications**: For modified peptides, use the appropriate notation (e.g., `[UNIMOD:737]-AAVEE...`) as required by the specific model.
- **Batching**: The package handles the distribution of requests; for very large datasets, a progress bar will indicate the status of the remote computation.
- **Data Integration**: Use the `Spectra` and `msdata` packages to load raw experimental data (`.mzML`) before comparing with `koinar` predictions.

## Reference documentation
- [Using R client for Koina](./references/koina.md)