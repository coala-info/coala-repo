---
name: pan-plaster
description: Plaster is a high-speed bioinformatics tool designed for the construction of linear pangenomes.
homepage: https://gitlab.com/treangenlab/plaster
---

# pan-plaster

## Overview
Plaster is a high-speed bioinformatics tool designed for the construction of linear pangenomes. While applicable to various genomic data, it is particularly specialized for plasmid pangenomics. It streamlines the process of comparing multiple sequences by identifying homologous regions and organizing them into a pangenome framework, allowing for rapid assessment of genetic diversity across a population of sequences.

## Installation
The recommended way to install pan-plaster is via Bioconda:
```bash
conda install -c bioconda pan-plaster
```

## Basic Usage
The primary command is `plaster`. It typically takes a set of FASTA files as input and requires an output directory.

### Standard Pangenome Construction
To generate a pangenome from all FASTA files in the current directory:
```bash
plaster *.fasta -o ./pangenome_output
```

### Common CLI Options
- `-o`, `--output`: Path to the directory where results will be stored.
- `-k`: Keep intermediate files. By default (v1.2.0+), Plaster removes intermediate files to save disk space. Use this flag if you need to inspect raw alignments or fragments.
- `-a`, `--align-only`: Runs only the alignment phase of the pipeline.
- `-t`: Specify the number of threads for multithreaded processing (recommended for large datasets).

## Expert Tips and Best Practices
- **Input Organization**: Place all individual sequence files (e.g., `.fasta` or `.fa`) into a single directory to use wildcard expansion (`*.fasta`). Plaster supports both individual FASTA files and multifasta inputs.
- **Disk Space Management**: When working with thousands of sequences, the intermediate alignment files can become very large. Ensure you have sufficient storage, or rely on the default behavior of version 1.2.1 which automatically cleans up these files unless `-k` is specified.
- **Error Troubleshooting**: If you encounter an error like `argument -a/--align-only: ignored explicit argument`, ensure that your input file list is correctly formatted and that you are not accidentally passing a filename into a flag that doesn't expect an argument.
- **Performance**: For large-scale analyses (e.g., >10,000 sequences), always utilize the multithreading capabilities to significantly reduce runtime during the alignment and realigning phases.

## Reference documentation
- [pan-plaster Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pan-plaster_overview.md)
- [Plaster GitLab Repository](./references/gitlab_com_treangenlab_plaster.md)
- [Plaster README](./references/gitlab_com_treangenlab_plaster_-_blob_master_README.md)