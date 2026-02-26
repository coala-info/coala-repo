---
name: vtools
description: vtools is a high-performance suite of utilities designed for rapid VCF file manipulation. Use when user asks to filter variants, generate VCF statistics, calculate genomic coverage, or evaluate call sets.
homepage: https://github.com/LUMC/vtools
---


# vtools

## Overview

vtools is a high-performance suite of utilities designed for rapid VCF file manipulation. Built on `cyvcf2` and `cython`, it provides a faster alternative to standard VCF processing tools for specific tasks like population-frequency filtering, exon-based coverage analysis from gVCFs, and genotype concordance evaluation. Use this skill when you need to perform quality control, filter variants based on external database frequencies (GoNL/GnomAD), or compare a call set against a known truth set (e.g., comparing WES data to a SNP array).

## Installation and Setup

Note that while the commands are prefixed with `vtools-`, the PyPI package name differs from the tool name.

- **Pip**: `pip install v-tools`
- **Conda**: `conda install -c bioconda vtools`

## Command Line Usage

### 1. Filtering Variants (vtools-filter)
Filters VCF files based on specific criteria and segregates "trash" variants into a separate file.

```bash
vtools-filter \
  -i input.vcf \
  -o filtered_output.vcf \
  -t trash_output.vcf \
  -p filter_params.json \
  --index-sample <sample_name>
```

**Filter Criteria (defined in JSON):**
- `NON_CANONICAL`: Filter non-canonical chromosomes.
- `INDEX_UNCALLED`: Filter uncalled or homozygous reference genotypes.
- `TOO_HIGH_GONL_AF`: Filter based on GoNL allele frequency.
- `TOO_HIGH_GNOMAD_AF`: Filter based on GnomAD allele frequency.
- `LOW_GQ`: Filter based on Genotype Quality.

### 2. VCF Statistics (vtools-stats)
Generates a JSON summary of VCF metrics to stdout.

```bash
vtools-stats -i input.vcf > stats.json
```

### 3. Genomic Coverage (vtools-gcoverage)
Calculates coverage metrics over exons or transcripts using a gVCF and a refFlat file.

```bash
vtools-gcoverage \
  -I input.g.vcf \
  -R refFlat.txt \
  --per-exon \
  --per-transcript
```

**Output Columns:**
- Mean/Median DP and GQ.
- Percentage of bases at specific DP thresholds (10, 20, 30, 50, 100).
- Percentage of bases at specific GQ thresholds (10, 29, 30, 50, 90).

### 4. Call Set Evaluation (vtools-evaluate)
Evaluates a VCF against a baseline (positive) VCF. Useful for comparing different technologies (e.g., WES vs. SNP array).

```bash
vtools-evaluate \
  -c call_set.vcf \
  -p baseline_truth.vcf \
  -cs <call_sample_name> \
  -ps <positive_sample_name> \
  -s evaluation_stats.json \
  -dc discordant_variants.vcf.gz
```

## Expert Tips and Best Practices

- **Immediate Return**: By default, `vtools-filter` uses `--immediate-return`, meaning it writes a variant to the trash file as soon as it hits the first failing criteria. Disable this if you need to see all failing filters in the INFO field.
- **GQ Calculation**: In `vtools-gcoverage`, the mean GQ is calculated by converting Phred scores to P-values, averaging the P-values, and converting back to Phred. This is more statistically sound than a simple arithmetic mean of Phred scores.
- **Evaluation Thresholds**: `vtools-evaluate` defaults to a minimum Genotype Quality (GQ) of 30. If you are working with low-coverage data, use `--min-qual 0` to overrule this. You can also set a minimum depth with `--min-depth`.
- **Multi-sample Handling**: `vtools-gcoverage` only expects one sample. If a multi-sample VCF is provided, it will only process the first sample. For `vtools-evaluate`, you must explicitly specify which samples to compare using `-cs` and `-ps`.

## Reference documentation
- [vtools README](./references/github_com_LUMC_vtools.md)
- [Bioconda vtools Overview](./references/anaconda_org_channels_bioconda_packages_vtools_overview.md)