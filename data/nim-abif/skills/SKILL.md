---
name: nim-abif
description: The `nim-abif` skill enables the handling of Applied Biosystems Information Format (ABIF) files, which are the standard output for Sanger capillary sequencing.
homepage: https://github.com/quadram-institute-bioscience/nim-abif
---

# nim-abif

## Overview
The `nim-abif` skill enables the handling of Applied Biosystems Information Format (ABIF) files, which are the standard output for Sanger capillary sequencing. This skill is essential when you need to extract high-quality genomic sequences from raw trace files, perform quality-based trimming to remove unreliable base calls at the ends of reads, or visualize the underlying chromatogram peaks to verify specific mutations or sequencing artifacts. It also supports merging forward and reverse reads into a single consensus sequence using local alignment.

## CLI Usage Patterns

### FASTQ Conversion and Quality Trimming
Use `abi2fq` to convert raw `.ab1` files into FASTQ format. By default, it performs quality trimming to ensure downstream analysis uses reliable data.

*   **Standard conversion (output to STDOUT):**
    `abi2fq trace.ab1 > output.fq`
*   **Aggressive quality trimming:**
    Use a sliding window to trim where quality drops.
    `abi2fq --window=20 --quality=30 trace.ab1`
*   **Raw extraction (no trimming):**
    `abi2fq --no-trim trace.ab1`

### Merging Paired Sanger Reads
Use `abimerge` to combine forward and reverse reads from the same template. This tool uses Smith-Waterman alignment to find the optimal overlap.

*   **Basic merge:**
    `abimerge forward.ab1 reverse.ab1 > merged.fq`
*   **Strict overlap requirements:**
    Ensure at least 50bp overlap with 95% identity.
    `abimerge --min-overlap=50 --pct-id=95 fwd.ab1 rev.ab1`
*   **Handling non-overlapping reads:**
    If reads don't overlap, join them with a string of Ns (e.g., 10 Ns).
    `abimerge --join=10 fwd.ab1 rev.ab1`

### Visualizing Chromatograms
Use `abichromatogram` to generate SVG representations of the sequencing traces.

*   **Render a specific region:**
    Useful for inspecting a specific mutation site (e.g., bases 200 to 300).
    `abichromatogram input.ab1 -o trace.svg -s 200 -e 300 --width 1200`

## Expert Tips
*   **Quality Control:** When converting to FASTQ, use `--verbose` with `abi2fq` to see statistics on how many bases were trimmed. Sanger reads typically have low quality at the beginning (first 30-50bp) and end (after 700-800bp).
*   **Alignment Tuning:** If `abimerge` fails to find an overlap in high-quality regions, try adjusting the scoring parameters: `--score-match`, `--score-mismatch`, and `--score-gap`.
*   **Raw Data Access:** For custom analysis, the tool can extract specific ABIF tags. For example, `PBAS2` contains the base calls and `DATA1-4` contain the raw fluorescent channel data.

## Reference documentation
- [nim-abif GitHub Repository](./references/github_com_quadram-institute-bioscience_nim-abif.md)
- [nim-abif Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nim-abif_overview.md)