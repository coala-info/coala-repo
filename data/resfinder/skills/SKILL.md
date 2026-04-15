---
name: resfinder
description: ResFinder identifies antimicrobial resistance genes and chromosomal mutations in bacterial sequence data. Use when user asks to detect AMR determinants, identify point mutations, or profile resistance from assemblies and raw reads.
homepage: https://bitbucket.org/genomicepidemiology/resfinder
metadata:
  docker_image: "quay.io/biocontainers/resfinder:4.7.2--pyhdfd78af_0"
---

# resfinder

## Overview
ResFinder is a specialized bioinformatics tool designed to detect the presence of antimicrobial resistance determinants in bacterial sequence data. It compares input sequences against a curated database of acquired genes and known chromosomal mutations. This skill facilitates the configuration of ResFinder runs, including database selection, identity thresholds, and minimum length requirements to ensure accurate AMR profiling from either assembled contigs or raw sequencing reads.

## Command Line Usage
The primary executable is `run_resfinder.py`. It requires a pre-indexed database to function correctly.

### Basic Identification
To search for acquired AMR genes in an assembly:
```bash
python3 run_resfinder.py -ifa input_assembly.fa -o output_directory -s "Species name" --acquired
```

### Point Mutation Detection
To include chromosomal point mutations (requires species specification):
```bash
python3 run_resfinder.py -ifa input_assembly.fa -o output_directory -s "Escherichia coli" --acquired --point
```

### Working with Raw Reads
ResFinder can process FASTQ files directly using KMA (k-mer alignment):
```bash
python3 run_resfinder.py -ifq forward_reads.fastq.gz reverse_reads.fastq.gz -o output_directory -s "Staphylococcus aureus" --acquired
```

## Key Parameters and Best Practices
- **Species Selection (`-s`)**: Always provide the full species name in quotes. This is mandatory for point mutation detection and improves the accuracy of the results.
- **Identity Threshold (`-t`)**: The default is often 90%. For high-stringency clinical reporting, consider increasing this to `-t 0.95` or `-t 0.98`.
- **Minimum Length (`-l`)**: The default minimum coverage of the resistance gene is 60%. Adjust this using `-l [0-1]` (e.g., `-l 0.8` for 80% coverage) to filter out partial hits or fragments.
- **Database Path (`-db_res`)**: Ensure the environment variable for the ResFinder database is set, or specify it explicitly if it is not in the default location.
- **Output Interpretation**:
    - `results_tab.txt`: A tab-delimited summary of all hits.
    - `ResFinder_results.txt`: A more verbose, human-readable report.
    - `pheno_table.txt`: Predicts the resistance phenotype based on the detected genes.

## Expert Tips
- **Database Updates**: AMR databases evolve rapidly. Always verify the date of the ResFinder database being used to ensure novel variants (like new NDM or mcr alleles) are detectable.
- **Discrepancy Checking**: If a phenotype is observed in the lab but not found by ResFinder, check the `blocked_genes.txt` or look for low-coverage hits that may have fallen just below the `-l` or `-t` thresholds.
- **Contig Quality**: For assembly-based input, ensure the N50 is sufficient. Fragmented assemblies can split resistance genes across multiple contigs, leading to false negatives if the length threshold is high.

## Reference documentation
- [ResFinder Source and Documentation](./references/bitbucket_org_genomicepidemiology_resfinder.md)
- [Bioconda ResFinder Package Overview](./references/anaconda_org_channels_bioconda_packages_resfinder_overview.md)