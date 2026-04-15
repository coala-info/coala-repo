---
name: plasmidfinder
description: PlasmidFinder identifies plasmid replicons in bacterial genomic sequences by comparing them against a curated database of known replication genes. Use when user asks to identify plasmid composition, detect plasmid replicons in bacterial isolates, or determine if antibiotic resistance genes are plasmid-mediated.
homepage: https://bitbucket.org/genomicepidemiology/plasmidfinder
metadata:
  docker_image: "quay.io/biocontainers/plasmidfinder:2.1.6--hdfd78af_0"
---

# plasmidfinder

## Overview

PlasmidFinder is a bioinformatic tool designed to identify plasmid replicons in bacterial sequences. By comparing input genomic data against a curated database of known plasmid replication genes, it allows researchers to determine the plasmid composition of a bacterial isolate. This is a critical step in genomic epidemiology, as plasmids are primary vehicles for the spread of antibiotic resistance and virulence factors. The tool is most effective when used with assembled contigs but can also process raw sequencing data.

## Command Line Usage

### Basic Execution
The primary script for the tool is `plasmidfinder.py`. It requires an input file, an output directory, and a path to the PlasmidFinder database.

```bash
plasmidfinder.py -i <input_file> -o <output_directory> -p <path_to_database>
```

### Key Arguments
- `-i`, `--infile`: Input file in FASTA or FASTQ format.
- `-o`, `--outdir`: Directory where results will be stored.
- `-p`, `--database`: Path to the directory containing the PlasmidFinder database.
- `-t`, `--threshold`: Minimum percentage of identity (default is 90%).
- `-l`, `--mincov`: Minimum percentage of coverage (default is 60%).
- `-x`, `--extnd`: Extend the seed hit (default is off).
- `-tmp`, `--tmp_dir`: Specify a temporary directory for analysis.

### Database Preparation
PlasmidFinder relies on a specific database that must be downloaded and indexed before use. If using the tool in a fresh environment, ensure the database is fetched:
```bash
# Example of downloading the database (usually via a provided shell script in the tool directory)
download_db.sh
```

## Best Practices and Expert Tips

### Input Quality
- **Assembly vs. Reads**: While PlasmidFinder supports raw reads, using high-quality assembled contigs (e.g., from SPAdes or SKESA) generally yields more reliable replicon identification and reduces false positives caused by sequencing errors.
- **Filtering**: Remove very short contigs (e.g., <500bp) before running the tool to improve performance and focus on significant hits.

### Interpreting Results
- **results_tab.txt**: This is the most useful output for automated pipelines. It provides a tab-delimited summary of the replicons found, including identity, coverage, and contig location.
- **Multiple Hits**: If multiple replicons are found on the same contig, it may indicate a multi-replicon plasmid or a chimeric assembly. Cross-reference with the "Position in contig" column.
- **Threshold Tuning**: For closely related species or well-characterized plasmids, increasing the threshold (`-t`) to 95% or 98% can help distinguish between highly similar plasmid types.

### Common Workflow Integration
- **AMR Correlation**: Often used in conjunction with ResFinder. If a plasmid replicon and an AMR gene are found on the same contig, it provides strong evidence that the resistance is plasmid-mediated.
- **PointFinder**: Use PlasmidFinder results to contextualize chromosomal vs. extrachromosomal mutations found by tools like PointFinder.

## Reference documentation
- [plasmidfinder - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_plasmidfinder_overview.md)
- [Genomic Epidemiology - PlasmidFinder](./references/bitbucket_org_genomicepidemiology_plasmidfinder.md)