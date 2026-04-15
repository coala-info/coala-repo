---
name: shapeit5
description: SHAPEIT5 is a high-performance software suite designed for accurate haplotype estimation and phasing of common and rare variants in large-scale genomic cohorts. Use when user asks to phase common variants or SNP arrays, phase rare variants using a scaffolded approach, ligate phased genomic chunks, or calculate switch error rates for validation.
homepage: https://odelaneau.github.io/shapeit5/
metadata:
  docker_image: "quay.io/biocontainers/shapeit5:5.1.1--h34261f4_2"
---

# shapeit5

## Overview

SHAPEIT5 is a high-performance software suite designed for accurate haplotype estimation in massive genomic cohorts. It is particularly optimized for rare variant phasing in Whole Genome Sequencing (WGS) and Whole Exome Sequencing (WES) data. The toolset follows a modular "scaffolded" approach: common variants are phased first to create a backbone, and rare variants are subsequently phased onto this backbone. This multi-step workflow allows SHAPEIT5 to handle hundreds of thousands of samples while maintaining high accuracy for variants with very low minor allele frequencies.

## Core Workflows

### 1. Phasing Common Variants (or SNP Arrays)
Use `phase_common` for SNP array data or as the initial step for sequencing data (typically variants with MAF > 0.1%).

```bash
phase_common --input input.bcf --region 1 --map chr1.gmap.gz --output phased_common.bcf --thread 8
```

**Expert Tips:**
- **Pedigree Data**: If family information is available, use `--pedigree family.fam` to improve accuracy and ensure correct parental transmission in the output.
- **Reference Panels**: Use `--reference panel.bcf` to phase your target samples against a known reference (e.g., 1000 Genomes).
- **Scaffolding**: Use `--scaffold scaffold.bcf` to fix the phase of specific sites based on prior high-confidence phasing.

### 2. Ligating Chunks
When phasing large chromosomes in chunks, use `ligate` to merge them into a single file while maintaining phase consistency across boundaries.

```bash
# Create a sorted list of chunks
ls -1v chunk*.bcf > chunks.txt

# Ligate
ligate --input chunks.txt --output whole_chr.bcf --thread 4
```

**Critical Note**: If the chunks were phased using pedigree information, you **must** provide the same `--pedigree` file to `ligate` to prevent phase flips in offspring.

### 3. Phasing Rare Variants
For sequencing datasets (>2,000 samples), phase rare variants onto the common variant scaffold using `phase_rare`.

```bash
phase_rare --input wgs_data.bcf --scaffold phased_common.bcf --map chr1.gmap.gz --input-region 1:1000-5000 --scaffold-region 1:500-5500 --output rare_phased.bcf --thread 8
```

**Best Practices:**
- **Region Buffers**: The `--scaffold-region` must be larger than the `--input-region` (typically 0.5Mb buffer on each side) to provide context for the rare variants at the edges.
- **Chunking**: Use the GLIMPSE chunking tool to generate optimal coordinates for large-scale processing.

### 4. Chromosome X Phasing
Handle haploid regions (males on ChrX) by providing a list of haploid samples.

```bash
phase_common --input chrx.bcf --haploids males.txt --region X --output chrx_phased.bcf
```

## Benchmarking and Validation
Use `switch` to calculate Switch Error Rate (SER) and Genotyping Error Rate (GER) against a validation set (e.g., trios or simulated data).

```bash
switch --validation truth.bcf --estimation phased.bcf --region 1 --output benchmark_results --thread 4
```

**Interpreting Results:**
- `*.sample.switch.txt.gz`: Provides the SER per sample (the most common metric).
- `*.frequency.switch.txt.gz`: Provides SER stratified by Minor Allele Count (MAC), useful for assessing rare variant performance.

## General Best Practices
- **File Formats**: Use BCF instead of VCF for significantly faster I/O.
- **Threads**: Most SHAPEIT5 tools scale well with `--thread`. Match this to your available CPU cores.
- **Genetic Maps**: Always provide a genetic map (`--map`) specific to the assembly (b37/b38). If omitted, the tool assumes a flat 1 cM/Mb rate, which is less accurate.
- **Memory**: For extremely large datasets, consider using the XCF format via `xcftools` for optimized memory mapping.

## Reference documentation
- [phase_common Documentation](./references/odelaneau_github_io_shapeit5_docs_documentation_phase_common.md)
- [phase_rare Documentation](./references/odelaneau_github_io_shapeit5_docs_documentation_phase_rare.md)
- [ligate Documentation](./references/odelaneau_github_io_shapeit5_docs_documentation_ligate.md)
- [switch Documentation](./references/odelaneau_github_io_shapeit5_docs_documentation_switch.md)