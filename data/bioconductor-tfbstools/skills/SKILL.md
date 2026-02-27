---
name: bioconductor-tfbstools
description: "TFBSTools provides a computational framework for the analysis and manipulation of transcription factor binding sites. Use when user asks to create or convert position matrices, search DNA sequences for motifs, interface with the JASPAR database, or perform phylogenetic footprinting."
homepage: https://bioconductor.org/packages/release/bioc/html/TFBSTools.html
---


# bioconductor-tfbstools

name: bioconductor-tfbstools
description: Analysis and manipulation of transcription factor binding sites (TFBS). Use this skill to create, convert, and compare position matrices (PFM, PWM, ICM), search DNA sequences for binding sites, interface with the JASPAR database, and perform phylogenetic footprinting.

# bioconductor-tfbstools

## Overview
TFBSTools is an R/Bioconductor package providing a computational framework for TFBS analysis. It supports the full lifecycle of motif analysis: pattern generation (PFM/PWM), sequence scanning for putative sites, and advanced modeling using Transcription Factor Flexible Models (TFFM). It serves as the primary R interface for the JASPAR database.

## Core Workflows

### 1. Matrix Objects and Conversions
The package uses S4 classes to represent different matrix types.
*   **PFM (Position Frequency Matrix):** Raw counts.
*   **PWM (Position Weight Matrix):** Log-likelihood scores for scanning.
*   **ICM (Information Content Matrix):** Used for sequence logos.

```r
library(TFBSTools)

# Create a PFM
pfm <- PFMatrix(ID="MA0004.1", name="Arnt",
                profileMatrix=matrix(c(4L,19L,0L,0L, 16L,0L,20L,0L, 0L,1L,0L,20L, 0L,0L,0L,0L), 
                                     nrow=4, dimnames=list(c("A","C","G","T"))))

# Convert PFM to PWM or ICM
pwm <- toPWM(pfm, type="log2probratio", pseudocounts=0.8)
icm <- toICM(pfm, schneider=TRUE)

# Plot sequence logo
seqLogo(icm)
```

### 2. Interfacing with JASPAR
Use the `JASPAR2014` (or newer) data packages to retrieve known motifs.

```r
library(JASPAR2014)
opts <- list(species=9606, name="RUNX1")
pfmList <- getMatrixSet(JASPAR2014, opts)
pwmList <- toPWM(pfmList)
```

### 3. Scanning Sequences (searchSeq)
Scan a `DNAString` or `DNAStringSet` for matches to a PWM.

```r
library(Biostrings)
subject <- DNAString("GAATTCTCTCTTGTTGTAGTCTCTTGACAAAATG")

# Search both strands (*) with a minimum score threshold
siteset <- searchSeq(pwm, subject, seqname="seq1", min.score="80%", strand="*")

# Extract results
head(writeGFF3(siteset))
relScore(siteset)
pvalues(siteset, type="TFMPvalue") # Requires TFMPvalue package
```

### 4. Pairwise Alignment Scanning (searchAln)
Identify conserved binding sites in aligned sequences (phylogenetic footprinting).

```r
sitePairSet <- searchAln(pwm, aln1, aln2, min.score="70%", cutoff=0.5, strand="*")
```

### 5. TFFM (Transcription Factor Flexible Models)
TFFMs capture position interdependence, unlike standard PWMs.

```r
# Read TFFM from XML (usually from Python TFFM tool)
tffmFirst <- readXMLTFFM("tffm_first_order.xml", type="First")
seqLogo(tffmFirst)
```

## Tips and Best Practices
*   **Pseudocounts:** The default `pseudocounts=0.8` is recommended for converting PFMs to PWMs to avoid log(0) and handle small sample sizes.
*   **Background Frequencies:** Always ensure the `bg` argument in `toPWM` matches the GC content of your target genome for accurate scoring.
*   **Thresholds:** `min.score` can be a percentage (e.g., "80%") or an absolute value. Percentages are relative to the maximum possible score for that specific PWM.
*   **Memory:** When scanning whole genomes, use `searchPairBSgenome` or process sequences in chunks to manage memory.

## Reference documentation
- [Transcription factor binding site (TFBS) analysis with the "TFBSTools" package](./references/TFBSTools.md)
- [TFBSTools Source Documentation](./references/TFBSTools.Rmd)