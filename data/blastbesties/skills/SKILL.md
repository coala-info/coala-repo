---
name: blastbesties
description: blastbesties automates the discovery of reciprocal best hits from bidirectional BLAST results to identify putative orthologs. Use when user asks to identify reciprocal best hits, find orthologous sequence pairs, or process bidirectional BLAST tabular files.
homepage: https://github.com/Adamtaranto/blast-besties
---


# blastbesties

## Overview
`blastbesties` is a specialized bioinformatics tool designed to automate the discovery of reciprocal best hits (RBH) from BLAST results. It processes two tabular BLAST files—representing a bidirectional search between two datasets (A vs B and B vs A)—to identify pairs where each sequence is the top-scoring match for the other. This is a standard method for identifying putative orthologs and high-confidence sequence pairs across different datasets.

## Usage Instructions

### 1. Prepare BLAST Input
Before using `blastbesties`, you must generate two BLAST tabular output files. For the best results, use the following BLAST parameters:
- `-outfmt 6`: Required (Standard tabular format).
- `-qcov_hsp_perc`: Recommended (e.g., 90) to ensure alignments cover a significant portion of the query.
- `-use_sw_tback`: Recommended for more accurate alignments.

**Example BLAST commands:**
```bash
# Search A against B
blastp -query A_prot.fa -subject B_prot.fa -out AvB.tab -outfmt 6 -qcov_hsp_perc 90

# Search B against A
blastp -query B_prot.fa -subject A_prot.fa -out BvA.tab -outfmt 6 -qcov_hsp_perc 90
```

### 2. Identify Reciprocal Best Hits
Run `blastbesties` by providing the two tabular files. You can apply filters for e-value, alignment length, and bitscore to increase the stringency of the matches.

**Basic Command:**
```bash
blastbesties -a AvB.tab -b BvA.tab -o reciprocal_pairs.tab
```

**Filtered Command:**
```bash
blastbesties -a AvB.tab -b BvA.tab -e 0.00001 -l 50 -s 100 -o filtered_pairs.tab
```

### 3. Command Line Options
- `-a, --blastAvB`: Path to the BLAST result file for Set A (query) against Set B (subject).
- `-b, --blastBvA`: Path to the BLAST result file for Set B (query) against Set A (subject).
- `-l, --minLen`: Minimum alignment length to consider (Default: 1).
- `-e, --eVal`: Maximum e-value threshold (Default: 0.001).
- `-s, --bitScore`: Minimum bitscore threshold (Default: 1.0).
- `-o, --outFile`: Path to save the resulting reciprocal pairs.
- `--tui`: Launches an interactive Terminal User Interface for exploring results.

## Best Practices
- **Sorting**: Ensure your BLAST output is sorted by query name and then by descending match quality (bitscore). This is the default behavior for BLAST, but if you have manipulated the files, you may need to re-sort them.
- **Stringency**: When looking for orthologs, use a strict e-value (e.g., `-e 1e-10`) and a minimum length requirement (`-l`) relative to your average protein/gene length.
- **Interactive Exploration**: Use the `--tui` flag if you want to inspect the hits and pairs interactively within your terminal session.

## Reference documentation
- [GitHub Repository - Adamtaranto/blast-besties](./references/github_com_Adamtaranto_blast-besties.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_blastbesties_overview.md)