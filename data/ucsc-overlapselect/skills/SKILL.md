---
name: ucsc-overlapselect
description: ucsc-overlapselect identifies and extracts genomic features that intersect with a reference set of regions across various formats like BED, PSL, and GenePred. Use when user asks to identify overlapping genomic features, filter alignments based on overlap thresholds, or generate overlap statistics between two datasets.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-overlapselect:482--h0b57e2e_0"
---

# ucsc-overlapselect

## Overview
The `ucsc-overlapselect` utility is a high-performance tool from the UCSC Kent toolkit used to identify and extract genomic features that intersect with a reference set of regions. Unlike simple intersection tools, it is designed to work seamlessly across various UCSC-native formats (BED, PSL, GenePred) and can provide sophisticated filtering based on the fraction of overlap. It is the standard choice for tasks like filtering EST alignments against gene boundaries or identifying which genomic elements fall within specific chromosomal windows.

## Common CLI Patterns

### Basic Usage
The tool requires three positional arguments: the reference file (selectFile), the file to be filtered (inFile), and the output file (outFile).
```bash
overlapSelect [options] selectFile inFile outFile
```

### Filtering by Overlap Fraction
To ensure a significant overlap rather than a single base intersection, use the threshold options:
*   **Minimum overlap in the input record**: `-overlapThreshold=0.5` (requires 50% of the input record to be covered).
*   **Minimum overlap in the select record**: `-overlapThresholdSelect=0.5` (requires 50% of the reference record to be covered).

### Outputting Statistics
Instead of selecting records, you can generate a report of overlap metrics:
```bash
overlapSelect -stats selectFile inFile stats.txt
```
The output includes columns for the number of bases overlapping, the fraction of the input record covered, and the fraction of the select record covered.

### Handling Specific Formats
While the tool auto-detects many formats, you can be explicit:
*   **BED files**: `-bed`
*   **PSL files**: `-psl`
*   **GenePred files**: `-genePred`

### Advanced Selection Logic
*   **Non-overlapping records**: Use `-nonOverlapping` to select records that do *not* intersect with the selectFile.
*   **Merge overlapping records**: Use `-mergeOutput` to join multiple overlapping records into a single output entry.
*   **Ignore gaps**: Use `-inGap` to consider overlaps that occur within the gaps (introns/blocks) of the records.

## Expert Tips
*   **Coordinate Consistency**: Ensure both files use the same coordinate system (typically 0-based, half-open for UCSC tools).
*   **Performance**: `ucsc-overlapselect` is optimized for speed. For very large datasets, ensure your input files are sorted by chromosome and start position to minimize memory overhead, although the tool is generally robust to unsorted input.
*   **ID Matching**: Use the `-idMatch` flag if you only want to consider overlaps between records that share the same name/ID.
*   **Strand Specificity**: By default, the tool ignores strand. Use `-strand` to require that overlaps occur on the same strand.

## Reference documentation
- [anaconda_org_channels_bioconda_packages_ucsc-overlapselect_overview.md](./references/anaconda_org_channels_bioconda_packages_ucsc-overlapselect_overview.md)
- [hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [github_com_ucscGenomeBrowser_kent.md](./references/github_com_ucscGenomeBrowser_kent.md)