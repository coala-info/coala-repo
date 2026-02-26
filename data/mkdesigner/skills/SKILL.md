---
name: mkdesigner
description: MKDesigner automates the design of laboratory-ready PCR primers from NGS data by integrating variant calling, primer design, and specificity checking. Use when user asks to identify genetic markers between lines, design SNP or INDEL primers, or generate physical maps for fine mapping.
homepage: https://github.com/KChigira/mkdesigner/
---


# mkdesigner

## Overview

MKDesigner is a specialized bioinformatics tool designed to automate the transition from raw Next-Generation Sequencing (NGS) data to laboratory-ready PCR primers. It replaces the laborious process of manual primer design and specificity checking by integrating variant calling, Primer3-based design, and BLAST-based specificity searches into a streamlined command-line workflow. Use this skill to identify markers for fine mapping, variety identification, or any application requiring physical DNA markers between two or more genetic lines.

## Core Workflow

The tool follows a deterministic three-step procedure. Each step generates the input required for the next.

### 1. Variant Calling (mkvcf)
Generate a multi-sample VCF file from aligned reads (BAM files).
- **Command**: `mkvcf -r <ref.fasta> -b <lineA.bam> -b <lineB.bam> -n lineA -n lineB -O <output_prefix> --cpu <int>`
- **Requirement**: You must provide at least two BAM files and corresponding names to identify polymorphisms between them.

### 2. Primer Design (mkprimer)
Design primers for the variants identified in the previous step.
- **Command**: `mkprimer -r <ref.fasta> -V <input.vcf> -n1 <lineA> -n2 <lineB> -O <output_prefix> --type <SNP|INDEL>`
- **Key Parameters**:
    - `--type`: Specify `SNP` or `INDEL` depending on the desired marker type.
    - `--target`: Focus on a specific region (e.g., `chr01:1000000-2000000`) for fine mapping.
    - `--mindep` / `--maxdep`: Filter variants based on read depth to ensure high-quality calls.
    - `--limit`: Set the maximum number of primer design attempts to balance runtime and discovery.

### 3. Marker Selection and Visualization (mkselect)
Filter the designed primers to a manageable number and generate a physical map.
- **Command**: `mkselect -i <ref.fai> -V <primers.vcf> -n <int> -O <output_prefix>`
- **Output**: Produces a `.tsv` file with primer sequences and amplicon data, and a `.png` visualization of marker distribution across chromosomes.

## Expert CLI Patterns

### Designing Common Markers for Multiple Varieties
To find markers that are common across several lines (e.g., comparing a group of resistant lines against a group of susceptible lines), specify multiple names for the `-n1` and `-n2` parameters:
`mkprimer -r ref.fa -V all.vcf -n1 Res1 -n1 Res2 -n2 Sus1 -n2 Sus2 -O common_markers --type SNP`

### Optimizing for Specific PCR Conditions
Adjust product length and primer size to match laboratory protocols:
`mkprimer ... --min_prodlen 150 --opt_prodlen 200 --max_prodlen 300 --primer_min_size 20 --primer_opt_size 24 --primer_max_size 28`

### Handling Repetitive Regions
If the BLAST specificity search is taking too long due to repetitive sequences, use the `--blast_timeout` parameter (default 60.0s) to skip problematic variants:
`mkprimer ... --blast_timeout 30.0`

## Best Practices

- **Environment**: Install via Bioconda (`conda install mkdesigner -c bioconda -c conda-forge`) to ensure all dependencies like GATK4, BLAST, and Primer3 are correctly configured.
- **Memory**: Ensure the system has >16 GB RAM, especially for large reference genomes or high-depth BAM files.
- **Input Quality**: Use sorted and indexed BAM files. The `mkvcf` command expects standard alignment formats.
- **Marker Density**: When using `mkselect`, if you need to see all designed markers on the map regardless of the count, set `-n` to a very high number (e.g., `10000`).

## Reference documentation
- [MKDesigner User Guide](./references/github_com_KChigira_mkdesigner.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mkdesigner_overview.md)