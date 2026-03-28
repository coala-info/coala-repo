---
name: mcscanx
description: MCScanX identifies collinear blocks and syntenic regions across multiple genomes to analyze gene order conservation and evolutionary relationships. Use when user asks to detect syntenic blocks, classify gene duplication origins, or generate dot plots and circle plots to visualize chromosomal relationships.
homepage: https://github.com/wyp1125/MCScanX
---

# mcscanx

## Overview
MCScanX is a specialized toolkit for scanning multiple genomes or sub-genomes to identify collinear blocks—regions where gene order is conserved. It is a standard tool in comparative genomics for evolutionary analysis. Beyond identifying syntenic blocks, it provides utilities to categorize the origins of gene duplications and generate various plots (dot plots, dual synteny, circle, and bar plots) to visualize chromosomal relationships.

## Data Preparation
MCScanX requires two primary input files with the same prefix (e.g., `xyz.blast` and `xyz.gff` or `xyz.bed`).

### 1. BLAST Input (`xyz.blast`)
*   **Format**: BLASTP output in tabular format (`-m 8` or `-outfmt 6`).
*   **Requirement**: Concatenate all inter-species and intra-species BLAST results into one file.
*   **Best Practice**: Limit BLAST hits to the top 5–10 matches per gene to reduce noise and computational overhead.
*   **Command Pattern**:
    `blastp -query all_proteins.fasta -db all_proteins.fasta -out xyz.blast -evalue 1e-10 -outfmt 6 -max_target_seqs 5`

### 2. Gene Location Input (`xyz.gff` or `xyz.bed`)
*   **Format**: Tab-delimited file: `chromosome_id`, `gene_id`, `start_position`, `end_position`.
*   **Naming Convention**: Use a two-letter species prefix for chromosome names (e.g., `at1` for Arabidopsis chromosome 1).
*   **Constraint**: Gene IDs must match the BLAST file exactly. Duplicate gene entries are not allowed.

## Core Command Usage

### Running the Main Algorithm
To detect syntenic blocks and generate alignment files:
`./MCScanX prefix`
*(Note: Do not include the file extension; if files are `data/my_genome.blast` and `data/my_genome.gff`, use `data/my_genome`)*

### Common Options
- `-s 5`: Minimum number of genes to call a syntenic block (default: 5). Increase for higher stringency.
- `-e 1e-05`: E-value threshold for alignment significance.
- `-m 25`: Maximum gaps allowed (intergenic distance units) between collinear genes.
- `-b 1`: Patterns of blocks. `0`: intra- and inter-species (default); `1`: intra-species only; `2`: inter-species only.

### Duplicate Gene Classification
To classify genes into WGD, tandem, proximal, or dispersed duplications:
`./Duplicate_gene_classifier prefix`
*   **Output**: A `.genomic_control` file containing the classification for every gene in the input.

## Downstream Analysis and Visualization
MCScanX includes several Java and Perl utilities in the `downstream_analyses` folder.

### Visualization Patterns
Most visualizers require a `control` file specifying which chromosomes to display.
- **Dot Plot**: `java dot_plotter -g xyz.gff -s xyz.synteny -c control.txt -o output.png`
- **Circle Plot**: `java circle_plotter -g xyz.gff -s xyz.synteny -c control.txt -o output.png`
- **Dual Synteny**: `java dual_synteny_plotter -g xyz.gff -s xyz.synteny -c control.txt -o output.png`

### Statistical Tools
- **Add Ka/Ks**: Use `add_ka_and_ks_to_synteny.pl` to incorporate evolutionary pressure data into the synteny blocks.
- **Group Collinear Genes**: Use `group_collinear_genes.pl` to generate clusters of homologous genes across multiple species.

## Expert Tips
- **Memory Management**: For very large plant genomes, ensure the BLAST file is filtered. Massive BLAST files can cause the `MCScanX` process to hang or crash due to memory limits.
- **Homology Mode**: If you have high-confidence ortholog pairs from another source (not BLAST), use `MCScanX_h` with a `.homology` file instead of a `.blast` file.
- **Chromosome Prefixes**: If the tool fails to find matches, verify that the chromosome names in the GFF/BED file use the required species prefix (e.g., `hs` for Homo sapiens) to distinguish between genomes in a multi-species run.



## Subcommands

| Command | Description |
|---------|-------------|
| MCScanX | MCScanX prefix_fn [options] |
| MCScanX_h | MCScanX_h prefix_fn [options] |

## Reference documentation
- [MCScanX GitHub Repository](./references/github_com_wyp1125_MCScanX.md)