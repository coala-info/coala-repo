---
name: bioconductor-crisprbase
description: The bioconductor-crisprbase package provides foundational S4 classes and arithmetic functions to represent CRISPR nucleases, base editors, and nickases within the crisprVerse ecosystem. Use when user asks to define custom CRISPR systems, calculate genomic coordinates for cut sites and protospacers, or manage PAM sequences and target ranges.
homepage: https://bioconductor.org/packages/release/bioc/html/crisprBase.html
---

# bioconductor-crisprbase

name: bioconductor-crisprbase
description: Expert guidance for the Bioconductor package crisprBase. Use this skill when designing CRISPR guide-RNAs (gRNAs), defining custom nucleases (Cas9, Cas12a, Cas13), working with base editors or nickases, and performing genomic arithmetic for CRISPR target sites.

## Overview

The `crisprBase` package is the foundational component of the crisprVerse ecosystem. It provides S4 classes to represent various CRISPR systems (nucleases, base editors, and nickases) and general restriction enzymes. It standardizes CRISPR terminology and provides arithmetic functions to calculate cut sites, protospacer ranges, and PAM sequences across different genomic strands and nuclease types.

## Core Classes

### Nuclease
Used for general restriction enzymes or recognition motifs.
```r
library(crisprBase)
EcoRI <- Nuclease("EcoRI", targetType="DNA", motifs=c("G^AATTC"))
motifs(EcoRI, expand=TRUE) # View expanded IUPAC codes
```

### CrisprNuclease
The primary class for CRISPR systems. Requires `pam_side` ("3prime" or "5prime") and `spacer_length`.
```r
# Manual construction
SpCas9 <- CrisprNuclease("SpCas9", 
                         targetType="DNA", 
                         pams=c("(3/3)NGG", "(3/3)NAG"), 
                         pam_side="3prime", 
                         spacer_length=20)

# Loading pre-built nucleases
data(SpCas9, package="crisprBase")
data(AsCas12a, package="crisprBase")
data(CasRx, package="crisprBase") # RNA-targeting
```

### BaseEditor and CrisprNickase
Extensions for specialized editing technologies.
```r
# Nickase: specify which strand is cleaved
Cas9D10A <- CrisprNickase("Cas9D10A", nickingStrand="opposite", pams="(3)NGG", pam_side="3prime")

# BaseEditor: requires editing weights matrix
BE4max <- BaseEditor(SpCas9, baseEditorName="BE4max", editingStrand="original", editingWeights=ws)
plotEditingWeights(BE4max)
```

## CRISPR Arithmetic and Ranges

Use these functions to convert between PAM sites and genomic coordinates. A `pam_site` is defined as the coordinate of the first nucleotide of the PAM sequence.

### Coordinate Extraction
```r
# Get cut site relative to PAM site
cutSites(SpCas9, strand="+")

# Extract sequences from target strings (Protospacer + PAM)
targets <- c("AGGTGCTGATTGTAGTGCTGCGG")
extractPamFromTarget(targets, SpCas9)
extractProtospacerFromTarget(targets, SpCas9)
```

### Genomic Ranges (GRanges)
Generate `GRanges` objects for different parts of the CRISPR target:
```r
# Inputs: seqnames, pam_site, strand, nuclease
getPamRanges(seqnames="chr7", pam_site=200, strand="+", nuclease=SpCas9)
getProtospacerRanges(seqnames="chr7", pam_site=200, strand="+", nuclease=SpCas9)
getTargetRanges(seqnames="chr7", pam_site=200, strand="+", nuclease=SpCas9)
```

## Key Conventions
- **Spacer vs. Protospacer**: For DNA nucleases, these are identical. For RNA nucleases (e.g., Cas13d), the spacer is the reverse complement of the protospacer.
- **PAM Site**: Always the 1st nucleotide of the PAM motif in the 5' to 3' direction on the strand where the PAM is located.
- **Target Type**: Set `targetType="RNA"` for nucleases like CasRx to ensure correct reverse-complement logic for spacers.

## Reference documentation
- [Base functions and classes for CRISPR gRNA design](./references/crisprBase.md)
- [Introduction to crisprBase](./references/crisprBase.Rmd)