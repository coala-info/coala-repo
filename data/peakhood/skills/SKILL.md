---
name: peakhood
description: Peakhood is a specialized bioinformatics tool designed to resolve the ambiguity of CLIP-seq peak locations.
homepage: https://github.com/BackofenLab/Peakhood
---

# peakhood

## Overview
Peakhood is a specialized bioinformatics tool designed to resolve the ambiguity of CLIP-seq peak locations. While many peaks are clearly intronic or exonic, those at exon-intron boundaries or within exons require careful analysis of read distributions to determine if the binding occurred on a spliced transcript or genomic DNA. Peakhood automates this decision-making process by evaluating exon-intron coverage ratios and identifying intron-spanning reads to provide a more accurate representation of the RBP binding site context.

## Installation
The recommended way to install Peakhood is via Bioconda:
```bash
conda install bioconda::peakhood
```

## Core Command Patterns

### Site Context Extraction
The primary workflow involves taking genomic peaks and determining their most likely context using gene annotations and experimental read data.

```bash
peakhood extract -p peaks.bed -g annotations.gtf -b alignment.bam -o output_dir
```
*   **-p**: CLIP-seq peak regions in BED format.
*   **-g**: Gene annotations in GTF format (standard or custom).
*   **-b**: Mapped reads from the CLIP-seq experiment in BAM format.

### Merging Results
After extraction, use the merge mode to consolidate transcript context datasets into unified site collections. This is particularly useful for joining exon-border sites that are biologically part of the same binding event but split by splicing.

```bash
peakhood merge -i extraction_results/ -o merged_sites.bed
```

### Batch Processing
For projects involving multiple datasets, the batch mode streamlines the extraction and merging process in a single execution.

```bash
peakhood batch -i input_config_folder/ -o batch_output/
```

## Expert Tips and Best Practices

### 1. Handling Ambiguous Contexts
Peakhood uses the ratio of exon-to-intron read coverage to decide context. If you are working with an RBP known to have dual roles (e.g., a splicing factor that also binds mature mRNA in the cytoplasm), pay close attention to sites assigned to "both" contexts.

### 2. Custom GTF Files
For the most accurate transcript selection, use a custom GTF file derived from cell-type-specific or condition-specific RNA-seq data. This ensures Peakhood evaluates the binding sites against the isoforms actually expressed in your experimental system.

### 3. Intron-Spanning Reads
The tool relies heavily on intron-spanning reads to connect neighboring exons. Ensure your BAM files are generated using a splice-aware aligner (like STAR or HISAT2) to provide the necessary evidence for transcript-context binding.

### 4. Peak Merging Logic
Peakhood automatically merges exon-border sites connected by intron-spanning reads. This prevents the over-counting of binding events that appear as separate peaks in genomic coordinates but represent a single continuous binding site on a spliced RNA molecule.

## Reference documentation
- [Peakhood GitHub Repository](./references/github_com_BackofenLab_Peakhood.md)
- [Bioconda Peakhood Package](./references/anaconda_org_channels_bioconda_packages_peakhood_overview.md)