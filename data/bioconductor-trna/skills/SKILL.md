---
name: bioconductor-trna
description: The bioconductor-trna package provides specialized tools for analyzing, extracting, and visualizing tRNA structural elements and features from genomic data. Use when user asks to extract specific tRNA components like loops or stems, subset tRNAs based on structural characteristics, or compare tRNA feature distributions across datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/tRNA.html
---

# bioconductor-trna

name: bioconductor-trna
description: Analyzing tRNA sequences and structures using the Bioconductor tRNA package. Use this skill when you need to extract specific tRNA structural elements (loops, stems), subset tRNAs based on structural features (mismatches, bulges, lengths), or visualize tRNA feature distributions across different datasets.

## Overview

The `tRNA` package provides specialized tools for the analysis of tRNA features. It operates on `GRanges` objects that contain both sequence and secondary structure information (in dot-bracket notation). It allows for the extraction of specific tRNA components (e.g., the anticodon loop), structural subsetting, and comparative visualization of tRNA characteristics like GC content, length, and tRNAscan-SE scores.

## Data Preparation

The package requires a `GRanges` object with specific metadata columns. If importing from external tools, use `tRNAscanImport` or `tRNAdbImport`.

Required metadata columns:
- `tRNA_length`: Integer length of the tRNA.
- `tRNA_type`: Amino acid specificity.
- `tRNA_anticodon`: Anticodon sequence.
- `tRNA_seq`: The tRNA sequence.
- `tRNA_str`: Dot-bracket structure string (compatible with `Structstrings`).
- `tRNA_CCA.end`: Logical indicating presence of CCA end.

## Core Workflows

### Extracting Structural Elements

You can retrieve coordinates or sequences for specific parts of the tRNA (e.g., "anticodonLoop", "DStem", "Tloop").

```r
library(tRNA)

# Get coordinates of the anticodon loop
gettRNAstructureGRanges(gr, structure = "anticodonLoop")

# Get sequences of the anticodon loop
gettRNAstructureSeqs(gr, structure = "anticodonLoop")

# Get full sequences padded/aligned by structure
seqs <- gettRNAstructureSeqs(gr, joinCompletely = TRUE)
# Access structure boundaries via metadata
metadata(seqs)[["tRNA_structures"]]
```

### Subsetting by Structure

Use `has*` functions to filter tRNAs based on structural integrity or specific features.

```r
# Find tRNAs with an unpaired acceptor stem
gr[hasAcceptorStem(gr, unpaired = TRUE)]

# Find tRNAs with mismatches in the acceptor stem and a specific D-loop length
gr[hasAcceptorStem(gr, mismatches = TRUE) & hasDloop(gr, length = 8L)]
```

Available functions include `hasAcceptorStem`, `hasDStem`, `hasDloop`, `hasAnticodonStem`, `hasAnticodonLoop`, `hasVariableLoop`, `hasTStem`, and `hasTloop`.

### Visualization and Summaries

Compare multiple tRNA sets (e.g., different species) using `GRangesList`.

```r
grl <- GRangesList(Human = gr_human, Ecoli = gr_eco)

# Generate a list of ggplot2 objects
plots <- gettRNAFeaturePlots(grl)

# View specific plots
plots$length
plots$gc
plots$variableLoop_length

# Get raw summary data without plotting
summary_stats <- gettRNASummary(grl)
```

### Base Pairing and Loop Analysis

For detailed residue-level pairing information:

```r
# Get base pairing data frame (pos, forward, reverse, character)
bp <- gettRNABasePairing(gr)

# Get loop IDs for each position
loop_ids <- gettRNALoopIDs(gr)
```

## Tips

- **Dot-Bracket Format**: Ensure `tRNA_str` uses standard characters (`<>{}[]()`). The package handles the `><` orientation often found in tRNAscan-SE files by converting them via `Structstrings`.
- **Custom Plots**: Since `gettRNAFeaturePlots` returns `ggplot2` objects, you can modify them (e.g., `plots$length + ggplot2::theme_bw()`).
- **Non-canonical tRNAs**: Functions are tested on mitochondrial tRNAs and armless tRNAs, but results may vary for highly divergent structures.

## Reference documentation

- [tRNA](./references/tRNA.md)