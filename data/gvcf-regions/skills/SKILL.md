---
name: gvcf-regions
description: This tool identifies and exports genomic regions from gVCF files to produce a BED file representing the callable genome. Use when user asks to identify callable genomic regions, convert gVCF files to BED format, or filter genomic regions based on quality thresholds and caller-specific presets.
homepage: https://github.com/lijiayong/gvcf_regions
metadata:
  docker_image: "quay.io/biocontainers/gvcf-regions:2016.06.23--py35_0"
---

# gvcf-regions

## Overview
The `gvcf-regions` skill provides a streamlined way to identify and export genomic regions that meet specific quality and calling criteria from a gVCF file. While standard VCFs only list variants, gVCFs contain information about every position; this tool parses that data to produce a BED file representing the "callable" genome. Use this when you need to define the search space for downstream analysis, calculate precise coverage metrics, or filter variants against a background of high-confidence calls.

## Common CLI Patterns

### Basic Usage
Convert a standard gVCF to BED using default settings:
```bash
python gvcf_regions.py input.g.vcf > called_regions.bed
```

### Using Caller-Specific Presets
The tool includes optimized presets for major variant callers. Using these automatically configures flags like `--unreported_is_called` and quality thresholds:
- **GATK**: `python gvcf_regions.py --gvcf_type gatk input.g.vcf`
- **Freebayes**: `python gvcf_regions.py --gvcf_type freebayes input.g.vcf`
- **Complete Genomics**: `python gvcf_regions.py --gvcf_type complete_genomics input.g.vcf`

### Custom Quality Filtering
To enforce stricter confidence requirements, manually set Genotype Quality (GQ) or QUAL thresholds:
```bash
python gvcf_regions.py --min_GQ 30 --min_QUAL 50 input.g.vcf > high_conf_regions.bed
```

### Filtering by Status Phrases
Include or exclude regions based on the FILTER column or specific info tags:
- **Include only specific tags**: `--pass_phrases PASS REFCALL`
- **Exclude specific categories**: `--ignore_phrases CNV ME` (useful for removing structural variants or mobile elements)

### Stream Processing
Process compressed files or pipe data directly from other tools using the `-` alias:
```bash
zcat input.g.vcf.gz | python gvcf_regions.py - > output.bed
```

## Expert Tips and Best Practices

- **Handling Overlaps**: The tool automatically handles edge cases where variant or hom-ref lines overlap by keeping the first line and ignoring subsequent overlapping entries.
- **Unreported Sites**: For Complete Genomics data, use the `--unreported_is_called` flag. This treats sites not explicitly mentioned in the file as called, which is the standard interpretation for that specific format.
- **GATK GQ Missingness**: When using GATK gVCFs, the tool is designed to avoid errors if the GQ field is missing, making it robust for various GATK versions.
- **Telomere Handling**: The tool correctly handles telomeric regions where the position (POS) in the VCF might be 0.
- **Memory Efficiency**: Since the tool can accept streams, it is highly efficient for large-scale genomic pipelines when combined with `bcftools` or `samtools`.

## Reference documentation
- [gVCF Regions Main Documentation](./references/github_com_lijiayong_gvcf_regions.md)