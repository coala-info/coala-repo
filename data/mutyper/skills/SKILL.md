---
name: mutyper
description: mutyper polarizes and annotates biallelic SNPs with their ancestral k-mer context. Use when user asks to create ancestral sequences, annotate variants with mutation types, calculate mutation spectra, determine genomic targets, or generate k-mer site frequency spectra.
homepage: https://github.com/harrispopgen/mutyper
---


# mutyper

## Overview
`mutyper` is a specialized bioinformatics tool used to polarize and annotate biallelic SNPs with their ancestral k-mer context. By utilizing an ancestral sequence (typically in FASTA format) and a VCF file, it determines the specific mutation type (e.g., C>T in a GCG context) for every variant. This is a critical preprocessing step for downstream analyses like mutation spectrum history inference (often paired with the `mushi` package) or studying variation in mutation rates across different genomic contexts.

## Installation
The package is available via bioconda:
```bash
conda install bioconda::mutyper
```

## Common CLI Patterns

### 1. Ancestral Sequence Preparation
Before annotating variants, you often need to create or process an ancestral FASTA.
```bash
mutyper ancestor reference.fa alignment.vcf out_ancestor.fa
```

### 2. Variant Annotation
The core functionality involves adding mutation type information to the INFO field of a VCF. This requires the ancestral FASTA.
```bash
mutyper variants ancestral_sequence.fa input.vcf > annotated.vcf
```
*   **Note**: This command adds a `MUTATION_TYPE` entry to the VCF INFO field, representing the k-mer context (default is 3-mer).

### 3. Calculating Mutation Spectra
Once a VCF is annotated, you can collapse the variants into a mutation spectrum (counts of each mutation type per sample).
```bash
mutyper spectra annotated.vcf > spectrum.tsv
```
*   **Expert Tip**: Use the `--randomize` flag if you need to handle multi-allelic sites or specific downsampling requirements.
*   **Haploid Support**: `mutyper` supports haploid VCFs, which is useful for microbial data or male X-chromosome analysis.

### 4. Genomic Targets
To normalize mutation counts, you must calculate the "opportunity" or target size for each k-mer in the genome or a specific mask.
```bash
mutyper targets ancestral_sequence.fa --mask accessibility_mask.bed > targets.tsv
```

### 5. K-mer Site Frequency Spectra (kSFS)
For demographic and mutation rate inference, generate the site frequency spectrum partitioned by k-mer context.
```bash
mutyper ksfs annotated.vcf > ksfs.tsv
```

## Best Practices
- **Biallelic SNPs Only**: Ensure your input VCF contains only biallelic SNPs. `mutyper` is specifically designed for these; complex variants or indels should be filtered out beforehand.
- **Reference Compatibility**: The chromosome names in your ancestral FASTA must match those in your VCF exactly.
- **Missing Genotypes**: Recent versions of `mutyper` include improved handling for missing genotypes. If your VCF has high missingness, ensure you are using version 1.0.0 or later to avoid biased frequency estimates.
- **Compressed Inputs**: While `mutyper` supports many compressed formats, using `bgzip` and `tabix` on your VCF files is recommended for performance, especially when accessing specific genomic regions.

## Reference documentation
- [mutyper Overview](./references/anaconda_org_channels_bioconda_packages_mutyper_overview.md)
- [mutyper GitHub Repository](./references/github_com_harrispopgen_mutyper.md)
- [mutyper Issues and Feature Requests](./references/github_com_harrispopgen_mutyper_issues.md)