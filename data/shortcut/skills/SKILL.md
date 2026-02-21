---
name: shortcut
description: ShortCut is a streamlined pipeline for the initial processing of small RNA-seq (sRNA-seq) datasets.
homepage: https://github.com/Aez35/ShortCut
---

# shortcut

## Overview

ShortCut is a streamlined pipeline for the initial processing of small RNA-seq (sRNA-seq) datasets. It automates the transition from raw FASTQ files to aligned and annotated data by wrapping adapter trimming (via Cutadapt), size distribution analysis, and alignment/annotation (via ShortStack). It is particularly useful for researchers needing a standardized workflow for miRNA and siRNA analysis in either plant or animal systems, providing automated quality control plots such as read size distributions.

## Installation

Install the tool via Bioconda:

```bash
conda install bioconda::shortcut
```

## Command Line Usage

### Basic Trimming and QC
To perform basic adapter trimming and generate quality control plots for a set of libraries:

```bash
ShortCut -fastq *.fastq.gz -kingdom plant -out my_results/
```

### Full Alignment and Annotation
To trigger alignment and sRNA annotation using ShortStack, include the `-annotate` flag and provide a reference genome:

```bash
ShortCut -fastq data/*.fastq -kingdom animal -annotate -genome genome.fa -known_mirnas mirbase.fa -dn_mirna
```

### Parameter Reference

| Option | Description |
| :--- | :--- |
| `-fastq` | Input small RNA-seq libraries (FASTQ/FASTA, supports .gz). |
| `-kingdom` | **Required.** Specify `plant` or `animal`. |
| `-trimkey` | Specific miRNA sequence used to detect adapter sequences for trimming. |
| `-m` | Minimum read length for Cutadapt (default: 12). |
| `-annotate` | Enables sRNA annotation via ShortStack. |
| `-genome` | Reference genome FASTA for alignment. |
| `-known_mirnas` | FASTA file of known miRNAs for annotation. |
| `-dn_mirna` | Enables de novo miRNA search in ShortStack. |
| `-threads` | Number of threads for the trimming step. |

## Best Practices and Tips

- **Input Handling**: ShortCut accepts wildcards (e.g., `SRR*`) for the `-fastq` argument, allowing for batch processing of multiple libraries in one command.
- **Quality Control**: Always inspect the generated `Read size distribution PDF`. For high-quality sRNA libraries, you should typically see distinct peaks at 21-nt (miRNAs) and 24-nt (siRNAs, especially in plants).
- **Adapter Trimming**: If standard trimming fails to identify adapters, provide a specific sequence using the `-trimkey` option to guide Cutadapt.
- **ShortStack Integration**: When using `-annotate`, ensure your genome file is indexed or in the same directory to avoid pathing issues during the ShortStack alignment phase.
- **Resource Management**: Use the `-threads` option to speed up the initial trimming phase, especially when dealing with large multiplexed datasets.

## Reference documentation
- [ShortCut README](./references/github_com_Aez35_ShortCut_blob_main_README.md)
- [Bioconda ShortCut Overview](./references/anaconda_org_channels_bioconda_packages_shortcut_overview.md)