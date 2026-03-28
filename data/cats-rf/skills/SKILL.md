---
name: cats-rf
description: CATS-rf is a diagnostic pipeline that validates transcriptome assemblies without a reference genome by analyzing RNA-seq read mapping inconsistencies. Use when user asks to evaluate transcript quality, identify assembly errors like chimeric sequences, or compare the fidelity of multiple transcriptome assemblies.
homepage: https://github.com/bodulic/CATS-rf
---

# cats-rf

## Overview
CATS-rf (Comprehensive Assessment of Transcript Sequences - reference-free) is a diagnostic pipeline designed to validate transcriptome assemblies when a reference genome is unavailable. It works by treating the assembly as a reference, mapping the source RNA-seq reads against it, and analyzing mapping inconsistencies that point to specific assembly flaws. 

You should use this tool to:
- Generate a quantitative quality score ($S_t$) for every transcript in an assembly.
- Identify specific types of errors, such as chimeric transcripts, misassembled contigs, or redundant sequences.
- Compare multiple assemblies (e.g., from different assemblers like Trinity or SPAdes) to determine which produced the highest fidelity sequences.

## Core Commands

### CATS_rf
The primary evaluation script. It requires the assembly FASTA and the reads used to build it.

```bash
# Basic usage for paired-end reads
CATS_rf -t assembly.fasta -1 reads_R1.fastq.gz -2 reads_R2.fastq.gz -o output_dir

# Usage for single-end reads
CATS_rf -t assembly.fasta -u reads.fastq.gz -o output_dir
```

### CATS_rf_compare
Used to aggregate and visualize results from multiple CATS-rf runs to compare different assembly versions or tools.

```bash
# Compare two or more assemblies
CATS_rf_compare -n "Assembler_A,Assembler_B" -d "path/to/A_out,path/to/B_out" -o comparison_results
```

## Expert Tips and Best Practices

### Resource Management
CATS-rf relies on several heavy-duty bioinformatic tools (Bowtie2, kallisto, Samtools). 
- **Threading**: Always specify threads using `-p` to speed up the mapping and scoring phases.
- **Memory**: Ensure the environment has enough RAM for the Bowtie2 index, especially for large, complex transcriptomes.

### Input Preparation
- **Read Cleaning**: While CATS-rf evaluates the assembly based on the reads provided, it is best practice to use the same trimmed/filtered reads that were used for the initial assembly.
- **Strand Specificity**: If your RNA-seq library is stranded, specify the library type (e.g., `--rf` or `--fr` for kallisto-based steps) if the specific version of the script supports it, or ensure the mapping parameters align with your library prep.

### Interpreting the Scores
The final Transcript Quality Score ($S_t$) is a product of four components (0 to 1 scale):
1. **Coverage ($S_c$)**: Penalizes low-coverage regions (suggests insertions or redundancy).
2. **Accuracy ($S_a$)**: Penalizes regions with high mismatch/indel rates (suggests sequence inaccuracy).
3. **Local Fidelity ($S_l$)**: Penalizes inconsistent pair mapping (suggests structural errors like inversions or translocations).
4. **Integrity ($S_i$)**: Penalizes pairs mapping to different transcripts (suggests fragmentation).

A score near 1.0 indicates high-confidence assembly, while scores near 0.0 suggest significant misassembly.

### Execution via Containers
To avoid complex dependency chains (R, Python, and various C++ tools), use the official Docker or Singularity images:

```bash
# Docker execution pattern
docker run --rm -v "$PWD":/data -w /data bodulic/cats-rf CATS_rf [options]
```



## Subcommands

| Command | Description |
|---------|-------------|
| cats-rf_CATS_rf | reference-free transcriptome assembly assessment |
| cats-rf_compare | transcriptome assembly comparison script |

## Reference documentation
- [CATS-rf GitHub README](./references/github_com_bodulic_CATS-rf_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cats-rf_overview.md)