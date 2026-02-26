---
name: freebayes
description: Freebayes is a haplotype-based variant caller that identifies small genetic variations by analyzing reads aligned to a reference genome. Use when user asks to call variants, perform joint calling across multiple samples, identify variants in polyploid or pooled samples, or generate a GVCF.
homepage: https://github.com/freebayes/freebayes
---


# freebayes

## Overview
Freebayes is a haplotype-based variant caller that identifies small genetic variations by analyzing the sequences of reads aligned to a reference genome. Unlike position-based callers, it evaluates the likelihood of specific haplotypes, making it robust against alignment artifacts. It is particularly effective for population-scale joint calling, non-diploid organisms, and pooled sequencing projects where allele frequencies are needed.

## Core CLI Patterns

### Basic Variant Calling
To call variants for a single diploid sample, provide the reference FASTA and a sorted BAM/CRAM file:
```bash
freebayes -f reference.fa alignment.bam > output.vcf
```

### Joint Calling
Provide multiple BAM files to perform joint calling across a population. This improves sensitivity for low-frequency variants shared across samples:
```bash
freebayes -f reference.fa sample1.bam sample2.bam sample3.bam > population.vcf
```

### Targeted Calling (Regions)
Limit analysis to specific chromosomes or coordinates to save time:
```bash
# Specific chromosome
freebayes -f reference.fa -r chr1 alignment.bam > chr1.vcf

# Specific range
freebayes -f reference.fa -r chr1:1000-2000 alignment.bam > region.vcf
```

## Advanced Configurations

### Ploidy and Pooled Samples
Freebayes defaults to diploid (-p 2). Adjust this for different organisms or experimental designs:
*   **Polyploidy**: Use `-p` to set the number of copies (e.g., `-p 4` for tetraploid).
*   **Pooled Discrete**: Use `--pooled-discrete` if your BAM contains samples that are themselves pools of a known number of individuals.
*   **Pooled Continuous**: Use `--pooled-continuous` for samples with unknown or extremely high ploidy where you want frequency-based calls.

### Performance and Parallelization
For large genomes, use `freebayes-parallel` to distribute the workload across CPU cores. This requires a regions file, typically generated from the FASTA index (.fai):
```bash
freebayes-parallel <(fasta_generate_regions.py reference.fa.fai 100000) 12 \
    -f reference.fa alignment.bam > parallel_output.vcf
```

### Filtering and Quality Control
*   **Observation Thresholds**: Use `-C` (min alternate observations) and `-F` (min alternate fraction) to reduce noise.
*   **High Coverage Skip**: Use `-g` (or `--skip-coverage`) to bypass regions with excessive depth (e.g., `-g 1000`), which often represent repetitive elements and slow down processing.
*   **GVCF Output**: Use `--gvcf` to include non-polymorphic sites in the output, useful for downstream merging and identifying "no-call" regions.

## Expert Tips
*   **Memory Management**: When using high ploidy settings, limit memory usage by setting `--use-best-n-alleles` to a low number (e.g., 4 or 6).
*   **Input Priors**: You can use an existing VCF as a source of prior information with `-@ in.vcf.gz` to force calls at known sites.
*   **Haplotype Length**: For complex regions, adjusting `--haplotype-length` (default is often sufficient) can help in resolving multi-nucleotide polymorphisms (MNPs).

## Reference documentation
- [freebayes Main Repository and Manual](./references/github_com_freebayes_freebayes.md)
- [Bioconda freebayes Overview](./references/anaconda_org_channels_bioconda_packages_freebayes_overview.md)