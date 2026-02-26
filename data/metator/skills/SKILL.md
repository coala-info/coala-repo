---
name: metator
description: MetaTOR bins metagenomic contigs by leveraging spatial proximity information from Hi-C data. Use when user asks to bin metagenomic contigs, generate a metaHi-C network, partition contigs into communities, or validate and decontaminate metagenome-assembled genomes.
homepage: https://github.com/koszullab/metator
---


# metator

## Overview
MetaTOR (Metagenomic Tridimensional Organisation-based Reassembly) is a computational pipeline designed to bin metagenomic contigs by leveraging the spatial proximity information provided by Hi-C data. By analyzing the 3D interactions of DNA within a sample, MetaTOR can accurately group contigs from the same organism even in complex microbial communities. The tool provides a modular workflow that transitions from raw sequence alignment to the generation of validated, decontaminated MAGs.

## Installation and Setup
The most reliable way to use metator is via Conda, which manages the various non-pythonic dependencies:
`conda create -n metator bioconda::metator`

Required external tools that must be in the `$PATH` if not using Conda:
- bowtie2 or bwa
- samtools
- hmmer
- prodigal
- java (default-jdk)

## Command Structure
The general syntax for metator is:
`metator {action} [parameters]`

### Primary Actions
1. **network**: Generates a normalized metaHi-C contig network from fastq or bam files.
2. **partition**: Executes Louvain or Leiden community detection to bin contigs based on interaction signals.
3. **validation**: Uses CheckM to validate bins and performs recursive decontamination.
4. **pipeline**: Runs the three primary steps (network, partition, validation) sequentially.

### Miscellaneous Actions
- **contactmap**: Generates a contact map for a specific bin from the final output.
- **version**: Displays the current version.
- **help**: Displays help documentation.

## Native CLI Usage Patterns

### Running the Full Pipeline
To process raw reads into validated bins in one step:
`metator pipeline --fastq1 reads_R1.fastq.gz --fastq2 reads_R2.fastq.gz --contigs assembly.fasta --threads 16`

### Step-by-Step Execution
If manual intervention or intermediate analysis is required, run the steps individually:

**Step 1: Network**
`metator network --fastq1 R1.fq --fastq2 R2.fq --contigs assembly.fa --output_dir ./workdir`

**Step 2: Partition**
`metator partition --network network.txt --contig_data contig_data_network.txt --algorithm louvain`

**Step 3: Validation**
`metator validation --partition_dir overlapping_bin --contig_data contig_data_partition.txt`

## Expert Tips and Best Practices
- **Input Requirements**: Contig data files used as input must contain a header row. While the column order is not strict, the headers must match the expected names (e.g., ID, Name, Size, GC_content).
- **Shotgun Coverage**: To populate the `Shotgun_coverage` column in final reports, you must provide a `depth.txt` file. If omitted, this field will be filled with `-`.
- **Algorithm Selection**: In the `partition` step, you can choose between `louvain` and `leiden`. Leiden is generally preferred for higher quality community detection but may require specific library versions.
- **Resource Management**: The `pipeline` and `network` steps are computationally intensive; always specify `--threads` to match your environment's capabilities.
- **Validation Prerequisites**: The `validation` step requires CheckM to be installed and configured with its reference database.

## Key Output Files
- `final_bin/`: Directory containing the FASTA files of the final, decontaminated MAGs.
- `bin_summary.txt`: Summary statistics for the final bins.
- `binning.txt`: A mapping file linking contig names to their final cluster assignments.
- `network.txt`: The normalized edgelist representing contig interactions.

## Reference documentation
- [metaTOR GitHub README](./references/github_com_koszullab_metaTOR.md)
- [Bioconda metator Overview](./references/anaconda_org_channels_bioconda_packages_metator_overview.md)