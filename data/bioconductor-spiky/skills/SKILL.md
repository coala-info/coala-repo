---
name: bioconductor-spiky
description: The bioconductor-spiky package provides a workflow for the absolute quantification of methylated DNA in cfMeDIP-seq experiments using synthetic spike-in controls. Use when user asks to quantify methylated DNA molar amounts, correct for immunoprecipitation biases, calculate methylation specificity, or predict picomoles for genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/spiky.html
---

# bioconductor-spiky

## Overview
The `spiky` package provides a workflow for the absolute quantification of methylated DNA in cfMeDIP-seq experiments. By utilizing a set of 54 synthetic spike-in controls (varying in methylation status, length, GC content, and CpG density), it allows researchers to correct for common immunoprecipitation biases. The package transforms relative read counts into absolute molar amounts (picomoles), enabling more robust comparisons across different experiments and batches.

## Core Workflow

### 1. Setup and Spike-in Database
Load the default spike-in database or process custom sequences.
```r
library(spiky)

# Load standard spike-in data
data(spike)

# For custom spikes, use a fasta file and a logical vector of methylation status
# spikes_fs <- "path/to/spikes.fa"
# spikemeth <- c(0, 1, 0, ...) 
# custom_spike <- process_spikes(spikes_fs, spikemeth)
```

### 2. Processing Input Files (BAM or BEDPE)
`spiky` requires scanning both the genomic data and the spike-in contigs.
```r
# BAM Input
genomic_cov <- scan_genomic_contigs("sample.bam", spike=spike)
spike_cov <- scan_spike_contigs("sample.spike.bam", spike=spike)

# BEDPE Input (requires indexed .bed.gz)
# genomic_cov <- scan_genomic_bedpe("sample.bed.gz", genome="hg38")
# spike_cov <- scan_spike_bedpe("sample_spike.bed.gz", spike=spike)
```

### 3. Quality Control: Methylation Specificity
Assess the non-specific binding of the antibody. A mean/median specificity < 0.98 suggests the cfMeDIP experiment may have performed inadequately.
```r
methyl_spec <- methylation_specificity(spike_cov, spike=spike)
print(methyl_spec$mean)
```

### 4. Modeling and Prediction
Build a Gaussian GLM using the methylated spike-ins to predict molar amounts for genomic regions.
```r
# Fit the model
gaussian_glm <- model_glm_pmol(spike_cov, spike=spike)

# Predict picomoles for genomic bins
# Requires the appropriate BSgenome package installed
sample_pmol <- predict_pmol(gaussian_glm, genomic_cov, 
                            bsgenome="BSgenome.Hsapiens.UCSC.hg38", 
                            ret="df")
```

### 5. Genomic Binning
Adjust the predicted molar amounts into standard non-overlapping genomic windows (default 300bp).
```r
binned_data <- bin_pmol(sample_pmol)
```

## Key Functions
- `process_spikes()`: Creates a database of spike-in properties (GC content, CpG fraction, etc.).
- `scan_genomic_contigs()` / `scan_spike_contigs()`: Extracts coverage from BAM files.
- `methylation_specificity()`: Calculates the ratio of methylated reads to total spike-in reads.
- `model_glm_pmol()`: Generates the calibration curve for absolute quantification.
- `predict_pmol()`: Applies the GLM to genomic data to estimate DNA concentration.
- `bin_pmol()`: Maps fragment-level predictions to fixed genomic windows.

## Tips for Success
- **Index Files**: Ensure BAM files have `.bai` indexes and BEDPE files are sorted, bgzipped, and indexed with `tabix`.
- **Genome Versions**: When using `predict_pmol`, ensure the `bsgenome` string matches an installed Bioconductor BSgenome object (e.g., `"BSgenome.Hsapiens.UCSC.hg19"`).
- **Batch Effects**: Always build a new GLM for each batch of samples using `model_glm_pmol` to account for batch-specific immunoprecipitation efficiency.

## Reference documentation
- [Spiky: Analysing cfMeDIP-seq data with spike-in controls](./references/spiky_vignette.md)
- [Spiky: Analysing cfMeDIP-seq data with spike-in controls (Rmd)](./references/spiky_vignette.Rmd)