---
name: viral_consensus
description: ViralConsensus calls consensus sequences directly from read alignments. Use when user asks to call consensus sequences, reconstruct a genome, trim primer sequences, or generate base and insertion counts.
homepage: https://github.com/niemasd/ViralConsensus
---


# viral_consensus

## Overview
ViralConsensus is a high-performance tool designed to call consensus sequences directly from read alignments. Its primary advantage is the ability to process data without requiring the input reads to be sorted, which allows for direct integration with read mappers via standard input. While optimized for viral genomics, it can reconstruct any genome (bacterial, mitochondrial, etc.) that uses a single reference sequence, though memory usage scales linearly with the reference length.

## Core CLI Usage

The basic syntax requires an input alignment, a reference genome, and an output path:

```bash
viral_consensus -i input.bam -r reference.fasta -o consensus.fasta
```

### Key Parameters
- `-q, --min_qual`: Minimum base quality (default: 20). Bases below this threshold are ignored.
- `-d, --min_depth`: Minimum coverage depth required to call a base (default: 10).
- `-f, --min_freq`: Minimum frequency of the most common base to call it in the consensus (default: 0.5).
- `-a, --ambig`: Character used when depth or frequency thresholds are not met (default: N).

## Advanced Workflows and Best Practices

### Real-time Piping (Zero Disk I/O)
To maximize speed, pipe alignments directly from a mapper like `minimap2`. This avoids the overhead of writing large SAM/BAM files to disk before processing.

```bash
minimap2 -a -x sr reference.fas reads.fastq.gz | viral_consensus -i - -r reference.fas -o consensus.fas
```

### Simultaneous Consensus and BAM Creation
If you need to keep the alignment file for other analyses while generating the consensus, use `tee` with process substitution:

```bash
minimap2 -a -x sr reference.fas reads.fastq.gz | \
  tee >(viral_consensus -i - -r reference.fas -o consensus.fas) | \
  samtools view -b > reads.bam
```

### Primer Trimming
For amplicon-based sequencing (e.g., ARTIC protocols), provide a BED file to mask or trim primer sequences.
- `-p, --primer_bed`: Path to the BED file containing primer coordinates.
- `-po, --primer_offset`: Additional bases to trim after the primer sequence (default: 0).

### Generating Analysis Metadata
ViralConsensus can export detailed counts for downstream visualization or variant checking:
- `-op, --out_pos_counts`: Generates a TSV of base counts at every position.
- `-oi, --out_ins_counts`: Generates a JSON file containing insertion counts.

## Expert Tips
- **Memory Management**: For very large references (e.g., bacterial), ensure the system has sufficient RAM, as memory consumption is linear relative to the reference genome length.
- **Parallelization**: ViralConsensus is single-threaded. When processing multiple samples, parallelize at the sample level rather than trying to multi-thread a single execution.
- **Quality Control**: If you see an unexpected number of ambiguous 'N' characters, consider lowering `-d` (if coverage is low) or `-f` (if the sample is highly polymorphic), but be aware this may reduce the reliability of the consensus.

## Reference documentation
- [ViralConsensus GitHub Repository](./references/github_com_niemasd_ViralConsensus.md)
- [ViralConsensus Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_viral_consensus_overview.md)