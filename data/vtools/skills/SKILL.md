---
name: vtools
description: vtools is a high-performance toolset designed for filtering, evaluating, and calculating coverage metrics for VCF and gVCF files. Use when user asks to filter variants based on population frequency, calculate exon-level coverage from gVCFs, or evaluate genotype concordance between VCF files.
homepage: https://github.com/LUMC/vtools
---


# vtools

## Overview

vtools is a high-performance toolset designed for efficient operations on VCF files. By leveraging Cython and the cyvcf2 library, it provides a fast alternative for common genomic data processing tasks. The suite is particularly useful for filtering variants based on population frequencies (GnomAD/GoNL), calculating exon-level coverage metrics from gVCF files, and performing genotype concordance evaluations between different sequencing technologies.

## Installation and Setup

The package is available via PyPI and Bioconda. Note that the PyPI package name differs from the command-line tool names.

- **PyPI**: `pip install v-tools`
- **Conda**: `conda install -c bioconda vtools`

All tools are invoked using the `vtools-<toolname>` convention.

## Tool-Specific Instructions

### 1. VCF Filtering (vtools-filter)
Use this to remove common variants or low-quality calls. It requires a JSON configuration file to define thresholds.

**Common Pattern:**
```bash
vtools-filter \
  -i input.vcf \
  -o filtered_output.vcf \
  -t trash_variants.vcf \
  -p filter_params.json \
  --index-sample SAMPLE_NAME
```

**Expert Tips:**
- **Immediate Return**: By default, the tool writes to the trash file as soon as a single filter criterion is met. Use `--no-immediate-return` if you need to see every filter that a variant failed in the VCF header/INFO field.
- **Filter Criteria**: Supported filters include `NON_CANONICAL`, `INDEX_UNCALLED`, `TOO_HIGH_GONL_AF`, `TOO_HIGH_GNOMAD_AF`, `LOW_GQ`, and `DELETED_ALLELE`.

### 2. gVCF Coverage Analysis (vtools-gcoverage)
Calculates coverage metrics (mean/median DP and GQ) over genomic regions defined in a refFlat file.

**Common Pattern:**
```bash
vtools-gcoverage \
  -I input.p.gvcf \
  -R refFlat.txt \
  --per-exon
```

**Expert Tips:**
- **Transcript Mode**: Use `--per-transcript` for whole-transcript metrics or `--per-transcript-cds-exons` to limit analysis to coding regions.
- **Input Handling**: If the input VCF contains multiple samples, the tool only processes the first sample.
- **Output**: The tool produces a TSV with specific columns for percentage of bases reaching DP thresholds (10, 20, 30, 50, 100) and GQ thresholds.

### 3. Genotype Evaluation (vtools-evaluate)
Compares a "call" VCF against a "positive" (truth) VCF. Useful for validating WES/WGS data against SNP arrays.

**Common Pattern:**
```bash
vtools-evaluate \
  -c calls.vcf \
  -p truth.vcf \
  -cs SAMPLE_ID_CALLS \
  -ps SAMPLE_ID_TRUTH \
  -s stats.json \
  -dc discordant_variants.vcf.gz
```

**Expert Tips:**
- **Quality Thresholds**: The tool defaults to a Minimum Genotype Quality (`--min-qual`) of 30. Set to 0 to consider all variants.
- **Depth Filtering**: Use `--min-depth` to exclude low-coverage sites from the evaluation.
- **Concordance**: The output JSON provides counts for concordant and discordant alleles, allowing for precision/recall calculations.

### 4. VCF Statistics (vtools-stats)
A quick utility to generate a JSON summary of VCF content.

**Usage:**
```bash
vtools-stats -i input.vcf > stats.json
```



## Subcommands

| Command | Description |
|---------|-------------|
| vtools-evaluate | Evaluate calls in a VCF against a set of known calls. |
| vtools-filter | Filter VCF files based on provided parameters. |
| vtools-gcoverage | Collect coverage metrics from VCF files. |
| vtools-stats | Calculate statistics for VCF files. |

## Reference documentation
- [Main README](./references/github_com_LUMC_vtools_blob_devel_README.md)
- [Filter Configuration Example](./references/github_com_LUMC_vtools_blob_devel_cfg_example-filter.json.md)
- [Changelog and Version Updates](./references/github_com_LUMC_vtools_blob_devel_CHANGELOG.rst.md)