---
name: pangenie
description: PanGenie is a k-mer based genotyper that uses a pangenome graph and a panel of known haplotypes to infer genotypes from short-read data. Use when user asks to genotype short reads against a pangenome graph, infer genotypes for structural variants, or perform k-mer based genotyping using a reference panel.
homepage: https://github.com/eblerjana/pangenie
metadata:
  docker_image: "quay.io/biocontainers/pangenie:4.2.1--h077b44d_0"
---

# pangenie

## Overview

PanGenie is a k-mer based genotyper that leverages a pangenome graph and a panel of known, fully assembled haplotypes to infer genotypes from short-read data. Unlike traditional linear mappers, PanGenie uses paths through the graph to account for complex variation and structural variants. It is designed for diploid individuals and requires a specific VCF format where variants are represented as bubbles in a directed acyclic graph.

## Input Requirements

PanGenie is sensitive to input VCF formatting. Ensure your input variants (-v) meet these criteria:
- **Multi-sample**: Must contain haplotype information for at least one known sample.
- **Fully-phased**: Haplotypes must be phased into a single block from start to end. Tools like WhatsHap are generally unsuitable as they produce multiple blocks.
- **Non-overlapping**: Overlapping variants must be merged into a single multi-allelic record.
- **Sequence-resolved**: REF and ALT sequences must be explicitly defined; symbolic records (e.g., `<DEL>`) are not supported.

## Core Workflow

The recommended approach uses a two-step process to save memory and allow for multi-sample genotyping using a shared index.

### 1. Preprocessing (Indexing)
Generate the k-mer index from the pangenome graph and reference genome.
```bash
PanGenie-index -v <variants.vcf> -r <reference.fa> -t <threads> -o <index_prefix>
```

### 2. Genotyping
Run the genotyper using the generated index and the subject's short reads.
```bash
PanGenie -f <index_prefix> -i <reads.fastq> -s <sample_name> -j <kmer_threads> -t <genotyping_threads> -o <output_prefix>
```

## Handling Complex VCFs

### Overlapping Variants
If your VCF contains overlapping records (common in `vg deconstruct` output), filter it with `vcfbub` before running PanGenie:
```bash
vcfbub -l 0 -r 100000 --input <input.vcf> > pangenie-ready.vcf
```

### Nested Variants (Decomposition)
Graph bubbles often contain multiple nested variants. To extract genotypes for these individual alleles, use the `convert-to-biallelic.py` script after genotyping:
```bash
cat <pangenie_output.vcf> | python3 convert-to-biallelic.py <callset.vcf> > <final_biallelic.vcf>
```
*Note: This requires a "callset VCF" that defines the individual variant IDs referenced in the graph VCF's INFO field.*

## Expert Tips and Best Practices

- **Memory Management**: Always use the two-step (`PanGenie-index` followed by `PanGenie -f`) workflow for large pangenomes to minimize memory overhead.
- **Haplotype Sampling**: If the input panel contains more than 100 haplotypes, PanGenie automatically switches to haplotype sampling (defaulting to 15) to maintain efficiency.
- **Read Input**: PanGenie expects all reads in a single FASTA or FASTQ file. If you have paired-end data, concatenate them or provide them as a single stream.
- **Thread Allocation**: Use `-j` for k-mer counting (I/O and memory intensive) and `-t` for the actual genotyping (CPU intensive).
- **Serialization**: Use the `-w` flag to serialize genotyping results if you intend to generate the final VCF separately using `PanGenie-vcf`.



## Subcommands

| Command | Description |
|---------|-------------|
| PanGenie | Genotyping based on kmer-counting and known haplotype sequences. |
| PanGenie-index | PanGenie - genotyping based on kmer-counting and known haplotype sequences. Indexing step. |
| PanGenie-vcf | Genotyping based on kmer-counting and known haplotype sequences using serialized genotyping results. |

## Reference documentation
- [PanGenie Main Documentation](./references/github_com_eblerjana_pangenie.md)
- [Genotyping variation nested inside of bubbles](./references/github_com_eblerjana_pangenie_wiki_A_--Genotyping-variation-nested-inside-of-bubbles.md)
- [Creating PanGenie input VCFs from assemblies](./references/github_com_eblerjana_pangenie_wiki_B_-Creating-PanGenie-input-VCFs-from-haplotype_E2_80_90resolved-assemblies.md)