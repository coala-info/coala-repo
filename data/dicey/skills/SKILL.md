---
name: dicey
description: The `dicey` skill provides a specialized workflow for simulating molecular biology assays computationally.
homepage: https://github.com/gear-genomics/dicey
---

# dicey

## Overview
The `dicey` skill provides a specialized workflow for simulating molecular biology assays computationally. It allows for high-speed sequence searching within indexed reference genomes, enabling researchers to validate primer specificity and design complex probes. Key capabilities include calculating PCR melting temperatures, identifying amplicon sequences, and generating padlock probes for mRNA imaging based on gene identifiers and transcript data.

## Command Line Usage

### Genome Indexing
Before searching large genomes, you must create a FM-index. This step is only required once per reference.
```bash
# Index a bgzip compressed genome
dicey index -o reference.fa.fm9 reference.fa.gz

# Ensure the fasta is also indexed with samtools
samtools faidx reference.fa.gz
```

### Sequence Searching (Hunt)
Use `hunt` to find specific nucleotide sequences at a defined edit or hamming distance.
```bash
# Search for a sequence and convert JSON output to text
dicey hunt -g reference.fa.gz TCTCTGCACACACGTTGT | python scripts/json2txt.py

# Save raw JSON output to a compressed file
dicey hunt -g reference.fa.gz -o results.json.gz TCTCTGCACACACGTTGT
```

### In-silico PCR (Search)
The `search` command identifies PCR amplicons and off-target products for a set of primers.
```bash
# Run PCR simulation with a specific annealing temperature (e.g., 45°C)
dicey search -c 45 -g reference.fa.gz primers.fa | python scripts/json2txt.py
```

### Padlock Probe Design
Design probes for imaging mRNA in single cells. This requires an indexed genome and a matching GTF file.
```bash
# Design probes for a specific Ensembl Gene ID
dicey padlock -g reference.fa.gz -t transcripts.gtf.gz -b barcodes.fa.gz ENSG00000136997
```

## Expert Tips and Best Practices

- **Primer3 Configuration**: If `dicey` fails to find the `primer3_config` directory, explicitly provide the path using the `-i` flag:
  `dicey search -i path/to/dicey/src/primer3_config/ -g genome.fa.gz primers.fa`
- **Output Processing**: `dicey` outputs data in JSON format by default. Always keep the `scripts/json2txt.py` utility from the source repository handy to transform results into a human-readable table.
- **Input Formatting**: For the `search` command, the input `primers.fa` should be a standard FASTA file containing your forward and reverse primer sequences.
- **Memory Efficiency**: Using the pre-built FM-index (`.fm9`) is significantly faster and more memory-efficient than searching unindexed sequences for large-scale genomic queries.

## Reference documentation
- [dicey GitHub Repository](./references/github_com_gear-genomics_dicey.md)
- [dicey Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dicey_overview.md)