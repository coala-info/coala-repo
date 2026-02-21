---
name: virdig
description: VirDiG (Viral Discovery and Generation) is a specialized de novo assembler tailored for coronavirus transcriptomes.
homepage: https://github.com/Limh616/VirDiG
---

# virdig

## Overview

VirDiG (Viral Discovery and Generation) is a specialized de novo assembler tailored for coronavirus transcriptomes. It processes paired-end RNA-Seq data to generate candidate transcripts in FASTA format. This tool is particularly valuable when studying viral variants, non-canonical transcripts, or samples where a reference genome might bias the assembly results.

## Installation and Setup

The most efficient way to deploy VirDiG is via Bioconda:

```bash
conda install bioconda::virdig
```

If building from source, ensure the Boost libraries (program_options, regex, filesystem, system) are installed and linked in your environment.

## Core Command Line Usage

The basic execution requires left and right reads in FASTQ format and a designated output directory.

```bash
virdig -l <forward_reads.fq> -r <reverse_reads.fq> -o <output_dir>
```

### Required Arguments
- `-l <string>`: Path to the left (forward) reads.
- `-r <string>`: Path to the right (reverse) reads.
- `-o <string>`: Name of the directory for output files.

### Performance and Tuning Options
- `-t <int>`: Number of threads. Default is 6. Increase this to match your available CPU cores for faster processing.
- `-k <int>`: K-mer length. Default is 31. Adjust based on read length; shorter k-mers may increase sensitivity but also noise.
- `-d <int>`: Read directionality. 
    - `1` (Default): Directions are inversely complementary (standard for most Illumina paired-end libraries).
    - `2`: Directions are the same.
- `--non_canonical <int>`: Set to `1` to enable the generation of non-standard transcripts. Default is `0`.
- `--map_weight <float>`: Weight assigned to paired node weights. Recommended range is 0.0 to 1.0. Default is `0.7`.

## Expert Workflow Tips

### Data Preprocessing
VirDiG expects high-quality FASTQ inputs. Before assembly, it is best practice to:
1. **Clean Reads**: Use `fastp` or `Trimmomatic` to remove adapters and low-quality bases.
2. **Format Conversion**: If your data is in SAM/BAM format, use `samtools fastq` to convert it back to paired FASTQ files.
3. **SRA Downloads**: When using NCBI SRA data, use `fastq-dump --split-files` or `fasterq-dump` to ensure proper paired-end formatting.

### Handling Large Datasets
If encountering memory issues or `std::out_of_range` errors on extremely large datasets, consider digital normalization of the reads or subsampling to a specific depth (e.g., 100x coverage) before running the assembly.

### Output Interpretation
The primary output is a FASTA file containing all assembled candidate transcripts. These should be further validated using BLAST or specialized viral annotation tools to confirm their identity and completeness.

## Reference documentation
- [VirDiG GitHub Repository](./references/github_com_Limh616_VirDiG.md)
- [VirDiG Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_virdig_overview.md)