---
name: merquryfk
description: MerquryFK is a refactored version of the original Merqury suite that replaces the meryl k-mer counter with FastK to achieve significantly faster processing times.
homepage: https://github.com/thegenemyers/MERQURY.FK
---

# merquryfk

## Overview

MerquryFK is a refactored version of the original Merqury suite that replaces the meryl k-mer counter with FastK to achieve significantly faster processing times. It provides a collection of UNIX-style command-line tools for genomic sequence data and assembly analysis. The skill facilitates the generation of copy-number spectrum plots, assembly-specific k-mer analysis, and trio-based haplotype evaluation. It is particularly useful for bioinformaticians needing to validate assembly accuracy or identify issues like collapsed repeats or missing sequences.

## Core Usage and Conventions

### Input Requirements
*   **FastK Tables**: Most tools require k-mer tables (`.ktab`) and their associated histograms (`.hist`) produced by FastK.
*   **Table Generation**: Ensure FastK tables are created using the `-t` or `-t1` flags so that all k-mers occurring at least once are included.
*   **File Extensions**: Suffix extensions are optional for known types. If you provide `sample`, the tool will automatically search for `sample.fasta`, `sample.fa`, `sample.fastq`, or `sample.fq`.

### Command Flexibility
*   **Option Placement**: Optional arguments (starting with `-`) can be placed in any order or position relative to the required primary arguments.
*   **Threading**: Use the `-T` flag to control the number of threads (default is usually 4).
*   **Verbose Mode**: Use `-v` for detailed reporting to standard error.

## Key Tools and Workflows

### 1. Copy-Number Spectrum Plots (CNplot)
Used to compare a read set k-mer distribution against an assembly.
*   **Basic Command**: `CNplot <reads>[.ktab] <asm:dna> <out>`
*   **Plot Types**: Generates line (`.ln`), filled (`.fl`), and stacked (`.st`) plots by default. Use `-l`, `-f`, or `-s` to select specific ones.
*   **Optimization**: Use the `-k` flag to create a `.cni` file. This saves processed data, allowing you to re-run `CNplot <out>.cni` with different aesthetic parameters (like `-w`, `-h`, or `-pdf`) without re-calculating the k-mer data.
*   **Scaling**: Use `-x` and `-y` to set axis maximums as multiples of the peak frequency/count, or `-X` and `-Y` for absolute integer limits.

### 2. Trio Analysis (HAPmaker & HAPplot)
Used for evaluating assemblies when parental data is available.
*   **Hap-mer Generation**: Run `HAPmaker <mat>.ktab <pat>.ktab <child>.ktab` first. This produces `<mat>.hap.ktab` and `<pat>.hap.ktab`.
*   **Hap-mer Plots**: Use `HAPplot` (or the `MerquryFK` wrapper in trio mode) to visualize inherited k-mers and identify phase blocks or switching errors.

### 3. Assembly Evaluation (ASMplot)
Used to visualize k-mers present in the assembly versus those found in the raw reads.
*   Identifies k-mers missing from the assembly (completeness) and k-mers unique to the assembly (potential errors or contamination).

### 4. Ploidy and Comparative Analysis
*   **PloidyPlot**: An improved version of SmudgePlot for assessing genomic ploidy levels.
*   **KatComp / KatGC**: Tools for comparing k-mer content between two datasets or analyzing GC content distribution, similar to the KAT suite.

## Expert Tips
*   **Temporary Files**: Use `-P<dir>` to specify a high-speed temporary directory (like a RAM disk or SSD) for FastK subcalls, especially if the system `$TMPDIR` is on a slow network drive.
*   **Output Formats**: While `.png` is the default, always consider adding `-pdf` for publication-quality vector graphics.
*   **Zero-Count k-mers**: Use the `-z` option in `CNplot` to include a bar at the origin representing k-mers found in the assembly but missing from the reads.

## Reference documentation
- [MerquryFK Main Documentation](./references/github_com_thegenemyers_MERQURY.FK.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_merquryfk_overview.md)