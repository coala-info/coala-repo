---
name: var-agg
description: This tool combines multiple VCF files into a single aggregated VCF. Use when user asks to combine VCF files, aggregate variants, or merge VCF data.
homepage: https://github.com/bihealth/var-agg
metadata:
  docker_image: "quay.io/biocontainers/var-agg:0.1.1--h2c42bab_0"
---

# var-agg

## Overview

The `var-agg` tool is designed to simplify the process of combining multiple Variant Call Format (VCF) files, typically representing individual samples, into a single "site VCF" file. This is particularly useful for downstream analyses that require a consolidated view of variants across a cohort, such as population genetics studies or variant annotation pipelines. It efficiently merges variant data, allowing for aggregated analysis of genetic variations.

## Usage

The `var-agg` tool is primarily used via its command-line interface. The core functionality involves specifying input VCF files and an output file.

### Basic Aggregation

To aggregate multiple VCF files into a single output VCF:

```bash
var-agg --input <input1.vcf> <input2.vcf> ... --output <output.vcf>
```

Replace `<input1.vcf>`, `<input2.vcf>`, etc., with the paths to your individual sample VCF files. The `--output` flag specifies the name of the aggregated VCF file.

### Advanced Options

While the basic aggregation is straightforward, `var-agg` may offer advanced options for controlling the aggregation process. Consult the tool's help message for specific flags related to:

*   **Frequency Calculation**: Options to control how allele frequencies are computed, especially concerning founder status in pedigree files.
*   **Cohort Handling**: Mechanisms for defining and managing different cohorts within the aggregation process.

To view all available options and their descriptions, run:

```bash
var-agg --help
```

### Best Practices

*   **Input File Order**: While `var-agg` is designed to aggregate, the order of input VCF files might influence the exact representation of certain metadata or the order of samples in the output if not explicitly handled. It's good practice to list them in a consistent, logical order (e.g., by sample ID).
*   **VCF Compatibility**: Ensure all input VCF files are compatible in terms of their structure and the variants they represent. Significant structural differences might lead to unexpected results.
*   **Resource Management**: Aggregating large VCF files can be memory and CPU intensive. Ensure your system has adequate resources, especially when dealing with many samples or large genomes.
*   **Output File**: The output VCF will contain all unique variants found across the input files, with genotype information merged for each sample.

## Reference documentation

* [Overview of var-agg](https://anaconda.org/bioconda/var-agg)
* [var-agg GitHub Repository](https://github.com/bihealth/var-agg)