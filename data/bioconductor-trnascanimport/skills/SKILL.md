---
name: bioconductor-trnascanimport
description: This tool imports and parses tRNAscan-SE output files into Bioconductor-compatible GRanges objects for downstream genomic analysis in R. Use when user asks to import tRNAscan-SE results, convert tRNA predictions to GFF3 format, extract tRNA precursor sequences, or visualize tRNA features and statistics.
homepage: https://bioconductor.org/packages/release/bioc/html/tRNAscanImport.html
---

# bioconductor-trnascanimport

name: bioconductor-trnascanimport
description: Import and analyze tRNAscan-SE output in R. Use this skill to parse tRNAscan-SE text files into Bioconductor GRanges objects, extract tRNA sequences, handle introns, and prepare tRNA data for visualization or downstream genomic analysis.

## Overview

The `tRNAscanImport` package bridges the gap between the standalone tRNAscan-SE tool (or gtRNADb) and the Bioconductor ecosystem. It parses the formatted text output of tRNAscan-SE into `GRanges` objects, preserving metadata such as tRNA type, anticodon positions, scores, and secondary structure information.

## Core Workflow

### 1. Importing tRNAscan-SE Output
The primary function is `import.tRNAscanAsGRanges()`. It reads the text-based output and converts it into a structured `GRanges` object.

```r
library(tRNAscanImport)

# Path to your tRNAscan-SE output file
tRNA_file <- "path/to/output.tRNAscan"

# Import as GRanges
gr <- import.tRNAscanAsGRanges(tRNA_file)

# Verify the object
istRNAscanGRanges(gr) # Returns TRUE if valid
head(gr)
```

### 2. Metadata and Sequences
The resulting `GRanges` object contains several metadata columns:
- `tRNA_type`: Amino acid type.
- `tRNA_anticodon`: The anticodon sequence.
- `tRNAscan_score`: The confidence score.
- `tRNA_seq`: The actual tRNA sequence as a `DNAStringSet`.
- `tRNA_str`: Secondary structure in dot-bracket notation.

### 3. Exporting Data
To use the data in other tools, you can export the sequences or convert the object to a GFF3-compliant format.

```r
library(Biostrings)
library(rtracklayer)

# Save sequences to FASTA
writeXStringSet(gr$tRNA_seq, filepath = "tRNAs.fasta")

# Convert to GFF3 and export
gff <- tRNAscan2GFF(gr)
export.gff3(gff, con = "tRNAs.gff3")
```

### 4. Retrieving Precursor Sequences
If you have the corresponding genome sequence (e.g., from a `BSgenome` package), you can extract the genomic context (precursors) around the predicted tRNAs.

```r
# Assuming 'genome' is a DNAStringSet or BSgenome object
# add.5prime and add.3prime define the length of flanking regions
tRNAprecursor <- get.tRNAprecursor(gr, genome, add.5prime = 50, add.3prime = 50)

# Optional: Remove introns from the precursor sequences
tRNAprecursor_trimmed <- get.tRNAprecursor(gr, genome, trim.introns = TRUE)
```

## Visualization and Summary
While `tRNAscanImport` handles the data entry, it integrates with the `tRNA` package for analysis.

- `gettRNASummary(gr)`: Provides aggregated statistics.
- `gettRNAFeaturePlots(grl)`: Generates ggplot2 visualizations for tRNA length, scores, GC content, and intron distribution (requires a `GRangesList`).

## Tips
- **Chromosome Names**: Ensure the chromosome names in your tRNAscan-SE output match the names in your genome object when using `get.tRNAprecursor()`.
- **CCA-end**: The `tRNA_CCA.end` column indicates if the conserved CCA-end is encoded in the genomic DNA.
- **Introns**: tRNAscan-SE identifies introns; `tRNAscanImport` captures their genomic and local coordinates (`tRNAscan_intron.start`, etc.).

## Reference documentation
- [tRNAscanImport](./references/tRNAscanImport.md)