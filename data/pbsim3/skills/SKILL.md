---
name: pbsim3
description: pbsim3 simulates PacBio and Oxford Nanopore long-read sequencing data using model-based or sampling-based strategies. Use when user asks to simulate long-read sequencing data, generate benchmark datasets for bioinformatics tools, or perform whole genome and transcriptome sequencing simulations.
homepage: https://github.com/yukiteruono/pbsim3
metadata:
  docker_image: "quay.io/biocontainers/pbsim3:3.0.5--h9948957_2"
---

# pbsim3

## Overview
pbsim3 is a specialized simulator designed to mimic the characteristics of PacBio and ONT long-read sequencing. It is primarily used to generate benchmark datasets for testing bioinformatics tools like assemblers, mappers, and variant callers. The tool supports three main simulation strategies: WGS (random sequencing from a genome), TS (transcriptome sequencing based on expression profiles), and Templ (full-length sequencing of specific templates). It can simulate various error profiles using pre-built Hidden Markov Models (HMMs) or by sampling directly from existing real-world datasets.

## Common CLI Patterns

### Whole Genome Sequencing (WGS)
WGS simulation generates reads randomly from a reference genome.

**Model-based (Quality Scores):**
Use `qshmm` to generate realistic quality scores based on a specific platform model.
```bash
pbsim --strategy wgs --method qshmm --qshmm data/QSHMM-ONT.model --depth 20 --genome reference.fasta
```

**Model-based (Error Rates):**
Use `errhmm` if you only need the error profile without specific quality score distributions (all quality scores will be `!`).
```bash
pbsim --strategy wgs --method errhmm --errhmm data/ERRHMM-SEQUEL.model --depth 20 --genome reference.fasta
```

**Sampling-based:**
Uses a real FASTQ file to determine read length and quality score distributions.
```bash
pbsim --strategy wgs --method sample --sample real_reads.fastq --depth 20 --genome reference.fasta
```

### Transcriptome Sequencing (TS)
Simulates reads from transcript sequences based on a user-provided expression profile.
```bash
pbsim --strategy trans --method qshmm --qshmm data/QSHMM-RSII.model --transcript expression_profile.txt
```
*Note: The transcript file must be tab-delimited: `ID | Sense-Expression | Anti-Sense-Expression | Sequence`.*

### Multi-pass Sequencing (HiFi Generation)
To simulate PacBio HiFi reads, pbsim3 simulates the multi-pass subreads (CLR). These subreads must then be processed by external tools like `ccs`.
```bash
pbsim --strategy wgs --method qshmm --qshmm data/QSHMM-RSII.model --depth 20 --genome reference.fasta --pass-num 10
```
*Note: When `--pass-num` is 2 or greater, the output format switches to BAM.*

## Expert Tips and Best Practices

*   **Model Selection:** Use `*-ONT-HQ.model` variants when simulating modern ONT chemistry with an expected average accuracy of 90% or higher.
*   **Output Files:** 
    *   Single-pass simulation produces `.ref` (reference copy), `.fq.gz` (FASTQ), and `.maf.gz` (alignments).
    *   Multi-pass simulation produces `.ref`, `.bam` (subreads), and `.maf.gz`.
*   **Environment Requirements:** Ensure `samtools` and `gzip` are installed and available in the system PATH; pbsim3 relies on them to compress outputs and generate BAM files.
*   **Sample Profiles:** For sampling-based WGS, use `--sample-profile-id <ID>` to save the profile. This allows you to reuse the same length/quality distribution in future runs without re-processing the large source FASTQ file.
*   **Input Formatting:** If working on Windows, ensure input FASTA/FASTQ files use LF (Unix) line endings rather than CRLF to avoid parsing errors.

## Reference documentation
- [PBSIM3 GitHub Repository](./references/github_com_yukiteruono_pbsim3.md)
- [Bioconda pbsim3 Package](./references/anaconda_org_channels_bioconda_packages_pbsim3_overview.md)