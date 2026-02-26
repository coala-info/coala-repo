---
name: gvcf2coverage
description: "gvcf2coverage parses gVCF files to generate a tabular representation of genomic coverage and ploidy. Use when user asks to extract coverage from gVCF files, convert gVCF to TSV format, or prepare coverage data for Varda2."
homepage: https://github.com/varda/varda2_preprocessing
---


# gvcf2coverage

## Overview
gvcf2coverage is a specialized tool designed to parse gVCF files and produce a streamlined, tabular representation of genomic coverage. While gVCF files contain detailed information about every position in the genome, this tool extracts only the essential coordinates and the associated ploidy. It is available in two implementations: a Python version (`pygvcf2coverage`) for readability and a C version (`gvcf2coverage`) which is approximately 12 times faster and recommended for production environments.

## Command Line Usage

The tool typically operates using standard input and output streams.

### Basic Extraction
To extract coverage from a gVCF file:
```bash
gvcf2coverage < input.g.vcf > output.coverage
```

### Output Format
The tool produces a tab-separated values (TSV) file with the following columns:
1. `<CHROM>`: Chromosome or Reference Sequence ID.
2. `<START>`: Start position (0-based).
3. `<END>`: End position.
4. `<PLOIDY>`: The ploidy level for the region.

Example output:
```text
NC_000001.10    10033   10038   2
NC_000001.10    10038   10043   2
```

## Expert Tips and Best Practices

### Performance Optimization
Always prefer the C implementation (`gvcf2coverage`) over the Python implementation (`pygvcf2coverage`) when processing large human whole-genome sequencing (WGS) files to significantly reduce processing time.

### Merging Adjacent Regions
By default, the tool merges adjacent entries with a merging distance of 0. This is preferred over using external tools like `bedtools merge` because `gvcf2coverage` preserves the ploidy column during the merge, whereas standard BED tools may require additional configuration to handle the fourth column correctly.

### Chromosome Identifier Normalization
If your gVCF uses "human-friendly" names (e.g., `chr1` or `1`) instead of official RefSeq accessions (e.g., `NC_000001.10`), it is standard practice to pipe the output to `cthreepo` for identifier mapping:
```bash
gvcf2coverage < input.g.vcf | cthreepo --mapfile h37 --infile - --id_from uc --id_to rs --outfile output.normalized.coverage
```

### Integration with Varda2
When preparing data for a Varda2 database, the resulting coverage file is one of the two primary inputs required by the `varda2-client submit` command, alongside the variants file.

## Reference documentation
- [gvcf2coverage Overview](./references/anaconda_org_channels_bioconda_packages_gvcf2coverage_overview.md)
- [Varda2 Preprocessing Workflow](./references/github_com_varda_varda2_preprocessing.md)