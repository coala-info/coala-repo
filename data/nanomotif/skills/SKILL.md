---
name: nanomotif
description: Nanomotif identifies prokaryotic DNA methylation motifs from nanopore sequencing data to characterize epigenetic patterns. Use when user asks to identify de novo methylation motifs, refine metagenomic bins, or score motif presence across an assembly.
homepage: https://pypi.org/project/nanomotif/
---


# nanomotif

## Overview
Nanomotif is a specialized bioinformatics tool designed to identify prokaryotic DNA methylation motifs from nanopore sequencing data. It processes modification probabilities (typically from tools like Megalodon or Dorado) to detect consistent patterns of methylation across a genome or metagenome. This is particularly useful for identifying Restriction-Modification (RM) systems and using "methylation fingerprints" to associate mobile genetic elements with their hosts or to improve the binning of metagenomic contigs.

## Core Workflows

### 1. Motif Discovery
The primary entry point for identifying de novo motifs.
```bash
nanomotif find_motifs \
    --megalodon <megalodon_results_dir> \
    --fasta <assembly.fasta> \
    --out <output_dir>
```
*   **Input**: Requires the assembly FASTA and the directory containing per-read modification data.
*   **Tip**: Ensure the contig names in the FASTA match the headers in the modification files exactly.

### 2. Metagenomic Binning Refinement
Use methylation patterns to verify or improve metagenomic bins.
```bash
nanomotif bin_eval \
    --motifs <motifs.tsv> \
    --bins <bins_directory> \
    --out <output_dir>
```
*   **Logic**: Contigs within the same bin should share the same methylation profile. Outliers often indicate mis-binned sequences or horizontal gene transfer.

### 3. Motif Scoring and Filtration
After discovery, use `score_motifs` to quantify the presence of motifs across the assembly.
```bash
nanomotif score_motifs \
    --motifs <discovered_motifs.tsv> \
    --megalodon <megalodon_results_dir> \
    --fasta <assembly.fasta>
```

## Best Practices
*   **Modification Types**: Nanomotif is optimized for 6mA and 4mC modifications, which are common in prokaryotes. 5mC detection is supported but often requires higher coverage for confident motif calling.
*   **Coverage Requirements**: For reliable de novo motif discovery, aim for at least 20x-30x coverage per strand for the specific modification type.
*   **False Positives**: Low-complexity regions or homopolymers can sometimes trigger false motif calls. Always check the "score" and "fraction methylated" columns in the output TSV; a high-confidence motif typically has a methylation fraction > 0.7.
*   **Metagenomics**: When working with complex samples, run `find_motifs` on the entire assembly first, then use the resulting motif list to evaluate individual bins.

## Reference documentation
- [nanomotif Overview](./references/anaconda_org_channels_bioconda_packages_nanomotif_overview.md)
- [nanomotif Project Details](./references/pypi_org_project_nanomotif.md)