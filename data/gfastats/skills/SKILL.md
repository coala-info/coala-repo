---
name: gfastats
description: gfastats is a high-performance tool for evaluating, reporting, and modifying genome assembly files. Use when user asks to generate assembly statistics, convert between FASTA and GFA formats, manipulate assemblies using SAK instructions, or filter sequences with BED files.
homepage: https://github.com/vgl-hub/gfastats
metadata:
  docker_image: "quay.io/biocontainers/gfastats:1.3.11--h077b44d_0"
---

# gfastats

## Overview

gfastats is a high-performance, exhaustive tool designed for the rapid evaluation and modification of genome assembly files. It functions as a "Swiss Army Knife" for bioinformaticians, capable of handling massive genomes (100Gbp+) to produce detailed reports on scaffolds, contigs, and gaps. Beyond reporting, it utilizes a bidirected graph representation to allow for seamless format conversion and complex assembly manipulations, such as overlaying AGP coordinates or executing manual sequence edits via a dedicated instruction language.

## Common CLI Patterns

### Summary Statistics
Generate standard assembly metrics (N50, total length, GC content):
`gfastats assembly.fasta`

Generate a full N*/NG* report (N10 through N90):
`gfastats assembly.fasta --nstar-report`

Generate metrics for every individual sequence in the file:
`gfastats assembly.fasta --seq-report`

### Format Conversion
Convert FASTA to GFA:
`gfastats input.fasta -o gfa > output.gfa`

Convert GFA to FASTA:
`gfastats input.gfa -o fa > output.fasta`

### Assembly Manipulation
Apply structural changes (JOIN/SPLIT) using a Swiss Army Knife (.sak) instruction file:
`gfastats input.fasta -k instructions.sak -o fa > manipulated.fasta`

Scaffold an assembly using an AGP file:
`gfastats input.fasta -a input.agp -o output.fasta`

### Filtering and Subsetting
Include only specific regions defined in a BED file:
`gfastats input.fasta --include-bed regions.bed -o fa > filtered.fasta`

Exclude regions defined in a BED file:
`gfastats input.fasta --exclude-bed repeats.bed -o fa > cleaned.fasta`

## Expert Tips

*   **GFA Path Discovery**: If working with a GFA file that lacks defined paths (common in hifiasm output), you must use the `--discover-paths` flag to generate contig and scaffold statistics.
*   **Expected Genome Size**: For accurate NG50 and AuNG statistics, provide the estimated genome size as the second positional argument: `gfastats assembly.fasta 3100000000`.
*   **Coordinate Output**: Use `--out-coord` to generate an AGP representation of the assembly or `--out-size` to get a simple list of sequence names and lengths.
*   **Specific Sequence Analysis**: You can target a specific scaffold or a sub-range directly from the command line: `gfastats assembly.fasta "chr1:1000000-2000000"`.
*   **SAK Instruction Syntax**:
    *   `JOIN contig1+ contig2+ 50`: Joins two contigs with a 50bp gap.
    *   `SPLIT contig1+ contig2+`: Removes the gap between two contigs within a scaffold.

## Reference documentation
- [gfastats GitHub Repository](./references/github_com_vgl-hub_gfastats.md)
- [gfastats Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gfastats_overview.md)