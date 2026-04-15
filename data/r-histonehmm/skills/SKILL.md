---
name: r-histonehmm
description: This tool analyzes ChIP-seq data for histone modifications with broad genomic footprints using Hidden Markov Models. Use when user asks to call modified regions in single samples or identify differentially modified regions between two samples.
homepage: https://cran.r-project.org/web/packages/histonehmm/index.html
---

# r-histonehmm

name: r-histonehmm
description: Analyze ChIP-seq data for histone modifications with broad genomic footprints (e.g., H3K27me3). Use this skill to call modified regions in single samples or identify differentially modified regions (DMRs) between two samples using Hidden Markov Models (HMM).

# r-histonehmm

## Overview
The `histonehmm` package provides a Hidden Markov Model (HMM) framework specifically designed for histone modification ChIP-seq data that exhibits broad genomic footprints. Unlike narrow-peak callers, it excels at identifying large domains of enrichment and detecting differential modifications between experimental conditions.

## Installation
To install the package from CRAN:
```R
install.packages("histonehmm")
```

## Workflow: Single Sample Analysis
To identify modified regions in a single ChIP-seq sample:

1. **Data Preparation**: Load binned read counts. The package typically expects counts in genomic bins (e.g., 1kb windows).
2. **Model Initialization**: Define the HMM structure (typically 2 states: unmodified and modified).
3. **Parameter Estimation**: Use the EM algorithm to fit the model to the observed counts.
4. **Decoding**: Use the Viterbi algorithm or posterior decoding to assign states to genomic bins.

```R
library(histonehmm)

# Load your binned data (example structure)
# data should contain chromosome, start, end, and count columns
model <- histoneHMM(counts = my_counts, control = my_control)

# Call regions
regions <- getRegions(model)
```

## Workflow: Differential Analysis
To compare two samples (e.g., Wild Type vs. Mutant) and find differentially modified regions (DMRs):

1. **Joint Modeling**: Fit a model that accounts for both samples simultaneously or compare posterior probabilities.
2. **State Comparison**: Identify bins where the modification state differs between conditions (e.g., Gain or Loss of histone mark).
3. **Significance Testing**: Evaluate the evidence for differential enrichment.

```R
# Compare two fitted models
diff_result <- compareSamples(model1, model2)

# Extract differentially modified regions
dmrs <- getDMRs(diff_result)
```

## Key Functions
- `histoneHMM()`: The high-level interface for fitting the HMM to ChIP-seq count data.
- `readBAM()`: Utility to process BAM files into binned counts (if available in the high-level API).
- `getRegions()`: Extracts contiguous genomic intervals assigned to the "modified" state.
- `compareSamples()`: Performs the differential analysis between two histoneHMM objects.

## Tips for Success
- **Bin Size**: For broad marks like H3K27me3, bin sizes of 500bp to 1000bp are generally recommended.
- **Input Control**: Always use an Input/IgG control sample to account for genomic biases and improve the specificity of the HMM.
- **Normalization**: Ensure counts are normalized for library size before differential comparison if the high-level functions do not handle it automatically.

## Reference documentation
- [Home Page](./references/home_page.md)