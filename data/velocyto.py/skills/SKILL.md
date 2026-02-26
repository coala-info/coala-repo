---
name: velocyto.py
description: Velocyto.py is a bioinformatics tool that estimates RNA velocity by analyzing unspliced to spliced mRNA ratios in single-cell RNA-seq data. Use when user asks to estimate RNA velocity, process single-cell RNA-seq alignment data, quantify unspliced and spliced mRNA, or generate Loom files from 10x Genomics, Smart-seq2, Drop-seq, or generic BAM files.
homepage: https://github.com/velocyto-team/velocyto.py
---


# velocyto.py

## Overview

`velocyto.py` is a specialized bioinformatics tool used to estimate RNA velocity—the rate of change in gene expression—by analyzing the ratio of unspliced to spliced mRNA in single-cell RNA-seq datasets. This skill assists in the initial quantification phase, where raw alignment data (BAM files) are processed into Loom files containing the necessary count matrices. It is most effective when preparing data from 10x Genomics, Smart-seq2, or Drop-seq platforms for trajectory and kinetic analysis.

## Installation and Environment

Install the package via Conda from the Bioconda channel:

```bash
conda install -c bioconda velocyto.py
```

**Critical Dependencies:**
*   **samtools:** Must be installed and available in your system PATH.
*   **loompy:** Required for creating and manipulating the output `.loom` files.
*   **Python Version:** Best maintained on Python 3.6–3.10; newer versions (3.11+) may encounter Cython or NumPy compatibility issues.

## Common CLI Patterns

### 1. Processing 10x Genomics Data
The `run10x` command is a wrapper designed to work directly with the output directory structure of CellRanger.

```bash
velocyto run10x -m repeat_masker.gtf /path/to/sample_folder/ /path/to/genes.gtf
```
*   **sample_folder:** The directory containing the `outs` folder from CellRanger.
*   **-m (mask):** Highly recommended. A GTF file containing expressed repetitive elements (e.g., from UCSC Genome Browser) to mask, which reduces noise in unspliced counts.

### 2. Generic BAM Processing (Standard Mode)
Use the `run` command for non-10x data or custom pipelines where you have a BAM file and a list of cell barcodes.

```bash
velocyto run -b barcodes.txt -o output_dir -m mask.gtf input.bam annotation.gtf
```
*   **-b:** A text file containing valid cell barcodes (one per line).
*   **-o:** Output directory for the resulting `.loom` file.

### 3. Platform-Specific Commands
*   **Smart-seq2:** `velocyto run-smartseq2 [options] [bam_files]`
*   **Drop-seq:** `velocyto run-dropest [options] [dropest_directory]`

## Expert Tips and Best Practices

*   **Maintenance Warning:** The `velocyto.py` repository is no longer actively maintained. For modern, high-performance workflows, consider using **STARSolo** (part of the STAR aligner), which can generate velocyto-compatible Spliced/Unspliced/Ambiguous matrices much faster during the alignment step.
*   **Memory Management:** `velocyto` can be memory-intensive. If processing large BAM files, ensure you have significant RAM (64GB+) or use the `-t` (logic type) and `--samtools-memory` flags to manage resource allocation.
*   **GTF Compatibility:** Ensure your annotation GTF matches the one used for initial alignment. Discrepancies in chromosome naming (e.g., "chr1" vs "1") will result in empty output matrices.
*   **Logic Types:** The default logic is `Intervals`. For specific chemistries or if you encounter unexpected counting behavior, check the `--logic` parameter documentation to switch between `UMI` or `Forward` strand logic.
*   **Validation:** After running, check the `.loom` file using `loompy`. A successful run should show three layers: `spliced`, `unspliced`, and `ambiguous`.

## Reference documentation
- [velocyto.py Overview](./references/anaconda_org_channels_bioconda_packages_velocyto.py_overview.md)
- [GitHub Repository Home](./references/github_com_velocyto-team_velocyto.py.md)
- [Known Issues and Troubleshooting](./references/github_com_velocyto-team_velocyto.py_issues.md)