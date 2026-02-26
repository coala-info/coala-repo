---
name: bioconductor-apalyzer
description: "APAlyzer identifies and quantifies alternative polyadenylation events from RNA-seq BAM files. Use when user asks to quantify 3'UTR alternative polyadenylation, analyze intronic polyadenylation, calculate relative expression differences, or perform significance testing between experimental conditions."
homepage: https://bioconductor.org/packages/release/bioc/html/APAlyzer.html
---


# bioconductor-apalyzer

name: bioconductor-apalyzer
description: Analysis of alternative polyadenylation (APA) events using RNA-seq data. Use this skill to quantify 3'UTR APA and intronic polyadenylation (IPA) from BAM files, calculate relative expression (RE), and perform significance testing between experimental conditions.

## Overview
APAlyzer is a Bioconductor package designed to identify and quantify alternative polyadenylation (APA) events. It focuses on two main types of events: 3'UTR APA (lengthening or shortening of the 3'UTR) and Intronic Polyadenylation (IPA). The package works by comparing read coverage in specific genomic regions defined by polyadenylation sites (PAS).

## Core Workflow

### 1. Setup and Reference Preparation
APAlyzer requires PAS references. You can use pre-built references for human (hg19, hg38) and mouse (mm9, mm10) or generate them from GTF files.

```r
library(APAlyzer)

# Load pre-built reference (example for mm9)
library(repmis)
URL="https://github.com/RJWANGbioinfo/PAS_reference_RData/blob/master/"
source_data(paste0(URL, "mm9_REF.RData?raw=True"))

# Build reference regions at once
PASREF <- REF4PAS(refUTRraw, dfIPA, dfLE)
UTRdbraw <- PASREF$UTRdbraw
dfIPA <- PASREF$dfIPA
dfLE <- PASREF$dfLE
```

### 2. Quantifying 3'UTR APA
This analysis calculates the Relative Expression (RE) based on the ratio of reads in the distal UTR (aUTR) vs. the core UTR (cUTR).

```r
# 1. Define aUTR and cUTR regions
UTRdbraw <- REF3UTR(refUTRraw)

# 2. Calculate expression from BAM files
# flsall is a named vector of paths to BAM files
DFUTRraw <- PASEXP_3UTR(UTRdbraw, flsall, Strandtype="forward")
```

### 3. Quantifying Intronic Polyadenylation (IPA)
IPA analysis compares reads upstream and downstream of intronic PAS relative to the 3'-most exon.

```r
# Calculate IPA expression
IPA_OUTraw <- PASEXP_IPA(dfIPA, dfLE, flsall, Strandtype="forward", nts=1)
```

### 4. Significance Analysis
Compare two groups (e.g., Control vs. Treatment) using `APAdiff`. It handles both single-replicate (Fisher's Exact Test) and multi-replicate (t-test/ANOVA) designs.

```r
# Create sample table
sampleTable <- data.frame(
  samplename = names(flsall),
  condition = c(rep("Control", 3), rep("Treatment", 3))
)

# Test for 3'UTR APA differences
test_3UTR <- APAdiff(sampleTable, DFUTRraw, 
                     conKET='Control', trtKEY='Treatment', 
                     PAS='3UTR', CUTreads=5)

# Test for IPA differences
test_IPA <- APAdiff(sampleTable, IPA_OUTraw, 
                    conKET='Control', trtKEY='Treatment', 
                    PAS='IPA', CUTreads=5)
```

### 5. Visualization
APAlyzer provides built-in functions for visualizing Relative Expression Difference (RED).

```r
# Volcano plot
APAVolcano(test_3UTR, PAS='3UTR', Pcol = "pvalue", top=5)

# Box plot of RED by regulation pattern (UP, DN, NC)
APABox(test_3UTR, xlab = "APAreg", ylab = "RED")
```

## Key Parameters and Definitions
- **RED (Relative Expression Difference):** The difference in log2 ratios between groups.
- **APAreg:** 
    - `UP`: Lengthening (3'UTR) or increased IPA usage in treatment.
    - `DN`: Shortening (3'UTR) or decreased IPA usage in treatment.
    - `NC`: No significant change.
- **Strandtype:** Can be "forward", "invert", or "NONE" depending on the RNA-seq library preparation.
- **SeqType:** For paired-end data where only the 3'-most alignment is extracted, set to "ThreeMostPairEnd".

## Reference documentation
- [APAlyzer: A toolkit for APA analysis using RNA-seq data](./references/APAlyzer.Rmd)