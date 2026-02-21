---
name: deepchopper
description: DeepChopper is a specialized tool for bioinformaticians working with Nanopore Direct RNA-seq.
homepage: https://github.com/ylab-hi/DeepChopper
---

# deepchopper

## Overview

DeepChopper is a specialized tool for bioinformaticians working with Nanopore Direct RNA-seq. It utilizes a genomic language model to pinpoint chimera artifacts—sequences where two or more distinct RNA molecules are joined together during the sequencing process. By identifying these junctions, DeepChopper allows for "chopping" the reads into their constituent parts, ensuring more accurate downstream analysis such as transcript quantification or isoform detection.

## Core Workflow

Starting with version 1.3.0, the workflow has been simplified to a two-step process. The previous `encode` step is deprecated and should no longer be used.

### 1. Predict Artifacts
The `predict` command scans your FASTQ files and generates prediction files identifying potential chimera junctions.

```bash
# Basic prediction
deepchopper predict input.fastq --output predictions_dir

# Using GPU acceleration (highly recommended for large datasets)
deepchopper predict input.fastq --output predictions_dir --gpus 2

# Supports compressed files directly
deepchopper predict sample.fastq.gz --output predictions_dir
```

### 2. Chop Sequences
The `chop` command uses the output from the prediction step to split the original sequences at the identified artifact points.

```bash
# The prediction file is typically found within the output directory (e.g., index 0)
deepchopper chop predictions_dir/0 input.fastq
```

## Command Reference and Tips

### CLI Commands
- `deepchopper predict`: Analyzes FASTQ files for artificial sequences.
- `deepchopper chop`: Splits chimeric reads based on prediction results.
- `deepchopper web`: Launches a local web interface. Note that the web version is intended for quick tests and is limited to processing one FASTQ record at a time.

### Best Practices
- **File Formats**: DeepChopper automatically detects `.fastq`, `.fq`, `.fastq.gz`, and `.fq.gz`. There is no need to manually decompress files before processing.
- **Hardware**: For production-scale sequencing runs, always use the `--gpus` flag to significantly reduce processing time.
- **Python Integration**: For custom bioinformatics pipelines, DeepChopper can be imported as a library:
  ```python
  import deepchopper
  model = deepchopper.DeepChopper.from_pretrained("yangliz5/deepchopper")
  ```

## Reference documentation
- [DeepChopper GitHub Repository](./references/github_com_ylab-hi_DeepChopper.md)
- [Bioconda DeepChopper Overview](./references/anaconda_org_channels_bioconda_packages_deepchopper_overview.md)