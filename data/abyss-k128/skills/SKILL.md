---
name: abyss-k128
description: abyss-k128 is a parallelized de Bruijn graph assembler designed to assemble genomic sequences from short-read data using k-mer lengths up to 128. Use when user asks to perform de novo genome assembly, optimize memory usage with Bloom filters, or manage multi-library scaffolding for complex datasets.
homepage: http://www.bcgsc.ca/platform/bioinfo/software/abyss
metadata:
  docker_image: "quay.io/biocontainers/abyss-k128:2.0.2--boost1.64_2"
---

# abyss-k128

## Overview
ABySS (Assembly By Short Sequences) is a high-performance, parallelized de Bruijn graph assembler designed for short-read data. The `abyss-k128` package is a specific build allowing for k-mer lengths up to 128, which is essential for resolving complex genomic repeats in high-coverage datasets. This skill provides guidance on executing the `abyss-pe` driver script, optimizing memory usage via Bloom filters, and managing multi-library scaffolding.

## Core Usage Patterns

### Basic Assembly Pipeline
The primary interface is `abyss-pe`. At a minimum, you must provide a name for the assembly, the k-mer size (`k`), and the input read files.

```bash
abyss-pe name=my_assembly k=64 in='reads1.fastq reads2.fastq'
```

### Memory-Efficient Assembly (Bloom Filter Mode)
For large genomes (e.g., Human) where RAM is limited, use the Bloom filter mode introduced in ABySS 2.0. This reduces memory requirements by up to 10x.

Required parameters for Bloom filter mode:
- `B`: Bloom filter size (e.g., `B=34G` for human genome).
- `H`: Number of hash functions (typically `H=3`).
- `kc`: K-mer coverage threshold (e.g., `kc=3`).

```bash
abyss-pe name=human_asm k=96 B=36G H=3 kc=3 in='reads.fastq'
```

### Multi-Library Scaffolding
ABySS handles multiple libraries by defining them in stages: `lib` (paired-end), `mp` (mate-pair), and `long` (long reads or linked reads).

```bash
abyss-pe name=multi_lib k=80 \
    lib='pe1 pe2' \
    mp='mp1' \
    pe1='lib1_R1.fq lib1_R2.fq' \
    pe2='lib2_R1.fq lib2_R2.fq' \
    mp1='mate_R1.fq mate_R2.fq'
```

## Expert Tips and Best Practices

- **K-mer Selection**: For `abyss-k128`, higher k-mers (e.g., 90-120) are effective for high-coverage Illumina data to resolve repeats, but require higher read quality and coverage.
- **Parallel Execution**: Use `np` to specify the number of MPI processes for the initial unitig assembly stage.
  ```bash
  abyss-pe np=16 name=asm k=64 in='reads.fq'
  ```
- **Gap Closing**: Use the `Sealer` tool (integrated into `abyss-pe`) to close scaffold gaps using a Bloom filter representation of the reads.
- **Resource Management**: If encountering stack overflows on large datasets, increase the system stack limit (`ulimit -s unlimited`) before running the assembly.
- **Rescaffolding**: You can rescaffold existing assemblies using long sequences (like RNA-seq contigs) by providing them to the `long` parameter.

## Reference documentation
- [ABySS Software Overview](./references/www_bcgsc_ca_resources_software_abyss.md)
- [Bioconda abyss-k128 Package Details](./references/anaconda_org_channels_bioconda_packages_abyss-k128_overview.md)