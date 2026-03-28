---
name: msisensor
description: "MSIsensor detects replication slippage variants at microsatellite regions and differentiates them as somatic or germline. Use when analyzing tumor-normal paired sequence data to identify microsatellite instability (MSI)."
homepage: https://github.com/ding-lab/msisensor
---

# msisensor

Detects replication slippage variants at microsatellite regions and differentiates them as somatic or germline.
  Use when analyzing tumor-normal paired sequence data to identify microsatellite instability (MSI).
---
## Overview
MSIsensor is a C++ program designed to identify microsatellite instability (MSI) by detecting replication slippage variants within microsatellite regions of DNA. It can differentiate these variants as either somatic (occurring in tumor cells) or germline (inherited). This tool is particularly useful when analyzing paired tumor and normal sequence data to assess MSI status, which is a significant biomarker in cancer research.

## Usage Instructions

MSIsensor analyzes microsatellite regions to detect instability. It typically requires BAM files from paired tumor and normal samples.

### Core Functionality

The primary function of MSIsensor is to compare the length distribution of repeated sequences in tumor samples against normal samples to identify significant deviations indicative of MSI.

### Command-Line Usage

The general command structure involves specifying input BAM files and an output prefix.

```bash
msisensor <command> [options]
```

While the provided documentation does not detail specific subcommands or a comprehensive list of options, the core usage revolves around processing BAM files.

### Input Requirements

*   **Paired Tumor and Normal BAM Files**: MSIsensor is designed to work with paired sequencing data. You will need to provide the paths to both the tumor and normal BAM files.
*   **Reference Genome**: A reference genome is implicitly required for alignment and variant calling, though not explicitly a command-line argument in the provided snippets. Ensure your BAM files are indexed and aligned to a consistent reference.

### Output

MSIsensor generates output files that detail the detected microsatellite variants and their classification (somatic/germline). The exact format and content of these files are not fully detailed in the provided documentation, but they are crucial for downstream analysis of MSI status.

### Expert Tips

*   **Data Quality**: Ensure your BAM files are properly aligned, sorted, and indexed. High-quality input data is critical for accurate MSI detection.
*   **Reference Consistency**: Use the same reference genome for both tumor and normal BAM files.
*   **Parameter Tuning**: While specific parameters are not detailed here, be aware that advanced usage might involve tuning parameters related to window size, minimum variant length, or statistical thresholds. Consult the tool's full documentation if available for these options.
*   **Archived Repository**: Note that the primary repository for `msisensor` (ding-lab/msisensor) has been archived. For the latest developments or support, consider looking for newer versions or related projects like `msisensor-pro` or `msisensor2` as mentioned in the documentation.



## Subcommands

| Command | Description |
|---------|-------------|
| msisensor | homopolymer and miscrosatelite analysis using bam files |
| msisensor msi | Calculate MSI score and distribution |
| msisensor_scan | Scan for homopolymers and microsatellites in a reference genome. |

## Reference documentation
- [MSIsensor Overview](https://anaconda.org/bioconda/msisensor)
- [MSIsensor GitHub Repository](https://github.com/ding-lab/msisensor)