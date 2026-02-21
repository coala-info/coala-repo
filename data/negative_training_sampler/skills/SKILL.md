---
name: negative_training_sampler
description: The `negative_training_sampler` is a specialized tool for genomic data preprocessing.
homepage: https://github.com/kircherlab/negative_training_sampler
---

# negative_training_sampler

## Overview
The `negative_training_sampler` is a specialized tool for genomic data preprocessing. In many bioinformatics tasks, GC content is a significant confounding factor that can lead to biased machine learning models. This tool addresses that by taking a set of labeled genomic coordinates (BED format) and performing distribution-matching sampling. It calculates the GC content of all provided regions using a reference genome and then selects a subset of negative samples (labeled 0) that mirrors the GC profile of the positive samples (labeled 1) for every chromosome.

## Installation and Dependencies
The tool relies on `pybedtools`, which requires a functional installation of `bedtools` on your system path.

- **Conda**: `conda install -c bioconda negative_training_sampler`
- **Pip**: `pip install negative_training_sampler` (requires manual installation of `bedtools`)

## Core CLI Usage
The basic command requires a labeled BED file, a reference FASTA, and a genome file (tab-delimited file with chromosome names and lengths).

```bash
negative_training_sampler \
  -i labeled_regions.bed \
  -r reference.fasta \
  -g hg38.genome \
  -o balanced_output.tsv
```

### Key Options
- `-i, --label-file`: Input BED file. Must contain at least `chrom`, `start`, `end`, and a `label` column (0 or 1).
- `-n, --label_num`: If your file has multiple label columns, specify which one to use (Default: 1).
- `--seed`: Set an integer seed to ensure reproducible sampling across runs.
- `--precision`: Set the number of decimal places for GC content calculation.
- `-c, --bgzip`: Use this flag to compress the output directly into bgzip format.

## Expert Tips and Best Practices

### 1. Minimize Sampling Bias
For the most accurate GC matching, ensure that all genomic windows in your input BED file are of the same size. Using variable-length windows can introduce length-based biases that the GC sampling cannot fully correct.

### 2. Performance Optimization
The tool uses Dask for parallel processing. For large-scale genomic datasets, explicitly define resource allocation to prevent memory overflows:
- Use `--cores [INT]` to specify parallel threads.
- Use `--memory [INT]GB` to define memory limits per core (e.g., `--cores 4 --memory 4GB` allocates 16GB total).

### 3. Input Format Requirements
While the tool supports standard BED fields (up to 12), it requires numerical binary labels (0.0 and 1.0). A minimal input should look like this:
```text
chr1    10000    10500    0.0
chr1    20000    20500    1.0
```

### 4. Handling Output
By default, the tool writes to `stdout`. If you do not provide the `-o` flag, you should pipe the output to a file or a downstream processor. The output includes all original BED columns plus a new `gc` column containing the calculated GC percentage.

## Reference documentation
- [Main README and Usage Guide](./references/github_com_kircherlab_negative_training_sampler.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_negative_training_sampler_overview.md)