---
name: pydownsampler
description: pydownsampler is a bioinformatics utility used to reduce the depth of sequence alignment files to a specific target coverage level. Use when user asks to downsample BAM, CRAM, or SAM files to a precise depth or check the current coverage of an alignment file.
homepage: https://github.com/LindoNkambule/pydownsampler
metadata:
  docker_image: "quay.io/biocontainers/pydownsampler:1.0--py_0"
---

# pydownsampler

## Overview

pydownsampler is a bioinformatics utility designed to simplify the process of reducing the depth of sequence alignment files. While many tools perform random read sampling, pydownsampler allows users to target a specific coverage level (e.g., 10X), ensuring that the resulting file meets precise depth requirements for downstream analysis. It supports the standard alignment formats used in genomics, including SAM, BAM, and CRAM.

## Installation

The tool can be installed via Conda or Pip:

```bash
# Via Bioconda
conda install bioconda::pydownsampler

# Via Pip
pip install pydownsampler
```

## Command Line Usage

### Checking Coverage
Before downsampling, it is best practice to determine the current coverage of your file.
```bash
pydownsampler input.bam -c
```

### Downsampling to a Target Depth
To downsample a file to a specific coverage (e.g., 10X), use the `-d` flag.
```bash
# Basic usage (outputs to input.Downsampled10X.bam)
pydownsampler input.bam -d 10

# Specifying a custom output prefix
pydownsampler input.bam -d 10 -o my_downsampled_file
```

### Arguments and Options
- `<file>`: The input BAM, CRAM, or SAM file.
- `-d, --downcoverage`: The target coverage depth (Required for downsampling).
- `-o, --output`: Optional prefix for the output filename.
- `-c, --coverage`: Flag to check the current file coverage without performing downsampling.
- `-h, --help`: Display the help message.
- `-v, --version`: Display the version information.

## Best Practices and Tips

- **File Formats**: The tool is compatible with BAM, CRAM, and SAM. For large-scale data, BAM or CRAM are recommended over SAM for performance and storage efficiency.
- **Output Naming**: By default, the tool appends `.Downsampled[Depth]X.bam` to the original filename. Use the `-o` flag if you need to follow a specific naming convention for your pipeline.
- **Workflow Integration**: Use the `-c` command in an initial step to validate that the input file actually has higher coverage than your target `-d` value to avoid unnecessary processing or errors.
- **Indexing**: Ensure your input BAM/CRAM files are indexed (e.g., using `samtools index`) as many alignment processing tools require indices for efficient data access.

## Reference documentation
- [pydownsampler GitHub Repository](./references/github_com_LindoNkambule_pydownsampler.md)
- [pydownsampler Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pydownsampler_overview.md)