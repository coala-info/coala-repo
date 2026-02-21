---
name: last
description: LAST (Local Alignment Search Tool) is a versatile suite for biological sequence comparison.
homepage: https://gitlab.com/mcfrith/last
---

# last

## Overview
LAST (Local Alignment Search Tool) is a versatile suite for biological sequence comparison. Unlike many aligners that prioritize speed over sensitivity, LAST is designed to find distant or complex relationships between sequences. It is highly effective for genome-to-genome comparisons, mapping long reads, and translated searches (DNA vs. protein). The tool follows a standard bioinformatics workflow: indexing a reference, optionally training parameters to match the specific error profile of the data, and then performing the alignment.

## Core Workflow and CLI Patterns

### 1. Indexing the Reference (lastdb)
Before alignment, you must create a database from your reference sequences.
- **Basic DNA indexing**: `lastdb mydb reference.fasta`
- **Protein indexing**: `lastdb -p mydb reference.fasta`
- **Handling large genomes**: Use `-u` to specify a seeding scheme (e.g., `-uNEAR` for closely related sequences).

### 2. Parameter Training (last-train)
For non-standard data (like specific sequencing technologies or distant species), use `last-train` to find the best scoring parameters.
- **Standard training**: `last-train mydb queries.fasta > my_params.txt`
- **Translated training**: Use `--codon` when training for DNA-versus-protein searches.

### 3. Sequence Alignment (lastal)
The primary alignment tool. It outputs in MAF (Multiple Alignment Format) by default.
- **Basic alignment**: `lastal mydb queries.fasta > alignments.maf`
- **Using trained parameters**: `lastal -p my_params.txt mydb queries.fasta > alignments.maf`
- **Genome-to-genome (Unique mapping)**: Use the `--split` option to ensure each part of the query is aligned to at most one place in the reference.
- **Translated search (DNA vs. Protein)**: `lastal -fBlastTab+ -F0 mydb queries.fasta` (Outputs in a BLAST-like tabular format).

### 4. Post-Processing and Conversion
- **Format conversion**: Use `maf-convert` to transform MAF files into other formats like SAM, BLAST, or BED.
  - `maf-convert sam alignments.maf > alignments.sam`
  - `maf-convert blast alignments.maf > alignments.blast`
- **Visualization**: Use `last-dotplot` to create visual representations of alignments.
  - `last-dotplot alignments.maf plot.png`

## Expert Tips
- **Sensitivity vs. Speed**: Increase sensitivity by using `-s2` (search both strands) or adjusting the `-m` (maximum multiplicity) and `-k` (step size) parameters.
- **E-values**: Use `-e` to set an E-value threshold to filter out random matches, especially in large-scale genome alignments.
- **Memory Management**: For very large databases, consider the memory requirements of the index; `lastdb` options like `-c` (soft-masking) can affect both memory and sensitivity.
- **Frame Information**: In recent versions (1651+), the `BlastTab+` format includes frame information for translated alignments, which is critical for distinguishing overlapping alignments in different translation frames.

## Reference documentation
- [LAST Overview](./references/anaconda_org_channels_bioconda_packages_last_overview.md)
- [LAST README](./references/gitlab_com_mcfrith_last_-_blob_main_README.rst.md)
- [LAST Activity and Updates](./references/gitlab_com_mcfrith_last.atom.md)