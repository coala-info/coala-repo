---
name: bioconductor-msa
description: This tool performs multiple sequence alignment for protein, DNA, or RNA sequences using ClustalW, ClustalOmega, or MUSCLE algorithms within R. Use when user asks to align biological sequences, calculate consensus sequences, compute conservation scores, or generate pretty-printed alignment visualizations.
homepage: https://bioconductor.org/packages/release/bioc/html/msa.html
---


# bioconductor-msa

name: bioconductor-msa
description: Perform multiple sequence alignment (MSA) using ClustalW, ClustalOmega, and MUSCLE algorithms within R. Use this skill when you need to align protein, DNA, or RNA sequences, calculate consensus sequences, compute conservation scores, or generate pretty-printed alignment visualizations (PDF/TeX).

# bioconductor-msa

## Overview
The `msa` package provides a unified R interface to three popular multiple sequence alignment algorithms: ClustalW, ClustalOmega, and MUSCLE. It integrates seamlessly with the Biostrings ecosystem, allowing for the alignment of `AAStringSet`, `DNAStringSet`, and `RNAStringSet` objects. A key feature is its ability to interface with the LaTeX package "TeXshade" for high-quality, customizable alignment visualizations.

## Core Workflow

### 1. Loading Sequences
Sequences must be in a Biostrings container. You can read them from a FASTA file:
```r
library(msa)
mySeqs <- readAAStringSet("path/to/sequences.fasta")
# Or readDNAStringSet / readRNAStringSet
```

### 2. Running Alignment
The `msa()` function is a wrapper for all three algorithms. By default, it uses ClustalW.
```r
# Default (ClustalW)
aln <- msa(mySeqs)

# Specify algorithm
aln_omega <- msa(mySeqs, method = "ClustalOmega")
aln_muscle <- msa(mySeqs, method = "Muscle")
```

### 3. Inspecting Results
The alignment object can be printed to the console. Use `show="complete"` to see the full alignment.
```r
print(aln, show="complete")
# Show a specific range
print(aln, show=c(100, 200))
```

## Advanced Processing

### Consensus and Conservation
Calculate the consensus sequence or conservation scores based on substitution matrices.
```r
# Simple consensus
con <- msaConsensusSequence(aln)

# Upper/Lower case consensus based on thresholds
con_ul <- msaConsensusSequence(aln, type="upperlower", thresh=c(40, 20))

# Conservation scores (requires a substitution matrix)
library(pwalign)
data(BLOSUM62)
scores <- msaConservationScore(aln, BLOSUM62)
```

### Masking and Subsetting
You can mask specific rows or columns without deleting the data.
```r
# Mask columns 1 to 50
colmask(aln) <- IRanges(start=1, end=50)

# Remove masks to get a raw StringSet
raw_aln <- unmasked(aln)
```

### Interfacing with Other Packages
Convert `msa` objects for use in `seqinr`, `ape`, or `phangorn`.
```r
# Convert to seqinr format for distance calculation
aln_seqinr <- msaConvert(aln, type="seqinr::alignment")

# Convert to ape format (DNAbin/AAbin)
aln_ape <- msaConvert(aln, type="ape::AAbin")
```

## Pretty-Printing (Visualization)
The `msaPrettyPrint()` function generates LaTeX-based visualizations. This requires a TeX distribution installed on the system.

```r
# Generate a PDF of the alignment
msaPrettyPrint(aln, output="pdf", file="my_alignment.pdf", askForOverwrite=FALSE)

# Customize shading and features
msaPrettyPrint(aln, output="asis", 
               shadingMode="similar", 
               shadingColors="blues",
               showLogo="top",
               showConsensus="bottom")
```

## Algorithm-Specific Tips
- **ClustalW**: Supports custom substitution matrices via `substitutionMatrix`.
- **ClustalOmega**: Fast for very large datasets. Does not allow custom gap penalties. Only supports a specific set of matrices (e.g., "Gonnet", "BLOSUM65").
- **MUSCLE**: Good balance of speed and accuracy. Use `maxiters` to control refinement cycles.

## Reference documentation
- [msa](./references/msa.md)