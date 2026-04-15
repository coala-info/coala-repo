---
name: inspector
description: Inspector evaluates de novo genome assembly quality by identifying structural and base-level errors using long reads. Use when user asks to evaluate assembly quality, detect structural or small-scale errors in contigs, or perform error correction on assemblies.
homepage: https://github.com/ChongLab/Inspector
metadata:
  docker_image: "quay.io/biocontainers/inspector:1.3.1--hdfd78af_1"
---

# inspector

## Overview
Inspector is a specialized tool for assessing the quality of de novo genome assemblies. Unlike many evaluators that require a high-quality reference genome, Inspector primarily uses the original long reads to detect inconsistencies between the reads and the assembled contigs. It identifies structural errors (expansions, collapses, inversions, and haplotype switches) and small-scale base errors. It also includes a correction module that uses local assembly to fix identified errors, significantly improving assembly accuracy.

## Core Workflows

### Assembly Evaluation
The primary command is `inspector.py`. You must provide the contigs and the raw reads used for the assembly.

**Basic Evaluation (Reference-Free):**
```bash
# For PacBio HiFi reads
inspector.py -c contigs.fa -r reads.fastq.gz -o output_dir --datatype hifi

# For Oxford Nanopore reads
inspector.py -c contigs.fa -r reads.fastq.gz -o output_dir --datatype nanopore

# For PacBio CLR (Raw) reads
inspector.py -c contigs.fa -r reads.fastq.gz -o output_dir --datatype clr
```

**Reference-Based Evaluation:**
If a related reference genome is available, Inspector can perform comparative analysis. Note that reported errors in this mode may include true genetic variants.
```bash
inspector.py -c contigs.fa -r reads.fastq.gz --ref reference.fa -o output_dir --datatype hifi
```

### Error Correction
After running the evaluation, use `inspector-correct.py` to fix the detected errors. This module requires `Flye` to be installed for local assembly.

```bash
inspector-correct.py -i evaluation_output_dir/ --datatype pacbio-hifi -o corrected_output_dir/
```

## Command Line Options & Best Practices

### Key Parameters for `inspector.py`
- `--datatype` (`-d`): Critical for error detection sensitivity. Options: `clr`, `hifi`, `nanopore`, `mixed`.
- `--min_contig_length`: Contigs shorter than this (default 10,000bp) are ignored.
- `--pvalue`: Threshold for small-scale error identification. Default is `0.01` for HiFi and `0.05` for others. Lowering this reduces false positives but may miss real errors.
- `--thread` (`-t`): Set based on available CPU cores (default 8).

### Optimization Tips
- **Skip Steps**: If re-running an analysis in the same directory to tweak error detection parameters, use `--skip_read_mapping` to save significant time by reusing existing BAM files.
- **Mixed Data**: If you have reads from multiple platforms, use `--datatype mixed` and provide all files to the `-r` argument.
- **Memory Requirements**: For large genomes (e.g., Human), ensure the system has at least 128GB of RAM.

## Interpreting Results
The output directory contains several key files:
- `summary_statistics`: The main report containing N50, mapping rate, error counts, and QV scores.
- `structural_error.bed`: Coordinates and types of large-scale errors.
- `small_scale_error.bed`: Coordinates of base-level errors (SNVs/Indels).
- `read_to_contig.bam`: The alignment file used for the evaluation, useful for manual inspection in IGV.



## Subcommands

| Command | Description |
|---------|-------------|
| inspector-correct.py | Assembly error correction based on Inspector assembly evaluation |
| inspector.py | de novo assembly evaluator |

## Reference documentation
- [Inspector README](./references/github_com_ChongLab_Inspector_blob_master_README.md)
- [Inspector Main Script Documentation](./references/github_com_ChongLab_Inspector_blob_master_inspector.py.md)
- [Error Correction Module Documentation](./references/github_com_ChongLab_Inspector_blob_master_inspector-correct.py.md)