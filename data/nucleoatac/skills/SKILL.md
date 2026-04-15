---
name: nucleoatac
description: NucleoATAC identifies nucleosome positions and occupancy levels from paired-end ATAC-seq data by analyzing fragment size distributions and V-plot patterns. Use when user asks to call nucleosome positions, estimate nucleosome occupancy, identify nucleosome-free regions, or characterize ATAC-seq fragment size distributions.
homepage: http://nucleoatac.readthedocs.io/en/latest/
metadata:
  docker_image: "quay.io/biocontainers/nucleoatac:0.3.4--py27hf119a78_5"
---

# nucleoatac

## Overview
NucleoATAC leverages the unique fragmentation patterns of ATAC-seq (V-plots) to distinguish between nucleosomal and nucleosome-free regions (NFR). It is specifically designed for paired-end data where fragment size information is available. This skill provides the procedural knowledge to run the full `nucleoatac` pipeline, manage its subcommands for granular control, and utilize the `pyatac` utility suite for data characterization.

## Core Workflow: The "Run" Command
For most standard analyses, use the `run` subcommand to execute the full pipeline (occupancy estimation, V-plot processing, and nucleosome calling) in one step.

```bash
nucleoatac run \
    --bed <regions.bed> \
    --bam <aligned_sorted.bam> \
    --fasta <indexed_genome.fasta> \
    --out <prefix> \
    --cores <int>
```

### Input Requirements
- **BAM**: Must be paired-end, sorted, and indexed. Filter for high mapping quality and remove mitochondrial reads beforehand.
- **FASTA**: Must be indexed (e.g., `samtools faidx`).
- **BED**: Broad open-chromatin regions (e.g., MACS2 `--broad` peaks). It is recommended to merge overlapping regions and slightly extend them (slop) to ensure enough context for the V-plot model.

## Granular Control (Subcommands)
If the `run` command fails or you need to adjust specific parameters, execute the steps manually:

1.  **`occ`**: Estimates nucleosome occupancy and fragment size distribution.
    - *Output*: `.occ.bedgraph.gz` (occupancy track) and `.nuc_dist.txt`.
2.  **`vprocess`**: Generates the normalized V-plot matrix using the distribution from `occ`.
    - *Command*: `nucleoatac vprocess --sizes <prefix>.nuc_dist.txt --out <prefix>`
3.  **`nuc`**: Performs the high-resolution cross-correlation to call nucleosome positions.
    - *Output*: `.nucpos.bed.gz` (high-res dyads) and `.nucleoatac_signal.bedgraph.gz`.
4.  **`merge`**: Combines low-resolution occupancy peaks with high-resolution dyad calls.
5.  **`nfr`**: Identifies Nucleosome Free Regions between called nucleosomes.

## Interpreting Key Outputs
- **`.nucpos.bed.gz`**: The primary file for high-resolution dyad positions. Use this for sequence preference analysis.
- **`.occ.bedgraph.gz`**: Best for comparing occupancy levels between different samples or loci, as it is less confounded by local accessibility than the signal track.
- **`.nucleoatac_signal.bedgraph.gz`**: Represents how well the local pattern matches a nucleosome V-plot. Note: Negative values are possible and do not necessarily mean a nucleosome is absent; they indicate the signal is lower than the background model.

## ATAC-seq Utilities (pyatac)
Use `pyatac` for preprocessing and diagnostic checks:
- **`pyatac sizes`**: Check fragment size distribution. If there is no "nucleosome laddering" (peak at ~150-200bp), NucleoATAC results will not be reliable.
- **`pyatac ins`**: Generate a bedgraph of insertion frequencies.
- **`pyatac bias`**: Calculate Tn5 hexamer sequence bias.
- **`pyatac vplot`**: Generate a diagnostic V-plot around a set of genomic features (e.g., TSS).

## Expert Tips
- **Memory/Performance**: Use the `--cores` flag to parallelize across genomic regions.
- **Single-End Data**: Do not attempt to use NucleoATAC on single-end data; the model strictly requires fragment length.
- **Signal-to-Noise**: In low-quality samples, occupancy estimates may be biased downwards. Always cross-reference occupancy tracks with raw insertion density.



## Subcommands

| Command | Description |
|---------|-------------|
| nucleoatac merge | Merge nucleosome occupancy and position files. |
| nucleoatac nfr | NFR determination parameters |
| nucleoatac nuc | Nucleosome calling |
| nucleoatac occ | Calculate nucleosome occupancy |
| nucleoatac run | Run the nucleoatac pipeline |
| nucleoatac vprocess | Processes nucleosome positioning data to generate various outputs and plots related to insert sizes and nucleosome footprints. |

## Reference documentation
- [NucleoATAC Overview](./references/nucleoatac_readthedocs_io_en_latest_nucleoatac.md)
- [Pyatac Utilities](./references/nucleoatac_readthedocs_io_en_latest_pyatac.md)
- [Frequently Asked Questions](./references/nucleoatac_readthedocs_io_en_latest_faq.md)