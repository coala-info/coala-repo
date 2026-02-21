---
name: graphtyper
description: Graphtyper is a graph-based variant caller designed for population-scale genomic analysis.
homepage: https://github.com/DecodeGenetics/graphtyper
---

# graphtyper

## Overview

Graphtyper is a graph-based variant caller designed for population-scale genomic analysis. Unlike traditional linear reference callers, it represents the reference genome and known variants as an acyclic pangenome graph. By re-aligning high-throughput sequence reads to this graph structure, it achieves high sensitivity and specificity for discovering and genotyping SNPs, small indels, and structural variations. It is particularly useful for large-scale projects where consistency across many samples is required.

## Core Workflows

### Small Variant Genotyping (SNPs and Indels)
To genotype small variants within a specific genomic region, use the `genotype` subcommand. This requires a reference FASTA and a list of BAM or CRAM files.

```bash
graphtyper genotype <REFERENCE.fa> \
  --sams=<BAMLIST_OR_CRAMLIST> \
  --region=<chrA:begin-end> \
  --threads=<T>
```

### Structural Variant (SV) Genotyping
For structural variants, use the `genotype_sv` subcommand. This requires an input VCF containing the SV candidates to be genotyped.

```bash
graphtyper genotype_sv <REFERENCE.fa> <input.vcf.gz> \
  --sams=<BAMLIST_OR_CRAMLIST> \
  --region=<chrA:begin-end> \
  --threads=<T>
```

### Merging Results
After running genotyping on multiple regions or batches, use `vcf_merge` to aggregate the results into a single population VCF.

```bash
graphtyper vcf_merge <VCF_FILES...> --output=<merged.vcf.gz>
```

## Expert Tips and Best Practices

- **Input Lists**: The `--sams` argument can take a text file containing a list of paths to BAM/CRAM files (one per line). This is the preferred method for population-scale runs.
- **Region Parallelization**: Graphtyper is designed to be run in parallel across genomic regions. For whole-genome analysis, split the genome into chunks (e.g., 1MB or by chromosome) and execute separate tasks.
- **Bamshrink**: Graphtyper often uses an internal tool called `bamshrink` to reduce data volume. If you have already pre-processed your alignments or wish to skip this step to save time on specific infrastructures, use the `--no_bamshrink` flag.
- **Memory Management**: When genotyping large cohorts, ensure the `--threads` parameter matches your available CPU cores, but monitor memory usage as graph-based alignment is more memory-intensive than linear alignment.
- **PopVCF Encoding**: For very large cohorts, consider using the `--popvcf` encoding option during `genotype_sv` or `vcf_merge` to produce more compact VCF representations.
- **Filtering**: After genotyping, apply filters based on the quality metrics provided in the VCF (e.g., FT, QUAL). Refer to the version-specific filtering guides in the wiki for recommended thresholds.

## Reference documentation
- [Main README](./references/github_com_DecodeGenetics_graphtyper.md)
- [Graphtyper Wiki](./references/github_com_DecodeGenetics_graphtyper_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_graphtyper_overview.md)