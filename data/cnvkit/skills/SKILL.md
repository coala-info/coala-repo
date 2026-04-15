---
name: cnvkit
description: CNVkit is a comprehensive toolkit for inferring and visualizing copy number changes from DNA sequencing data using both on-target and off-target reads. Use when user asks to detect copy number variations, run a somatic batch pipeline, normalize sequencing coverage, or export copy number calls to VCF format.
homepage: https://github.com/etal/cnvkit
metadata:
  docker_image: "quay.io/biocontainers/cnvkit:0.9.12--pyhdfd78af_1"
---

# cnvkit

## Overview

CNVkit is a comprehensive toolkit for inferring copy number changes from DNA sequencing. Unlike tools that rely solely on on-target coverage, CNVkit leverages "off-target" reads—sequencing fragments that map outside of targeted regions—to provide a genome-wide profile even in sparse targeted panels. It provides a streamlined pipeline for normalization, bias correction (GC content, mapability, and target size), segmentation, and visualization.

## Installation and Setup

The recommended installation method is via Conda to ensure all R and Python dependencies (like `DNAcopy` and `pomegranate`) are correctly configured.

```bash
conda install -c bioconda cnvkit
```

## Common CLI Patterns

### The Batch Pipeline
The `batch` command is the most efficient way to run the standard pipeline. It automates the creation of a reference, coverage calculation, and segmentation.

**Somatic analysis with a pooled reference:**
```bash
cnvkit.py batch *.bam --normal normal1.bam normal2.bam \
    --targets targets.bed --fasta hg38.fa \
    --output-reference my_reference.cnn --output-dir results/
```

**Using an existing reference:**
```bash
cnvkit.py batch tumor_sample.bam -r my_reference.cnn --output-dir results/
```

### Privacy-Preserving Workflow
For clinical or sensitive data, you can extract coverage locally and share only the non-identifying bedGraph files for analysis.

1. **Extract coverage:** Use `mosdepth` or `bedtools` to create a `.bed.gz` (bedGraph).
2. **Run CNVkit on bedGraph:**
```bash
cnvkit.py batch sample.bed.gz -r reference.cnn -d results/
```

### Refining Calls and Exporting
After the initial batch run, use `call` to adjust for sample purity and ploidy, then export to standard formats.

```bash
# Adjust for 70% tumor purity and 4n ploidy
cnvkit.py call sample.cns -m threshold --purity 0.7 --ploidy 4 -o sample.call.cns

# Export to VCF
cnvkit.py export vcf sample.call.cns -o sample.cnv.vcf
```

## Expert Tips and Best Practices

- **Pooled Normals**: Always prefer a pooled reference of at least 5-10 normal samples processed with the same library prep and sequencing run. This significantly reduces "noise" from systematic biases.
- **Flat Reference**: If no normal samples are available, create a "flat" reference using the `--normal` flag without BAM files, though this will be less accurate.
- **Sex Chromosomes**: Use the `--diploid-parx-genome` flag (e.g., `--diploid-parx-genome grch38`) to treat human pseudoautosomal regions as autosomal, reducing false calls on sex chromosomes.
- **Bias Correction**: If you notice wavy log2 ratios, use the `fix` command with `--smoothing-window-fraction` to manually tune the GC and mapability bias corrections.
- **Segmentation Choice**: While `cbs` (Circular Binary Segmentation) is the default and widely trusted, `hmm` (Hidden Markov Model) is available and may perform better on high-depth WGS data.
- **Filtering**: Use `genemetrics` to calculate confidence intervals (`ci`) and prediction intervals (`pi`). Filter out segments where the confidence interval overlaps with neutral log2 (0.0) to reduce false positives.

## Reference documentation
- [CNVkit GitHub Repository](./references/github_com_etal_cnvkit.md)
- [CNVkit v0.9.13 Release Notes](./references/github_com_etal_cnvkit_tags.md)
- [Bioconda CNVkit Overview](./references/anaconda_org_channels_bioconda_packages_cnvkit_overview.md)