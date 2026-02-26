---
name: goalign
description: Goalign is a high-performance command-line toolkit designed for the rapid manipulation, cleaning, and transformation of multiple sequence alignments. Use when user asks to convert alignment formats, remove gap-heavy sites or sequences, extract sub-alignments, translate sequences, or generate bootstrap alignments for phylogenetic analysis.
homepage: https://github.com/fredericlemoine/goalign
---


# goalign

## Overview
Goalign is a high-performance command-line toolkit designed for the rapid manipulation of multiple sequence alignments. It excels in bioinformatics pipelines where alignments need to be filtered, transformed, or summarized before downstream phylogenetic analysis. Use this skill to handle large-scale genomic data, automate alignment cleaning (removing gap-heavy sites or sequences), and prepare data for tools like RAxML, IQ-TREE, or Gotree.

## Common CLI Patterns

### Format Conversion
Goalign supports Fasta, Phylip, Nexus, and Clustal. It automatically detects input formats but requires the `reformat` command for output.
```bash
# Convert any supported format to Phylip
goalign reformat phylip -i input.fasta > output.phy

# Convert to Nexus
goalign reformat nexus -i input.fasta > output.nex
```

### Alignment Cleaning
Removing uninformative data is a standard preprocessing step.
```bash
# Remove sites containing any gaps
goalign clean sites -i input.fasta > clean_sites.fasta

# Remove sequences that are entirely gaps or exceed a gap threshold
goalign clean seqs -i input.fasta > clean_seqs.fasta
```

### Sequence and Site Manipulation
```bash
# Extract a specific sub-alignment (e.g., sites 10 to 100)
goalign subseq -s 10 -l 90 -i input.fasta > subset.fasta

# Translate nucleotide alignment to amino acids (supports IUPAC)
goalign translate -i input.nt.fasta > input.aa.fasta

# Rename sequences using a map file (tab-separated: old_name\tnew_name)
goalign rename -m map.txt -i input.fasta > renamed.fasta
```

### Phylogeny Preparation
```bash
# Generate 100 bootstrap alignments
goalign build seqboot -n 100 -i input.fasta -p boot

# Compute a distance matrix (p-distance by default)
goalign compute distances -i input.fasta > dist_matrix.txt
```

## Expert Tips
- **Piping**: Goalign is designed for Unix pipes. Most commands output an alignment that can be fed directly into the next goalign command without writing intermediate files.
  - *Example*: `goalign clean sites -i in.fa | goalign reformat phylip > out.phy`
- **Remote Files**: You can pass a URL directly to the `-i` flag (e.g., `-i https://example.com/align.fasta`), and goalign will handle the download.
- **Compression**: Goalign natively handles gzipped (`.gz`), bzipped (`.bz2`), and xz files. You do not need to decompress them manually before processing.
- **Validation**: Use `goalign stats` to quickly check the number of sequences, alignment length, and alphabet (NT/AA) to ensure your input is valid before running complex commands.

## Reference documentation
- [Goalign GitHub Repository](./references/github_com_evolbioinfo_goalign.md)
- [Goalign Documentation Index](./references/github_com_evolbioinfo_goalign_tree_master_docs.md)