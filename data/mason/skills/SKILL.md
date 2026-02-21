---
name: mason
description: The `mason` suite is a high-performance read simulator designed for generating synthetic sequencing data.
homepage: https://www.seqan.de/apps/mason.html
---

# mason

## Overview
The `mason` suite is a high-performance read simulator designed for generating synthetic sequencing data. It is particularly useful for benchmarking bioinformatics pipelines, testing variant callers, and evaluating assembly algorithms. The tool supports various sequencing technologies and allows for the simulation of both small-scale variations (SNPs, indels) and large-scale structural variations within a reference genome before sampling reads.

## Common CLI Patterns

### Simulating Variation (mason_variator)
Before simulating reads, you often need to generate a "gold standard" mutated genome.
```bash
mason_variator -ir reference.fasta -ov mutated.fasta -os vcf_gold_standard.vcf --snp-rate 0.001 --indel-rate 0.0001
```
- `-ir`: Input reference genome.
- `-ov`: Output path for the simulated genome.
- `-os`: Output path for the VCF file containing the ground truth variants.

### Simulating Illumina Reads (mason_simulator)
Generate paired-end Illumina reads from a reference.
```bash
mason_simulator -ir reference.fasta -n 1000000 -o left_reads.fq -or right_reads.fq --illumina-read-length 150
```
- `-n`: Number of fragments to simulate.
- `-o` / `-or`: Output files for left and right reads (FASTQ format).
- `--illumina-read-length`: Sets the length of the simulated reads.

### Simulating Other Technologies
Mason includes specific models for older or specialized technologies:
- **454**: Use `--sequencing-technology 454` to apply the flow-gram based error model.
- **Sanger**: Use `--sequencing-technology sanger` for longer reads with specific end-of-read degradation patterns.

## Expert Tips
- **Fragment Size**: For paired-end data, always specify the fragment size distribution using `--fragment-mean-size` and `--fragment-size-std-dev` to match your expected library preparation.
- **Seed for Reproducibility**: Use the `--seed` flag with a fixed integer to ensure that the simulated data is identical across different runs.
- **Quality Profiles**: Mason uses empirical models for Illumina quality scores. If your project requires specific error profiles, you can provide custom probability tables, though the defaults are generally sufficient for standard benchmarking.
- **Memory Management**: Mason is optimized for large genomes (e.g., Human), but ensure you have enough RAM to load the reference index, especially when using `mason_variator`.

## Reference documentation
- [Mason Application Page](./references/www_seqan_de_apps_mason.html.md)
- [Bioconda Mason Overview](./references/anaconda_org_channels_bioconda_packages_mason_overview.md)