---
name: clair3-illumina
description: Clair3-illumina is a variant calling framework that identifies germline variants from Illumina short-read sequencing data using a combination of pileup calling and deep learning. Use when user asks to call germline variants, generate GVCF files, or perform variant calling on high-coverage amplicon data.
homepage: https://github.com/HKU-BAL/Clair3
---


# clair3-illumina

## Overview
Clair3-illumina is a specialized implementation of the Clair3 variant calling framework optimized for Illumina short-read data. It utilizes a "symphonized" approach: pileup calling handles the majority of variant candidates with high speed, while a deep-learning-based full-alignment model tackles complex candidates to ensure high precision and recall. This skill provides the necessary CLI patterns and configuration logic to execute germline calling, manage high-coverage data, and utilize the PyTorch-based engine introduced in version 2.0.0.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure the environment is properly configured before execution.

```bash
# Installation via Conda
conda install bioconda::clair3-illumina

# Verify installation
run_clair3.py --version
```

## Common CLI Patterns

### Basic Germline Calling
The primary entry point is `run_clair3.py`. At a minimum, you must provide the BAM file, reference genome, and the path to the pre-trained models.

```bash
run_clair3.py \
  --bam_fn input.bam \
  --ref_fn reference.fasta \
  --threads 8 \
  --model_path /path/to/models/illumina \
  --output /path/to/output_dir \
  --sample_name SAMPLE_ID
```

### Generating GVCF Output
To produce a Genomic VCF (GVCF) for downstream joint calling or population-scale analysis:

```bash
run_clair3.py \
  --bam_fn input.bam \
  --ref_fn reference.fasta \
  --threads 8 \
  --model_path /path/to/models/illumina \
  --output /path/to/output_dir \
  --gvcf
```

### Handling Targeted Amplicon Data
For high-coverage amplicon sequencing, splitting the genome into chunks can be inefficient or cause issues. Disable chunking to improve performance:

```bash
run_clair3.py \
  --bam_fn amplicon.bam \
  --ref_fn reference.fasta \
  --threads 4 \
  --model_path /path/to/models/illumina \
  --output /path/to/output_dir \
  --chunk_num -1
```

## Expert Tips and Best Practices

### Performance Optimization
*   **GPU Acceleration**: Since version 1.2.0, Clair3 natively supports GPU on Linux and Apple Silicon. Using a GPU can increase processing speed by approximately 5x compared to CPU-only execution.
*   **Thread Allocation**: Ensure the number of threads matches your available CPU cores; however, for the deep learning inference phase, memory bandwidth is often the bottleneck rather than raw core count.

### Variant Filtering and Sensitivity
*   **Allele Frequency Thresholds**: You can fine-tune sensitivity using `--min_snp_af` and `--min_indel_af`. Note that if a VCF file is provided via `--vcf_fn` for forced calling, these thresholds are automatically set to 0.0.
*   **Sequence Ends**: By default, variant calling is conservative at the ends of sequences. Use `--enable_variant_calling_at_sequence_head_and_tail` to enable calling within the first/last 16bp of a contig, but be aware that alignments in these regions are often less reliable.

### Troubleshooting Common Issues
*   **Memory Guards**: If working with extremely high coverage (e.g., >1000x), the tool includes memory guards to prevent stack overflows. If you encounter memory errors, consider reducing the number of parallel jobs or using the `--chunk_num -1` flag for amplicons.
*   **VCF Headers**: If you require all contigs to appear in the GVCF header (even those with no coverage), use the `--output_all_contigs_in_gvcf_header` flag.

## Reference documentation
- [Clair3-illumina Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_clair3-illumina_overview.md)
- [Clair3 Main Documentation](./references/github_com_HKU-BAL_Clair3.md)