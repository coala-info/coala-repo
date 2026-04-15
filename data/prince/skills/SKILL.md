---
name: prince
description: PRINCE approximates the copy number of tandem repeats directly from FastQ files using a k-mer based recruitment strategy. Use when user asks to estimate VNTR copy numbers, query samples against existing models, or train new boosting models for specific organisms.
homepage: https://github.com/WGS-TB/PythonPrince
metadata:
  docker_image: "quay.io/biocontainers/prince:2.3--py_0"
---

# prince

## Overview
PRINCE (PythonPRINCE) is a specialized bioinformatics tool that approximates the copy number of tandem repeats directly from FastQ files. It utilizes a k-mer based recruitment strategy and coverage adjustments to provide rapid VNTR estimations. This skill provides the necessary command-line patterns for querying existing models or training new ones for specific organisms.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::prince
```

## Core Workflows

### Querying Samples
To estimate copy numbers for a set of samples, you must first create a `target_file` (e.g., `samples.txt`). This text file should contain the paths to your FastQ files, one sample per line.

**Target File Format:**
- For single-end: `path/to/sample.fastq.gz`
- For paired-end: Specify only the prefix or one of the files (e.g., `sample_1.fq` and `sample_2.fq` can be listed as `sample_`).

**Execution:**
```bash
prince -tf samples.txt -to output_results.txt
```

### Parallel Execution
PRINCE supports multi-core processing, which is highly recommended for large datasets:
```bash
prince -tf samples.txt -to output_results.txt -np 16
```

### Custom Training
If working with a species other than *M. tuberculosis*, or if you have specific simulated data, you can generate a new boosting model.

1. **Create a training list** (`training_samples.txt`):
   Each line should contain the path to the simulated genome reads followed by the known copy number.
   ```text
   genome_1_copy 1
   genome_2_copies 2
   ```

2. **Generate the model**:
   ```bash
   prince -bf training_samples.txt -bo custom_model.txt
   ```

3. **Apply the custom model to queries**:
   ```bash
   prince -tf samples.txt -to output.txt -bo custom_model.txt
   ```

## Command Line Arguments Reference
- `-tf`: Path to the text file containing target FastQ paths.
- `-to`: Path for the output file containing predicted copy numbers.
- `-bo`: Path to the training data/model (input for queries, output for training).
- `-tmp`: Path to VNTR templates (defaults to M.TB).
- `-k`: K-mer size used during read recruitment.
- `-p`: Primers/flanking sequences used for coverage adjustments.
- `-np`: Number of processor cores to use.

## Expert Tips
- **Default Templates**: PRINCE is pre-configured for *Mycobacterium tuberculosis*. If analyzing other organisms, you must provide custom templates using the `-tmp` flag.
- **Memory Management**: While `-np` increases speed, ensure the system has sufficient RAM to handle multiple concurrent k-mer recruitment processes.
- **Input Validation**: Ensure FastQ paths in your `target_file` are absolute or correctly relative to the directory where the command is executed.

## Reference documentation
- [PRINCE GitHub Repository](./references/github_com_WGS-TB_PythonPRINCE.md)
- [Bioconda Prince Overview](./references/anaconda_org_channels_bioconda_packages_prince_overview.md)