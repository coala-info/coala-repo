---
name: mtnucratio
description: This tool calculates the ratio of mitochondrial to nuclear sequencing reads from a BAM file. Use when user asks to calculate mitochondrial to nuclear read ratio.
homepage: https://github.com/apeltzer/MTNucRatioCalculator
---


# mtnucratio

---
## Overview
The mtnucratio tool is designed to compute the ratio of mitochondrial to nuclear sequencing reads. This is a crucial metric in next-generation sequencing (NGS) analysis, particularly for understanding the proportion of mitochondrial DNA present in a biological sample. It primarily operates on BAM files, which contain aligned sequencing reads.

## Usage Instructions

The `mtnucratio` tool is a command-line utility. The primary function is to calculate the ratio of MT to nuclear reads.

### Core Functionality

The tool takes a BAM file as input and outputs the calculated MT to Nuclear ratio.

**Basic Usage:**

```bash
mtnucratio <input.bam>
```

This command will process the specified BAM file and print the MT to Nuclear ratio to standard output.

### Input Requirements

*   **BAM File**: A valid BAM (Binary Alignment Map) file containing aligned sequencing reads. This file should be indexed if the tool requires random access, though the provided documentation doesn't explicitly state this requirement for the core ratio calculation.

### Output

The tool outputs a single numerical value representing the MT to Nuclear ratio.

### Expert Tips and Best Practices

*   **Input File Preparation**: Ensure your BAM file is properly sorted and indexed if required by the underlying alignment or processing steps that generated it. While not explicitly stated for `mtnucratio` itself, this is a general best practice for BAM file manipulation.
*   **Understanding the Ratio**: The MT to Nuclear ratio can be influenced by various factors, including sample preparation, library type, and the biological state of the sample. Interpret the ratio in the context of your experimental design.
*   **Version Management**: When using `mtnucratio`, especially in reproducible research, it's advisable to note the specific version used. The tool is available via Conda (`conda install bioconda::mtnucratio`), which helps in managing versions.

## Reference documentation
- [MTNucRatioCalculator Overview](./references/anaconda_org_channels_bioconda_packages_mtnucratio_overview.md)
- [MTNucRatioCalculator GitHub Repository](./references/github_com_apeltzer_MTNucRatioCalculator.md)