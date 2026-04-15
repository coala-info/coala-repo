---
name: rnalyze
description: rnalyze automates the complete RNA-Seq workflow from data acquisition and quality control to alignment and quantification. Use when user asks to download SRA data, perform read trimming, align reads to a reference genome, or generate gene counts.
homepage: https://github.com/MohamedElsisii/rnalyze
metadata:
  docker_image: "quay.io/biocontainers/rnalyze:1.0.1--hdfd78af_1"
---

# rnalyze

## Overview
rnalyze is a comprehensive automation tool designed to streamline the multi-stage RNA-Seq workflow. It orchestrates several industry-standard bioinformatics tools—including FastQC, Trimmomatic/Cutadapt, HISAT2/BWA/Bowtie2, and FeatureCounts—into a single command-line interface. By handling data acquisition (via SRA), quality assessment, and quantification, it reduces the need for manual script orchestration and ensures a reproducible analysis path for both single-end (SE) and paired-end (PE) data.

## Installation and Environment
The pipeline requires a specific environment to function correctly:
- **Conda Environment**: Must use Python version 3.10.
- **Installation**: `conda install -c bioconda rnalyze` or `mamba install rnalyze`.
- **Verification**: Run `rnalyze -h` to confirm the installation and view the help menu.

## Common CLI Patterns

### 1. Full Pipeline with SRA Download
Use this pattern when starting from a list of SRR accession numbers. This example uses HISAT2 for alignment and Trimmomatic for trimming.
```bash
rnalyze -p Full -t HISAT2 -d Download -s /path/to/SRR_Acc_List.txt -y SE \
-r UnindexedURL -u http://example.com/ref.fna -T yes -x Trimmomatic \
-a TruSeq3-SE -l 5 -g Download -G http://example.com/annotation.gtf -i gene_id
```

### 2. Alignment and Quantification Only (Local Files)
Use this pattern if you already have `fastq.gz` files and a local indexed reference genome.
```bash
rnalyze -p Alignment -t Bowtie2 -d Directory -D /path/to/local_fastq_dir -y PE \
-r IndexedPath -R /path/to/reference_index_prefix -T no \
-g Path -P /path/to/annotation.gtf
```

### 3. Custom Trimming with Cutadapt
For specific adapter sequences or quality cutoffs using Cutadapt:
```bash
rnalyze -p Full -t BWA -d Directory -D ./data -y SE -r UnindexedPath -R ./genome.fa \
-T yes -x Cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -q 20 -M 36 \
-g Path -P ./genes.gtf
```

## Tool-Specific Best Practices

### Reference Genome Handling
- **Validation**: Ensure reference genome files use standard extensions (`.fna`, `.fa`, `.fasta`).
- **Indexing**: If providing an `UnindexedPath` or `UnindexedURL`, the pipeline will automatically generate the index for the chosen tool (BWA, Bowtie2, or HISAT2). This is computationally expensive; use `IndexedPath` for repeated runs.

### Trimming Optimization
- **Trimmomatic**: Best for standard Illumina adapters using the `-a` (SE) or `-A` (PE) flags to specify the adapter file name (e.g., `TruSeq3-PE`).
- **Cutadapt**: Preferred when you need to provide the literal adapter sequence or require specific 5' trimming (`-g` or `-G`).

### Performance and Scalability
- **CPU Cores**: The tool automatically detects available CPU cores across Linux, macOS, and Windows to optimize multi-threading.
- **Memory**: Ensure the environment has sufficient RAM for genome indexing, especially when using HISAT2 or BWA on large mammalian genomes.

### Feature Counting
- **Identifier**: The default attribute is `gene_id`. If your GTF uses a different attribute (like `transcript_id` or `gene_name`), specify it using the `-i` flag to ensure the count matrix is correctly labeled.

## Reference documentation
- [rnalyze README](./references/github_com_MohamedElsisii_rnalyze_blob_main_README.md)
- [Bioconda rnalyze Overview](./references/anaconda_org_channels_bioconda_packages_rnalyze_overview.md)