---
name: scexecute
description: scexecute splits a single-cell BAM file by cell barcodes and executes a specified command on each resulting subset. Use when user asks to split BAM files by barcode, run commands on individual cell subsets, or process single-cell data using tools that are not natively single-cell aware.
homepage: https://github.com/HorvathLab/NGS/tree/master/SCExecute#readme
metadata:
  docker_image: "quay.io/biocontainers/scexecute:1.3.3--hdfd78af_0"
---

# scexecute

## Overview
The `scexecute` tool bridges the gap between aggregate single-cell BAM files and cell-level analysis. It automates the tedious process of splitting a large BAM file by cell barcodes and running a specific command on each resulting subset. This is essential for tasks where you need to treat each cell as an independent sample for downstream tools that are not natively single-cell aware.

## Usage Patterns

### Basic Command Structure
The core syntax requires an input BAM, a list of barcodes, and the command you wish to execute on each barcode-stratified subset.

```bash
scexecute-run --bam input.bam --barcode-file barcodes.txt --command "your_command_here"
```

### Common CLI Arguments
- `--bam`: Path to the aggregate, aligned single-cell BAM file (must be indexed).
- `--barcode-file`: A text file containing the list of cell barcodes to process (one per line).
- `--barcode-tag`: The BAM tag identifying the cell barcode (defaults to `CB` in most 10x Genomics pipelines).
- `--command`: The specific tool or script to run on each split BAM. Use the placeholder `@BAM` within the command string to represent the path to the temporary barcode-specific BAM file.
- `--output-dir`: Directory where the results of the executed commands will be stored.

### Expert Tips
- **Placeholder Usage**: Always use the `@BAM` placeholder in your `--command` string. `scexecute` replaces this with the actual path of the temporary BAM file it creates for the current barcode.
- **Resource Management**: Since `scexecute` can spawn many processes, ensure your environment has sufficient file descriptors and memory if running complex commands on thousands of cells.
- **Indexing**: Ensure your input BAM file is indexed (`.bai` file exists) before running, as the tool relies on rapid coordinate-based access to extract barcode data.

## Reference documentation
- [scexecute Overview](./references/anaconda_org_channels_bioconda_packages_scexecute_overview.md)
- [SCExecute Source and Documentation](./references/github_com_HorvathLab_NGS_tree_master_SCExecute.md)