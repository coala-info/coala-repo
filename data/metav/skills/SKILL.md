---
name: metav
description: metav is a command-line tool for the high-throughput identification and taxonomic classification of viruses within metagenomic datasets. Use when user asks to identify viruses in metagenomic data, perform host and plasmid decontamination, or map reads to viral protein databases.
homepage: https://github.com/ZhijianZhou01/metav
---


# metav

## Overview

metav is a Python-based command-line tool designed for the high-throughput identification of viruses within metagenomic datasets. It automates a complex pipeline that includes quality control, host and plasmid decontamination, and protein-level mapping to viral databases. By integrating tools like Trimmomatic, Bowtie2, Megahit, and Diamond, it provides a streamlined path from raw reads to viral taxonomic classification.

## Installation and Environment Setup

The recommended installation method is via Conda to ensure all binary dependencies (Trimmomatic, Bowtie2, Megahit, Diamond) are correctly resolved.

```bash
# Create and activate environment
conda create -n metav_env python=3.7
conda activate metav_env

# Install metav
conda install bioconda::metav
```

### Critical Memory Configuration
A common failure point in metav is the default Java memory limit for Trimmomatic. You must manually increase this to prevent read output errors.
1. Locate the `trimmomatic` executable in your conda environment (e.g., `.../envs/metav_env/share/trimmomatic-0.39-2/trimmomatic`).
2. Modify the JVM options:
   - Change: `default_jvm_mem_opts = ['-Xms512m', '-Xmx1g']`
   - To: `default_jvm_mem_opts = ['-Xms512m', '-Xmx20g']` (or higher depending on your system).

## Database Preparation

metav requires several pre-indexed databases. Ensure these are built before running the main pipeline.

### 1. Host and Plasmid Databases (Bowtie2)
Used to subtract non-viral contamination.
```bash
# Build host index
bowtie2-build host_genome.fna /path/to/indices/host_index

# Build plasmid index
bowtie2-build --threads 30 combined_plasmids.fna /path/to/indices/plasmids_index
```

### 2. Viral Protein Database (Diamond)
Used for sensitive protein-level classification.
```bash
# Build Diamond database
diamond makedb --in viral.1.protein.faa --db /path/to/database/ViralProtein.dmnd

# Generate taxonomy information
chmod +x viral_taxonomy_information.sh
./viral_taxonomy_information.sh
```

## Configuration via profiles.xml

metav uses a `profiles.xml` file to manage paths and parameters. This file is the central point of configuration.

- **Database Paths**: When entering paths in `profiles.xml`, do not point to the directory. Point to the index prefix (e.g., `/home/user/db/host_genome` instead of `/home/user/db/`).
- **Multiple Hosts**: If a sample contains contamination from multiple hosts, list the paths separated by commas in the XML.
- **Dynamic Updates**: Update the host path in `profiles.xml` between runs if different samples originate from different host organisms.

## Execution Patterns

Once configured, the primary interface is the `metav` command.

```bash
# View help and available parameters
metav -h
```

### Workflow Logic
1. **Preprocessing**: Trimmomatic removes adapters and low-quality bases.
2. **Decontamination**: Bowtie2 maps reads against host and plasmid databases to filter out non-viral sequences.
3. **Assembly/Mapping**:
   - **Sub-pipeline 1**: Direct mapping of reads to the viral protein database using Diamond.
   - **Sub-pipeline 2**: Assembly of reads into contigs using Megahit, followed by Diamond mapping for improved sensitivity in detecting novel or divergent viruses.

## Expert Tips and Best Practices

- **Resource Allocation**: Diamond and Megahit are resource-intensive. Ensure your environment has sufficient CPU threads and RAM, especially for large metagenomic libraries.
- **Taxonomy Consistency**: When building the Viral NR database, ensure the accession numbers in your `viral_extracted_info.txt` match those in the `ViralProtein.dmnd` database.
- **Second-Gen Focus**: Note that metav 2.x is optimized specifically for second-generation (Illumina-style) sequencing data.

## Reference documentation
- [metav GitHub Repository](./references/github_com_ZhijianZhou01_metav.md)
- [metav Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metav_overview.md)