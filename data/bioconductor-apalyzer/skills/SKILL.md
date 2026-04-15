---
name: bioconductor-apalyzer
description: APAlyzer analyzes alternative polyadenylation events, including 3'UTR and intronic polyadenylation, from RNA-seq BAM files. Use when user asks to identify APA regulation patterns, calculate relative expression of polyadenylation sites, or perform significance testing between experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/APAlyzer.html
---

# bioconductor-apalyzer

## Overview
APAlyzer is a Bioconductor package designed to analyze Alternative Polyadenylation (APA) events from RNA-seq BAM files. It focuses on two main types of events: 3'UTR APA (shifts between proximal and distal polyadenylation sites) and Intronic Polyadenylation (IPA). The package uses annotated PolyA sites (PAS) to demarcate genomic regions and calculates Relative Expression (RE) to identify APA regulation patterns across different conditions.

## Installation and Setup
```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("APAlyzer")
library(APAlyzer)
```

## Workflow: 3'UTR APA Analysis

### 1. Prepare Reference Regions
Load PAS references (e.g., mm9, mm10, hg19, hg38) and define the alternative UTR (aUTR) and core UTR (cUTR) regions.
```r
# Load pre-built reference (example for mm9)
# refUTRraw, dfIPA, and dfLE are typically loaded from RData
UTRdbraw <- REF3UTR(refUTRraw)
```

### 2. Calculate Relative Expression
Quantify reads in aUTR and cUTR regions from BAM files.
```r
# flsall is a named vector of paths to BAM files
DFUTRraw <- PASEXP_3UTR(UTRdbraw, flsall, Strandtype="forward")
# Output includes: aUTR_counts, cUTR_counts, and RE (log2(aUTR/cUTR))
```

### 3. Significance Testing
Compare two groups (e.g., Control vs Treatment) to find significantly regulated genes.
```r
sampleTable <- data.frame(samplename = names(flsall), condition = c("Control", "Control", "Test", "Test"))

test_3UTR <- APAdiff(sampleTable, DFUTRraw, 
                     conKET='Control', trtKEY='Test', 
                     PAS='3UTR', MultiTest='unpaired t-test')
# APAreg column: 'UP' (lengthening), 'DN' (shortening), 'NC' (no change)
```

## Workflow: Intronic APA (IPA) Analysis

### 1. Prepare IPA Reference
IPA analysis requires intronic PAS regions and 3'-most exon (LE) regions.
```r
# Use REF4PAS to synchronize references
PASREF <- REF4PAS(refUTRraw, dfIPAraw, dfLEraw)
```

### 2. Calculate IPA Expression
```r
IPA_OUTraw <- PASEXP_IPA(PASREF$dfIPA, PASREF$dfLE, flsall, Strandtype="forward")
# RE is calculated as log2((IPA_upstream - IPA_downstream) / 3'-most_exon)
```

### 3. Significance Testing
```r
test_IPA <- APAdiff(sampleTable, IPA_OUTraw, 
                    conKET='Control', trtKEY='Test', 
                    PAS='IPA')
```

## Visualization
APAlyzer provides built-in functions for visualizing results:
```r
# Volcano plot for APA changes
APAVolcano(test_3UTR, PAS='3UTR', Pcol = "pvalue", top=5)

# Boxplot of Relative Expression Difference (RED)
APABox(test_3UTR, xlab = "APAreg", ylab = "RED")
```

## Advanced Features
- **Custom Annotations**: Use `PAS2GEF(GTFfile)` to build references from a GTF file if the species is not in PolyA_DB.
- **Paired-End Data**: For paired-end BAMs, use `ThreeMostPairBam` to extract the 3'-most alignments before analysis to improve PAS quantification accuracy.
- **Gene Expression**: Use `REFCDS` and `GENEXP_CDS` to calculate standard gene expression based on coding sequences for comparison with APA results.

## Reference documentation
- [APAlyzer: A toolkit for APA analysis using RNA-seq data](./references/APAlyzer.Rmd)