---
name: bicseq2-seg
description: BICseq2-seg is the segmentation module of the BIC-seq2 pipeline, designed to detect CNVs in high-throughput sequencing data.
homepage: http://compbio.med.harvard.edu/BIC-seq/
---

# bicseq2-seg

## Overview
BICseq2-seg is the segmentation module of the BIC-seq2 pipeline, designed to detect CNVs in high-throughput sequencing data. It applies a Bayesian Information Criterion (BIC) to identify statistically significant changes in read depth across the genome. The tool is highly flexible, allowing for the analysis of individual genomes or the comparison of a case genome against a matched control to filter out germline variations and technical noise.

## Command Line Usage

The primary script is `BICseq2-seg.pl`. It requires a configuration file and an output path.

### Basic Syntax
```bash
BICseq2-seg.pl [options] <configFile> <output>
```

### Configuration File Format
The configuration file must be tab-delimited. The first row is treated as a header and is ignored.

**Case-Only (No Control):**
```text
chromName    binFileNorm
chr1         chr1.norm.bin
chr2         chr2.norm.bin
```

**Case-Control (e.g., Tumor/Normal):**
```text
chromName    binFileNorm.Case    binFileNorm.Control
chr1         tumor_chr1.bin      normal_chr1.bin
chr2         tumor_chr2.bin      normal_chr2.bin
```

## Key Options and Parameters

### Core Parameters
- `--lambda=<float>`: The penalty parameter for segmentation. This is the primary "tuning knob" for the tool.
  - **Default**: 2.0.
  - **Higher values**: Result in a smoother profile with fewer, larger segments (lower sensitivity, higher specificity).
  - **Lower values**: Result in more segments (higher sensitivity, but potentially more false positives).
- `--control`: **Mandatory** if the configuration file contains a control column. If omitted while using a control-style config, the tool will not process the data correctly.

### Statistical and Noise Adjustments
- `--noscale`: Prevents the tool from automatically adjusting the lambda parameter based on the noise level in the data. Use this if you want strict manual control over the penalty.
- `--strict`: Uses a more stringent method for automatic lambda adjustment.
- `--bootstrap`: Performs a bootstrap test to assign confidence levels to detected segments. This is specifically recommended for one-sample (case-only) analysis.

### Output and Visualization
- `--fig=<string>`: Generates a PNG file showing the CNV profile.
- `--title=<string>`: Sets the title for the generated figure.
- `--nrm`: Do not remove segments with bad mappability (in case-only mode) or likely germline CNVs (in case-control mode). Use this if you want to see all raw segments regardless of quality filters.

## Expert Tips and Best Practices

1. **Lambda Tuning**: If your output contains thousands of tiny segments that look like noise, increase `--lambda` (e.g., to 3 or 4). If you are missing known small CNVs, decrease it (e.g., to 1.2 or 1.5).
2. **Matched Controls**: Always use the `--control` flag when a matched normal sample is available. This significantly improves the detection of somatic mutations by canceling out germline CNVs and systematic biases.
3. **Temporary Files**: Use the `--tmp=<string>` option to specify a high-speed scratch directory if working with large whole-genome datasets, as the tool generates intermediate files during processing.
4. **Multi-Sample Detail**: If performing multi-sample analysis, use the `--detail` flag to get a more granular segmentation result.

## Reference documentation
- [BIC-seq2 Home Page](./references/compbio_med_harvard_edu_BIC-seq.md)
- [BICseq2-seg Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bicseq2-seg_overview.md)