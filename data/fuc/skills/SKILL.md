---
name: fuc
description: The fuc package provides a suite of command-line tools for streamlining bioinformatics tasks such as genomic data manipulation, file format conversion, and end-to-end NGS pipeline execution. Use when user asks to manipulate VCF or BAM files, visualize MAF data, run germline or somatic variant discovery pipelines, and perform table operations.
homepage: https://github.com/sbslee/fuc
---


# fuc

## Overview
The `fuc` (Frequently Used Commands) package is a Python-based suite designed to consolidate disparate bioinformatics tasks into a streamlined command-line interface. It eliminates the need for writing custom scripts for routine data manipulation by providing robust wrappers for analyzing, summarizing, and transforming genomic data. Use this skill to handle complex file formats like VCF and BAM, perform table operations, and run end-to-end pipelines for germline or somatic variant discovery.

## CLI Usage and Best Practices

### General Command Structure
All `fuc` operations follow a consistent sub-command pattern:
```bash
fuc <command> [arguments]
```
To see all available modules, use `fuc -h`. For specific command help, use `fuc <command> -h`.

### Working with VCF Files
`fuc` provides powerful utilities for variant data that often replace complex `bcftools` or `awk` one-liners.
- **Merging**: Combine multiple VCFs into one: `fuc vcf-merge in1.vcf in2.vcf > out.vcf`
- **Slicing**: Extract specific regions: `fuc vcf-slice in.vcf --region chr1:100-200`
- **Filtering**: Apply filters based on VEP annotations: `fuc vcf-vep in.vcf --filter "Consequence == 'missense_variant'"`
- **Conversion**: Quickly move to BED format: `fuc vcf-vcf2bed in.vcf > out.bed`

### BAM/CRAM Manipulation
- **Depth Analysis**: Calculate per-base read depth: `fuc bam-depth in.bam > depth.txt`
- **Allelic Depth**: Compute depth for specific alleles: `fuc bam-aldepth in.bam`
- **Header Inspection**: Quickly view headers: `fuc bam-head in.bam`
- **Sample Renaming**: Update SM tags without full re-processing: `fuc bam-rename in.bam new_name`

### Mutation Annotation Format (MAF) Visualization
`fuc` excels at generating publication-ready plots from MAF files.
- **Oncoplots**: Create a matrix of mutations across samples: `fuc maf-oncoplt in.maf`
- **Summary Plots**: Visualize TMB and variant classifications: `fuc maf-sumplt in.maf`
- **Conversion**: Convert MAF to VCF for downstream analysis: `fuc maf-maf2vcf in.maf > out.vcf`

### NGS Pipelines
The `ngs-` prefix denotes end-to-end workflows. These commands typically require a configuration or specific input structure.
- **Germline Discovery**: `fuc ngs-hc` (wraps GATK HaplotypeCaller logic).
- **Somatic Discovery**: `fuc ngs-m2` (wraps Mutect2 logic).
- **RNAseq Quant**: `fuc ngs-quant` (utilizes Kallisto).
- **Trimming**: `fuc ngs-trim` for adapter removal.

### Utility Commands
- **File Discovery**: Use `fuc-find` to retrieve absolute paths matching patterns recursively: `fuc-find . "*.vcf"`
- **Table Merging**: Join two delimiter-separated files: `fuc tbl-merge file1.csv file2.csv --on ID`
- **Compression**: Use `fuc-bgzip` for BGZF compression compatible with tabix.

## Expert Tips
- **Piping**: Many `fuc` commands support stdout, allowing you to chain operations with standard Unix tools or other bioinformatics suites.
- **Validation**: Use `fuc-exist` to verify the presence of multiple required files before starting long-running pipelines.
- **Demultiplexing**: If working with Illumina data, `fuc-demux` and `fuc-undetm` are highly efficient for parsing `bcl2fastq` reports and identifying index hopping or unknown barcodes.

## Reference documentation
- [fuc GitHub Repository](./references/github_com_sbslee_fuc.md)
- [fuc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fuc_overview.md)