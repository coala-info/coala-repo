---
name: catch
description: CATCH generates optimal oligonucleotide probe sets for capture-based sequencing by processing diverse, unaligned genomic sequences. Use when user asks to design probes for targeted sequencing, generate probe sets for large-scale viral diversity, or optimize probe pools across multiple taxa within a fixed size.
homepage: https://github.com/broadinstitute/catch
---


# catch

## Overview
CATCH (Compact Aggregation of Targets for Comprehensive Hybridization) is a specialized bioinformatics tool designed to generate optimal oligonucleotide probe sets. Unlike simple tiling approaches, CATCH can process large collections of unaligned, diverse sequences—such as all known variants of a viral species—and produce a minimal set of probes that guarantees coverage of that diversity. It is an essential tool for researchers developing capture-based sequencing assays who need to balance exhaustive target enrichment with practical constraints like array size or cost.

## Core Workflows

### 1. Standard Probe Design
Use `design.py` for most standard applications where you have a specific set of target sequences and want to generate probes with cautious default parameters.

```bash
design.py [dataset] -pl [probe_length] -ps [probe_stride] -m [mismatches] -l [l_target] -o [output_file]
```
*   **Dataset**: Typically a FASTA file or a path to a collection of sequences.
*   **Hybridization Criteria**: Defined by `-m` (allowed mismatches) and `-l` (length of the match).

### 2. Large-Scale Diversity Design
For large, highly diverse inputs (e.g., thousands of genomes), use `design_large.py`. This script uses more pragmatic defaults to manage computational resources (runtime and memory) more efficiently than the standard design script.

```bash
design_large.py [dataset] [options]
```

### 3. Pooling and Optimization
Use `pool.py` when you need to design a probe set that covers multiple taxa or species simultaneously while staying within a specific total probe count (e.g., a fixed array size).

```bash
pool.py [taxa_configs] --limit-probes [max_number] -o [output_file]
```

## Expert Tips and Best Practices

*   **Environment Management**: Always run CATCH within a dedicated conda environment to avoid dependency conflicts with NumPy and SciPy.
    ```bash
    conda create -n catch python=3.8
    conda activate catch
    pip install -e .
    ```
*   **Background Avoidance**: Use the avoidance parameters to prevent the design of probes that might hybridize with non-target sequences (like host DNA).
*   **Weighting Sensitivity**: When pooling multiple species, you can weight the sensitivity for different taxa to ensure that rarer or more critical targets receive better coverage within the probe limit.
*   **Testing Designs**: Before committing to a large synthesis, use the `unittest` framework to verify the installation and basic logic: `python -m unittest discover`.
*   **Input Preparation**: CATCH accepts unaligned sequences. You do not need to perform a multiple sequence alignment (MSA) before running the tool, which significantly simplifies the workflow for highly diverse viral genomes.



## Subcommands

| Command | Description |
|---------|-------------|
| design.py | Design probes for targeted sequencing experiments. |
| design_large.py | Design probes for target genomes. |
| pool.py | Optimizes parameter values for probe design based on probe counts and constraints. |

## Reference documentation
- [CATCH GitHub README](./references/github_com_broadinstitute_catch_blob_master_README.md)
- [Design Script Documentation](./references/github_com_broadinstitute_catch_blob_master_bin_design.py.md)
- [Large-Scale Design Documentation](./references/github_com_broadinstitute_catch_blob_master_bin_design_large.py.md)
- [Pooling and Optimization Documentation](./references/github_com_broadinstitute_catch_blob_master_bin_pool.py.md)