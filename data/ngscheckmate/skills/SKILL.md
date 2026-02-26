---
name: ngscheckmate
description: NGSCheckMate confirms sample identity and detects potential swaps across various sequencing datasets by analyzing variant allele fraction correlations at known SNP positions. Use when user asks to verify if sequencing files belong to the same donor, perform sample matching across different data types like RNA-seq and WGS, or identify sample contamination and mislabeling.
homepage: https://github.com/parklab/NGSCheckMate
---


# ngscheckmate

## Overview

NGSCheckMate is a specialized quality control tool designed to confirm sample identity across various high-throughput sequencing datasets. By analyzing the correlation of Variant Allele Fractions (VAFs) at known SNP positions, it determines whether two or more files belong to the same donor. It is highly versatile, supporting Whole Genome Sequencing (WGS), Whole Exome Sequencing (WES), RNA-seq, and ChIP-seq, even when mixing these data types in a single analysis. The tool offers an alignment-free FASTQ module for rapid initial checks and a BAM/VCF module for post-processing verification.

## Core Workflows

### 1. BAM or VCF Analysis (ncm.py)
Use this mode when you have aligned reads or called variants. Input BAM files must be sorted and indexed.

**Basic Command:**
```bash
python $NCM_HOME/ncm.py -B -d /path/to/bam_dir -bed $NCM_HOME/SNP/SNP_GRCh37_hg19_woChr.bed -O output_directory
```

**Key Arguments:**
- `-B` or `-V`: Specify input type (BAM or VCF).
- `-l`: Path to a text file listing input files and sample names (one per line).
- `-bed`: Choose the SNP file matching your reference genome's chromosome naming convention:
  - `SNP_GRCh37_hg19_wChr.bed`: Use if your reference has "chr1", "chr2", etc.
  - `SNP_GRCh37_hg19_woChr.bed`: Use if your reference has "1", "2", etc.

### 2. Fast Alignment-Free Analysis (ncm_fastq.py)
Use this for a quick check before alignment. It uses a binary pattern file to scan FASTQ reads.

**Basic Command:**
```bash
python $NCM_HOME/ncm_fastq.py -l fastq_list.txt -pt $NCM_HOME/SNP/SNP.pt -O output_directory
```

**Input List Format (`-l`):**
The list file should be tab-delimited:
```text
/path/to/sample1_R1.fastq.gz    Sample1
/path/to/sample2_R1.fastq.gz    Sample2
```

## Expert Tips and Best Practices

### High-Performance Optimization
For large cohorts (e.g., 100+ WGS samples), running `ncm.py` directly on BAM files is computationally expensive. Use the "VCF-first" strategy:
1. **Parallelize VCF Generation:** Use `samtools mpileup` and `bcftools` to create small VCFs targeting only the NGSCheckMate SNP positions for each BAM.
   ```bash
   samtools mpileup -I -uf ref.fasta -l SNP_locations.bed sample.bam | bcftools call -c - > sample.vcf
   ```
2. **Run NCM on VCFs:** Execute `ncm.py -V` on the resulting directory of small VCFs. This reduces runtime from hours to minutes.

### Handling Related Individuals
If your dataset contains family members (parents, siblings), the default correlation cutoffs may produce false positives for "same individual."
- **Action:** Use the `-f` flag to enforce strict VAF correlation cutoffs, which helps distinguish between identical samples and closely related individuals.

### Configuration for BAM Processing
The BAM module requires `samtools` and `bcftools`. Ensure your `$NCM_HOME/ncm.conf` is correctly populated with absolute paths:
```text
REF=/path/to/human_g1k_v37.fasta
SAMTOOLS=/usr/local/bin/samtools
BCFTOOLS=/usr/local/bin/bcftools
```

### Interpreting Results
- **output_all.txt:** Contains the correlation matrix and the final "MATCH" or "MISMATCH" call.
- **Dendrogram (PDF):** Visualizes sample clusters. Samples from the same individual should cluster tightly together.
- **xgmml:** Can be imported into Cytoscape for graphical network analysis of sample relationships.

## Reference documentation
- [NGSCheckMate GitHub Repository](./references/github_com_parklab_NGSCheckMate.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ngscheckmate_overview.md)