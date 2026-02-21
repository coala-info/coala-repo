---
name: ucsc-bedextendranges
description: The `ucsc-bedextendranges` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to standardize the length of genomic intervals.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedextendranges

## Overview
The `ucsc-bedextendranges` utility is a specialized tool from the UCSC Genome Browser "kent" suite designed to standardize the length of genomic intervals. Unlike simple padding tools, it requires BED 6+ format because it uses the strand information (column 6) to determine the direction of extension. If a feature is already longer than the specified minimum, it remains unchanged; if it is shorter, the tool extends it to reach the target length.

## CLI Usage and Patterns

### Basic Syntax
The standard invocation for the tool follows the UCSC binary pattern:
```bash
bedExtendRanges input.bed minLength output.bed
```

### Key Requirements
*   **BED 6+ Format**: The input file must have at least 6 columns. The 6th column (strand) must be present (`+` or `-`) for the tool to function correctly, as extension logic is strand-dependent.
*   **Strand Awareness**: 
    *   For `+` strand features, the start position is typically held constant while the end position is moved downstream to satisfy the length requirement.
    *   For `-` strand features, the end position is typically held constant while the start position is moved upstream.
*   **Coordinate System**: Like all UCSC tools, it operates on 0-indexed, half-open coordinates.

### Common Workflow Patterns

#### Standardizing Peak Widths
When working with ChIP-seq peaks of varying widths, you can use this tool to ensure all peaks are at least 200bp for consistent motif scanning:
```bash
bedExtendRanges peaks.bed 200 standardized_peaks.bed
```

#### Preparing for Signal Extraction
If you are extracting signal from a BigWig file using `bigWigAverageOverBed` and want to ensure a minimum window size around the feature start:
```bash
# Ensure all features are at least 500bp
bedExtendRanges features.bed 500 features_500bp.bed
```

### Expert Tips
*   **Pre-sorting**: While not strictly required for this specific tool's logic, it is best practice to run `bedSort` on your output if you plan to use it with other UCSC utilities like `bedToBigBed`.
*   **Validation**: If your BED file has fewer than 6 columns, the tool will likely fail or produce unexpected results. Use `awk` to add a dummy strand if necessary, though biological accuracy will be lost.
*   **Chrom Sizes**: Note that this tool does not inherently check for chromosome boundaries. If an extension pushes a coordinate beyond the start (0) or the end of a chromosome, you should follow up with `bedClip` using a `chrom.sizes` file to prevent out-of-bounds errors in downstream processing.

## Reference documentation
- [ucsc-bedextendranges Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedextendranges_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)