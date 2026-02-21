---
name: atropos
description: Atropos is a specialized tool for the sensitive and rapid trimming of adapters from high-throughput sequencing reads.
homepage: https://github.com/jdidion/atropos
---

# atropos

## Overview
Atropos is a specialized tool for the sensitive and rapid trimming of adapters from high-throughput sequencing reads. As a high-performance fork of Cutadapt, it introduces significant improvements including native multi-threading and an "insert" alignment algorithm. This algorithm is specifically designed for paired-end reads, using the overlap between mates to identify adapters more accurately than standard alignment and allowing for the correction of mismatches in the overlapping regions.

## Core Commands
Atropos provides several subcommands beyond basic trimming:
- **trim**: The primary command for adapter and quality trimming (default).
- **detect**: Automatically identifies adapter sequences and potential contaminants in your data.
- **error**: Estimates the sequencing error rate to help calibrate trimming parameters.
- **qc**: Generates read statistics and quality control metrics similar to FastQC.

## Common CLI Patterns

### Single-End Trimming
Unlike Cutadapt, Atropos requires explicit flags for input files.
```bash
atropos -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -o trimmed.fq.gz -se reads.fq.gz
```

### Paired-End Trimming (Standard)
Specify both adapters and both input/output pairs.
```bash
atropos -a [ADAPTER1] -A [ADAPTER2] -o out.1.fq.gz -p out.2.fq.gz -pe1 in.1.fq.gz -pe2 in.2.fq.gz
```

### Paired-End Trimming (Insert Aligner)
Use the `insert` aligner for superior sensitivity when reads overlap.
```bash
atropos --aligner insert -a [ADAPTER1] -A [ADAPTER2] -o out.1.fq.gz -p out.2.fq.gz -pe1 in.1.fq.gz -pe2 in.2.fq.gz
```

### Performance Optimization
Always specify threads to take advantage of multi-core systems.
```bash
atropos --threads 8 [OTHER_OPTIONS]
```

### Quality Control and Statistics
Generate detailed reports in various formats (JSON, YAML, or log).
```bash
atropos --stats --report-file summary.json [OTHER_OPTIONS]
```

## Expert Tips
- **Insert Alignment**: Use `--aligner insert` whenever you have paired-end data where the insert size is shorter than the combined read lengths. It is more robust against sequencing errors than the standard adapter-matching algorithm.
- **Adapter Detection**: If the adapter sequence is unknown, run the `detect` command on a subset of your data before starting the full trimming run.
- **SRA Streaming**: Atropos can stream data directly from SRA accessions using `ngstream`, avoiding the need to download large .sra files first.
- **BAM Support**: Atropos can read SAM/BAM files directly if `pysam` is installed, which is useful for re-trimming aligned data.

## Reference documentation
- [Atropos GitHub Repository](./references/github_com_jdidion_atropos.md)
- [Atropos Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_atropos_overview.md)