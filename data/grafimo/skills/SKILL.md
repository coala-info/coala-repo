---
name: grafimo
description: GRAFIMO scans genome variation graphs to identify DNA motif occurrences while accounting for genetic variants across multiple genomes. Use when user asks to build a genome variation graph from a reference and VCF file, search for motifs within specific genomic regions, or identify motif candidates that incorporate SNPs and structural variants.
homepage: https://github.com/pinellolab/GRAFIMO
---


# grafimo

## Overview

GRAFIMO (GRAph-based Finding of Individual Motif Occurrences) is a command-line tool designed to scan Genome Variation Graphs for DNA motifs. Unlike traditional scanners that use a single linear reference, GRAFIMO leverages VGs to account for SNPs, indels, and structural variants across many genomes simultaneously. It produces statistically significant motif candidates, reporting their frequency within specific haplotypes and identifying whether they contain variants or belong to the reference sequence.

## Core Workflows

### 1. Building a Genome Variation Graph
Before searching for motifs, you must construct a VG from a reference genome and a VCF file. GRAFIMO typically builds a VG for each chromosome to optimize search efficiency.

```bash
# Basic VG construction
grafimo buildvg -l /path/to/genome.fa -v /path/to/variants.vcf -o /path/to/output_dir

# Re-indexing the VCF (recommended for fresh data)
grafimo buildvg -l /path/to/genome.fa -v /path/to/variants.vcf --reindex
```

**Expert Tip**: Ensure chromosome names in the VCF match the headers in the FASTA file (e.g., "1" vs "chr1") before building.

### 2. Searching for Motifs
The `findmotif` command is the primary tool for scanning. It requires a VG (directory of chromosome VGs or a single whole-genome VG), a motif file (MEME or JASPAR), and a BED file defining search regions.

```bash
# Search using a directory of chromosome VGs
grafimo findmotif -d /path/to/vg_dir/ -m /path/to/motif.meme -b /path/to/regions.bed

# Search using a single whole-genome VG
grafimo findmotif -g /path/to/genome.xg -m /path/to/motif.jaspar -b /path/to/regions.bed
```

### 3. Advanced Search Configurations
Fine-tune the sensitivity and scope of the motif search using these parameters:

*   **Statistical Thresholds**: By default, GRAFIMO uses a P-value threshold of 1e-4.
    ```bash
    # Set a custom P-value threshold
    grafimo findmotif [args] -t 1e-5

    # Use Q-values (FDR) for the threshold instead
    grafimo findmotif [args] --qvalueT -t 0.05
    ```
*   **Background Distribution**: Provide a custom nucleotide background distribution file.
    ```bash
    grafimo findmotif [args] -k /path/to/bg_file
    ```
*   **Recombinant Search**: Search for potential motifs created by combinations of variants not explicitly observed in the input haplotypes.
    ```bash
    grafimo findmotif [args] --recomb
    ```
*   **Chromosome Filtering**: Limit the search to specific chromosomes.
    ```bash
    grafimo findmotif [args] --chroms-find 1 2 X
    ```

## Best Practices

*   **Index Management**: Ensure that `.xg` and `.gbwt` indexes are stored in the same directory when using the `-d` or `-g` flags.
*   **Output Organization**: Use the `-o` flag to specify a custom output directory; otherwise, GRAFIMO creates a default directory named `grafimo_out_PID_MOTIFID`.
*   **Visualization**: To inspect the graph structure of the top binding sites, use the visualization options to generate PNG images of the best *n* regions.
*   **Performance**: For large-scale population data (like 1000 Genomes Project), building the VG can take several hours. Use pre-built indexes where possible.



## Subcommands

| Command | Description |
|---------|-------------|
| grafimo | GRAph-based Find of Individual Motif Occurrences. GRAFIMO scans genome variation graphs in VG format (Garrison et al., 2018) to find potential binding site occurrences of DNA motif(s). |
| grafimo | GRAph-based Find of Individual Motif Occurrences. GRAFIMO scans genome variation graphs in VG format (Garrison et al., 2018) to find potential binding site occurrences of DNA motif(s). |

## Reference documentation
- [Quickstart](./references/github_com_pinellolab_GRAFIMO_wiki_Quickstart.md)
- [Building genome variation graphs (VGs) with GRAFIMO](./references/github_com_pinellolab_GRAFIMO_wiki_Building-genome-variation-graphs-_VGs_-with-GRAFIMO.md)
- [Which file format for motifs?](./references/github_com_pinellolab_GRAFIMO_wiki_Which-file-format-for-motifs_3F.md)
- [Required softwares and dependencies](./references/github_com_pinellolab_GRAFIMO_wiki_Required-softwares-and-dependencies.md)