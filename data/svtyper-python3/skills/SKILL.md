---
name: svtyper-python3
description: SVTyper genotypes structural variants by analyzing discordant and concordant read alignments at specific breakpoints. Use when user asks to genotype structural variants, perform single-sample parallelized genotyping, or generate library statistics from BAM files.
homepage: https://github.com/hall-lab/svtyper
metadata:
  docker_image: "quay.io/biocontainers/svtyper-python3:0.7.1--pyhdfd78af_0"
---

# svtyper-python3

## Overview
SVTyper is a tool designed to provide high-confidence genotypes for structural variants by analyzing discordant and concordant read alignments. It works by assessing paired-end and split-read data at specific breakpoints defined in an input VCF. This skill provides the necessary command-line patterns to perform genotyping, generate library statistics, and utilize the parallelized single-sample implementation for faster processing.

## Core Workflows

### Standard Genotyping
Use the base `svtyper` command for general purposes or multi-sample VCFs.
```bash
svtyper \
    -i input_svs.vcf \
    -B sample_alignments.bam \
    -l library_metrics.json \
    > genotyped_svs.vcf
```

### Single-Sample Optimization (svtyper-sso)
For significantly faster processing of a single sample, use the `svtyper-sso` variant. This utilizes multiple CPU cores.
```bash
svtyper-sso \
    --cores 4 \
    --batch_size 1000 \
    -i input_svs.vcf \
    -B sample_alignments.bam \
    -l library_metrics.json \
    > genotyped_svs.vcf
```

### Library Calibration
If you do not have a library JSON file, generate one first. This is critical for accurate genotyping as it defines the expected insert size distribution.
```bash
svtyper \
    -B sample_alignments.bam \
    -l sample_library.json
```
*Note: By default, this samples the first 1 million reads.*

## Parameters and Best Practices

| Parameter | Description | Recommendation |
| :--- | :--- | :--- |
| `-i`, `--input_vcf` | Input VCF file of SV sites | Required. Often from LUMPY. |
| `-B`, `--bam` | Input BAM or CRAM file | Must be indexed. |
| `-l`, `--lib_info` | JSON file for library metrics | Always generate/use for consistency. |
| `--max_reads` | Skip genotyping if reads exceed this | Use (e.g., 1000) to avoid high-depth artifacts. |
| `--cores` | Number of CPUs (sso only) | Match to available hardware for ~2x speedup. |

### Expert Tips
- **CRAM Support**: While supported, `svtyper-sso` may occasionally encounter stability issues with CRAM files. If errors occur, fallback to the standard `svtyper` command or convert to BAM.
- **Insert Size Issues**: If genotyping results seem off, use the `scripts/lib_stats.R` utility (found in the source repository) on your JSON file to visualize the insert size distribution and check for abnormalities.
- **Python Integration**: SVTyper can be imported as a library. Use `import svtyper.classic as svt` for standard genotyping or `import svtyper.singlesample as sso` for parallelized tasks within Python scripts.



## Subcommands

| Command | Description |
|---------|-------------|
| svtyper | Compute genotype of structural variants based on breakpoint depth |
| svtyper-sso | Compute genotype of structural variants based on breakpoint depth on a SINGLE sample |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_hall-lab_svtyper.md)
- [Known Issues and Limitations](./references/github_com_hall-lab_svtyper_issues.md)