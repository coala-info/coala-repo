---
name: jaffa
description: JAFFA is a transcript-centric bioinformatics pipeline designed to detect gene fusions across various sequencing read lengths. Use when user asks to identify gene fusions, perform de novo assembly of transcripts, or analyze long-read RNA sequencing data for chimeric sequences.
homepage: https://github.com/Oshlack/JAFFA
---

# jaffa

## Overview

JAFFA (Joined Assembly and Fusion Fasta) is a multi-step bioinformatics pipeline designed to detect gene fusions by comparing a sample's transcriptome against a reference. Unlike genome-centric fusion finders, JAFFA's transcript-centric approach allows it to perform consistently across a wide range of read lengths, from 50bp short-reads to full-length transcripts. It is executed using the `bpipe` workflow engine and outputs both a summary table of candidates and the cDNA sequences of the fusion breakpoints.

## Pipeline Modes

Select the appropriate `.groovy` workflow based on your input data and requirements:

*   **Assembly (`JAFFA_assembly.groovy`)**: The most sensitive mode for short reads (50bp+). It performs de novo assembly using Velvet/Oases. Note: This mode is computationally expensive and requires significant RAM.
*   **Direct (`JAFFA_direct.groovy`)**: Faster than assembly mode. It maps reads directly to a reference transcriptome and identifies those that do not align normally.
*   **Hybrid (`JAFFA_hybrid.groovy`)**: Combines both assembly and direct approaches to balance speed and sensitivity.
*   **Long (`JAFFAL.groovy`)**: Specifically optimized for noisy long-read data from Oxford Nanopore (ONT) or PacBio. It utilizes `minimap2` for alignment.

## Common CLI Patterns

JAFFA is invoked through the `bpipe` binary included in the `tools/bin` directory of the JAFFA installation.

### Basic Execution
Run a pipeline by pointing to the desired groovy script and your input fastq files:
```bash
# Run assembly mode on paired-end reads
<JAFFA_dir>/tools/bin/bpipe run <JAFFA_dir>/JAFFA_assembly.groovy sample_R1.fastq.gz sample_R2.fastq.gz

# Run long-read mode
<JAFFA_dir>/tools/bin/bpipe run <JAFFA_dir>/JAFFAL.groovy long_reads.fastq.gz
```

### Parallelization
Use the `-n` flag to specify the number of threads/cores. JAFFA can run multiple samples in parallel branches:
```bash
# Run with 8 cores
<JAFFA_dir>/tools/bin/bpipe run -n 8 <JAFFA_dir>/JAFFA_direct.groovy *.fastq.gz
```

### Specifying Genomes and Annotations
If not using the default (hg38/Gencode), specify the genome and annotation version using the `-p` parameter:
```bash
# Run using hg19 and Gencode v19
bpipe run -p genome=hg19 -p annotation=genCode19 <JAFFA_dir>/JAFFA_direct.groovy *.fastq.gz
```

## Expert Tips and Best Practices

*   **Memory Management**: Assembly mode is RAM-intensive because it runs multiple k-mer assemblies. If the pipeline fails at `Stage run_assembly`, ensure the machine has sufficient memory or reduce the number of parallel samples.
*   **Reference Preparation**: For non-default genomes (like mm10 or hg19), you must download the reference tarball and run `makeblastdb` on the fasta file before execution.
*   **Output Files**:
    *   `jaffa_results.csv`: The main summary table containing fusion genes, genomic coordinates, and the number of spanning reads/pairs.
    *   `jaffa_results.fasta`: Contains the predicted cDNA sequence for each fusion breakpoint.
*   **Trimming**: By default, JAFFA uses Trimmomatic but performs no actual trimming. You can modify `JAFFA_stages.groovy` to adjust trimming parameters if your library has high adapter contamination.
*   **Filtering**: JAFFA automatically filters out reads mapping to intronic, intergenic, or mitochondrial (chrM) regions to improve performance in assembly and hybrid modes.



## Subcommands

| Command | Description |
|---------|-------------|
| jaffa-assembly | JAFFA is a tool for detecting gene fusions from RNA-Seq data. |
| jaffa-hybrid | JAFFA is a tool for detecting fusion sequences in next-generation sequencing data. |

## Reference documentation
- [JAFFA Example Workflow](./references/github_com_Oshlack_JAFFA_wiki_Example.md)
- [FAQ and Troubleshooting](./references/github_com_Oshlack_JAFFA_wiki_FAQandTroubleshooting.md)
- [Reference Download Instructions](./references/github_com_Oshlack_JAFFA_wiki_Download.md)