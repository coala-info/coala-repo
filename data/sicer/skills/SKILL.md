---
name: sicer
description: SICER (Spatial Clustering for Identification of Enriched Regions) is a specialized tool for analyzing ChIP-Seq data, particularly for histone modifications that cover broad genomic regions rather than narrow transcription factor binding sites.
homepage: http://home.gwu.edu/~wpeng/Software.htm
---

# sicer

## Overview
SICER (Spatial Clustering for Identification of Enriched Regions) is a specialized tool for analyzing ChIP-Seq data, particularly for histone modifications that cover broad genomic regions rather than narrow transcription factor binding sites. It uses a clustering approach to identify significant domains of enrichment by accounting for the spatial distribution of reads and comparing them against a control library or a random background model.

## Usage Guidelines

### Core Command Structure
The primary execution script for SICER is typically `sicer`, which requires several positional arguments to define the biological context and statistical thresholds.

```bash
sicer [Data_Dir] [Bed_File] [Control_File] [Output_Dir] [Species] [Redundancy_Threshold] [Window_Size] [Fragment_Size] [Effective_Genome_Fraction] [Gap_Size] [FDR]
```

### Key Parameters
- **Window Size**: Typically set to 200bp for most histone modifications.
- **Gap Size**: This is the most critical parameter for broad peaks. It must be a multiple of the Window Size. 
    - For narrow/sharp marks (e.g., H3K4me3): Use a Gap Size of 200 (1 window).
    - For broad marks (e.g., H3K27me3, H3K36me3): Use a Gap Size of 600 or 1000 (3-5 windows).
- **Redundancy Threshold**: The maximum number of allowed copies of identical reads (usually set to 1 to avoid PCR artifacts).
- **Effective Genome Fraction**: The mappable portion of the genome (e.g., ~0.74 for Human hg19, ~0.77 for Mouse mm9).

### Best Practices
- **Input Format**: Ensure input files are in standard BED format.
- **Control Library**: Always provide a matching Input/IgG control file when available to reduce false positives from open chromatin or mapping biases.
- **Species Support**: Common identifiers include `hg19`, `hg18`, `mm9`, and `mm8`. Ensure the effective genome fraction matches the specific assembly used.
- **Output Interpretation**: Focus on the `.scoreisland` and `-islands-summary-fdr` files for the most statistically robust enrichment domains.

## Reference documentation
- [sicer Overview](./references/anaconda_org_channels_bioconda_packages_sicer_overview.md)