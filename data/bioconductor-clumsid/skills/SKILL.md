---
name: bioconductor-clumsid
description: Bioconductor-clumsid compares and clusters tandem mass spectrometry data to aid in metabolite identification. Use when user asks to extract MS2 spectra, merge redundant scans, calculate spectral similarity, or visualize metabolite clusters using multidimensional scaling and correlation networks.
homepage: https://bioconductor.org/packages/release/bioc/html/CluMSID.html
---

# bioconductor-clumsid

name: bioconductor-clumsid
description: Analysis of MS2 spectra from untargeted LC-MS/MS, DI-MS/MS, and GC-EI-MS data. Use this skill for extracting, merging, and clustering mass spectra to aid metabolite identification through cosine similarity, multidimensional scaling (MDS), and correlation networks.

# bioconductor-clumsid

## Overview
CluMSID (Clustering Spectra for Metabolite Identification) is a tool for the comparison and clustering of tandem mass spectrometry (MS2) data. It facilitates metabolite annotation by grouping features with similar fragmentation patterns, neutral losses, or pseudospectra. It supports high-resolution and low-resolution data from various platforms (LC-MS/MS, Direct Infusion, and GC-MS).

## Core Workflow

### 1. Data Import and Extraction
Extract MS2 spectra from raw data files (mzXML, mzML, mzTab, or netCDF).

```r
library(CluMSID)
# Extract spectra from a file
ms2list <- extractMS2spectra("path/to/data.mzXML", 
                             min_peaks = 2, 
                             recalibrate_precursor = TRUE)
```

### 2. Merging Redundant Spectra
Consolidate multiple scans of the same feature into consensus spectra.

*   **Without external peak table:** Groups consecutive spectra by precursor m/z and retention time (RT).
*   **With external peak table (e.g., from XCMS):** Matches MS2 scans to specific MS1 features.

```r
# Standard merging
featlist <- mergeMS2spectra(ms2list, rt_tolerance = 30, mz_tolerance = 1e-5)

# Merging with XCMS peak table
# ptable must have columns: 1=ID, 2=m/z, 3=RT (in seconds)
featlist_matched <- mergeMS2spectra(ms2list, peaktable = ptable, exclude_unmatched = FALSE)
```

### 3. Adding Annotations
Integrate known metabolite identities into the feature list.

```r
# Write a template for manual annotation
writeFeaturelist(featlist, "features_to_annotate.csv")

# Add annotations from a CSV (requires 'id' and 'annotation' columns)
annotatedSpeclist <- addAnnotations(featlist, "annotated_features.csv")
```

### 4. Generating Distance Matrices
Calculate similarities between features using cosine similarity.

```r
# Based on product ion spectra
distmat <- distanceMatrix(annotatedSpeclist, type = "spectra")

# Based on neutral loss patterns
nlmat <- distanceMatrix(annotatedSpeclist, type = "neutral_losses")
```

## Data Exploration and Visualization

### Multidimensional Scaling (MDS)
Visualize global spectral similarities in 2D space.

```r
MDSplot(distmat, highlight_annotated = TRUE, interactive = FALSE)
# Set interactive = TRUE to generate a plotly object
```

### Hierarchical Clustering and Heatmaps
Identify clusters of similar spectra.

```r
# Generate a heatmap with dendrograms
HCplot(distmat, type = "heatmap", cexRow = 0.5, cexCol = 0.5)

# Generate a circular dendrogram
HCplot(distmat, type = "dendrogram", h = 0.8)
```

### Correlation Networks
View relationships between features as a network graph.

```r
networkplot(distmat, 
            interactive = FALSE, 
            min_similarity = 0.1, 
            exclude_singletons = TRUE)
```

## Specialized Workflows

### GC-EI-MS and Pseudospectra
For GC-MS or MS1-only data, use `CAMERA` to generate pseudospectra.

```r
# Extract from a CAMERA xsAnnotate object
pslist <- extractPseudospectra(xA, min_peaks = 0)
# Use distanceMatrix with a higher mz_tolerance for low-res data
pseudodistmat <- distanceMatrix(pslist, mz_tolerance = 0.02)
```

### Direct Infusion (DI-MS/MS)
Since RT is absent, set a high `rt_tolerance` in `mergeMS2spectra` to group identical precursors across the entire run.

## Tips for Success
*   **Mass Tolerance:** For high-res data (Q-TOF, Orbitrap), use `1e-5` (10ppm). For low-res data (Ion Trap, Quadrupole), use absolute values like `0.02` Da.
*   **RT Units:** Ensure RT in your peak tables matches the units in the raw data (usually seconds).
*   **Neutral Losses:** Use `type = "neutral_losses"` in `distanceMatrix` to find structural similarities that product ion spectra might miss (e.g., shared sugar moieties).

## Reference documentation
- [CluMSID DI-MS/MS Tutorial](./references/CluMSID_DI-MSMS.md)
- [CluMSID GC-EI-MS Tutorial](./references/CluMSID_GC-EI-MS.md)
- [Using CluMSID with MetaboLights Data](./references/CluMSID_MTBLS.md)
- [Low Resolution LC-MS/MS Tutorial](./references/CluMSID_lowres-LC-MSMS.md)
- [General CluMSID Tutorial](./references/CluMSID_tutorial.md)