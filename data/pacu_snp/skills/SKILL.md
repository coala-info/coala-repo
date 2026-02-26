---
name: pacu_snp
description: PACU is a bioinformatics workflow that performs read mapping, variant calling, and SNP-based phylogenetic tree construction for prokaryotic genomes. Use when user asks to map sequencing reads to a reference, identify genomic variations, filter SNPs, mask recombinant regions, or construct high-resolution phylogenetic trees for bacterial isolates.
homepage: https://github.com/BioinformaticsPlatformWIV-ISP/PACU
---


# pacu_snp

## Overview
PACU (Prokaryotic Awesome variant Calling Utility) is a specialized bioinformatics workflow that streamlines the transition from raw sequencing reads to phylogenetic analysis. It handles read mapping, variant calling, SNP filtering, and tree construction. This skill is particularly useful when you need to compare bacterial isolates, identify genomic variations across samples, or construct high-resolution phylogenetic trees using standardized SNP-based methods.

## Core Workflows

### 1. Read Mapping (PACU_map)
Before running the main phylogeny workflow, raw FASTQ reads must be mapped to a reference genome to produce BAM files.

**Illumina (Paired-end):**
```bash
PACU_map \
  --ref-fasta reference.fasta \
  --read-type illumina \
  --fastq-illumina sample_R1.fastq.gz sample_R2.fastq.gz \
  --output mapped_sample.bam \
  --threads 8 \
  --trim
```

**Oxford Nanopore (ONT):**
```bash
PACU_map \
  --ref-fasta reference.fasta \
  --read-type ont \
  --fastq-ont sample_ont.fastq.gz \
  --output mapped_sample.bam \
  --threads 8
```

### 2. Phylogeny Workflow (PACU)
The main command processes directories containing BAM files. You can provide Illumina BAMs, ONT BAMs, or both.

**Basic Multi-platform Run:**
```bash
PACU \
  --ilmn-in path/to/illumina_bams/ \
  --ont-in path/to/ont_bams/ \
  --ref-fasta reference.fasta \
  --output results_dir/ \
  --dir-working work_dir/ \
  --threads 16
```

## Expert Tips and Best Practices

### Handling Recombination
By default, PACU uses **Gubbins** to identify and mask recombinant regions, which is critical for accurate prokaryotic phylogeny. 
- If your dataset is known to have low recombination or you want to speed up the process, use `--skip-gubbins`.
- Note: Gubbins requires a single-sequence reference. If your reference has multiple contigs and you need Gubbins, you must concatenate them or disable Gubbins using `--skip-gubbins`.

### Filtering and Quality Control
Fine-tune your SNP calling using these parameters to reduce false positives:
- **Allele Frequency:** Use `--min-snp-af` (default is usually 0.9 for haploid bacteria) to ensure high-confidence calls.
- **Depth Requirements:** Use `--min-global-depth` to ensure a position is only included in the SNP matrix if all samples meet the minimum coverage threshold.
- **Phage Masking:** If you have a BED file of prophage regions, provide it via `--ref-bed` to exclude these highly variable regions from the phylogeny.

### Tree Construction
- **IQ-TREE:** The default and recommended tool for maximum likelihood phylogeny.
- **MEGA:** If you specifically require MEGA for tree construction, use the `--use-mega` flag (ensure MEGA is manually installed as it is often not available via Conda).
- **Reference Inclusion:** Use `--include-ref` to include the reference genome as a leaf node in the final tree, which is helpful for rooting and context.

### Resource Management
- **Temporary Files:** PACU can generate large intermediate files. Set the `TMPDIR` environment variable to a high-capacity disk if your default `/tmp` is small.
- **Parallelization:** Use the `--threads` flag to scale across available CPU cores, especially during the mapping and IQ-TREE phases.

## Reference documentation
- [PACU GitHub Repository](./references/github_com_BioinformaticsPlatformWIV-ISP_PACU.md)