---
name: arriba
description: Arriba is a specialized command-line tool for discovering chimeric transcripts and structural rearrangements from RNA-Seq data.
homepage: https://github.com/suhrig/arriba
---

# arriba

## Overview
Arriba is a specialized command-line tool for discovering chimeric transcripts and structural rearrangements from RNA-Seq data. It functions as a post-processor for the STAR aligner, typically completing its analysis in approximately two minutes. Beyond standard gene fusions, Arriba is capable of identifying complex events including whole exon duplications, intragenic inversions, and truncations. A key advantage of Arriba is its compatibility with standard STAR parameters; it does not require users to reduce maximum intron limits, ensuring that the same alignments used for fusion detection remain suitable for gene expression quantification.

## Installation and Setup
Arriba is most easily managed via Bioconda.
```bash
conda install -c bioconda arriba
```
**Note:** Do not simply clone the repository to use the tool, as essential database files (like the blacklist) are not included in the git history. Use the provided `download_references.sh` script or the Bioconda package to ensure all resources are present.

## Core Workflow
The standard Arriba pipeline consists of two main stages: alignment with STAR and fusion calling with Arriba.

### 1. STAR Alignment
Arriba requires STAR to be run with specific parameters to output chimeric junctions.
*   **Required flags**: `--outSAMtype BAM Unsorted` (or SortedByCoordinate), `--outReadsUnmapped Fastx`, and `--chimSegmentMin`.
*   **Best Practice**: Unlike other fusion callers, do **not** reduce `--alignIntronMax`. Arriba is designed to handle focal deletions and long introns without altering this parameter, which preserves the quality of standard expression quantification.

### 2. Fusion Calling
Run the `arriba` executable on the resulting BAM file.
```bash
arriba \
    -x Aligned.out.bam \
    -g annotations.gtf \
    -a assembly.fa \
    -b blacklist.tsv.gz \
    -o fusions.tsv \
    -O fusions.discarded.tsv
```
*   `-x`: Input BAM file (STAR output).
*   `-g`: GTF annotation file.
*   `-a`: Reference genome assembly (FASTA).
*   `-b`: Blacklist file (provided with Arriba) to filter out common artifacts and frequent misalignments.

## Visualization
Arriba includes a dedicated R script, `draw_fusions.R`, to generate publication-quality PDF visualizations of detected fusions.
```bash
draw_fusions.R \
    --fusions=fusions.tsv \
    --alignments=Aligned.out.bam \
    --output=fusions.pdf \
    --annotation=annotations.gtf \
    --cytobands=cytobands.tsv \
    --proteinDomains=protein_domains.gff3
```

## Expert Tips
*   **Viral Integration**: Arriba can detect viral integration sites if the viral sequences are included in the reference genome assembly (`-a`).
*   **Resource Management**: The post-alignment step is highly efficient. If processing time is a concern, focus on optimizing the STAR alignment phase, as Arriba itself typically finishes in under 5 minutes for standard samples.
*   **Filtering**: Always review `fusions.discarded.tsv` if a suspected fusion is missing from the main output. This file contains events removed by Arriba's filters, which can help diagnose issues with library prep or alignment artifacts.
*   **Clinical Relevance**: Arriba is the winner of the DREAM SMC-RNA Challenge, making it a top-tier choice for high-precision clinical research applications.

## Reference documentation
- [Arriba GitHub Repository](./references/github_com_suhrig_arriba.md)
- [Arriba Wiki Home](./references/github_com_suhrig_arriba_wiki.md)
- [Bioconda Arriba Overview](./references/anaconda_org_channels_bioconda_packages_arriba_overview.md)