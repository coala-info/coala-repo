---
name: pbsim
description: pbsim simulates synthetic long reads that mimic the characteristics of PacBio and Oxford Nanopore sequencing platforms. Use when user asks to generate benchmark datasets for bioinformatics tools, simulate whole genome or transcriptome sequencing, or create multi-pass reads for HiFi generation.
homepage: https://github.com/yukiteruono/pbsim3
metadata:
  docker_image: "biocontainers/pbsim:v1.0.3-2-deb_cv1"
---

# pbsim

## Overview

PBSIM3 is a simulator designed to generate synthetic long reads that mimic the characteristics of real PacBio and ONT platforms. This skill allows for the creation of benchmark datasets for testing bioinformatics tools like assemblers, mappers, and variant callers. It supports various sequencing strategies, including multi-pass sequencing (for HiFi read generation) and expression-profile-based transcriptome simulation.

## Common CLI Patterns

### Whole Genome Sequencing (WGS)

**Model-based simulation (Quality Score HMM)**
Use this to generate reads with realistic quality scores based on a specific platform model.
```bash
pbsim --strategy wgs --method qshmm --qshmm data/QSHMM-RSII.model --depth 20 --genome reference.fasta
```

**Model-based simulation (Error HMM)**
Use this when specific error models are preferred over quality score models. Note: All quality scores will be set to "!".
```bash
pbsim --strategy wgs --method errhmm --errhmm data/ERRHMM-ONT.model --depth 20 --genome reference.fasta
```

**Sampling-based simulation**
Use this to mimic the length and quality distribution of a specific real-world dataset.
```bash
pbsim --strategy wgs --method sample --sample real_reads.fastq --depth 20 --genome reference.fasta
```

### Transcriptome Sequencing (TS)
Requires a transcript sequence file and an expression profile (tab-delimited: ID, sense-count, anti-sense-count, sequence).
```bash
pbsim --strategy trans --method qshmm --qshmm data/QSHMM-RSII.model --transcript transcripts.txt
```

### Multi-pass Sequencing (HiFi Generation)
To simulate the circular consensus sequencing (CCS) process, use the `--pass-num` flag. This produces a BAM file intended for processing with the `ccs` tool.
```bash
pbsim --strategy wgs --method qshmm --qshmm data/QSHMM-RSII.model --depth 20 --genome reference.fasta --pass-num 10
```

## Expert Tips and Best Practices

- **High-Accuracy ONT Reads**: When simulating ONT reads with an expected average accuracy of 90% or higher, always use the `QSHMM-ONT-HQ.model` or `ERRHMM-ONT-HQ.model`.
- **Output Management**: PBSIM3 generates three files per FASTA entry in the reference:
  - `.ref`: A copy of the reference FASTA.
  - `.fq.gz`: The simulated reads (FASTQ).
  - `.maf.gz`: Alignments between reference and reads (MAF).
- **Environment Requirements**: Ensure `samtools` and `gzip` are in your PATH. PBSIM3 relies on these for compressing outputs and generating BAM files during multi-pass simulation.
- **Input Formatting**: If working on Windows, convert input file line endings from CRLF to LF before running the simulation to avoid parsing errors.
- **Sample Profiles**: For repetitive sampling-based simulations, use `--sample-profile-id <ID>`. This saves the profile of the input FASTQ (stats and sampled reads) to speed up subsequent runs using the same source data.

## Reference documentation
- [PBSIM3 Main Documentation](./references/github_com_yukiteruono_pbsim3.md)
- [Data Models and Assets](./references/github_com_yukiteruono_pbsim3_tree_master_data.md)