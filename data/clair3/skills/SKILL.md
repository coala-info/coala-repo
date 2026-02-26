---
name: clair3
description: Clair3 is a high-performance germline small variant caller designed for long-read sequencing technologies. Use when user asks to call germline variants from long-read data, perform ONT signal-aware calling, or generate GVCF files for joint calling.
homepage: https://github.com/HKU-BAL/Clair3
---


# clair3

## Overview

Clair3 is a high-performance germline small variant caller designed for long-read sequencing technologies. It utilizes a hybrid approach that "symphonizes" two methods: pileup calling for speed and full-alignment for precision in complex regions. As of version 2.0.0, the tool has migrated to a PyTorch-based deep learning framework and supports signal-aware calling for ONT data. It is particularly effective at lower coverage (≤30-fold) compared to other callers and is optimized for speed, typically running significantly faster than its predecessors.

## Installation and Setup

The recommended way to install Clair3 is via Bioconda:

```bash
conda install -c bioconda clair3
```

Alternatively, use the pre-built Docker image:
`hkubal/clair3:latest`

## Common CLI Patterns

### Standard Germline Calling
The primary entry point for version 2.0.0+ is `run_clair3.py`. For older versions, use `run_clair3.sh`.

```bash
run_clair3.py \
  --bam_fn=input.bam \
  --ref_fn=ref.fa \
  --threads=16 \
  --platform="ont" \
  --model_path="/path/to/models/ont" \
  --output="/path/to/output_dir"
```

### ONT Signal-Aware Calling (v2.0.0+)
If using ONT data basecalled with Dorado (using `--emit-moves`), enable dwelling time features for improved accuracy:

```bash
run_clair3.py \
  --bam_fn=input.bam \
  --ref_fn=ref.fa \
  --threads=16 \
  --platform="ont" \
  --model_path="/path/to/pytorch_models/ont" \
  --output="/path/to/output_dir" \
  --enable_dwell_time
```

### GPU Acceleration
Clair3 supports GPU execution on Linux and Apple Silicon, providing up to a 5x speedup. Ensure you are using the GPU-specific Docker image or have the appropriate environment set up.

```bash
# Example using the GPU-enabled script/environment
run_clair3.py [options] --enable_gpu
```

## Expert Tips and Best Practices

### Handling Targeted/Amplicon Data
Standard Clair3 workflows split the genome into chunks for parallelization. For targeted sequencing or amplicons, this can be inefficient. Disable splitting to improve speed:
- Use `--chunk_num=-1` to process the data without splitting.
- Increase mpileup read coverage limits for high-depth amplicons (Clair3 supports up to 2^20 coverage).

### Output Formats
- **GVCF:** To generate a Genomic VCF (useful for joint calling), ensure the `--gvcf` flag is used.
- **Contig Headers:** Use `--output_all_contigs_in_gvcf_header` if you need all reference contigs listed in the header regardless of coverage.

### Edge Case Calling
By default, variant calling is restricted at the very ends of sequences due to alignment unreliability. If you must call variants in these regions:
- Use `--enable_variant_calling_at_sequence_head_and_tail` to enable calling within the first/last 16bp. Use with caution as false positive rates may increase.

### Performance Tuning
- **Threads:** Match `--threads` to your available CPU cores.
- **Memory:** For high-coverage samples, monitor memory usage. Version 1.0.7+ includes memory guards for full-alignment C implementations to prevent crashes.
- **CRAM Input:** If using CRAM, ensure the reference is cached or provided correctly, as Clair3 supports reference caching for CRAM.

## Reference documentation
- [Clair3 GitHub Repository](./references/github_com_HKU-BAL_Clair3.md)
- [Bioconda Clair3 Overview](./references/anaconda_org_channels_bioconda_packages_clair3_overview.md)