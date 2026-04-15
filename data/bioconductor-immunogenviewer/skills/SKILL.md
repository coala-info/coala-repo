---
name: bioconductor-immunogenviewer
description: immunogenViewer facilitates the selection of antibodies by analyzing and visualizing the structural and functional context of their immunogens within a protein. Use when user asks to retrieve protein features from UniProt, add and manage immunogen sequences, visualize antibody binding sites, or quantitatively evaluate immunogens based on accessibility and post-translational modifications.
homepage: https://bioconductor.org/packages/release/bioc/html/immunogenViewer.html
---

# bioconductor-immunogenviewer

## Overview
The `immunogenViewer` package facilitates the pre-selection of antibodies by analyzing the structural and functional context of their immunogens within a full-length protein. By integrating data from UniProtKB and PredictProtein, it allows researchers to visualize whether an antibody's binding site is likely to be accessible (exposed), disordered, or hindered by post-translational modifications (PTMs) and membrane domains.

## Core Workflow

### 1. Retrieve Protein Features
Fetch residue-level annotations (secondary structure, accessibility, PTMs, etc.) using a UniProt accession ID.

```r
library(immunogenViewer)

# Retrieve features for human TREM2 (Default taxonomy is 9606 for human)
protein_df <- getProteinFeatures("Q9NZC2")

# For non-human species, specify the taxonomy ID
# protein_df <- getProteinFeatures("P12345", taxID = "10090") # Mouse
```

### 2. Manage Immunogens
Add the specific peptide sequences used to raise the antibodies you are evaluating. You can define them by position or by sequence.

```r
# Add by position
protein_df <- addImmunogen(protein_df, start = 142, end = 192, name = "Antibody_A")

# Add by sequence
protein_df <- addImmunogen(protein_df, seq = "HGQKPGTHPPSELD", name = "Antibody_B")

# Utility functions
protein_df <- renameImmunogen(protein_df, oldName = "Antibody_A", newName = "Ab_A_Revised")
protein_df <- removeImmunogen(protein_df, name = "Antibody_B")
```

### 3. Visualization
Visualize the entire protein or zoom in on a specific immunogen to inspect local features.

```r
# Plot full protein with all added immunogens highlighted
plotProtein(protein_df)

# Plot specific immunogen details (shows AA sequence on x-axis)
plotImmunogen(protein_df, "Ab_A_Revised")
```

### 4. Quantitative Evaluation
Generate summary statistics to compare multiple antibodies objectively.

```r
# Returns a dataframe with proportions of features (Exposed, Helix, PTM count, etc.)
stats_df <- evaluateImmunogen(protein_df)

# Sort to find the most "exposed" immunogen
best_antibodies <- stats_df[order(stats_df$ProportionsExposed, decreasing = TRUE), ]
```

## Key Constraints & Tips
- **Immunogen Length**: Sequences must be between 10 and 50 amino acids long.
- **Feature Interpretation**: 
    - **ProportionsExposed**: Higher values suggest better accessibility in native protein folds.
    - **SumPTM**: High counts might indicate that the antibody binding is blocked by glycosylation or other modifications in vivo.
    - **Secondary Structure**: "Other" typically refers to coil/loop structures.
- **Data Sources**: The package performs API calls to UniProt and PredictProtein; an active internet connection is required for `getProteinFeatures()`.

## Reference documentation
- [Using immunogenViewer to evaluate and choose antibodies](./references/immunogenViewer_vignette.md)
- [immunogenViewer Vignette Source](./references/immunogenViewer_vignette.Rmd)