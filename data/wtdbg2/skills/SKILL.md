---
name: wtdbg2
description: wtdbg2 is a high-speed assembler designed for long-read sequencing data, capable of assembling large genomes directly from raw, noisy reads. Use when user asks to assemble long-read sequencing data, generate contig layouts, produce consensus sequences, or polish an assembly.
homepage: https://github.com/ruanjue/wtdbg2
---


# wtdbg2

## Overview

wtdbg2 (also known as Redbean) is a specialized assembler designed for high-speed processing of long-read sequencing data. Unlike many other assemblers that require pre-assembly error correction, wtdbg2 works directly with raw, noisy reads by chopping them into 1024bp segments and building a fuzzy Bruijn graph. This makes it significantly faster than traditional OLC (Overlap-Layout-Consensus) assemblers, capable of handling large genomes (like human or even larger) in a fraction of the time.

The tool follows a two-step primary workflow:
1. **Assembly**: `wtdbg2` generates a contig layout (`.ctg.lay.gz`).
2. **Consensus**: `wtpoa-cns` processes the layout to produce the final FASTA sequences.

## Core Usage Patterns

### One-Step Execution
For most standard projects, use the wrapper script to run the full pipeline:
```bash
./wtdbg2.pl -t 16 -x ont -g 3g -o output_prefix reads.fastq.gz
```

### Manual Two-Step Assembly
For more control, run the assembler and consensus tools separately:

1. **Generate Layout**:
   ```bash
   ./wtdbg2 -x ont -g 4.6m -i reads.fa.gz -t 16 -fo prefix
   ```
2. **Generate Consensus**:
   ```bash
   ./wtpoa-cns -t 16 -i prefix.ctg.lay.gz -fo prefix.ctg.fa
   ```

### Technology Presets (-x)
Always set the `-x` parameter first, as it overrides other defaults.
- `rs`: PacBio RSII
- `sq`: PacBio Sequel
- `ccs`: PacBio CCS (HiFi) reads
- `ont`: Oxford Nanopore

## Expert Tips and Parameter Tuning

### Handling Low Coverage
If your sequencing depth is low, adjust the k-mer sampling and edge filtering:
- **Increase Sampling**: Decrease `-S` (default is 4, meaning 1/4 k-mers). Reducing this to 1 or 2 increases sensitivity but significantly raises memory usage.
- **Lower Edge Threshold**: Adjust `-e` (minimum read coverage for an edge). Default is 3; for very low coverage, try 2.
- **Enable -A**: Use the `-A` flag to improve assembly for low-coverage data at the cost of runtime.

### Improving Assembly Quality
- **PacBio Optimization**: For PacBio data, adding `-L 5000` (discarding reads shorter than 5kb) often yields better N50 and cleaner assemblies.
- **K-mer Lengths**: Use `-k` for normal k-mers and `-p` for homopolymer-compressed (HPC) k-mers.
- **Memory Management**: For large genomes (e.g., Human 3Gb), expect to need ~200GB+ RAM. If memory is an issue, ensure you are not over-sampling k-mers with `-S`.

### Polishing the Assembly
While `wtpoa-cns` provides a base consensus, further polishing is often required for high accuracy:
1. Map raw reads back to the assembly using `minimap2`.
2. Sort the BAM file.
3. Run `wtpoa-cns` in polishing mode:
   ```bash
   samtools view -F0x900 sorted.bam | ./wtpoa-cns -t 16 -d prefix.raw.fa -i - -fo prefix.cns.fa
   ```

## Troubleshooting
- **Input Order**: If mixing file formats, always list FASTQ files before FASTA files. Listing FASTA first can cause the parser to fail on FASTQ headers.
- **Genome Size**: The `-g` parameter is an estimate. If the assembly is significantly smaller than expected (common with ONT), try reducing the stringency of k-mer matches.
- **64-bit Only**: Ensure you are running on a 64-bit Linux environment; other architectures are not supported.

## Reference documentation
- [wtdbg2 Main Documentation](./references/github_com_ruanjue_wtdbg2.md)