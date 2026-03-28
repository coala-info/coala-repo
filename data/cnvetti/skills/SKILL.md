---
name: cnvetti
description: "CNVetti is a toolkit designed for clinical copy number variation calling using BAM and BCF files. Use when user asks to call CNVs, build genomic models, extract coverage, normalize data, or convert coverage files for visualization in IGV."
homepage: https://github.com/bihealth/cnvetti
---


# cnvetti

## Overview

CNVetti is a robust and efficient toolkit designed for clinical CNV calling. It operates primarily on BAM and BCF files to identify genomic copy number changes. The tool is structured into high-level "quick" workflows for rapid calling and low-level "cmd" operations for fine-grained control over the pipeline stages. It is particularly effective for "Within-Sample" (WIS) calling, which utilizes sample-specific models to improve calling accuracy by accounting for local biases.

## Command Line Usage and Workflows

CNVetti uses a hierarchical command structure: `cnvetti <category> <subcommand>`.

### Within-Sample (WIS) Calling Workflow
The WIS approach is the preferred method for robust calling. It involves two primary steps:

1.  **Build the Model**: Create a baseline model from your alignment data.
    ```bash
    cnvetti quick wis-build-model [options] <input.bam>
    ```
2.  **Call CNVs**: Execute the calling process using the BAM and the generated model BCF.
    ```bash
    cnvetti quick wis-call [options] <input.bam> <model.bcf>
    ```

### Atomic Pipeline Commands (`cmd`)
For custom pipelines, use the `cmd` subcommands to process data sequentially:

*   **Coverage Extraction**: Generate genome-wide or target-wise fragment counts.
    ```bash
    cnvetti cmd coverage <input.bam>
    ```
*   **Normalization**: Adjust coverage values based on total coverage or GC-wise median to remove systematic biases.
    ```bash
    cnvetti cmd normalize <input.bcf>
    ```
*   **Merging**: Combine multiple coverage BCF files into a single dataset.
    ```bash
    cnvetti cmd merge-cov <input1.bcf> <input2.bcf> ...
    ```
*   **Model-Based Coverage**: Compute coverage values relative to a specific model.
    ```bash
    cnvetti cmd mod-cov <input.bcf> <model.bcf>
    ```

### Visualization and Export
To inspect results in external tools like the Integrative Genomics Viewer (IGV), convert the internal BCF coverage format:

```bash
cnvetti visualize cov-to-igv <input.bcf>
```

## Expert Tips and Best Practices

*   **OS Compatibility**: Ensure you are running on a Linux environment, as this is the only supported operating system.
*   **Data Formats**: CNVetti relies heavily on the BCF format for intermediate coverage and model files. Ensure `bcftools` is available in your environment for manual inspection of these files if needed.
*   **Normalization Choice**: Use GC-wise median normalization when dealing with samples known to have significant GC-content bias, which is common in many HTS library preparation protocols.
*   **Log Transformation**: Note that CNVetti writes log2-transformed coverage values to the `COV2` field in output BCFs, which is the standard for identifying gains and losses.



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Perform annotate called CNV result BCF files |
| cmd | Low-level access to the CNVetti primitives. This section of commands provides access to the individual, atomic steps of CNVetti. |
| quick | Easy-to-use shortcuts for command and important use cases. |
| visualize | Visualization of coverage information (on-target, off-target, and genome-wide bins). This visualization command allows to extract coverage information tracks in IGV format from (target) coverage BCF files. |

## Reference documentation
- [CNVetti README](./references/github_com_bihealth_cnvetti_blob_master_README.md)
- [CNVetti CHANGELOG](./references/github_com_bihealth_cnvetti_blob_master_CHANGELOG.md)