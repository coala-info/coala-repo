---
name: trimal
description: trimal refines biological multiple sequence alignments by filtering out noisy columns and sequences. Use when user asks to trim multiple sequence alignments, clean up alignments, filter alignment columns, remove noisy sequences, convert alignment formats, visualize trimming results, map trimmed columns, or get removed alignment regions.
homepage: https://trimal.readthedocs.io
---


# trimal

## Overview

trimal (trimAl) is a command-line utility designed to refine biological sequence alignments. It helps researchers clean up MSAs by applying automated heuristics or manual thresholds to filter out columns and sequences that might introduce noise into downstream analyses, such as phylogenetic tree reconstruction. It supports a wide variety of input/output formats and provides statistical summaries of the trimming process.

## Command Line Usage

### Basic Syntax
```bash
trimal -in <inputfile> -out <outputfile> -<method/threshold>
```

### Automated Trimming Methods
These methods are recommended for most users as they automatically determine optimal thresholds based on the input alignment's characteristics.

*   **Maximum Likelihood Optimization**: Use `-automated1`. This heuristic selects the best automated method based on similarity statistics.
*   **Neighbor-Joining Optimization**: Use `-strictplus`.
*   **Strict Trimming**: Use `-strict`. Combines gap-based trimming with similarity thresholds.
*   **Gap-only Trimming**: Use `-gappyout`. Focuses exclusively on the gap distribution.

### Manual Thresholds
Use these when specific filtering criteria are required.

*   **Gap Threshold (`-gt`)**: Range 0-1. `-gt 0.9` removes columns where more than 10% of sequences have a gap.
*   **Similarity Threshold (`-st`)**: Range 0-1. Sets the minimum average similarity required for a column.
*   **Conservation Threshold (`-cons`)**: Range 0-100. Ensures a minimum percentage of the original alignment is retained, overriding other filters if necessary.
*   **Remove All Gaps**: Use `-nogaps` to delete any column containing at least one gap.

### Sequence Overlap Trimming
To remove fragmentary or poorly aligned sequences rather than just columns:
```bash
trimal -in <input> -out <output> -resoverlap 0.75 -seqoverlap 80
```
*   `-resoverlap`: Minimum overlap score for a residue to be considered "good".
*   `-seqoverlap`: Minimum percentage of "good" residues a sequence must have to be kept.

### Format Conversion
trimal can convert alignments between formats during the trimming process or as a standalone task:
*   **Formats**: `-fasta`, `-phylip`, `-nexus`, `-clustal`, `-mega`, `-nbrf`.
*   **PAML Compatibility**: Use `-phylip_paml` for PHYLIP files compatible with PAML.

## Expert Tips and Best Practices

*   **Visual Validation**: Use `-htmlout <file.html>` to generate a visual summary of the trimming, showing exactly which residues were kept or removed.
*   **Mapping Columns**: Use `-colnumbering` to output a mapping between the old and new column indices. This is essential if you need to relate specific sites back to the original alignment.
*   **Complementary Alignments**: Use `-complementary` to output the regions that *were removed* instead of the regions that were kept. This is useful for "inverse" analysis.
*   **Windowed Scoring**: For manual thresholds, use `-w <n>` to calculate scores based on a sliding window (e.g., `-w 3` averages scores over 7 columns). This prevents single-site fluctuations from causing excessive trimming.
*   **Backtranslation**: Use `-backtrans <coding_sequences.fasta>` to trim a protein alignment and automatically apply the same trimming to the corresponding nucleotide sequences.

## Reference documentation
- [Usage Guide](./references/trimal_readthedocs_io_en_latest_usage.html.md)
- [Trimming Algorithms](./references/trimal_readthedocs_io_en_latest_algorithms.html.md)
- [Scoring Metrics](./references/trimal_readthedocs_io_en_latest_scores.html.md)