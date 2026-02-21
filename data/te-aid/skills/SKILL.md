---
name: te-aid
description: TE-aid is a specialized diagnostic tool designed for the "finishing" stage of transposable element discovery.
homepage: https://github.com/clemgoub/TE-Aid/tree/v{version}
---

# te-aid

## Overview
TE-aid is a specialized diagnostic tool designed for the "finishing" stage of transposable element discovery. While automated pipelines often produce raw consensus sequences, TE-aid provides the visual and structural evidence required for a human curator to "seal" a consensus. It automates the integration of BLAST+ searches, EMBOSS structural tools, and R-based visualization to produce a four-quadrant summary plot that reveals how well a candidate TE matches its genomic instances and whether its internal coding structure is intact.

## Usage Patterns and Best Practices

### Basic Curation Command
To generate the standard diagnostic plots for a new consensus sequence:
```bash
TE-Aid -q consensus.fa -g genome.fa -o output_directory/
```

### Structural Feature Identification
When investigating if a TE is an LTR retrotransposon or a DNA transposon with Terminal Inverted Repeats (TIRs):
*   **Self-Dotplot**: Use `-D` to generate an additional high-resolution dotplot via EMBOSS `dotmatcher`. This is critical for identifying the boundaries of LTRs or nested repeats.
*   **Coordinate Tables**: Always use `-t` to output raw coordinates. This allows you to precisely map the suggested TIR/LTR arrows from the plot back to your FASTA sequence for manual trimming.

### Refining Genomic Hits
For TEs belonging to highly repetitive families or those with many truncated copies:
*   **Redundancy Filtering**: Use `-r` to remove overlapping genomic hits. This produces a cleaner "Genomic Hits" plot (top-left) and prevents over-representation in the coverage pileup.
*   **Full-Length Analysis**: Adjust `-f` (default 0.9) to define what constitutes a "full-length" copy. If you are working with a degraded element, lowering this to `0.7` or `0.8` can help visualize the distribution of near-complete copies.
*   **Transparency**: If the genomic hits are too dense to see individual lines, increase transparency by lowering the alpha value (e.g., `-a 0.1`).

### Coding Potential and Protein Annotation
To identify if the consensus represents an autonomous element:
*   **ORF Sensitivity**: If the TE uses non-standard start codons or has small functional ORFs, lower the minimum size with `-m` (e.g., `-m 300` for 100aa).
*   **Strand Specificity**: If you are certain of the TE's orientation, use `-R` to suppress reverse-complement ORFs and reduce plot clutter.

## Expert Tips
*   **Path Configuration**: Ensure `blastn`, `makeblastdb`, `getorf`, and `Rscript` are in your `$PATH`. If using the Conda installation, activate the environment first: `conda activate te-aid`.
*   **Memory Management**: Avoid using `-T` (all tables) on extremely high-copy elements (e.g., Alu elements in primates) unless necessary, as the resulting BLAST tables can exceed several gigabytes.
*   **Input Cleaning**: Ensure your query FASTA header is short and contains no special characters, as long headers can sometimes truncate or cause issues in the R-plotting labels.

## Reference documentation
- [TE-Aid GitHub Repository](./references/github_com_clemgoub_TE-Aid.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_te-aid_overview.md)