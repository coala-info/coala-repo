---
name: iclipro
description: iCLIPro is a diagnostic tool that analyzes iCLIP data to determine the most accurate cross-link site position by comparing read length groups. Use when user asks to analyze iCLIP fragment length bias, determine the optimal reference point for binding sites, or generate start site overlap maps from BAM files.
homepage: http://www.biolab.si/iCLIPro/doc/
---

# iclipro

## Overview
iCLIPro is a diagnostic Python package designed to improve the resolution of iCLIP data analysis. It addresses the issue where fragment length can systematically bias the perceived position of cross-link sites. By segmenting the genome into bins and comparing different read length groups, the tool visualizes whether fragment start sites coincide (supporting conventional iCLIP assumptions) or if the protein-RNA binding site is better represented by the center or end of the fragment.

## Usage Guidelines

### BAM File Preparation
iCLIPro relies on random barcode (RBC) information embedded in the read names within the input BAM file.
- **Format**: Read names should include a record like `:rbcATCGN:`.
- **Fallback**: If the ending colon is missing, the RBC must be at the very end of the name.
- **No Barcodes**: If no RBC info is present, ensure read names do not contain strings that match the RBC regular expression to avoid misleading the tool.

### Core Command Pattern
The basic execution requires an input BAM file:
```bash
iCLIPro [options] in.bam
```

### Defining Read Groups (-g)
You must group reads by length to perform comparisons. Groups can be single values or ranges.
- **Example**: `-g "Short:15-25,Long:35-50,Fixed:20"`
- Use overlapping groups to compare specific sub-populations of reads against a broader set.

### Comparison Logic (-p)
Specify which groups to compare to generate overlap maps. In a comparison `G1-G2`, `G2` acts as the reference (position 0).
- **Example**: `-p "Short-Long"`
- This will show where the sites in the "Short" group fall relative to the "Long" group.

### Interpreting Results
The primary output is `in_report.txt`, which includes the **start site overlap ratio**.
- **Ratio > 1.0**: Supports using the **start site** (conventional iCLIP) to detect binding sites.
- **Ratio < 1.0**: Suggests the **center position** is a more accurate reference point for binding site assignment.

### Parameter Tuning
- **Binning (-b, -r)**: Default is 300nt bins with at least 50 reads. Increase `-r` for higher stringency in noisy datasets.
- **Mapping Quality (-q)**: Default is 10. Increase this if you suspect multi-mapping reads are confounding the overlap maps.
- **Flanking Region (-f)**: Adjust the x-axis width of the heatmaps (default 50nt) if you expect long-range read-through effects.

## Expert Tips
- **Diagnostic Workflow**: Always run iCLIPro first with default settings to check the `in_report.txt` for identified barcodes. If the barcode list looks incorrect, your BAM read names may need reformatting.
- **Heatmap Analysis**: Look for a sharp peak at position 0 in the start-site heatmap. A distribution shifted downstream of 0 indicates that shorter fragments are not starting at the same position as longer ones, signaling a need to reconsider the reference point.
- **Read-through Detection**: If the "end" site comparison shows higher overlap than the "start" site, it may indicate significant read-through where the reverse transcriptase did not stop at the cross-link site.



## Subcommands

| Command | Description |
|---------|-------------|
| iCLIPro | For given input BAM file [in.bam] the script will generate a number of output files that can be used to check for and diagnose systematic misassignments in iCLIP data. |
| iCLIPro_bam_splitter | BAM splitter |

## Reference documentation
- [iCLIPro Usage and Method](./references/www_biolab_si_iCLIPro_doc.md)
- [iCLIPro Documentation Source](./references/www_biolab_si_iCLIPro_doc__sources_index.txt.md)