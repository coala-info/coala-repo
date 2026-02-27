---
name: bioconductor-sangerseqr
description: This tool processes and analyzes Sanger sequencing data from ABIF and SCF files. Use when user asks to read Sanger sequencing files, visualize chromatograms, perform basecalling, or resolve heterozygous indels.
homepage: https://bioconductor.org/packages/release/bioc/html/sangerseqR.html
---


# bioconductor-sangerseqr

name: bioconductor-sangerseqr
description: Analysis and manipulation of Sanger sequencing data (ABIF and SCF files). Use this skill to import chromatogram data, perform primary and secondary basecalling, visualize chromatograms, and resolve heterozygous indels by parsing alleles.

# bioconductor-sangerseqr

## Overview
The `sangerseqR` package is designed for reading, visualizing, and processing Sanger sequencing data. It supports both proprietary ABIF (.ab1) and open-source SCF (.scf) formats. Its primary utility lies in its ability to handle heterozygous sequences (double peaks) and automate the separation of alleles, particularly in cases of heterozygous indels.

## Core Workflow

### 1. Loading Data
While specific functions exist for ABIF and SCF files, the universal reader is recommended for most tasks.

```r
library(sangerseqR)

# Recommended: Automatically detects file type and creates a sangerseq object
seq_data <- readsangerseq(system.file("extdata", "heterozygous.ab1", package = "sangerseqR"))

# Alternative: Direct access to raw file structures
abif_raw <- read.abif("path/to/file.ab1")
scf_raw <- read.scf("path/to/file.scf")
```

### 2. Working with Sangerseq Objects
The `sangerseq` class is the central data structure. It contains slots for primary/secondary sequences, the trace matrix, and peak positions/amplitudes.

*   **Accessors:** Use `primarySeq(obj)` and `secondarySeq(obj)`.
*   **Format:** Set `string = TRUE` to get a character string, or `FALSE` (default) to get a `Biostrings::DNAString` object.

```r
# Get the primary sequence as a DNAString for alignment
p_seq <- primarySeq(seq_data)

# Get the secondary sequence as a character string
s_str <- secondarySeq(seq_data, string = TRUE)
```

### 3. Visualizing Chromatograms
Use the `chromatogram` function to generate plots. For long sequences, it is best to output to a PDF to avoid graphics device dimension errors.

```r
# Basic plot with both primary and secondary calls shown
chromatogram(seq_data, width = 80, height = 3, trim5 = 50, trim3 = 100, showcalls = "both")

# Save to PDF for high-quality output
chromatogram(seq_data, filename = "my_chromatogram.pdf")
```

### 4. Making Basecalls
To identify heterozygous peaks or re-call bases based on signal-to-noise ratios, use `makeBaseCalls`. The `ratio` parameter determines the cutoff for secondary peaks (e.g., 0.33 means a secondary peak must be at least 33% the height of the primary peak).

```r
# Re-calculate calls with a specific signal ratio
het_calls <- makeBaseCalls(seq_data, ratio = 0.33)
```

### 5. Parsing Alleles (Heterozygous Indels)
If you have a reference sequence (e.g., from a homozygous sample), you can phase the alleles in a heterozygous sample.

```r
# 1. Define reference (as a DNAString or character)
ref_seq <- "ATCG..." 

# 2. Set allele phase
phased_seq <- setAllelePhase(het_calls, ref_seq)

# 3. Compare alleles using Biostrings alignment
library(pwalign) # or Biostrings
pa <- pairwiseAlignment(primarySeq(phased_seq), secondarySeq(phased_seq), type = "global-local")
```

## Tips and Best Practices
*   **Trimming:** Use `trim5` and `trim3` in `chromatogram` and `setAllelePhase` to remove low-quality data at the start and end of the reads.
*   **Biostrings Integration:** Since sequences are returned as `DNAString` objects, you can immediately use functions like `reverseComplement()`, `matchPattern()`, or `vcountPattern()`.
*   **PolyPeakParser:** For a GUI-based approach to indel separation, you can run the local Shiny app included in the package using `PolyPeakParser()`.

## Reference documentation
- [Using the sangerseqR package](./references/sangerseqRWalkthrough.md)