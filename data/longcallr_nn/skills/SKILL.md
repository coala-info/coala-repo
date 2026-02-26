---
name: longcallr_nn
description: longcallr_nn uses a deep learning architecture to perform high-precision variant calling on long-read RNA sequencing data. Use when user asks to call variants from long-read RNA-seq data, download pre-trained genomic models, or perform neural network inference on extracted features.
homepage: https://github.com/huangnengCSU/longcallR-nn
---


# longcallr_nn

## Overview
longcallR_nn is a specialized genomic tool designed to handle the unique error profiles and characteristics of long-read RNA sequencing. It utilizes a deep learning ResNet50 architecture to achieve high precision in variant calling. The workflow is split into two primary phases: a high-performance data processing step (longcallR_dp) to extract features from BAM files, followed by the neural network inference step (longcallR_nn) to generate the final VCF output.

## Usage Instructions

### 1. Feature Extraction (longcallR_dp)
Before calling variants, you must extract features from your aligned reads. This component is performance-critical and typically run in parallel across contigs.

```bash
# Basic extraction command
longcallR_dp --mode predict \
  --bam-path input.bam \
  --ref-path reference.fa \
  --output output_features \
  --threads 4 \
  --min-depth 6 \
  --min-alt-freq 0.1 \
  --contigs chr22
```

**Key Parameters:**
- `--min-baseq`: Set to `0` for PacBio HiFi and `10` for Nanopore (ONT).
- `--min-depth`: Minimum coverage required to consider a site (default: 6).
- `--min-alt-freq`: Minimum allele frequency for candidate SNPs (default: 0.1).

### 2. Model Acquisition
The tool requires specific pre-trained models and configuration files based on the sequencing platform used.

```bash
# Download latest models and configs to a local directory
longcallR_nn download --download_dir ./models
```

### 3. Variant Calling (longcallR_nn)
Run the inference engine using the features extracted in step 1 and the models downloaded in step 2.

```bash
# Call variants for a specific contig
longcallR_nn call \
  -config models/pb_masseq_config.yaml \
  -model models/pb_masseq_model.chkpt \
  -data output_features_chr22 \
  -ref reference.fa \
  -output sample_chr22.vcf \
  -max_depth 200 \
  -batch_size 500
```

## Best Practices and Tips

- **Parallelization**: `longcallR_dp` is most efficient when run in parallel across chromosomes using tools like `GNU Parallel`. Ensure the output prefix includes the contig name to prevent overwriting.
- **Platform Specifics**: Always match the `-config` and `-model` files to your data type (e.g., use `masseq` models for PacBio MAS-Seq and `cdna` or `drna` models for Nanopore).
- **Memory Management**: If encountering OOM (Out of Memory) errors during the `call` phase, reduce the `-batch_size` (default: 500).
- **Depth Limits**: The `-max_depth` parameter in the calling phase helps maintain consistent performance in ultra-high coverage regions; 200 is a standard starting point for RNA-seq.

## Reference documentation
- [longcallR-nn GitHub Repository](./references/github_com_huangnengCSU_longcallR-nn.md)
- [longcallr_nn Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_longcallr_nn_overview.md)