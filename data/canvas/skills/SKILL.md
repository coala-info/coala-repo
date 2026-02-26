---
name: canvas
description: Canvas identifies copy number alterations and loss of heterozygosity by analyzing genomic coverage and B-allele frequencies from aligned sequencing reads. Use when user asks to detect somatic CNVs in tumor samples, call de novo variants in pedigrees, or analyze germline copy number status.
homepage: https://github.com/Illumina/canvas
---


# canvas

## Overview
Canvas is a tool designed to identify copy number alterations and loss of heterozygosity (LOH) by analyzing genomic coverage and B-allele frequencies from aligned sequencing reads. It transforms aligned BAM files into VCF reports that detail the copy number status across the genome. It is optimized for human data and supports various clinical and research workflows, including somatic mutation detection in cancer and de novo variant calling in families.

## Execution Environment
Canvas is written in C# and requires either .NET Core (recommended for performance) or Mono.
- **Command Pattern**: `dotnet Canvas.dll [MODE] [OPTIONS]`
- **Hardware Recommendation**: At least 4GB of RAM per CPU core.

## Core Workflows and Modes
Select the appropriate mode based on your experimental design:

- **SmallPedigree-WGS**: Use for germline samples, trios, or small families. 
  - *Note*: This mode has deprecated the old `Germline-WGS` mode; use it even for single-sample germline analysis.
- **Somatic-WGS / Somatic-Enrichment**: Use for tumor-only samples to detect somatic CNVs.
- **Tumor-normal-enrichment**: Use for paired tumor and matched-normal samples in targeted panels.

## Common CLI Patterns

### Small Pedigree / Germline WGS
To run a trio analysis, ensure sample names match the `SM` tags in the BAM headers.
```bash
dotnet Canvas.dll SmallPedigree-WGS \
  --bam=father.bam \
  --bam=mother.bam \
  --bam=proband.bam \
  --father=FatherSampleName \
  --mother=MotherSampleName \
  --proband=ProbandSampleName \
  --output=/path/to/output \
  --reference=genome.fa \
  --genome-folder=/path/to/genome_metadata/ \
  --filter-bed=filter.bed \
  --sample-b-allele-vcf=snvs.vcf
```

### Somatic (Tumor-Only) Calling
```bash
dotnet Canvas.dll Somatic-WGS \
  --bam=tumor.bam \
  --output=/path/to/output \
  --reference=genome.fa \
  --genome-folder=/path/to/genome_metadata/ \
  --filter-bed=filter.bed
```

## Required Input Files
Canvas requires specific metadata files for the reference genome:
1. **GenomeSize.xml**: Defines the searchable space of the genome.
2. **kmer.fa**: An annotated fasta file (generated via the `FlagUniqueKmers` tool) used to handle mappability.
3. **Filter BED**: A file containing regions to skip (e.g., gaps in the assembly, centromeres).
4. **B-Allele VCF**: A VCF containing SNV sites (e.g., from Strelka2) to calculate B-allele frequencies.

## Expert Tips and Best Practices
- **Sample Naming**: Canvas derives sample names from BAM header `@RG SM` tags. Ensure that the names provided in `--proband`, `--mother`, or `--father` flags are identical to these tags, as well as the sample names in your SNV VCF.
- **De Novo Calling**: In `SmallPedigree-WGS` mode, de novo variants are only reported if the `--proband` tag is explicitly used.
- **Filtering Results**: 
  - Look for the `DQ` (De novo Quality) score in the VCF for pedigree workflows.
  - Use `bcftools` to filter for high-confidence de novo calls: `bcftools filter -i 'FORMAT/DQ > 20' output.vcf`.
- **Reference Data**: Pre-built reference files for GRCh37, hg19, and GRCh38 are typically hosted on Illumina's public S3 buckets.

## Reference documentation
- [Canvas GitHub README](./references/github_com_Illumina_canvas.md)
- [Canvas Wiki - Command Line and Output](./references/github_com_Illumina_canvas_wiki.md)
- [Bioconda Canvas Overview](./references/anaconda_org_channels_bioconda_packages_canvas_overview.md)