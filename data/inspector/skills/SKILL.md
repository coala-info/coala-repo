---
name: inspector
description: Inspector is a reference-free assembly evaluator designed specifically for long-read sequencing data.
homepage: https://github.com/ChongLab/Inspector
---

# inspector

## Overview
Inspector is a reference-free assembly evaluator designed specifically for long-read sequencing data. It works by mapping raw reads back to the assembled contigs to identify discrepancies that indicate misassemblies or base-level errors. Beyond simple statistics, it provides a detailed list of structural errors (like inversions or translocations) and small-scale errors (SNVs and indels), and includes a dedicated module to correct these errors using local re-assembly.

## Installation and Setup
Install via Bioconda for the most reliable dependency management:
```bash
conda install -c bioconda inspector
```
Key dependencies include `minimap2`, `samtools`, `pysam`, and `flye` (required for the error correction module).

## Evaluation Workflow
The primary script is `inspector.py`. You must provide the contigs, the raw reads, an output directory, and the specific data type.

### Basic Evaluation Patterns
Evaluate a HiFi assembly:
```bash
inspector.py -c contigs.fa -r reads.fastq.gz -o output_dir/ --datatype hifi
```

Evaluate a Nanopore assembly using multiple threads:
```bash
inspector.py -c contigs.fa -r reads.fastq.gz -o output_dir/ --datatype nanopore -t 16
```

### Reference-based Evaluation
If a reference genome is available, Inspector can perform comparative analysis. Note that reported errors in this mode may include genuine genetic variants:
```bash
inspector.py -c contigs.fa -r reads.fastq.gz --ref reference.fa -o output_dir/ --datatype clr
```

### Continuity Analysis Only
To generate assembly statistics (N50, total length) without performing read mapping or error detection:
```bash
inspector.py -c contigs.fa -r empty_file -o output_dir/ --skip_base_error --skip_structural_error
```

## Error Correction Workflow
After running the evaluation, use `inspector-correct.py` to improve the assembly. This module uses `Flye` for local assembly of error-prone regions.

### Correcting a HiFi Assembly
```bash
inspector-correct.py -i evaluation_output_dir/ --datatype pacbio-hifi -o correction_out/
```

## Expert Tips and Best Practices
- **Memory Requirements**: Inspector is resource-intensive. For large genomes (e.g., human), ensure the system has at least 128GB of RAM.
- **Data Types**: Always specify the correct `--datatype`. Options include `clr`, `hifi`, `nanopore`, or `mixed`.
- **Correction Constraints**: The error correction module only supports reads from a single platform. Do not use `mixed` data for the correction step.
- **P-value Adjustment**: For high-coverage or very high-accuracy data, you can adjust the sensitivity of small-scale error detection using `--pvalue` (default is 0.01 for HiFi, 0.05 for others).
- **Output Interpretation**: 
    - `summary_statistics`: Check this first for QV scores and total error counts.
    - `structural_error.bed`: Use this to visualize large-scale misassemblies in a genome browser like IGV.

## Reference documentation
- [Inspector GitHub Repository](./references/github_com_ChongLab_Inspector.md)
- [Bioconda Inspector Overview](./references/anaconda_org_channels_bioconda_packages_inspector_overview.md)