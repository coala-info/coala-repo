---
name: mantis_pfa
description: The mantis_pfa skill enables automated functional profiling of protein sequences.
homepage: https://github.com/PedroMTQ/Mantis
---

# mantis_pfa

## Overview
The mantis_pfa skill enables automated functional profiling of protein sequences. Unlike tools that rely on a single database, Mantis aggregates results from various sources to provide a consensus-driven annotation. It is particularly effective for high-throughput processing of assembled genomes and metagenomes where taxonomic resolution and domain-level detail are required.

## Core Workflows

### 1. Environment Initialization
Before running annotations, the reference databases must be synchronized and the environment verified.
- **Setup**: `mantis setup` (Downloads and organizes required HMM/Diamond databases).
- **Verification**: `mantis check` and `mantis check_sql` to ensure all dependencies and metadata files are correctly indexed.

### 2. Single Sample Annotation
For a single protein FASTA file, use the `run` command. Providing organism details improves taxonomic pruning.
```bash
mantis run -i sample.faa -o ./output_dir -od "Genus species"
```

### 3. Batch Processing
To process multiple samples efficiently, provide a TSV file containing paths to the input files.
```bash
mantis run -i samples_list.tsv -o ./batch_output
```

### 4. Customizing Search Parameters
Fine-tune the sensitivity and specificity of the annotation using thresholds:
- **E-value**: `-et 1e-5` (Default is usually sufficient, but can be tightened for higher confidence).
- **Overlap**: `-ov 0.1` (Controls how much overlap is allowed between different domain hits on the same sequence).
- **Custom Config**: `-mc custom_MANTIS.cfg` (Use this to point to specific local reference paths or weights).

## Best Practices and Tips
- **Input Preparation**: Mantis requires amino acid sequences. If starting with genomic DNA or metagenomic contigs, use a gene predictor like Prodigal to generate the `.faa` file first.
- **Custom References**: You can add your own HMM or Diamond databases by placing them in the `Mantis/References/Custom_references/` directory or defining the `custom_ref` path in the configuration file. Each custom folder should include a `metadata.tsv` for proper integration.
- **Output Selection**:
    - Use `consensus_annotation.tsv` for a "one-line-per-query" summary (best for general profiling).
    - Use `integrated_annotation.tsv` for deep dives into all possible hits and their associated metadata.
- **Resource Management**: Mantis is designed to scale. When running on large metagenomes, ensure the system has sufficient RAM for loading HMMER/Diamond indices, especially if using multiple reference databases simultaneously.

## Reference documentation
- [Mantis GitHub README](./references/github_com_PedroMTQ_Mantis.md)
- [Mantis Wiki](./references/github_com_PedroMTQ_Mantis_wiki.md)