---
name: bioconductor-xnastring
description: This Bioconductor package provides specialized tools for the analysis, sequence alignment, and thermodynamic modeling of Xenonucleic Acids and modified oligonucleotides. Use when user asks to represent XNA sequences, perform pairwise alignments between modified and standard nucleic acids, or calculate melting temperatures for XNA-DNA and XNA-RNA duplexes.
homepage: https://bioconductor.org/packages/release/bioc/html/XNAString.html
---


# bioconductor-xnastring

name: bioconductor-xnastring
description: Specialized R package for the analysis of Xenonucleic Acids (XNA) and modified oligonucleotides. Use this skill when a user needs to perform sequence alignment, calculate melting temperatures (Tm), or analyze hybridization properties of XNA-DNA or XNA-RNA duplexes using the XNAString Bioconductor package.

# bioconductor-xnastring

## Overview
The `XNAString` package extends Biostrings functionality to support Xenonucleic Acids (XNAs). It provides classes and methods for representing XNA sequences, performing pairwise alignments between XNA and DNA/RNA, and predicting thermodynamic properties like melting temperatures. This is essential for researchers working with synthetic biology, antisense oligonucleotides, or modified nucleic acids.

## Installation and Loading
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("XNAString")

library(XNAString)
```

## Core Workflows

### Creating XNA Strings
XNA sequences are represented using the `XNAString` class. You can define sequences with specific modifications.
```r
# Create an XNAString (e.g., representing a Phosphorothioate or LNA modification)
# Note: Specific notation depends on the chemistry being modeled
xna_seq <- XNAString("ATGC")
```

### Sequence Alignment
Perform alignments between XNA sequences and standard DNA/RNA targets.
```r
target <- DNAString("ATGCATGC")
pattern <- XNAString("ATGC")

# Perform global or local alignment
align_result <- pairwiseAlignment(pattern, target)
score(align_result)
```

### Melting Temperature (Tm) Calculation
One of the primary uses of `XNAString` is predicting the stability of duplexes involving modified bases.
```r
# Calculate Tm for an XNA-DNA duplex
# Parameters typically include salt concentration and oligonucleotide concentration
tm_val <- calculateTm(xna_seq, target_seq = DNAString("TACG"), 
                      Na = 0.05, Mono = 0.1)
```

### Handling Modified Bases
The package allows for the definition of custom base properties (enthalpy, entropy) to support various XNA chemistries (e.g., MOE, LNA, PNA).
```r
# Accessing built-in thermodynamic parameters
data(XNAParameters)
```

## Tips for Effective Usage
- **Chemistry Specifics**: Always ensure the thermodynamic parameters match the specific XNA chemistry (e.g., 2'-O-methyl vs. Phosphorothioate) you are simulating.
- **Biostrings Compatibility**: Since `XNAString` inherits from the Biostrings infrastructure, you can use standard functions like `reverseComplement()` or `width()` on XNA objects.
- **Salt Correction**: Tm calculations are highly sensitive to salt concentrations (`Na`, `Mg`). Ensure these match your experimental conditions for accurate predictions.

## Reference documentation
- [XNAString Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/XNAString.html)