---
name: fings
description: FiNGS is a post-processing tool that filters somatic mutation calls by analyzing BAM files to reduce false positives. Use when user asks to filter somatic variants, increase the precision of mutation calls, or apply ICGC-compliant filtering standards to VCF files.
homepage: https://github.com/cpwardell/FiNGS
metadata:
  docker_image: "quay.io/biocontainers/fings:1.7.1--pyhb7b1952_0"
---

# fings

## Overview
FiNGS (Filters for Next Generation Sequencing) is a post-processing tool designed to increase the precision of somatic mutation calls. Standard variant callers often generate high rates of false positives due to sequencing artifacts, alignment issues, or sample impurity. FiNGS addresses this by analyzing the original BAM files to calculate metrics that are not typically available in VCF files alone. It allows users to implement highly specific filtering logic, including standards recommended by the International Cancer Genome Consortium (ICGC).

## Command Line Usage

The primary command for the tool is `fings`. It requires matched tumor and normal BAM files along with the raw VCF output from your variant caller.

### Basic Syntax
```bash
fings -n <normal.bam> -t <tumor.bam> -v <input.vcf> [options]
```

### Common Arguments
- `-n`, `--normal`: Path to the matched normal BAM file.
- `-t`, `--tumor`: Path to the tumor BAM file.
- `-v`, `--vcf`: The input VCF file containing raw variant calls.
- `-d`, `--dir`: Specify the output directory for filtered results and metric files.
- `--PASSonlyin`: Only process variants that have already been marked as "PASS" by the initial variant caller.
- `--PASSonlyout`: Only include variants in the output VCF that pass all FiNGS-specific filters.

### Docker Execution Pattern
When running via Docker, ensure you mount your local data volumes and set the working directory so the tool can access the BAM and VCF files:
```bash
docker run -it -v $PWD:/data -w /data -u $UID:$UID cpwardell/fings -n normal.bam -t tumor.bam -v raw_calls.vcf --PASSonlyin --PASSonlyout
```

## Expert Tips and Best Practices

- **BAM Indexing**: Ensure both tumor and normal BAM files are indexed (`.bai` files present) before running FiNGS, as the tool performs random access to calculate site-specific metrics.
- **ICGC Standards**: FiNGS is frequently used to apply ICGC-compliant filtering. If your project requires these specific standards, verify your threshold configurations match the ICGC recommendations (Alioto et al., 2015).
- **Metric Analysis**: Beyond the filtered VCF, FiNGS generates metric files. Review these to understand why specific variants were filtered (e.g., strand bias, low mapping quality, or presence in the normal sample).
- **Version Compatibility**: As of late 2024, the tool uses `vcfpy` for VCF handling. If you encounter issues with older VCF formats, ensure you are using the latest version (v1.7.1+) which supports modern package dependencies.
- **Environment Management**: Bioconda is the recommended installation method to ensure all system-level dependencies for `pysam` and `vcfpy` are correctly configured.

## Reference documentation
- [FiNGS GitHub Repository](./references/github_com_cpwardell_FiNGS.md)
- [FiNGS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fings_overview.md)