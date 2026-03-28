---
name: teloclip
description: Teloclip identifies and extracts overhanging soft-clipped reads from BAM files to extend draft contigs into complete chromosome-level assemblies. Use when user asks to filter for telomeric reads, extract overhanging sequences, or automatically extend genome assemblies using long-read alignments.
homepage: https://github.com/Adamtaranto/teloclip
---


# teloclip

## Overview

Teloclip is a bioinformatics utility designed to bridge the gap between draft contigs and complete chromosome-level assemblies. It identifies "overhanging" reads—sequences that extend beyond the current assembly's boundaries—by analyzing soft-clipped alignments in SAM/BAM files. It is particularly effective for recovering repetitive telomeric sequences (e.g., TTAGGG) that assemblers often truncate. The tool provides a three-stage workflow: filtering for candidate reads, extracting those sequences, and automatically patching them onto the reference genome.

## Core Workflows

### 1. Filtering for Telomeric Reads
The `filter` command identifies reads that are soft-clipped at the very ends of contigs.

*   **Basic Filter**: Requires a reference index (`.fai`) to identify contig boundaries.
    ```bash
    teloclip filter --ref-idx ref.fa.fai input.bam > filtered.sam
    ```
*   **Motif-Specific Filter**: Search for specific telomeric repeats (e.g., human/plant `TTAGGG` or `CCCTAA`).
    ```bash
    teloclip filter --ref-idx ref.fa.fai --motifs TTAGGG,CCCTAA input.bam > filtered_telo.sam
    ```

### 2. Extracting Overhang Sequences
The `extract` command pulls the non-aligned (clipped) portion of the reads into a FASTA format for inspection or manual assembly.

```bash
teloclip extract --ref-idx ref.fa.fai --outdir ./overhangs filtered.sam
```

### 3. Automatic Genome Extension
The `extend` command uses the filtered alignments to automatically append missing telomeric sequence to the ends of your reference FASTA.

```bash
teloclip extend --ref ref.fa --outdir ./extended_genome filtered.bam
```

## Expert Tips and Best Practices

*   **Alignment Requirements**: Teloclip relies on CIGAR strings. Ensure reads are mapped with a long-read aligner like `minimap2` using settings that allow soft-clipping (default for `-ax map-pb` or `-ax map-ont`).
*   **Reference Indexing**: Always ensure your reference FASTA has a corresponding `.fai` index (generated via `samtools faidx`) before running `filter` or `extract`.
*   **Handling Large Datasets**: When working with high-coverage long-read data, use the `--motifs` flag during the `filter` step to significantly reduce the size of intermediate SAM files by ignoring non-telomeric clips.
*   **Containerized Execution**: If using Docker, mount your local data directory to `/data` and set it as the working directory to simplify path management.
    ```bash
    docker run --rm -v $(pwd):/data adamtaranto/teloclip:latest filter --ref-idx ref.fa.fai input.sam
    ```
*   **Piping**: Teloclip supports `stdin` and `stdout`, allowing it to be integrated into pipelines without writing large intermediate SAM files to disk.



## Subcommands

| Command | Description |
|---------|-------------|
| extend | Extend contigs using overhang analysis from soft-clipped alignments. |
| extract | Extract overhanging reads for each end of each reference contig. Reads are always written to output files. |
| filter | Filter SAM file for clipped alignments containing unassembled telomeric   repeats. |

## Reference documentation

- [Teloclip GitHub README](./references/github_com_Adamtaranto_teloclip_blob_main_README.md)
- [Docker Usage Guide](./references/github_com_Adamtaranto_teloclip_blob_main_DOCKER.md)
- [Changelog and Version History](./references/github_com_Adamtaranto_teloclip_blob_main_CHANGELOG.md)