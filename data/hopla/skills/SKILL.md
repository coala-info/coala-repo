---
name: hopla
description: Hopla analyzes family pedigrees from multisample VCF files to identify inheritance patterns and perform pedigree-based haplotyping. Use when user asks to analyze family pedigrees, perform haplotyping via Merlin, visualize B-allele frequency profiles, or identify inheritance patterns in clinical genomics.
homepage: https://github.com/leraman/Hopla
metadata:
  docker_image: "quay.io/biocontainers/hopla:1.2.1--hdfd78af_1"
---

# hopla

## Overview
Hopla is a specialized tool for clinical genomics designed to streamline the analysis of family pedigrees (singles, duos, trios, and larger groups) using a single multisample VCF. It is particularly effective for identifying inheritance patterns and performing pedigree-based haplotyping via Merlin. The tool generates interactive HTML reports that visualize B-allele frequency (BAF) profiles and haplotype segments, making it a powerful asset for both postnatal diagnostics and preimplantation genetic testing.

## Core CLI Usage
The primary interface for Hopla is `hopla.R`. Ensure the environment is set up via Conda (`conda install -c bioconda hopla`) before execution.

### Mandatory Arguments
- `--vcf.file`: Path to the compressed multisample VCF (`.vcf.gz`).
- `--sample.ids`: Comma-separated list of IDs present in the VCF. Use `U1, U2...` for unknown placeholders to maintain pedigree structure (e.g., for distant relatives).

### Defining Pedigree Structure
To enable inheritance analysis and haplotyping, you must define parental relationships:
- `--father.ids`: Comma-separated IDs of fathers, matching the order of `--sample.ids`. Use `NA` if unknown.
- `--mother.ids`: Comma-separated IDs of mothers, matching the order of `--sample.ids`. Use `NA` if unknown.
- `--genders`: Comma-separated list (`M`, `F`, or `NA`).

### Filtering Best Practices
Hopla uses a two-tier filtering system to ensure variant quality:
- **Hard Filters**: Use `--dp.hard.limit` (default 10) and `--af.hard.limit` to remove variants globally if specific samples (defined by `--dp.hard.limit.ids`) do not meet the threshold.
- **Soft Filters**: Use `--dp.soft.limit` to exclude variants only from specific samples (usually children/embryos) while keeping them for others.
- **Informative Variants**: Use `--keep.informative.ids` with exactly two samples (e.g., parents) to filter for variants where one is heterozygous (0/1) and the other is homozygous (0/0 or 1/1).

## Advanced Workflows

### Merlin Haplotyping
Haplotyping is enabled by default (`--run.merlin T`). 
- **Model Selection**: Use `--merlin.model best` for optimized results.
- **Segment Smoothing**: Adjust `--min.seg.var` (default 5) to filter out small, potentially noisy haplotype segments. Increase this for Chromosome X using `--min.seg.var.X`.
- **Voting**: Use `--window.size.voting` to correct haplotypes based on neighborhood consensus.

### Region-Specific Analysis
For targeted diagnostics (e.g., Cystic Fibrosis), define regions of interest to generate detailed BAF profiles:
- `--regions "chr7:117480025-117668665"`
- `--baf.ids`: Specify samples that require genome-wide BAF plots. Note: Including too many samples here significantly increases the HTML file size.

### Annotation and Reporting
Enhance the interactive HTML output with clinical context:
- **Status Markers**: Use `--affected.ids`, `--carrier.ids`, and `--nonaffected.ids` to color-code the pedigree tree.
- **Custom Info**: Use `--info` to add text headers or use a settings file with `start.info` and `end.info` blocks for multi-line clinical summaries.

## Reference documentation
- [Hopla GitHub Repository](./references/github_com_CenterForMedicalGeneticsGhent_Hopla.md)
- [Bioconda Hopla Overview](./references/anaconda_org_channels_bioconda_packages_hopla_overview.md)