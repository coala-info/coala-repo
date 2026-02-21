---
name: ococo
description: Ococo is a high-performance tool for "online" variant calling, meaning it processes sequence alignments as they arrive in a stream.
homepage: http://github.com/karel-brinda/ococo
---

# ococo

## Overview

Ococo is a high-performance tool for "online" variant calling, meaning it processes sequence alignments as they arrive in a stream. By utilizing compact bit-counters to track nucleotide statistics at each genomic position, it provides a memory-efficient alternative to traditional variant calling pipelines. Use this skill to generate consensus sequences in FASTA format, call variants in VCF format, or produce pileup files directly from aligner output without intermediate storage or sorting steps.

## Core CLI Usage

The basic syntax for ococo requires an input alignment file (or stream) and usually a reference genome to initialize the counters.

### Basic Consensus Calling
To generate a VCF of variants and a consensus FASTA from a BAM file:
```bash
ococo -i input.bam -f reference.fa -V variants.vcf -F consensus.fa
```

### Streaming Workflow
Ococo's primary strength is processing data from a pipe. This avoids creating large intermediate BAM files:
```bash
bwa mem ref.fa reads.fq | ococo -i - -f ref.fa -V -
```
*Note: Using `-` for `-i` reads from stdin, and `-` for `-V` outputs VCF to stdout.*

## Expert Parameters and Tuning

### Counter Configurations
Ococo uses different bit-widths for its internal counters. Choose based on your expected depth and memory constraints:
- **ococo16**: 3 bits per counter (16 bits per position). Lowest memory.
- **ococo32**: 7 bits per counter (32 bits per position). **Default**.
- **ococo64**: 15 bits per counter (64 bits per position). Use for very high coverage data to prevent counter overflow.

Example:
```bash
ococo -i input.bam -x ococo64
```

### Quality Filtering
Improve call accuracy by filtering low-quality data at the stream level:
- `-q, --min-MQ`: Minimum mapping quality (default: 1).
- `-Q, --min-BQ`: Minimum base quality (default: 13).

### Consensus Logic
- `-M, --maj-thres`: Set the majority threshold for calling a base (default: 0.51).
- `-c, --min-cov`: Minimum coverage required before a position is updated in the consensus (default: 2).
- `-w, --ref-weight`: Give the initial reference bases a "head start" by pre-loading counters with a specific weight.

### Reporting Modes
- **batch**: (Default) Reports the final consensus/variants after the entire stream is processed.
- **real-time**: Reports updates immediately as they occur. Useful for monitoring live sequencing runs.
```bash
ococo -i input.bam -m real-time --verbose
```

## Best Practices
1. **Memory Management**: If working with very large genomes (e.g., human), ensure you have enough RAM for the counter configuration chosen. `ococo32` requires 4 bytes per genomic position.
2. **Reference Initialization**: Always provide a reference FASTA with `-f` if available. If omitted, ococo initializes the consensus with 'N's, which may require higher coverage to resolve.
3. **Statistics Persistence**: Use `-S` to export the final counter statistics and `-s` to reload them later. This allows for incremental variant calling across multiple sequencing runs.
```bash
# Save state
ococo -i run1.bam -f ref.fa -S run1.stats
# Resume with new data
ococo -i run2.bam -s run1.stats -V combined.vcf
```

## Reference documentation
- [Ococo GitHub Repository](./references/github_com_karel-brinda_ococo.md)
- [Bioconda Ococo Package](./references/anaconda_org_channels_bioconda_packages_ococo_overview.md)