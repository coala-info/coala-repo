---
name: x-mapper
description: x-mapper is a high-performance genomic sequence aligner designed for speed and accuracy.
homepage: https://github.com/mathjeff/mapper
---

# x-mapper

## Overview

x-mapper is a high-performance genomic sequence aligner designed for speed and accuracy. It is optimized for mapping reads to one or more reference genomes while providing integrated variant calling capabilities. Use this skill to streamline the process of converting raw sequencing data into aligned SAM files or mutation summaries (VCF/TXT), especially when working with complex datasets that benefit from ancestor inference or specific mutation depth thresholds.

## Installation

The tool is available via Bioconda or as a standalone Java executable.

```bash
# Install via Conda
conda install bioconda::x-mapper

# Run via JAR (if downloaded manually)
java -jar x-mapper.jar [options]
```

## Core CLI Patterns

### Basic Single-End Alignment
To align single-end reads and generate a SAM file:
```bash
java -jar x-mapper.jar --reference ref.fasta --queries reads.fastq --out-sam output.sam
```

### Paired-End Alignment
For Illumina-style paired-end reads, use `--paired-queries`. You can optionally adjust the expected inner distance with `--spacing`.
```bash
java -jar x-mapper.jar --reference ref.fasta --paired-queries r1.fastq r2.fastq --spacing 100 50 --out-vcf variants.vcf
```

### Multi-Reference Mapping
x-mapper supports mapping against multiple reference genomes simultaneously by repeating the flag:
```bash
java -jar x-mapper.jar --reference virus_a.fa --reference virus_b.fa --queries sample.fq --out-refs-map-count counts.txt
```

## Output Configuration

x-mapper provides several specialized output formats beyond standard SAM files:

- **VCF (`--out-vcf`)**: Generates a description of mutation counts by position.
- **Mutation List (`--out-mutations`)**: A text file listing specific mutations detected in queries compared to the reference.
- **Map Counts (`--out-refs-map-count`)**: Summarizes how many reads mapped to each reference genome (useful for metagenomics or contamination checks).
- **Unaligned Reads (`--out-unaligned`)**: Exports reads that failed to map for further troubleshooting.

## Expert Tips and Best Practices

### Ancestor Inference
If working with evolving populations or closely related strains, use the `--infer-ancestors` flag. This allows the tool to identify parts of the genome that likely shared a common ancestor, lowering the penalty for mismatches that align with the inferred ancestor.

### Tuning Variant Detection
You can control the sensitivity of variant calling using depth and fraction thresholds:
- **SNPs**: Use `--snp-threshold <min_total_depth> <min_supporting_fraction>` (Default for mutations file: 5, 0.9).
- **Indels**: Use `--indel-threshold` to set both start and continuation thresholds simultaneously.

### Handling Long Reads
For long-read data where rearrangements are expected, use the experimental `--split-queries-past-size <size>` option to break long queries into smaller segments, which can improve performance and detection accuracy.

### Resource Management
x-mapper is designed for speed but requires significant memory. Ensure your environment has sufficient RAM allocated, especially when using large or multiple reference genomes.

## Reference documentation
- [X-Mapper GitHub Repository](./references/github_com_mathjeff_Mapper.md)
- [Bioconda x-mapper Overview](./references/anaconda_org_channels_bioconda_packages_x-mapper_overview.md)