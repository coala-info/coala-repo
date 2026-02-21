---
name: orfipy
description: orfipy is a high-performance ORF discovery tool optimized for speed and flexibility.
homepage: https://github.com/urmi-21/orfipy
---

# orfipy

## Overview
orfipy is a high-performance ORF discovery tool optimized for speed and flexibility. Written in Python and Cython, it utilizes multiple CPU cores to rapidly scan sequences, making it significantly faster than traditional tools like getorf, especially for datasets containing numerous small sequences (e.g., de-novo transcriptome assemblies). It supports various output formats including DNA and peptide FASTA, BED, and BED12, and allows users to define custom translation tables via JSON.

## Common CLI Patterns

### Basic ORF Extraction
Extract ORFs longer than 100 nucleotides and save as DNA sequences:
```bash
orfipy input.fasta --dna orfs.fa --min 100
```

### Peptide Translation and Multi-threading
Translate ORFs to peptides using 8 CPU cores:
```bash
orfipy input.fasta --pep peptides.fa --procs 8
```

### Genomic Mapping (BED/BED12)
Generate a BED12 file, which is useful for visualizing ORFs in genome browsers:
```bash
orfipy input.fasta --bed12 orfs.bed12
```

### Custom Search Parameters
Search for ORFs using only 'ATG' as a start codon and a specific translation table:
```bash
orfipy input.fasta --start ATG --table 11 --dna orfs.fa
```

## Expert Tips and Best Practices

### Transdecoder Compatibility
To make orfipy output consistent with Transdecoder.Predict (often used in transcriptomics), include the stop codon and allow partial ORFs:
```bash
orfipy input.fasta --min 100 --bed12 out.bed --partial-5 --partial-3 --include-stop
```

### Handling Soft-Masked Sequences
If your input FASTA contains soft-masked (lowercase) nucleotides, use the `--ignore-case` flag to ensure they are treated as valid bases during the search.

### Working with Compressed Data
orfipy natively supports gzipped input files. You can process them directly without manual decompression:
```bash
orfipy input.fasta.gz --dna out.fa
```

### Custom Translation Tables
If the standard NCBI tables are insufficient, you can provide a custom table in JSON format:
```bash
orfipy input.fasta --table my_table.json --dna out.fa
```

### Filtering by Length
Always use `--min` and `--max` to reduce noise. For most eukaryotic applications, a minimum length of 30-100 codons (90-300 bp) is a standard starting point to filter out random non-coding sequences.

## Python API Usage
For integration into bioinformatics pipelines, use the `orfipy_core` module:
```python
import orfipy_core
for start, stop, strand, description in orfipy_core.orfs(sequence, minlen=30, maxlen=10000):
    print(f"Found ORF at {start}-{stop} on {strand} strand")
```

## Reference documentation
- [orfipy GitHub Repository](./references/github_com_urmi-21_orfipy.md)
- [orfipy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_orfipy_overview.md)