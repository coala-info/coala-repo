---
name: amas
description: AMAS is a command-line tool for manipulating biological sequence alignments and calculating summary statistics. Use when user asks to calculate alignment metrics, concatenate multiple sequence files, convert between alignment formats, translate DNA to protein, or split alignments by partition.
homepage: https://github.com/marekborowiec/AMAS
---


# amas

## Overview
AMAS (Alignment Manipulation and Summary statistics) is a versatile tool designed for the rapid processing of biological sequence data. It is particularly useful in phylogenomic workflows where researchers need to manage hundreds or thousands of loci. AMAS provides a streamlined interface to merge alignments, handle complex partitioning schemes (including codon-aware partitions), and extract detailed statistics at both the alignment and individual taxon levels.

## Core CLI Usage
Every AMAS command requires three primary arguments:
- `-i` (`--in-files`): One or more input files.
- `-f` (`--in-format`): Format of input (`fasta`, `phylip`, `nexus`, `phylip-int`, `nexus-int`).
- `-d` (`--data-type`): Type of data (`dna` or `aa`).

### Calculating Summary Statistics
Generate metrics including number of taxa, alignment length, missing data percentage, and AT/GC content.
```bash
# Basic summary for multiple files
python3 AMAS.py summary -i gene1.fas gene2.fas -f fasta -d dna

# Generate per-taxon statistics in addition to alignment totals
python3 AMAS.py summary -i alignment.phy -f phylip -d dna -s
```

### Concatenating Alignments
Merge multiple files into a single alignment and generate a partition file.
```bash
# Concatenate all FASTA files in a directory
python3 AMAS.py concat -i *.fas -f fasta -d dna --part-format raxml -u nexus
```
- Use `--part-format` to specify the output partition style (`raxml` or `nexus`).
- Use `-n` or `--codons` (e.g., `-n 123`) to create partitions by codon position.

### Format Conversion
Convert alignments between supported formats.
```bash
# Convert FASTA to interleaved NEXUS
python3 AMAS.py convert -i input.fas -f fasta -d dna -u nexus-int
```

### Translation and Manipulation
- **Translate**: Convert DNA alignments to protein.
  ```bash
  python3 AMAS.py translate -i dna_aln.fas -f fasta -d dna
  ```
- **Split**: Divide an alignment based on a partition file.
  ```bash
  python3 AMAS.py split -i combined.fas -f fasta -d dna -l partitions.txt
  ```
- **Remove**: Delete specific taxa from an alignment.
  ```bash
  python3 AMAS.py remove -i aln.fas -f fasta -d dna -x taxon1 taxon2
  ```

## Expert Tips and Best Practices
- **Parallel Processing**: For large datasets with many files, use the `-c` or `--cores` flag with the `summary` command to speed up parsing and calculation.
- **Alignment Validation**: By default, AMAS does not check if sequences are properly aligned for efficiency. Use `-e` or `--check-align` if you suspect the input sequences have unequal lengths.
- **Missing Data Handling**: When concatenating, AMAS automatically populates missing taxa with gaps/missing data characters. Ensure taxon names are identical across files to avoid creating redundant rows.
- **Output Naming**: Use `-p` to name the partition file and `-t` to name the concatenated output file to avoid overwriting the default `partitions.txt` and `concatenated.out`.

## Reference documentation
- [AMAS GitHub Repository](./references/github_com_marekborowiec_AMAS.md)
- [AMAS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_amas_overview.md)