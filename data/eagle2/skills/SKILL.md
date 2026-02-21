---
name: eagle2
description: Eagle2 is a high-efficiency software package designed to estimate haplotype phase.
homepage: https://github.com/poruloh/Eagle
---

# eagle2

## Overview
Eagle2 is a high-efficiency software package designed to estimate haplotype phase. It employs a fast HMM-based algorithm powered by the Positional Burrows-Wheeler Transform (PBWT), making it significantly faster and more accurate than previous iterations, especially for sample sizes under 50,000. It is the default phasing method for the Sanger and Michigan imputation servers. Use this skill to execute phasing workflows, manage reference panels, and process specific genomic regions.

## Installation
Install eagle2 via Bioconda:
```bash
conda install bioconda::eagle2
```

## Common CLI Patterns

### Basic Phasing (No Reference)
To phase a genotyped cohort without an external reference panel:
```bash
eagle \
  --vcf target_samples.vcf.gz \
  --geneticMapFile genetic_map_hg38.txt \
  --outPrefix phased_output \
  --numThreads 8
```

### Phasing with a Reference Panel
To improve accuracy by using a phased reference (e.g., 1000 Genomes or HRC):
```bash
eagle \
  --vcf target_samples.vcf.gz \
  --refVcf reference_panel.vcf.gz \
  --geneticMapFile genetic_map_hg38.txt \
  --outPrefix phased_with_ref
```

### Phasing Chromosome X
Eagle2 supports the unique ploidy requirements of Chromosome X. Use the following flag to respect the ploidy of missing genotypes:
```bash
eagle \
  --vcf target_chrX.vcf.gz \
  --chrom X \
  --keepMissingPloidyX \
  --geneticMapFile genetic_map_chrX.txt \
  --outPrefix phased_chrX
```

### Region-Specific Phasing
To restrict phasing to a specific genomic window:
```bash
eagle \
  --vcf target.vcf.gz \
  --chrom 22 \
  --bpStart 20000000 \
  --bpEnd 30000000 \
  --geneticMapFile map_chr22.txt \
  --outPrefix phased_region
```

## Expert Tips and Best Practices

- **Genetic Map Format**: Ensure your `--geneticMapFile` contains exactly four columns. The tool is strict about this schema.
- **Large Cohorts**: For extremely large datasets (N > 200,000) in non-reference mode, Eagle2 may require or force the `--pbwtOnly` flag to manage memory and computational load.
- **Handling Allele Flips**: If your target and reference panels have swapped alleles, use `--allowRefAltSwap`. Note that this only applies to SNPs, not indels.
- **Output Control**: If you are phasing against a reference and want to include sites present in the target but not the reference (leaving them unphased), use the `--outputUnphased` flag.
- **Legacy Support**: If you need to replicate results from older pipelines, the Eagle1 algorithm is still accessible via the `--v1` flag.
- **VCF Requirements**: Eagle2 supports compressed VCF files (.vcf.gz). Ensure your input VCFs are indexed (using `tabix`) for efficient region-based access.
- **Missing Data**: Use `--noImpMissing` if you want to prevent the software from imputing missing genotypes during the phasing process.

## Reference documentation
- [eagle2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_eagle2_overview.md)
- [GitHub - poruloh/Eagle: Haplotype phasing software](./references/github_com_poruloh_Eagle.md)
- [Commits · poruloh/Eagle · GitHub](./references/github_com_poruloh_Eagle_commits_master.md)