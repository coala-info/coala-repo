---
name: peakhood
description: Peakhood identifies the most probable sequence context for CLIP-seq binding sites by distinguishing between genomic and transcriptomic evidence. Use when user asks to assign binding sites to genomic or transcript contexts, extract site-specific sequence information, or merge transcript context datasets.
homepage: https://github.com/BackofenLab/Peakhood
---

# peakhood

## Overview

Peakhood is a bioinformatics tool designed to refine the interpretation of CLIP-seq data by identifying the most probable sequence context for each binding site. While genomic context (containing introns) is standard for intronic or intergenic regions, exonic sites are often ambiguous, potentially representing binding to either pre-mRNA or mature, spliced mRNA. Peakhood resolves this by analyzing experimental evidence from BAM files—specifically looking for high exon-intron read coverage ratios and the presence of intron-spanning reads—to decide between genomic and transcript contexts for every peak individually.

## Core Workflows

### Site Context Extraction
The primary function of Peakhood is to process genomic CLIP-seq peaks and assign them to a context.

*   **Transcript Context**: Assigned when read evidence shows substantial coverage drops at exon borders and the presence of junction-spanning reads.
*   **Genomic Context**: Assigned when reads overlap exon borders significantly or map consistently into neighboring intronic regions (typical for splicing factors like U2AF2).

### Command Line Usage Patterns

The tool operates primarily through two modes: `extract` and `merge`.

#### 1. Extracting Contexts
Use `peakhood extract` to perform the initial context assignment. This requires:
*   A set of CLIP-seq peak regions (BED format).
*   Read alignment data (BAM format).
*   Gene annotations (GTF format).

#### 2. Merging Results
Use `peakhood merge` to consolidate transcript context datasets into unified site collections. This is particularly useful when dealing with multiple replicates or related datasets to create a comprehensive binding map.

## Expert Tips and Best Practices

*   **Isoform Selection**: When a site is assigned to a transcript context, Peakhood automatically selects the most likely transcript isoform. If cell-type or condition-specific RNA-seq data is available, always use a **custom GTF file** to improve the accuracy of this selection.
*   **Handling Exon Borders**: Peakhood identifies "exon border sites"—peaks that appear separate in genomic coordinates but are connected by intron-spanning reads. The tool merges these into single binding events to prevent over-counting and misinterpretation of the binding architecture.
*   **RBP-Specific Logic**: 
    *   For RBPs known to bind predominantly spliced RNA (e.g., PUM2), expect high transcript context assignments.
    *   For splicing factors or nuclear-retained RBPs (e.g., U2AF2), expect higher genomic context assignments even within exonic regions.
*   **Thresholding**: In cases where an RBP has dual roles (cytoplasmic and nuclear), sites may show evidence for both contexts. Review the exon-intron coverage ratios if results seem ambiguous for specific peaks.



## Subcommands

| Command | Description |
|---------|-------------|
| peakhood batch | Batch processing for peakhood to extract transcript context and genomic context for sites using BAM, BED, GTF, and genomic sequence files. |
| peakhood extract | Extract transcript and genomic context for CLIP-seq peak regions using BAM coverage and GTF annotations. |
| peakhood merge | Merge peakhood results |
| peakhood motif | Search for motifs or regular expressions in genomic or transcript sequences based on peakhood extract output, BED files, or transcript lists. |

## Reference documentation

- [Peakhood Main Documentation](./references/github_com_BackofenLab_Peakhood_blob_main_README.md)
- [Peakhood Workflow Visual](./references/github_com_BackofenLab_Peakhood_blob_main_docs_peakhood_workflow.png.md)