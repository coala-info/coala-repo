---
name: clairvoyante
description: Clairvoyante is a multi-task convolutional neural network designed for sensitive and accurate variant calling, particularly optimized for Single Molecule Sequencing data. Use when user asks to call variants from BAM files, extract variant candidates, create tensors for training, or process read alignments for genomic analysis.
homepage: https://github.com/aquaskyline/Clairvoyante
---


# clairvoyante

## Overview

Clairvoyante is a multi-task five-layer convolutional neural network (CNN) designed for sensitive and accurate variant calling. While it supports Illumina data, it is specifically optimized for the challenges of Single Molecule Sequencing (SMS), where error rates are significantly higher. It processes read alignments to disentangle subtle details and provides predictions for variant type, zygosity, and Indel length. Use this skill to navigate the tool's data preparation scripts and variant calling submodules.

## Command Line Usage

Clairvoyante uses a submodule invocator pattern via `clairvoyante.py`.

### Core Invocator Pattern
```bash
python clairvoyante.py <SubmoduleName> [Options]
```

### Variant Calling
For standard variant calling from BAM files, use `callVarBam` or its parallelized version:
- **Standard**: `python clairvoyante.py callVarBam --bam_fn <BAM> --ref_fn <REF> --model_prefix <MODEL> --threads 4`
- **Parallel**: `python clairvoyante.py callVarBamParallel --bam_fn <BAM> --ref_fn <REF> --model_prefix <MODEL> --threads <N>`

### Data Preparation
Before training or complex calling, data must be processed into tensors:
1. **Extract Candidates**: `python clairvoyante.py ExtractVariantCandidates [options]`
2. **Create Tensors**: `python clairvoyante.py CreateTensor [options]`
3. **Get Truth**: `python clairvoyante.py GetTruth [options]` (for training sets)

## Expert Tips and Best Practices

### Performance Optimization
- **PyPy Speedup**: Use the PyPy interpreter instead of standard Python for data preparation scripts (like `ExtractVariantCandidates.py` and `CreateTensor.py`). This typically yields a 5-10x speed increase because these modules are independent of TensorFlow.
- **Threading**: `callVar.py` uses all available CPU cores by default, while `callVarBam.py` defaults to 4 threads. Use the `--threads` parameter to manually tune performance based on your hardware.

### Environment and Compatibility
- **Python 3 Support**: Clairvoyante was originally written for Python 2.7. If working in a Python 3 environment, run the included porting script first:
  ```bash
  python port23.py
  ```
- **TensorFlow Versioning**: Ensure TensorFlow ≥ 1.0.0 is installed. Version 1.9.0 is the tested standard for this tool.
- **GPU vs. CPU**: CPU is sufficient for variant calling using pre-trained models. A high-end GPU is only required if you are training new models from scratch.

### Model Management
- **Trained Models**: Ensure you have downloaded the pre-trained models before calling. They are typically provided as a compressed archive (`trainedModels.tbz`) and must be extracted into the working directory.
- **Successor Tool**: For the most up-to-date performance, note that "Clair" is the successor to Clairvoyante, though Clairvoyante remains a robust choice for specific CNN-based research workflows.



## Subcommands

| Command | Description |
|---------|-------------|
| clairvoyante_ExtractVariantCandidates.py | Extract variant candidates from a BAM file for Clairvoyante variant calling. |
| clairvoyante_callVar.py | Call variants using a trained Clairvoyante model |

## Reference documentation
- [Clairvoyante README](./references/github_com_aquaskyline_Clairvoyante_blob_rbDev_README.md)
- [Clairvoyante Submodule Invocator](./references/github_com_aquaskyline_Clairvoyante_blob_rbDev_clairvoyante.py.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_clairvoyante_overview.md)