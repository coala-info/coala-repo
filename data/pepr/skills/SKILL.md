---
name: pepr
description: PePr (Peak-calling and Prioritization) is a specialized pipeline designed to handle biological replicates in ChIP-Seq experiments.
homepage: https://github.com/shawnzhangyx/PePr/
---

# pepr

## Overview

PePr (Peak-calling and Prioritization) is a specialized pipeline designed to handle biological replicates in ChIP-Seq experiments. Instead of merging replicates, PePr models the read counts across replicates using a negative binomial distribution. This approach allows the tool to prioritize regions with consistent signals and lower variability. It supports both sharp peaks (e.g., transcription factors) and broad peaks (e.g., histone modifications) and provides built-in functionality for differential binding analysis.

## Common CLI Patterns

### Basic Peak-Calling
To call peaks for a single group with replicates and input controls:
```bash
PePr -c chip_rep1.bam,chip_rep2.bam -i input_rep1.bam,input_rep2.bam -f bam -n experiment_name
```

### Differential Binding Analysis
To compare two groups (each with replicates and inputs):
```bash
PePr -c g1_chip1.bam,g1_chip2.bam -i g1_input1.bam,g1_input2.bam --chip2 g2_chip1.bam,g2_chip2.bam --input2 g2_input1.bam,g2_input2.bam -f bam --diff -n diff_analysis
```

### Handling Different Peak Types
PePr defaults to broad peaks. For transcription factors or other narrow signals, specify the peak type:
```bash
PePr -c chip.bam -i input.bam -f bam --peaktype sharp
```

### Using Pre-estimated Parameters
If you have already run `PePr-preprocess` or have a custom parameter file:
```bash
PePr -p parameter_file.txt
```

## Expert Tips and Best Practices

- **File Sorting**: For paired-end data (`sampe` or `bampe`), files **must** be sorted by read name rather than genomic coordinates. Use `samtools sort -n` before running PePr.
- **Normalization Selection**: 
    - Use the default `intra-group` for standard peak-calling.
    - Use `inter-group` for differential analysis when you expect substantial peak overlap between groups.
    - If comparing a wild-type to a knockout (where peaks may be entirely absent in one group), switch to `intra-group` normalization even for differential analysis.
- **Duplicate Reads**: By default, PePr does not remove duplicates. Use `--keep-max-dup [N]` to limit the number of duplicated reads at a single position if PCR bias is a concern.
- **Memory Management**: The `PePr-postprocess` tool is memory-intensive as it loads all reads. If running on a machine with limited RAM, provide only a subset of the ChIP/input files (2-3) to the post-processing step; this is often sufficient for shape-based filtering.
- **Parallelization**: Use `--num-processors` to speed up the sliding window calculations on multi-core systems.
- **Input Directory**: When using `--input-directory`, ensure you provide an absolute path to avoid issues with relative path resolution during the pipeline execution.

## Reference documentation
- [PePr GitHub Repository](./references/github_com_shawnzhangyx_PePr.md)
- [Bioconda PePr Overview](./references/anaconda_org_channels_bioconda_packages_pepr_overview.md)