---
name: glnexus
description: GLnexus is a high-performance, scalable tool designed for the joint-genotyping of large cohorts.
homepage: https://github.com/dnanexus-rnd/GLnexus
---

# glnexus

## Overview

GLnexus is a high-performance, scalable tool designed for the joint-genotyping of large cohorts. It addresses the "N+1" problem in genomics by merging individual gVCF files into a unified project VCF (pVCF). It is specifically optimized for population-scale sequencing projects, such as those involving hundreds of thousands of exomes or genomes. The tool uses RocksDB for efficient intermediate storage and provides several configuration presets tailored to different variant callers to ensure scientific accuracy in the merged output.

## Common CLI Patterns

### Basic Cohort Merging
The most common use case is merging a set of gVCF files using a specific configuration preset.
```bash
glnexus_cli --config DeepVariant input1.g.vcf.gz input2.g.vcf.gz > cohort.pvcf
```

### Merging Large Numbers of Samples
When dealing with hundreds or thousands of files, use a manifest file (a text file containing one path per line) to avoid shell command-line length limits.
```bash
glnexus_cli --config DeepVariant_unfiltered -l gvcf_list.txt > cohort.pvcf
```

### Multi-threaded Execution
Scale the process by specifying the number of threads.
```bash
glnexus_cli --threads 16 --config DeepVariantWES input/*.g.vcf.gz > cohort.pvcf
```

## Configuration Presets
Choosing the correct `--config` is critical for the scientific validity of the results. Common presets include:
- `DeepVariant`: Standard for DeepVariant whole-genome sequencing.
- `DeepVariantWES`: Optimized for DeepVariant whole-exome sequencing.
- `gatk`: For GATK HaplotypeCaller gVCFs.
- `weCall`: For weCall gVCFs.
- `DeepVariant_unfiltered` / `gatk_unfiltered`: Presets that skip certain quality filters during the merge.

## Expert Tips and Best Practices

### Managing Intermediate Storage
GLnexus uses RocksDB to manage data during the merge process. For large cohorts, this database can grow significantly.
- **Specify Scratch Directory**: Use the `--dir` flag to point to a fast SSD or a directory with ample space.
- **Cleanup**: By default, GLnexus may leave the database directory behind if it crashes. Ensure you have a cleanup routine for the directory specified in `--dir`.

### Input Requirements
- **Indexing**: All input gVCF files must be indexed (typically `.tbi` files).
- **Normalization**: While GLnexus handles many representation differences, ensuring consistent reference genome versions across all input gVCFs is mandatory.

### Performance Tuning
- **Memory**: GLnexus is memory-intensive. Ensure the host has sufficient RAM (typically 2-4GB per thread as a baseline for large human cohorts).
- **I/O**: Since the tool relies on RocksDB, disk I/O is often the bottleneck. Running on NVMe storage significantly improves performance compared to standard HDDs or network-attached storage.

### Handling Haploid Chromosomes
For sex chromosomes in males or mitochondrial data, ensure the input gVCFs correctly represent haploid calls. GLnexus will process these based on the provided configuration logic.

## Reference documentation
- [GLnexus GitHub Repository](./references/github_com_dnanexus-rnd_GLnexus.md)
- [GLnexus Wiki Overview](./references/github_com_dnanexus-rnd_GLnexus_wiki.md)