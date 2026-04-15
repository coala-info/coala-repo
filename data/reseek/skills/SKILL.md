---
name: reseek
description: Reseek performs protein structure comparison and alignment using a structural state alphabet to detect remote homologs with high sensitivity. Use when user asks to search structure databases, perform all-vs-all structural comparisons, generate pairwise alignments and superpositions, or convert protein structures into binary database formats.
homepage: https://github.com/rcedgar/reseek
metadata:
  docker_image: "quay.io/biocontainers/reseek:2.6.1--h503566f_0"
---

# reseek

## Overview

Reseek is a specialized tool for protein structure comparison that utilizes a "mega-alphabet" of structural states to achieve high sensitivity. It outperforms traditional methods like DALI or Foldseek in discriminating true homologs from false positives while maintaining competitive speeds. It is ideal for researchers needing reliable P-values and local/global structural alignments.

## Core CLI Patterns

### Database Searching
The `-search` command is the primary interface for alignment tasks, including database searches and all-vs-all comparisons.

```bash
# Basic search against a database
reseek -search query.pdb -db database.bca -output hits.txt -sensitive

# All-vs-all alignment within a directory
reseek -search ./my_structures/ -output results.txt -fast
```

### Pairwise Alignment and Superposition
Use `-alignpair` to generate a sequence alignment and a structural superposition (rotated PDB).

```bash
reseek -alignpair protein1.pdb -input2 protein2.pdb -aln alignment.txt -output rotated_protein1.pdb
```

### Format Conversion and DB Preparation
For large-scale searches, converting structures to the binary `.bca` format is highly recommended for performance.

```bash
# Convert a directory of PDBs to a binary database
reseek -convert ./pdb_mirror/ -bca PDB_db.bca

# Convert structures to FASTA format
reseek -convert structures.files -fasta output.fasta
```

## Expert Tips and Best Practices

### Sensitivity Levels
You must specify a sensitivity mode for searches.
- `-fast`: Optimized for speed, similar to Foldseek.
- `-sensitive`: Balanced approach (recommended for most searches).
- `-verysensitive`: Maximum sensitivity for remote homolog detection.

### Statistical Significance
- **P-values vs. E-values**: Recent versions of Reseek recommend using `pvalue` for reporting. The `evalue` and `aq` columns are deprecated.
- **Customizing Output**: Use the `-columns` flag to define specific data fields.
  - Recommended: `reseek -search ... -columns query+target+qlo+qhi+ql+tlo+thi+tl+pctid+pvalue`

### Input Handling
The `STRUCTS` argument in commands can be:
- A single file (`.pdb`, `.cif`, `.mmcif`, `.cal`, `.bca`).
- A directory (Reseek will recursively search for known structure files).
- A `.files` text file containing a list of filenames or directories (one per line).

### Performance Tuning
- **Threading**: Reseek uses all available CPU cores by default. Use `-threads N` to limit usage.
- **Memory**: For massive databases, ensure you are using the `.bca` format to minimize I/O overhead.

## Reference documentation
- [Reseek GitHub Repository](./references/github_com_rcedgar_reseek.md)
- [Bioconda Reseek Overview](./references/anaconda_org_channels_bioconda_packages_reseek_overview.md)