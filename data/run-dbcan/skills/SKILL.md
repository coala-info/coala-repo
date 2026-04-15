---
name: run-dbcan
description: run-dbcan is a bioinformatics pipeline that identifies and annotates Carbohydrate-Active EnZymes (CAZymes) and their gene clusters in genomic and metagenomic data. Use when user asks to annotate protein or DNA sequences for CAZymes, predict carbohydrate substrates, or identify CAZyme Gene Clusters.
homepage: https://github.com/linnabrown/run_dbcan
metadata:
  docker_image: "quay.io/biocontainers/run-dbcan:2.0.11--pyh3252c3a_0"
---

# run-dbcan

## Overview

run-dbcan is a specialized bioinformatics pipeline designed to identify and annotate CAZymes across diverse organisms, including prokaryotes, fungi, plants, and viruses. It functions by integrating three primary search methods: HMMER for HMM-based family identification, Diamond for fast protein alignment against the CAZy database, and dbCAN_sub for substrate-level annotation. The tool is essential for researchers studying carbohydrate metabolism, providing a consensus-based approach to gene functional annotation and the identification of CAZyme Gene Clusters (CGCs).

## Installation and Setup

The most reliable way to install run-dbcan is via the Bioconda channel.

```bash
conda install -c bioconda run-dbcan
```

### Database Preparation
Before running annotations, you must download and format the required databases (HMM profiles, CAZy database, and substrate mapping files). Use the built-in utility:

```bash
dbcan_build
```

## Common CLI Patterns

### Annotating Protein Sequences
Use this pattern when you have a proteome (FASTA format) from a single organism.

```bash
run_dbcan input_proteome.faa protein --out_dir ./output_results
```

### Annotating Genomic or Metagenomic DNA
Use this pattern for assembled contigs or scaffolds. The tool will automatically predict genes before annotation.

```bash
run_dbcan input_genome.fna dna --out_dir ./output_results
```

### Substrate Prediction and CGC Identification
To include substrate prediction and CAZyme Gene Cluster (CGC) analysis, ensure the input type is correctly specified (prokaryotic genomes are best suited for CGC detection).

```bash
run_dbcan input.fasta dna --out_dir ./output_results --dbcan_sub --cgc_finder all
```

## Expert Tips and Best Practices

- **Input Type Selection**: Always specify the correct input type (`protein`, `dna`, or `meta`). Using `meta` for metagenomic assemblies optimizes the gene prediction step for fragmented sequences.
- **Consensus Annotation**: run-dbcan provides results from HMMER, Diamond, and dbCAN_sub. A "gold standard" annotation is typically one where at least two of these tools agree on the CAZyme family.
- **Output Files to Watch**:
    - `cazyme.annotation`: The primary summary file containing the consensus results.
    - `substrate.out`: Contains predicted substrates for identified CAZymes.
    - `cgc.out`: Details the identified CAZyme Gene Clusters.
- **Database Updates**: CAZyme nomenclature and family definitions evolve. Periodically re-run `dbcan_build` to ensure your local database matches the latest dbCAN version.
- **Resource Management**: For large metagenomes, Diamond and HMMER can be CPU-intensive. Use the `--threads` flag to speed up processing if your environment supports multi-threading.

## Reference documentation
- [github_com_linnabrown_run_dbcan.md](./references/github_com_linrown_run_dbcan.md)
- [anaconda_org_channels_bioconda_packages_run-dbcan_overview.md](./references/anaconda_org_channels_bioconda_packages_run-dbcan_overview.md)
- [github_com_linnabrown_run_dbcan_tags.md](./references/github_com_linnabrown_run_dbcan_tags.md)