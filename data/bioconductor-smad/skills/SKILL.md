---
name: bioconductor-smad
description: The SMAD package scores protein-protein interactions from affinity purification-mass spectrometry data using CompPASS and HGScore algorithms. Use when user asks to calculate interaction scores, identify true interactors from background noise, or predict protein complex networks using spoke or matrix models.
homepage: https://bioconductor.org/packages/release/bioc/html/SMAD.html
---


# bioconductor-smad

## Overview

The `SMAD` package provides tools for scoring protein-protein interactions (PPI) from Affinity Purification-Mass Spectrometry (AP-MS) data. It implements two primary statistical frameworks:
1. **CompPASS**: A spoke-model based algorithm that calculates Z, S, D, and WD scores to distinguish true interactors from non-specific background.
2. **HGScore**: A matrix-model based algorithm using a hypergeometric distribution error model and Normalized Spectral Abundance Factor (NSAF) to predict protein complex networks.

## Input Data Requirements

The package requires a specific data frame format (referred to as `datInput`). Ensure your data contains the following columns:

| Column | Description |
| :--- | :--- |
| `idRun` | Unique ID for the AP-MS run |
| `idBait` | Identifier for the Bait protein |
| `idPrey` | Identifier for the Prey protein |
| `countPrey` | Spectral counts (PSMs) for the Prey |
| `lenPrey` | Length of the Prey protein (required for HGScore and NSAF) |

```r
library(SMAD)
data("TestDatInput")
# Preview required structure
head(TestDatInput)
```

## Scoring Workflows

### 1. CompPASS Scoring
Use `CompPASS()` for spoke-model analysis. This is ideal for identifying direct bait-prey interactions and filtering out common contaminants.

```r
# Calculate CompPASS scores
scoreCompPASS <- CompPASS(TestDatInput)

# Key output columns:
# scoreZ: Z-score
# scoreS: S-score
# scoreD: D-score
# scoreWD: Weighted D-score (often used for final ranking)
head(scoreCompPASS)
```

### 2. HGScore Scoring
Use `HG()` for matrix-model analysis. This approach is better suited for predicting protein complexes as it considers interactions between preys found in the same runs.

```r
# Calculate HGScore
# Note: This requires lenPrey to be present in the input
scoreHG <- HG(TestDatInput)

# Key output columns:
# InteractorA/B: The two proteins in the interaction
# HG: The final hypergeometric score
head(scoreHG)
```

## Usage Tips

- **Model Selection**: Use `CompPASS` if you are primarily interested in bait-to-prey relationships. Use `HGScore` if you want to infer a broader network of interactions including prey-prey associations within complexes.
- **Data Filtering**: The package works best on spectral count data. Ensure protein lengths are accurate as they heavily influence the NSAF components of the HGScore.
- **Ranking**: Higher scores in `scoreWD` (CompPASS) or `HG` (HGScore) generally indicate higher confidence in the protein-protein interaction.

## Reference documentation

- [SMAD Quick Start](./references/quickstart.md)