---
name: cloudspades
description: cloudspades is a genome assembly tool designed to reconstruct genomes from linked-read sequencing data by utilizing molecular barcodes to resolve complex genomic regions. Use when user asks to assemble 10x Genomics data, perform Tell-Seq assembly, process haplotagging datasets, or conduct hybrid assemblies with linked reads.
homepage: https://github.com/ablab/spades
---


# cloudspades

## Overview
cloudspades is a specialized module of the SPAdes (St. Petersburg Genome Assembler) suite tailored for linked-read technologies. While standard assemblers treat short reads as independent fragments, cloudspades utilizes the molecular barcodes attached to reads to determine which fragments originated from the same long DNA molecule. This allows the assembler to bridge gaps in the assembly graph and resolve complex repetitive regions that are otherwise unresolvable with standard Illumina data. It is the primary choice within the SPAdes ecosystem for 10x Genomics, Tell-Seq, and Haplotagging datasets.

## Installation and Setup
cloudspades is typically distributed as part of the standard SPAdes package.
- **Conda**: `conda install -c bioconda spades` (or specifically `cloudspades`).
- **Verification**: Run `spades.py --test` to ensure the environment and dependencies (Python 3.8+, zlib, libbz2) are correctly configured.

## Command Line Usage Patterns

### 10x Genomics Data
For 10x Genomics linked reads, provide the paired-end files. cloudspades will automatically detect and process the barcodes.
```bash
spades.py --10x-1 reads_R1.fastq.gz --10x-2 reads_R2.fastq.gz -o assembly_output
```

### Tell-Seq Data
Tell-Seq requires the two read files and the specific barcode index file.
```bash
spades.py --tellseq-1 R1.fastq.gz --tellseq-2 R2.fastq.gz --tellseq-barcodes I1.fastq.gz -o assembly_output
```

### Haplotagging Data
Similar to other linked-read modes, use the specific haplotagging flags:
```bash
spades.py --haplotagging-1 R1.fastq.gz --haplotagging-2 R2.fastq.gz -o assembly_output
```

### Hybrid Assembly
You can supplement linked-read data with long reads (PacBio or Nanopore) to further improve the assembly:
```bash
spades.py --10x-1 R1.fq --10x-2 R2.fq --nanopore long_reads.fq -o hybrid_output
```

## Best Practices and Expert Tips
- **Memory Allocation**: SPAdes is memory-intensive. Use the `-m` flag to limit RAM usage (in GB) and `-t` to specify CPU threads.
  - Example: `spades.py [input_flags] -m 250 -t 32 -o output`
- **Output Files**:
  - `contigs.fasta`: The resulting assembled sequences.
  - `scaffolds.fasta`: The sequences after scaffolding (recommended for linked-read projects).
  - `assembly_graph_with_scaffolds.gfa`: Useful for visualization in tools like Bandage.
- **Troubleshooting**: If an assembly fails, always check `spades.log` and `params.txt` in the output directory. These files contain the exact command executed and the specific error trace.
- **Isolate vs. Meta**: While cloudspades is primarily for isolates, if working with metagenomic linked-reads, ensure you are using a version of SPAdes that supports the combination of `--meta` and linked-read flags, though typically cloudspades is optimized for single-genome assembly.

## Reference documentation
- [cloudspades - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cloudspades_overview.md)
- [GitHub - ablab/spades: SPAdes Genome Assembler](./references/github_com_ablab_spades.md)