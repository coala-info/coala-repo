---
name: bioconductor-radiogx
description: RadioGx provides a standardized framework for the analysis and integration of large-scale radiogenomic datasets within the R environment. Use when user asks to work with RadioSet objects, fit linear-quadratic models to radiation dose-response data, calculate radio-sensitivity metrics like SF2 and D10, or identify molecular signatures associated with radiation response.
homepage: https://bioconductor.org/packages/release/bioc/html/RadioGx.html
---


# bioconductor-radiogx

name: bioconductor-radiogx
description: Analysis of large-scale radiogenomic datasets using the RadioGx R package. Use this skill to work with RadioSet (RSet) objects, fit linear-quadratic (LQ) models to radiation dose-response data, calculate radio-sensitivity metrics (SF2, D10, AUC), and identify molecular signatures associated with radiation response.

## Overview

RadioGx provides a standardized framework for radiogenomic data analysis, mirroring the PharmacoGx structure for pharmacogenomics. It allows researchers to integrate molecular profiles (RNA, DNA, CNV) with radiation sensitivity data to discover biomarkers of radio-resistance or radio-sensitivity.

## Core Workflows

### 1. Data Acquisition and Exploration
RadioGx uses the `RadioSet` (or `RSet`) class to store metadata, molecular profiles, and response data.

```r
library(RadioGx)

# List available datasets
availableRSets()

# Download a specific dataset (e.g., Cleveland)
Cleveland <- downloadRSet("Cleveland", saveDir=".")

# Load small example data
data(clevelandSmall)

# Explore the RSet
clevelandSmall
radiationTypes(clevelandSmall)
mDataNames(clevelandSmall) # List molecular data types (rna, mutation, etc.)
```

### 2. Accessing Data Components
Use specific accessor functions to ensure compatibility with the S4 object structure.

*   **Metadata:** `radiationInfo(rset)`, `phenoInfo(rset, mDataType)`, `featureInfo(rset, mDataType)`
*   **Molecular Data:** `molecularProfiles(rset, mDataType)`
*   **Response Data:** `treatmentResponse(rset)`, `sensitivityRaw(rset)`, `sensitivityProfiles(rset)`

### 3. Fitting Linear-Quadratic (LQ) Models
The LQ model is the standard for radiation dose-response, defined by alpha and beta coefficients.

```r
# Extract raw data for a specific experiment
sensRaw <- sensitivityRaw(clevelandSmall)
doses <- sensRaw[1, , "Dose"]
viability <- sensRaw[1, , "Viability"]

# Fit the model
LQmodel <- linearQuadraticModel(D = doses, SF = viability)
# Returns alpha and beta coefficients
```

### 4. Calculating Sensitivity Metrics
Once a model is fit, you can derive biological metrics:

*   **SF2:** Surviving fraction after 2 Gy of radiation.
*   **D10:** Radiation dose required to reduce survival to 10%.
*   **AUC:** Area under the dose-response curve.

```r
sf2 <- computeSF2(pars = LQmodel)
d10 <- computeD10(pars = LQmodel)
auc <- RadioGx::computeAUC(D = doses, pars = LQmodel, lower = 0, upper = 1)
```

### 5. Visualization
Generate survival fraction vs. dose plots.

```r
# Plot from raw data
doseResponseCurve(Ds = list(doses), SFs = list(viability), plot.type = "Both")

# Plot directly from an RSet
doseResponseCurve(rSets = list(clevelandSmall), 
                  cellline = "IMR-32")
```

### 6. Biomarker Discovery (Molecular Signatures)
Correlate molecular features with radiation sensitivity across cell lines.

```r
# Compute signatures for specific features
radSensSig <- radSensitivitySig(
  clevelandSmall, 
  mDataType = 'rna', 
  features = fNames(clevelandSmall, 'rna')[1:10], 
  nthread = 1
)

# View estimates and p-values
radSensSig@.Data
```

## Tips and Best Practices
*   **CoreGx Inheritance:** Since RadioGx inherits from CoreGx, many generic functions like `summarizeMolecularProfiles` and `summarizeSensitivityProfiles` work similarly to PharmacoGx.
*   **Radiation vs. Drug:** In RadioGx, the `radiation` slot is the equivalent of the `drug` slot in PharmacoGx.
*   **LQ Model Assumptions:** The `linearQuadraticModel` function assumes survival fraction data. Ensure your viability measurements are normalized (0 to 1) relative to untreated controls.

## Reference documentation
- [RadioGx](./references/RadioGx.md)