---
name: clairvoyante
description: Clairvoyante is a multi-task convolutional neural network (CNN) designed for sensitive and accurate variant calling.
homepage: https://github.com/aquaskyline/Clairvoyante
---

# clairvoyante

## Overview
Clairvoyante is a multi-task convolutional neural network (CNN) designed for sensitive and accurate variant calling. While it supports Illumina data, it is specifically optimized to handle the higher error rates of Single Molecule Sequencing. It predicts variant type, zygosity, alternative alleles, and Indel lengths simultaneously. This skill provides the necessary patterns for environment setup, model utilization, and performance optimization for whole-genome variant calling.

## Installation and Environment Setup
Clairvoyante was originally written for Python 2.7 but includes a compatibility layer for Python 3.

- **Conda Installation**:
  ```bash
  conda create -n clairvoyante-env -c bioconda clairvoyante
  conda activate clairvoyante-env
  ```
- **Python 3 Compatibility**: If using a Python 3 environment, run the fix script:
  ```bash
  python port23.py
  ```
- **TensorFlow Requirements**: 
  - Use the CPU version for variant calling: `pip install tensorflow==1.9.0`
  - Use the GPU version for training new models: `pip install tensorflow-gpu`

## Core Workflow Patterns

### 1. Acquiring Pre-trained Models
Before calling variants, you must download the trained models:
```bash
curl http://www.bio8.cs.hku.hk/trainedModels.tbz | tar -jxf -
```

### 2. Variant Calling from BAM
For standard variant calling from an aligned BAM file, use `callVarBam.py`.
- **Default behavior**: Uses 4 threads.
- **Custom threading**: Use the `--threads` parameter to scale.

```bash
python callVarBam.py --bam_fn input.bam --ref_fn reference.fa --model_prefix ./models/model_name --sample_name sample01 --threads 28 > output.vcf
```

### 3. Parallel Execution
For whole-genome processing, use the parallel wrapper to generate commands for multiple contigs:
```bash
python callVarBamParallel.py --bam_fn input.bam --ref_fn reference.fa --model_prefix ./models/model_name --sample_name sample01 --threads 28
```

## Performance Optimization Tips

### PyPy Speedup
Using the PyPy interpreter instead of standard CPython for data preparation scripts can result in a 5-10x speed increase.
- **Compatible scripts**: `dataPrepScripts/ExtractVariantCandidates.py` and `dataPrepScripts/CreateTensor.py`.
- **Incompatible scripts**: Any script utilizing TensorFlow (e.g., `callVar.py`) must use the standard Python interpreter.

Example PyPy usage:
```bash
pypy dataPrepScripts/ExtractVariantCandidates.py --bam_fn input.bam --ref_fn reference.fa
```

### Hardware Acceleration
- **CPU**: Sufficient for variant calling. Ensure `blosc` is installed for efficient data compression.
- **GPU**: Only required if you are training a new model from scratch.
- **Instruction Sets**: If installation fails on `blosc`, ensure your CPU supports AVX2 or set the `DISABLE_BLOSC_AVX2` environment variable during compilation.

## Common CLI Parameters
- `--threads`: Controls CPU utilization (default is all cores for `callVar.py`, 4 for `callVarBam.py`).
- `--qual`: Set this in `callVarBam.py` to include `PASS` and `LowQual` filter tags in the output VCF.
- `--model_prefix`: The path and prefix of the pre-trained model files.

## Reference documentation
- [Clairvoyante GitHub Repository](./references/github_com_aquaskyline_Clairvoyante.md)
- [Bioconda Clairvoyante Overview](./references/anaconda_org_channels_bioconda_packages_clairvoyante_overview.md)