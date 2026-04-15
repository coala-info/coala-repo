---
name: bioconductor-eximir
description: This tool normalizes miRNA expression data from Exiqon and Affymetrix platforms using spike-in control probes. Use when user asks to normalize miRNA arrays, perform spike-in based normalization, or process Exiqon miRCURY LNA and Affymetrix miRNA Genechip data.
homepage: https://bioconductor.org/packages/release/bioc/html/ExiMiR.html
---

# bioconductor-eximir

name: bioconductor-eximir
description: Normalization of miRNA expression data using spike-in probes. Use when processing Exiqon miRCURY LNA arrays, Affymetrix miRNA Genechips, or other miRNA platforms where spike-in controls are available. Supports background correction, spike-in based normalization (NormiR), and summarization into ExpressionSet objects.

# bioconductor-eximir

## Overview
ExiMiR provides tools for normalizing miRNA expression data, specifically optimized for Exiqon miRCURY LNA arrays and Affymetrix miRNA Genechips. Its core feature is a spike-in probe-based normalization method (`NormiR`) that accounts for the unique distribution of miRNA data compared to mRNA. It is designed to be compatible with both the `affy` and `limma` package ecosystems, allowing users to treat dual-channel data as single-channel for normalization purposes.

## Typical Workflows

### 1. Affymetrix miRNA Data
For Affymetrix CEL files, ExiMiR uses the `affy` package infrastructure.

```r
library(ExiMiR)
library(affy)

# Load CEL files
abatch <- ReadAffy(celfile.path = "path/to/CEL_files")

# Normalize using spike-in method
eset.spike <- NormiR(abatch, 
                     bgcorrect.method = 'rma',
                     normalize.method = 'spikein',
                     summary.method = 'medianpolish')
```

### 2. Exiqon miRCURY LNA Data
Exiqon arrays typically use ImaGene TXT files and GAL annotation files.

```r
library(ExiMiR)

# 1. Create annotation environment from GAL file
make.gal.env(galname = 'galenv', gal.path = 'path/to/GAL')

# 2. Read raw TXT files (requires a samplesinfo.txt file in the directory)
# samplesinfo.txt should map Hy3 and Hy5 channels to filenames
ebatch <- ReadExi(galname = 'galenv', txtfile.path = 'path/to/TXT')

# 3. Normalize
eset.spike <- NormiR(ebatch, 
                     bg.correct = FALSE,
                     normalize.method = 'spikein',
                     summary.method = 'medianpolish')
```

### 3. Custom Formats via Limma
If data is in a format supported by `limma`, it can be converted to an `AffyBatch` for ExiMiR processing.

```r
library(limma)
library(ExiMiR)

# Read data into limma RGList
targets <- readTargets("Targets.txt")
RG <- read.maimages(targets, source = "imagene")
RG$genes <- readGAL()

# Convert to AffyBatch
obatch <- createAB(RG)

# Normalize with specific spike-in probe IDs
spike_probes <- grep('^spike', featureNames(obatch), value = TRUE)
eset.spike <- NormiR(obatch, 
                     normalize.method = 'spikein',
                     normalize.param = list(probeset.list = spike_probes))
```

## The NormiR Function
`NormiR` is a wrapper for background correction, normalization, and summarization.

- **Background Methods**: `rma`, `mas`, `none` (for Affy); `normexp`, `minimum`, `edwards` (for Exiqon/Limma-based).
- **Normalization Methods**: `spikein` (default), `quantile`, `median`, `mean`.
- **Summarization Methods**: `medianpolish`, `avgdiff`, `liwong`, `mas`.

### Fine-Tuning Spike-in Normalization
Use the `normalize.param` list to adjust the behavior:
- `figures.show = TRUE`: Generates diagnostic plots (highly recommended for troubleshooting).
- `probeset.list`: Character vector of specific probe IDs to use as spikes.
- `loess.span`: Controls smoothing (default is 5 / number of spikes).
- `force.zero = TRUE`: Stabilizes low-intensity correction.

## Troubleshooting
If the spike-in assumptions are not met (e.g., low correlation between spikes, insufficient intensity coverage), `NormiR` will default to **median normalization** to prevent errors.

Check diagnostic figures for:
1. **Coherence**: Spike-in intensities should show parallel biases across arrays.
2. **Coverage**: Spike-in intensities should span the range of the actual miRNA probes (typically log2 6 to 16).
3. **Correlation**: Pearson correlation of spike-in raw intensities should generally be > 0.5.

## Reference documentation
- [ExiMiR-vignette](./references/ExiMiR-vignette.md)