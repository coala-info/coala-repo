---
name: pangenie
description: PanGenie infers genotypes by comparing short-read k-mer distributions against a pangenome graph of assembled haplotypes. Use when user asks to genotype short reads using a pangenome reference, index a pangenome VCF, or call structural variants using a haplotype panel.
homepage: https://github.com/eblerjana/pangenie
---


# pangenie

## Overview
PanGenie is a specialized bioinformatics tool that infers genotypes by comparing short-read k-mer distributions against a pangenome graph. Unlike traditional linear mappers, it uses a panel of assembled haplotypes to provide context for variants, including complex structural variations. It is most effective when working with high-quality pangenome references (like those from HPRC or HGSVC) and requires input VCFs to be sequence-resolved and phased into single blocks.

## Input Requirements
To ensure successful genotyping, input files must meet strict criteria:
- **VCF (-v):** Must be multi-sample, fully-phased (single block per sample), and sequence-resolved (no symbolic alleles).
- **Non-overlapping Variants:** Overlapping variants must be merged into multi-allelic records. If using `vg deconstruct`, filter with `vcfbub -l 0`.
- **Reads (-i):** Short-read data in a single FASTA or FASTQ file.
- **Reference (-r):** Reference genome in FASTA format.

## Command Line Usage

### Recommended Two-Step Workflow
The two-step process is more memory-efficient and allows the index to be reused for multiple samples.

1. **Index the Pangenome:**
   ```bash
   PanGenie-index -v <variants.vcf> -r <reference.fa> -o <prefix> -t <threads>
   ```

2. **Genotype the Sample:**
   ```bash
   PanGenie -f <prefix> -i <reads.fq> -s <sample_name> -j <kmer_threads> -t <genotype_threads>
   ```

### One-Step Workflow
Use this for quick runs where memory is not a constraint:
```bash
PanGenie -i <reads.fq> -r <reference.fa> -v <variants.vcf> -s <sample_name> -t <threads>
```

### Advanced Options and Performance
- **Haplotype Sampling:** If your panel contains >100 haplotypes, PanGenie automatically switches to sampling (default 15 haplotypes) to maintain performance.
- **Serialization:** Use the `-w` flag in `PanGenie` to serialize results instead of writing a VCF immediately. You can then use `PanGenie-vcf` to generate the VCF separately.
- **Thread Allocation:** Use `-j` for k-mer counting threads and `-t` for the core genotyping algorithm.

## Expert Tips
- **VCF Preparation:** If your VCF contains overlapping alleles (common in PAV or other callers), use the Snakemake pipeline in `pipelines/run-from-callset/` to merge them before running the main tool.
- **Memory Management:** The `PanGenie-index` step significantly reduces the memory footprint of subsequent genotyping runs. Always prefer this for large pangenomes (e.g., Human).
- **Diploid Only:** Note that PanGenie is currently optimized for diploid individuals; results for haploid organisms or polyploid plants may not be reliable.

## Reference documentation
- [PanGenie GitHub Repository](./references/github_com_eblerjana_pangenie.md)
- [PanGenie Wiki](./references/github_com_eblerjana_pangenie_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pangenie_overview.md)