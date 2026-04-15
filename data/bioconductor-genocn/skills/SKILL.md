---
name: bioconductor-genocn
description: This tool identifies copy number variations and aberrations from SNP array data using a Hidden Markov Model framework. Use when user asks to identify copy number states, perform genotype calls from Log R Ratio and B Allele Frequency data, or model tissue contamination in tumor samples.
homepage: https://bioconductor.org/packages/3.8/bioc/html/genoCN.html
---

# bioconductor-genocn

name: bioconductor-genocn
description: Identify copy number variations (CNV) and copy number aberrations (CNA) from SNP array data using the genoCN R package. Use this skill when you need to perform integrated analysis of copy number states and genotype calls, model tissue contamination in tumor samples, or use paired tumor-normal data for CNA detection.

## Overview

The `genoCN` package provides a Hidden Markov Model (HMM) framework to simultaneously identify copy number states and genotype calls from SNP array data (specifically Log R Ratio (LRR) and B Allele Frequency (BAF)). It includes two main components:
- `genoCNV`: Designed for naturally occurring and inheritable copy number variations in germline samples.
- `genoCNA`: Designed for acquired somatic alterations in tumor tissues, explicitly modeling tissue contamination (purity) and utilizing paired normal genotypes if available.

## Core Workflow

### 1. Data Preparation
The package requires two main data structures:
- **SNP Information**: A data frame with columns: `Name`, `Chr`, `Position`, and `PFB` (Population Frequency of B allele).
- **SNP Data**: A data frame containing `LRR` and `BAF` values for each SNP.

Data must be sorted by chromosomal location before analysis.

```R
library(genoCN)

# Load example data
data(snpData)
data(snpInfo)

# Ensure data is aligned and sorted
# Probes with PFB > 1 are treated as copy-number-only probes
```

### 2. Running the Analysis

#### For Germline Samples (CNV)
Use `genoCNV` to identify inherited variations.

```R
Theta = genoCNV(snpInfo$Name, 
                snpInfo$Chr, 
                snpInfo$Position, 
                snpData$LRR, 
                snpData$BAF, 
                snpInfo$PFB, 
                sampleID="sample01", 
                cnv.only=(snpInfo$PFB > 1), 
                outputSeg = TRUE, 
                outputSNP = 1, 
                outputTag = "sample01")
```

#### For Tumor Samples (CNA)
Use `genoCNA` to identify somatic aberrations. It includes parameters for tissue contamination and paired normal genotypes.

```R
Theta = genoCNA(snpInfo$Name, 
                snpInfo$Chr, 
                snpInfo$Position, 
                snpData$LRR, 
                snpData$BAF, 
                snpInfo$PFB, 
                sampleID="tumor01", 
                contamination = TRUE,
                normalGtp = NULL, # Vector of normal genotypes (0,1,2) if available
                outputSeg = TRUE, 
                outputSNP = 1, 
                outputTag = "tumor01")
```

### 3. Interpreting Results

The functions produce two main output files based on `outputTag`:
- **`TAG_segment.txt`**: Contains identified segments. Columns include `chr`, `start`, `end`, `state` (HMM state), `cn` (copy number), and `score`.
- **`TAG_SNP.txt`**: Contains SNP-specific calls. `outputSNP` levels:
    - `1`: SNPs in altered regions.
    - `2`: All SNPs.
    - `3`: Posterior probabilities for all states.

### 4. Visualization
Use `plotCN` to visualize LRR, BAF, and the resulting copy number calls.

```R
# Plot raw data and overlay segment calls
plotCN(pos=snpInfo$Position, 
       LRR=snpData$LRR, 
       BAF=snpData$BAF, 
       main = "Sample Analysis", 
       fileNames="sample01_segment.txt")
```

## Key Parameters and Tips

- **`cnv.only`**: Set this to `TRUE` for probes that do not overlap SNPs (where BAF is not informative). Usually identified by `PFB > 1`.
- **`seg.nSNP`**: Controls the minimum number of SNPs required to report a segment (default is 3).
- **Tumor Purity**: If using `genoCNA`, the tumor purity ($p_T$) can be estimated from the `mu.b` (mean BAF) estimates returned in the output list.
- **HMM States**: The package uses specific state indices (e.g., state 4 often represents CN 1 in `genoCNV`). Refer to the segment file `cn` column for the actual copy number estimate.

## Reference documentation
- [genoCN](./references/genoCN.md)