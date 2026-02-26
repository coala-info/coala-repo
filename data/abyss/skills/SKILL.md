---
name: abyss
description: ABySS is a genomic sequence assembler designed to reconstruct long sequences from short-read data using a distributed de Bruijn graph or Bloom filters. Use when user asks to assemble large genomes, configure k-mer sizes for assembly, perform scaffolding, or close gaps in scaffolds.
homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss
---


# abyss

## Overview

ABySS (Assembly By Short Sequences) is a specialized tool for reconstructing long genomic sequences from short-read data. It is particularly effective for large genomes due to its ability to distribute the de Bruijn graph across multiple nodes using MPI or to utilize a Bloom filter-based approach (ABySS 2.0+) to significantly reduce memory requirements. Use this skill to guide the configuration of assembly pipelines, select appropriate k-mer sizes, and manage scaffolding parameters.

## Installation and Setup

Install ABySS via Bioconda for the most stable environment:

```bash
conda install -c bioconda abyss
```

For large assemblies, ensure an MPI library (like OpenMPI) is installed if using the parallel distributed mode.

## Core Workflow with abyss-pe

The `abyss-pe` (ABySS Parallel Executive) script is the primary driver for the assembly pipeline. It manages stages from initial contig generation to scaffolding and gap closing.

### Basic Assembly
To run a standard assembly, specify the k-mer size, a name for the output, and the input files:

```bash
abyss-pe k=64 name=project_name in='reads_1.fq reads_2.fq'
```

### Memory-Efficient Assembly (Bloom Filter Mode)
For large genomes (e.g., human) on systems with limited RAM, use the Bloom filter mode introduced in ABySS 2.0. This requires setting the `B`, `H`, and `kc` parameters:

- `B`: Bloom filter size (e.g., `B=34G` for human).
- `H`: Number of hash functions (typically `H=3` or `H=4`).
- `kc`: K-mer coverage threshold (e.g., `kc=3`).

Example:
```bash
abyss-pe k=64 B=34G H=3 kc=3 name=human_asm in='reads.fq'
```

### Parallel Execution
Control the number of threads or MPI processes:
- For multi-threading: `abyss-pe j=8 ...`
- For MPI distributed assembly: `abyss-pe np=48 ...`

## Parameter Optimization

### Scaffolding and Contiguity
- `s`: Minimum unitig size required for scaffolding (default is often 200bp).
- `n`: Minimum number of pairs required to link two contigs.
- `mp`: Specify mate-pair libraries for long-range scaffolding.
- `l`: Minimum alignment length for a read to be used for scaffolding.

### RNA-Seq and High Coverage
When assembling transcriptomes or high-coverage data:
- Use `xtip=1` to more aggressively remove assembly tips caused by sequencing errors in high-coverage regions.
- Use `Q` to set a minimum base quality threshold to filter out low-quality k-mers before assembly.

## Specialized Tools

- **Sealer**: Use `abyss-sealer` to close gaps in finished scaffolds using a Bloom filter representation of the reads.
- **Konnector**: Use to merge overlapping paired-end reads into longer pseudo-reads before assembly to improve contiguity.
- **abyss-fatoagp**: Use to convert the final assembly into AGP format for GenBank submission.

## Best Practices

- **K-mer Selection**: Start with a k-mer size approximately 60-70% of the read length. Smaller k-mers increase sensitivity but also increase graph complexity and memory usage.
- **Data Pre-processing**: Always perform adapter trimming and quality filtering before running ABySS to reduce the number of erroneous k-mers.
- **Resource Estimation**: For MPI mode, memory usage scales with the number of unique k-mers. For Bloom filter mode, memory is fixed by the `B` parameter.

## Reference documentation
- [ABySS Overview and Installation](./references/anaconda_org_channels_bioconda_packages_abyss_overview.md)
- [ABySS Software Features and Publications](./references/www_bcgsc_ca_resources_software_abyss.md)