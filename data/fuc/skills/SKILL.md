---
name: fuc
description: The fuc package is a comprehensive bioinformatics suite for genomic data processing, variant analysis, and visualization. Use when user asks to manipulate VCF or BAM files, run NGS pipelines from FASTQ to BAM, discover variants, or generate genomic visualizations like oncoplots.
homepage: https://github.com/sbslee/fuc
---


# fuc

## Overview

The `fuc` (Frequently Used Commands) package is a comprehensive bioinformatics suite designed to consolidate disparate genomic processing tasks into a single, unified interface. It provides both a Command Line Interface (CLI) and a Python API to handle the heavy lifting of sequence alignment manipulation, variant call processing, and data visualization. You should use this skill to efficiently execute multi-step bioinformatics workflows—such as converting FASTQ files to analysis-ready BAMs or generating oncoplots from MAF files—without needing to write custom scripts for standard data transformations.

## CLI Usage and Best Practices

The `fuc` tool uses a subcommand-based structure: `fuc [COMMAND] [ARGUMENTS]`.

### Core File Manipulation Patterns

*   **VCF Operations**: Use `vcf-merge` to combine multiple VCF files and `vcf-slice` to extract specific genomic regions. For individual-level analysis, `vcf-split` can separate a multi-sample VCF into single-sample files.
*   **BAM/SAM Processing**: Use `bam-depth` for per-base read depth and `bam-slice` for region extraction. Always ensure files are indexed using `bam-index` or `tabix-index` before slicing.
*   **Table Merging**: Use `tbl-merge` to join two table files (CSV/TSV), which is highly effective for integrating metadata with genomic results.

### NGS Pipeline Commands

`fuc` includes pre-built pipelines that wrap standard tools (GATK, BWA, etc.):

*   **FASTQ to BAM**: `ngs-fq2bam` automates the path from raw reads to analysis-ready alignments.
*   **Variant Discovery**: Use `ngs-hc` for germline short variant discovery (HaplotypeCaller) and `ngs-m2` for somatic discovery (Mutect2).
*   **RNA-seq**: `ngs-quant` provides a streamlined pipeline for transcript quantification using Kallisto.

### Visualization and Summarization

*   **Mutation Annotation Format (MAF)**: Generate sophisticated visualizations using `maf-oncoplt` (oncoplots) or `maf-sumplt` (summary plots).
*   **Quick Summaries**: Use `fq-sum` for FASTQ files, `bed-sum` for BED files, and `tbl-sum` for general tabular data to get immediate statistics on your datasets.

### Expert Tips

*   **Recursive Search**: Use `fuc-find` to retrieve absolute paths of files matching a pattern across nested directories. This is often more reliable than standard `find` for building input lists for other `fuc` commands.
*   **'chr' Prefix Handling**: Many `fuc` commands (like `vcf-merge` and `pycov` methods) are designed to automatically handle the presence or absence of the 'chr' string in contig names, reducing errors when mixing datasets from different reference builds.
*   **VEP Integration**: Use `vcf-vep` to filter VCF files specifically by annotations produced by the Ensembl Variant Effect Predictor.
*   **Allelic Depth**: Use `bam-aldepth` to compute allelic depth directly from BAM files, which is essential for manual verification of low-frequency variants.



## Subcommands

| Command | Description |
|---------|-------------|
| bam-depth | Compute per-base read depth from BAM files. |
| bam-head | Print the header of a BAM file. |
| bam-index | Index a BAM file. |
| bam-rename | Rename the sample in a BAM file. |
| bam-slice | Slice a BAM file. |
| bed-intxn | Find the intersection of BED files. |
| fq-count | Count sequence reads in FASTQ files. |
| fq-sum | Summarize a FASTQ file. |
| fuc fa-filter | Filter sequence records in a FASTA file. |
| fuc maf-vcf2maf | Convert a VCF file to a MAF file. |
| fuc ngs-bam2fq | Pipeline for converting BAM files to FASTQ files. |
| fuc ngs-fq2bam | Pipeline for converting FASTQ files to analysis-ready BAM files. |
| fuc ngs-m2 | Pipeline for somatic short variant discovery. |
| fuc ngs-pon | Pipeline for constructing a panel of normals (PoN). |
| fuc ngs-quant | Pipeline for running RNAseq quantification from FASTQ files with Kallisto. |
| fuc-bgzip | Write a BGZF compressed file. |
| fuc-compf | Compare the contents of two files. |
| fuc-demux | Parse the Reports directory from bcl2fastq. |
| fuc-exist | Check whether certain files exist. |
| fuc-find | Retrieve absolute paths of files whose name matches a specified pattern, optionally recursively. |
| fuc-undetm | Compute top unknown barcodes using undertermined FASTQ from bcl2fastq. |
| fuc_bam-aldepth | Count allelic depth from a BAM file. |
| fuc_bed-sum | Summarize a BED file. |
| fuc_cov-concat | Concatenate depth of coverage files. |
| fuc_cov-rename | Rename the samples in a depth of coverage file. |
| maf-maf2vcf | Convert a MAF file to a VCF file. |
| maf-oncoplt | Create an oncoplot with a MAF file. The format of output image (PDF/PNG/JPEG/SVG) will be automatically determined by the output file's extension. |
| maf-sumplt | Create a summary plot with a MAF file. |
| ngs-hc | Pipeline for germline short variant discovery. |
| ngs-trim | Pipeline for trimming adapters from FASTQ files. |
| tabix-index | Index a GFF/BED/SAM/VCF file with Tabix. |
| tabix-slice | Slice a GFF/BED/SAM/VCF file with Tabix. |
| tbl-merge | Merge two table files. |
| tbl-sum | Summarize a table file. |
| vcf-call | Call SNVs and indels from BAM files. |
| vcf-filter | Filter a VCF file. |
| vcf-index | Index a VCF file. |
| vcf-merge | Merge two or more VCF files. |
| vcf-rename | Rename the samples in a VCF file. |
| vcf-slice | Slice a VCF file for specified regions. |
| vcf-split | Split a VCF file by individual. |
| vcf-vcf2bed | Convert a VCF file to a BED file. |
| vcf-vep | Filter a VCF file by annotations from Ensembl VEP. |

## Reference documentation

- [fuc GitHub README](./references/github_com_sbslee_fuc_blob_main_README.rst.md)
- [fuc Changelog and Version History](./references/github_com_sbslee_fuc_blob_main_CHANGELOG.rst.md)