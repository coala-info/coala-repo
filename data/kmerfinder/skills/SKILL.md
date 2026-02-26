---
name: kmerfinder
description: Kmerfinder identifies the species of bacterial samples by matching genomic K-mer signatures against a reference database. Use when user asks to identify species from genomic data, perform taxonomic classification, or match K-mers against a reference database.
homepage: https://bitbucket.org/genomicepidemiology/kmerfinder
---


# kmerfinder

## Overview
Kmerfinder is a taxonomic identification tool that uses K-mer genomic signatures to rapidly determine the species of an unknown bacterial sample. It is particularly effective for clinical microbiology and genomic epidemiology where speed and accuracy in species attribution are required. It works by matching the K-mers found in the input data against a pre-indexed database of reference genomes.

## Usage Patterns

### Basic Species Identification
To run a standard search against a kmerfinder database:
```bash
kmerfinder.py -i input.fastq -o output_directory -db /path/to/database -tax /path/to/taxonomy_file
```

### Common CLI Arguments
- `-i`: Input file(s). Supports FASTQ (can be gzipped) and FASTA formats.
- `-o`: Output directory where results and temporary files will be stored.
- `-db`: Path to the kmerfinder database (e.g., `bacteria.ATG`).
- `-tax`: Path to the taxonomy file mapping database entries to species names.
- `-k`: K-mer size (default is usually 16, but should match the database used).
- `-threshold`: Minimum threshold for a match to be considered significant.

### Handling Paired-End Data
For paired-end reads, provide both files to the input flag:
```bash
kmerfinder.py -i read1.fastq.gz read2.fastq.gz -o output_dir -db /path/to/db
```

## Best Practices
- **Database Selection**: Ensure the database path points to the `.ATG` file or the directory containing the specific k-mer index you intend to use (e.g., the "bacteria" or "fungi" database).
- **Output Interpretation**: Focus on the `results.txt` file in the output directory. The "Template" column indicates the closest matching reference genome, and "Score" reflects the number of matching K-mers.
- **Pre-processing**: While kmerfinder is robust, trimming adapters and low-quality bases from FASTQ files using tools like Fastp or Trimmomatic can improve the precision of K-mer matching.
- **Memory Management**: K-mer databases are loaded into RAM. Ensure the execution environment has sufficient memory to hold the specific database being queried.

## Reference documentation
- [Kmerfinder Overview](./references/anaconda_org_channels_bioconda_packages_kmerfinder_overview.md)
- [Kmerfinder Bitbucket Repository](./references/bitbucket_org_genomicepidemiology_kmerfinder.md)