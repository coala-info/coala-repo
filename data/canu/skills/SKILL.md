---
name: canu
description: Canu is a hierarchical assembly pipeline that corrects, trims, and assembles long-read sequencing data into high-quality contigs. Use when user asks to assemble genomes from PacBio or Oxford Nanopore reads, perform trio binning for haplotype-resolved assemblies, or correct and trim noisy long-read data.
homepage: https://github.com/marbl/canu
---

# canu

## Overview

Canu is a specialized hierarchical assembly pipeline designed to handle the high error rates associated with long-read sequencing technologies. It operates through three distinct phases: **Correction** (improving base accuracy), **Trimming** (removing adapters and low-quality regions), and **Assembly** (ordering reads into contigs/unitigs). 

The tool is highly automated, capable of detecting available hardware resources (CPU/Memory) and grid engines (SLURM, SGE, PBS, etc.) to scale from a single workstation to a massive compute cluster. It is idempotent, meaning it can safely resume interrupted runs by re-evaluating the state of the output directory.

## Core CLI Usage

The basic syntax for a Canu run requires a project prefix, an output directory, an estimated genome size, and the input read type.

```bash
canu \
  -p <project_prefix> \
  -d <output_directory> \
  genomeSize=<size>[g|m|k] \
  -[pacbio|nanopore|pacbio-hifi] <input_files>
```

### Common Input Types
- `-pacbio`: Raw PacBio CLR reads.
- `-nanopore`: Raw Oxford Nanopore reads.
- `-pacbio-hifi`: PacBio High-Fidelity (CCS) reads (skips initial correction).
- `-nanopore-raw`: Explicitly identifies raw ONT reads.

## Expert Tips and Best Practices

### Resource Management
- **Local Execution**: If working on a single machine and you want to prevent Canu from attempting to submit jobs to a detected grid, use `useGrid=false`.
- **Memory/Threads**: Limit resources manually if the auto-detection is too aggressive:
  ```bash
  maxMemory=64g maxThreads=16
  ```
- **Grid Options**: Pass specific cluster parameters (like partitions or accounts) using `gridOptions`:
  ```bash
  gridOptions="--partition=long --account=bio"
  ```

### Handling Coverage and Error Rates
- **Low Coverage (< 30x)**: Increase the `correctedErrorRate` to be more inclusive of overlaps:
  ```bash
  correctedErrorRate=0.105
  ```
- **High Coverage (> 60x)**: Decrease the `correctedErrorRate` to speed up the run and reduce false overlaps:
  ```bash
  correctedErrorRate=0.035
  ```
- **Read Sampling**: If you have excessive coverage (e.g., >100x), use `readSamplingCoverage=100` to reduce the computational burden while keeping the longest reads.

### Specialized Workflows
- **Trio Binning**: Assemble haplotype-resolved genomes using parental short-read data:
  ```bash
  canu -p offspring -d assembly \
    genomeSize=3g \
    -haplotypeFather father_kmers.fasta \
    -haplotypeMother mother_kmers.fasta \
    -pacbio offspring_reads.fastq
  ```
- **Manual Stepping**: You can run phases individually to test different assembly parameters without re-running correction:
  1. `-correct`: Generate corrected reads.
  2. `-trim`: Trim corrected reads.
  3. `-assemble`: Build the final assembly using `-trimmed -corrected` flags.

### Troubleshooting
- **Resuming**: If a run fails (power outage, disk space), simply run the **exact same command** again. Canu will skip completed steps.
- **Empty Contigs**: If `asm.contigs.fasta` is empty, check `asm.report`. This often indicates that `genomeSize` was set significantly higher than the actual data coverage supports, or that the `minOverlapLength` is too high for the read lengths provided.
- **Circular Elements**: For small circular genomes (plasmids, mitochondria), Canu may produce overlapping ends. Use tools like `bercca` or `circlator` to trim and orient the final circular contig.



## Subcommands

| Command | Description |
|---------|-------------|
| canu | Canu is a de novo assembler for long-read sequencing data. It is designed to produce high-quality assemblies from PacBio, Nanopore, and other long-read technologies. |
| canu | To restrict canu to only a specific stage, use:     -haplotype     - generate haplotype-specific reads     -correct       - generate corrected reads     -trim          - generate trimmed reads     -assemble      - generate an assembly     -trim-assemble - generate trimmed reads and then assemble them |
| canu | Canu is a de novo assembler for highly accurate long-read sequencing data. It is particularly well-suited for PacBio and Nanopore sequencing data, and can also be used for shorter reads. This command is specifically for generating haplotype-specific reads. |
| canu | Canu is a de novo assembler for long, noisy reads. It is designed to assemble genomes from PacBio, Nanopore, and other long-read technologies. It can also be used to assemble genomes from short reads, but it is not as efficient as other short-read assemblers. |
| canu | To restrict canu to only a specific stage, use:     -haplotype     - generate haplotype-specific reads     -correct       - generate corrected reads     -trim          - generate trimmed reads     -assemble      - generate an assembly     -trim-assemble - generate trimmed reads and then assemble them |

## Reference documentation
- [Canu Quick Start](./references/canu_readthedocs_io_en_latest_quick-start.html.md)
- [Canu Parameter Reference](./references/canu_readthedocs_io_en_latest_parameter-reference.html.md)
- [Canu FAQ](./references/canu_readthedocs_io_en_latest_faq.html.md)
- [Canu Tutorial](./references/canu_readthedocs_io_en_latest_tutorial.html.md)