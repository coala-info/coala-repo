---
name: cansnper2
description: CanSNPer2 is a bioinformatics pipeline that classifies bacterial genomes by aligning query sequences against reference genomes to identify lineage-defining SNPs. Use when user asks to classify bacterial genomes, create custom SNP-typing databases, download reference sequences, or generate phylogenetic tree visualizations.
homepage: https://github.com/FOI-Bioinformatics/CanSNPer2
---


# cansnper2

## Overview
CanSNPer2 is a specialized bioinformatics pipeline designed to classify bacterial genomes based on established SNP-typing schemes. It works by aligning query sequences (FASTA assemblies) against reference genomes and identifying specific derived alleles that define phylogenetic lineages. The tool is particularly useful for forensic microbiology and molecular epidemiology, allowing users to download pre-built databases, create custom SNP schemes, and generate visual phylogenetic trees (PDF) showing the placement of their samples.

## Core Workflows

### 1. Environment Setup
The tool is best managed via Conda/Mamba to handle dependencies like ETE3, FlexTaxD, and progressiveMauve.
```bash
mamba create -n cansnper2 cansnper2
mamba activate cansnper2
```

### 2. Database Management
Before running samples, you must have a database and its associated reference sequences.

*   **Download References**: If you have a `.db` file but no reference genomes:
    ```bash
    CanSNPer2-download --database species_name.db --outdir ./refs
    ```
*   **Create Custom Database**: Requires a tree file, SNP annotation file, and reference genome list.
    ```bash
    CanSNPer2-database --database custom.db --annotation snps.txt --tree tree.txt --references refs.txt --create
    ```

### 3. Running SNP-Typing
The primary command aligns your query genomes and calls SNPs.

*   **Standard Run**:
    ```bash
    CanSNPer2 --database species.db sample1.fasta sample2.fasta --summary --save_tree
    ```
*   **Batch Processing**: Point to a directory of FASTA files.
    ```bash
    CanSNPer2 --database species.db path/to/fastas/*.fasta --outdir results/ --summary
    ```

## CLI Best Practices
*   **Summary Flag**: Always use `--summary` to get a consolidated result file and a PDF tree visualization.
*   **Hit Threshold**: Use `--min_required_hits` to adjust the stringency of SNP calling. This is useful if working with lower-quality assemblies.
*   **Performance**: If re-running a failed job, use `--rerun` to overwrite existing results, or `--skip_mauve` if the alignment files (.xmfa) are already generated and valid.
*   **Troubleshooting**: If the tool hangs on large custom databases, check for duplicate positions in your `snps.txt` file.

## Data Formats for Custom Databases
*   **Tree File**: Tab-separated, two columns: `child` and `parent`.
*   **SNP File**: Requires `snp_id`, `strain`, `reference`, `genome`, `position`, `ancestral_base`, and `derived_base`.
*   **Genomes File**: Maps `genome_id` to NCBI accessions (GenBank/RefSeq) for automatic downloading.



## Subcommands

| Command | Description |
|---------|-------------|
| CanSNPer2 | CanSNPer2 |
| CanSNPer2-database | CanSNPer2-database |
| CanSNPer2-download | CanSNPer2-download |

## Reference documentation
- [CanSNPer2 Overview](./references/github_com_FOI-Bioinformatics_CanSNPer2.md)
- [Source File Formats](./references/github_com_FOI-Bioinformatics_CanSNPer2_wiki_CanSNPer2-source-file-format.md)
- [CLI Options Reference](./references/github_com_FOI-Bioinformatics_CanSNPer2_wiki_Options.md)