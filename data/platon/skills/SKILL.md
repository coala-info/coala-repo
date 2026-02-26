---
name: platon
description: Platon identifies and characterizes plasmid-borne contigs within bacterial draft genome assemblies using protein-coding gene distribution scores and functional markers. Use when user asks to identify plasmid sequences, characterize plasmid-borne genes, or separate chromosomal and plasmid contigs in genomic data.
homepage: https://github.com/oschwengers/platon
---


# platon

## Overview
Platon is a bioinformatics tool designed to identify and characterize plasmid-borne contigs within bacterial draft genome assemblies. It utilizes Replicon Distribution Scores (RDS) to measure the bias of protein-coding gene families between chromosomes and plasmids. Beyond simple classification, Platon provides deep characterization by searching for replication, mobilization, and conjugation genes, as well as oriT sequences and incompatibility groups. Use this skill to automate the separation of plasmid and chromosomal sequences and to gain functional insights into the plasmid content of a genome.

## Database Setup
Platon requires a mandatory pre-computed database to function.
- **Download**: The database must be downloaded from Zenodo and extracted.
- **Configuration**: Provide the path using the `--db` flag or by setting the `PLATON_DB` environment variable.
  ```bash
  export PLATON_DB=/path/to/platon_db
  ```

## Common CLI Patterns

### Basic Classification
Run Platon on a draft assembly using default settings (accuracy mode):
```bash
platon --db /path/to/db genome.fasta
```

### High-Throughput Analysis
Utilize multiple CPU cores and specify an output directory for cleaner project management:
```bash
platon --threads 16 --output results_dir/ --prefix sample_01 genome.fasta
```

### Metagenome Mode
When working with metagenomic assemblies where gene prediction parameters differ, use the `--meta` flag:
```bash
platon --meta genome.fasta
```

### Adjusting Sensitivity and Specificity
Platon offers three modes to balance false positives and false negatives:
- **accuracy** (Default): Uses RDS and characterization heuristics for the best overall performance.
- **sensitivity**: Uses RDS only, tuned for >= 95% sensitivity.
- **specificity**: Uses RDS only, tuned for >= 99.9% specificity.

```bash
platon --mode sensitivity genome.fasta
```

## Expert Tips and Best Practices
- **SPAdes Integration**: If your contigs were assembled with SPAdes, Platon automatically extracts coverage information from the fasta headers to improve classification accuracy.
- **Characterization Only**: To bypass the filtering logic and characterize every contig in the input file (regardless of whether Platon thinks it is a plasmid), use the `--characterize` flag.
- **Output Interpretation**:
    - `<prefix>.plasmid.fasta`: Contains the sequences identified as plasmids.
    - `<prefix>.tsv`: A tab-separated summary of all plasmid contigs and their features.
    - `<prefix>.json`: The most comprehensive output, containing detailed metadata for every identified plasmid contig.
- **Resource Management**: For large assemblies, ensure sufficient RAM is available for the Diamond and BLAST+ searches performed during the characterization phase.

## Reference documentation
- [Platon GitHub Repository](./references/github_com_oschwengers_platon.md)
- [Bioconda Platon Overview](./references/anaconda_org_channels_bioconda_packages_platon_overview.md)