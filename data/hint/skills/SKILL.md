---
name: hint
description: HiNT (Hi-C for copy Number variation and Translocation detection) is a specialized computational framework for extracting genomic structural variants from Hi-C data.
homepage: https://github.com/suwangbio/HiNT_py3
---

# hint

## Overview
HiNT (Hi-C for copy Number variation and Translocation detection) is a specialized computational framework for extracting genomic structural variants from Hi-C data. While Hi-C is primarily used for studying 3D genome organization, this skill leverages HiNT's ability to distinguish between true spatial interactions and signal biases caused by structural rearrangements. Use this tool to process Hi-C interaction matrices and output predicted breakpoints and copy number segments.

## Installation and Setup
The tool is distributed via Bioconda. Ensure the environment is properly configured before execution.

```bash
conda install -c bioconda hint
```

## Core Workflows
HiNT typically operates in three main modules: `hint pre`, `hint cnv`, and `hint tl`.

### 1. Data Preprocessing (`hint pre`)
Prepares Hi-C data for analysis. It requires aligned BAM files or contact matrices.
- Use high-resolution data (e.g., 50kb or 100kb) for CNV detection.
- Ensure the genome index matches the alignment used for the Hi-C reads.

### 2. Copy Number Variation Detection (`hint cnv`)
Identifies gains and losses across the genome by normalizing Hi-C interaction frequencies.
- **Input**: Processed Hi-C data from the `pre` step.
- **Output**: Segmented CNV profiles.
- **Tip**: HiNT is particularly effective at correcting for the "distance effect" in Hi-C data which can otherwise mask CNV signals.

### 3. Translocation Detection (`hint tl`)
Detects large-scale structural rearrangements, including balanced and unbalanced translocations.
- Focuses on inter-chromosomal interactions that significantly exceed background expectations.
- Provides breakpoint coordinates for identified translocations.

## Best Practices
- **Resolution Selection**: For translocation detection, coarser resolutions (100kb+) are often sufficient to identify the signal, while finer resolutions are needed to pinpoint breakpoints.
- **Background Modeling**: HiNT relies on a background model of normal spatial interactions; ensure your input data has sufficient coverage to distinguish signal from noise.
- **Validation**: Cross-reference HiNT CNV calls with traditional tools (like WGS-based callers) if available to confirm complex rearrangements.

## Reference documentation
- [HiNT Overview](./references/anaconda_org_channels_bioconda_packages_hint_overview.md)