---
name: abyss
description: ABySS is a de novo sequence assembler designed for reconstructing large genomes from short-read sequencing data using a de Bruijn graph approach. Use when user asks to assemble genomes from short reads, perform parallel assembly using MPI, or use Bloom filters to reduce memory usage during assembly.
homepage: https://www.bcgsc.ca/platform/bioinfo/software/abyss
metadata:
  docker_image: "quay.io/biocontainers/abyss:2.3.10--hf316886_2"
---

# abyss

## Overview
ABySS is a specialized tool for reconstructing genomes from short-read sequencing data. It utilizes a de Bruijn graph approach to identify unambiguous paths that represent contigs. It is highly scalable, offering a single-processor mode for smaller genomes (<100 Mbp) and an MPI-based parallel version (ABYSS-P) for large-scale eukaryotic genomes. Modern versions also include a Bloom filter mode (ABySS 2.0+) which significantly reduces memory overhead, making large genome assembly possible on standard workstations.

## Common CLI Patterns

### Basic Assembly with abyss-pe
The primary driver script is `abyss-pe`. It manages the multi-stage pipeline from k-mer counting to scaffolding.

```bash
# Basic paired-end assembly
abyss-pe k=64 name=my_assembly in='reads1.fastq reads2.fastq'

# Assembly using Bloom filter mode (ABySS 2.0+) to save memory
# B = Bloom filter size (e.g., 32G, 40G), H = number of hash functions
abyss-pe k=96 B=32G H=3 name=human_asm in='lib1_R1.fq lib1_R2.fq'
```

### Parallel Assembly (MPI)
To run ABySS across multiple processors or nodes, use `mpirun` with `abyss-pe`.

```bash
# Run with 16 MPI processes
mpirun -np 16 abyss-pe k=64 name=large_genome in='reads1.fq reads2.fq'
```

### Handling Multiple Libraries
ABySS can incorporate multiple paired-end (`lib`) and mate-pair (`mp`) libraries.

```bash
abyss-pe k=64 name=multi_lib \
    lib='pe1 pe2' \
    pe1='pe1_1.fq pe1_2.fq' \
    pe2='pe2_1.fq pe2_2.fq' \
    mp='mp1' \
    mp1='mp1_1.fq mp1_2.fq'
```

## Expert Tips and Troubleshooting

### K-mer Length Limits
If you encounter the error `Assertion length <= 64 failed`, the k-mer size exceeds the compile-time limit.
- **Default**: Usually 128 in version 2.0+.
- **Solution**: Recompile from source using `./configure --enable-maxk=192` (must be a multiple of 32).

### Memory Optimization
- **MPI Overhead**: For very large runs (>1000 cores), Open MPI buffers can consume excessive RAM. Use `--mca btl_openib_receive_queues` to tune communication buffers.
- **Estimation**: Memory usage for the hash table is roughly `(8 + maxk/4) * n` bytes, where `n` is the number of distinct k-mers. Use `ntCard` to find the `F0` value (distinct k-mers) before starting.

### Avoiding Deadlocks at High K
When `k` is high (e.g., >200), message sizes may exceed the MPI "eager send limit," causing the job to hang.
- **Fix**: Set the eager limit in the `mpirun` environment variable:
  `export mpirun='mpirun --mca btl_sm_eager_limit 16000 --mca btl_openib_eager_limit 16000'`

### Read ID Requirements
ABySS requires paired reads to have matching IDs.
- **Format**: IDs must be identical or end in `/1` and `/2`.
- **Error**: `abyss-fixmate: error: All reads are mateless` indicates a mismatch in the FASTQ headers.

### Performance Tuning
- **Parallel Loading**: Split large input BAM/FASTQ files into smaller chunks (up to the number of MPI ranks). This allows parallel I/O and can shave hours off large assemblies.
- **Caveat**: Do not split a single library into more than ~50 files, as `abyss-map` may hit open-file limits.



## Subcommands

| Command | Description |
|---------|-------------|
| abyss-fatoagp | Convert FASTA files to AGP format using ABySS |
| abyss-sealer-b | Close gaps by using left and right flanking sequences of gaps as 'reads' for Konnector and performing multiple runs with each of the supplied K values. |
| make | A tool to control the generation of executables and other non-source files of a program from the program's source files. |

## Reference documentation
- [ABySS Users FAQ](./references/github_com_BirolLab_abyss_wiki_ABySS-Users-FAQ.md)
- [ABySS File Formats](./references/github_com_BirolLab_abyss_wiki_ABySS-File-Formats.md)
- [ABySS Performance Tips](./references/github_com_BirolLab_abyss_wiki_ABySS-Performance-Tips.md)
- [ABYSS-P Source Code Overview](./references/github_com_BirolLab_abyss_wiki_ABYSS-P-Source-Code-Overview.md)