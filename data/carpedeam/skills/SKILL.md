---
name: carpedeam
description: Carpedeam is a specialized metagenomic assembler designed to reconstruct genomes from ancient DNA by incorporating empirical damage profiles into the assembly process. Use when user asks to assemble ancient metagenomes, configure the ancient_assemble command, optimize iteration parameters for fragmented reads, or troubleshoot damage matrix formatting.
homepage: https://github.com/LouisPwr/CarpeDeam
---


# carpedeam

## Overview

CarpeDeam is a specialized metagenomic assembler built to handle the unique challenges of ancient DNA, such as high fragmentation and chemical damage (e.g., C-to-T transitions). By incorporating empirical damage profiles into the assembly process, it achieves higher precision and longer contigs in datasets where standard assemblers often fail. Use this skill to configure the `ancient_assemble` command, optimize iteration parameters for specific sample types, and ensure input files meet the tool's strict formatting requirements.

## Core Workflow

The primary command for assembling ancient metagenomes is `ancient_assemble`.

```bash
carpedeam ancient_assemble [reads.fastq.gz] [output.fasta] [tmp_dir] --ancient-damage [damage_prefix]
```

### Critical Preprocessing
1.  **Merge Reads**: Always merge paired-end reads before assembly. Merging improves read quality and provides better context for damage assessment.
2.  **Length Filtering**: You must filter out extremely short reads (e.g., < 20bp) to prevent segmentation faults during the correction step.
    *   *Example using seqkit*: `seqkit seq -m 20 input.fastq > filtered.fastq`
3.  **Damage Matrix Suffixes**: The tool expects two specific files for the damage profile using the prefix provided in `--ancient-damage`:
    *   `[prefix]_5p.prof` (Five-prime end substitutions)
    *   `[prefix]_3p.prof` (Three-prime end substitutions)

## Parameter Optimization

| Parameter | Recommended Value | Purpose |
| :--- | :--- | :--- |
| `--num-iter-reads-only` | 3 to 5 | Initial iterations using only raw reads. Produces short but highly precise contigs. |
| `--num-iterations` | 9 to 12 | Total iterations (including reads-only). Higher values result in longer contigs through merging. |
| `--min-merge-seq-id` | 0.99 (99%) | Identity threshold for merging. Lowering this increases contig length but raises the risk of misassemblies. |
| `--unsafe` | 0 (Default) | Set to 1 to maximize sensitivity and length if chimeric contigs are not a primary concern. |

## Troubleshooting & Best Practices

### Damage Matrix Formatting
CarpeDeam is extremely sensitive to the format of `.prof` files. They must be strictly tab-separated with no trailing whitespaces or empty tabs at the end of lines. If you encounter the error `Profile not 12 fields uniq1`, fix your matrices with:

```bash
sed -E 's/[[:space:]]+/\t/g; s/\t$//' input.prof > fixed_input.prof
```

### Hardware Considerations
*   **Memory**: Ensure the system has roughly 1 byte of RAM per residue in the dataset.
*   **CPU**: The binary requires a CPU supporting at least the SSE4.1 instruction set.
*   **Scaling**: The tool automatically scales memory consumption based on available system RAM.



## Subcommands

| Command | Description |
|---------|-------------|
| ancient_correction | By Louis Kraft <lokraf@dtu.dk> |
| carpedeam ancient_assemble | By Louis Kraft <lokraf@dtu.dk> |
| nuclassemble | By Louis Kraft <lokraf@dtu.dk> and Annika Jochheim <annika.jochheim@mpinat.mpg.de> |

## Reference documentation

- [CarpeDeam Main Documentation](./references/github_com_LouisPwr_CarpeDeam_blob_main_README.md)