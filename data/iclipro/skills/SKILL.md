---
name: iclipro
description: The `iclipro` skill enables the diagnostic analysis of iCLIP data by examining how fragment length affects the positioning of fragment start sites.
homepage: http://www.biolab.si/iCLIPro/doc/
---

# iclipro

## Overview
The `iclipro` skill enables the diagnostic analysis of iCLIP data by examining how fragment length affects the positioning of fragment start sites. While conventional iCLIP assumes fragment starts coincide at the cross-linking position regardless of length, certain libraries exhibit length-dependent offsets. This tool generates heatmaps and calculates overlap ratios to help you decide whether to use the start or center of fragments for high-resolution mapping of RNA-protein interactions.

## Core Workflow

### 1. Input Preparation
Ensure your input BAM file contains random barcode (RBC) information in the read names. The tool expects a specific format:
- **Standard format**: `read_name:rbcATCGN:`
- **End of name**: `read_name:rbcATCGN`
- **Fallback**: If no `:rbc` tag is found, it will attempt to use the original read names, but ensure no text in the names accidentally matches the barcode regex.

### 2. Basic Execution
Run the primary analysis on a mapped BAM file:
```bash
iCLIPro -o output_results/ input.bam
```

### 3. Defining Read Groups
To compare different fragment populations, define length groups using the `-g` flag. This is critical for generating meaningful overlap maps.
- **Intervals**: `A:16-39` (reads between 16 and 39 nt)
- **Specific lengths**: `L:20` (only 20 nt reads)
- **Mixed groups**: `-g "A1:16-25,A2:26-32,A3:33-39,B:42"`

### 4. Generating Overlap Maps
Specify which groups to compare using the `-p` flag. The second group in the pair acts as the reference (zero position).
```bash
iCLIPro -g "A1:16-25,B:42" -p "A1-B" input.bam
```

## Parameter Optimization

| Parameter | Flag | Default | Expert Tip |
| :--- | :--- | :--- | :--- |
| **Bin Size** | `-b` | 300 | Use smaller bins (100) for high-density data; larger (1000) for sparse data. |
| **Min Reads** | `-r` | 50 | Minimum reads per bin to be included in testing. Increase to reduce noise. |
| **Map Quality** | `-q` | 10 | Filter out multi-mappers or low-confidence alignments. |
| **Flanking** | `-s` | 5 | Distance used for calculating the start site overlap ratio. |
| **Map Range** | `-f` | 50 | The x-axis range (-50 to +50) for the output heatmaps. |

## Interpreting Results

The primary output is `[input]_report.txt` and associated heatmaps.

- **Start Site Overlap Ratio > 1.0**: Suggests fragment start sites coincide well. Use the **start site** (conventional iCLIP) for binding site assignment.
- **Start Site Overlap Ratio < 1.0**: Suggests length-dependent offsets. The **center position** of the fragment is likely a more accurate proxy for the binding site.
- **Heatmap Visualization**: Look for a vertical peak at offset 0. A diagonal distribution indicates that start sites shift based on fragment length, signaling a need for center-based mapping.

## Helper Tools
- **iCLIPro_bam_splitter**: Use this to generate `bedGraph` files from specific read length groups for visualization in genome browsers (like IGV or UCSC).

## Reference documentation
- [iCLIPro Documentation](./references/www_biolab_si_iCLIPro_doc.md)
- [iCLIPro Source Index](./references/www_biolab_si_iCLIPro_doc__sources_index.txt.md)