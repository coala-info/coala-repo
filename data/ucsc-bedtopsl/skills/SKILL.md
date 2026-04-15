---
name: ucsc-bedtopsl
description: This tool converts BED genomic feature records into PSL alignment records. Use when user asks to transform BED files to PSL format, represent genomic features as alignments, or prepare data for UCSC visualization tracks.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bedtopsl:482--h0b57e2e_0"
---

# ucsc-bedtopsl

## Overview
The `bedToPsl` utility is part of the UCSC Genome Browser "kent" source suite. It transforms BED (Browser Extensible Data) records into PSL (Pattern Space Layout) records. This is particularly useful when you have genomic features (like gene models or peak calls) and need to represent them in a format that describes how they align to a reference sequence, which is a requirement for certain downstream UCSC utilities and visualization tracks.

## Usage Instructions

### Basic Command Syntax
The tool requires a chromosome sizes file to correctly map the BED coordinates into the PSL structure.

```bash
bedToPsl chrom.sizes input.bed output.psl
```

### Requirements
- **chrom.sizes**: A tab-separated file containing two columns: `<chromosome_name> <size_in_bases>`. You can generate this using `fetchChromSizes` or by extracting it from a 2bit file using `twoBitInfo`.
- **input.bed**: A standard BED file. While the tool can process BED3, it is most effective with BED12 (linked features/blocks) to correctly populate the block-related fields in the PSL output.

### Expert Tips and Best Practices
- **Preserving Block Structure**: If your BED file contains multiple blocks (e.g., exons in a gene model), `bedToPsl` will correctly translate these into PSL blocks. Ensure your input is a valid BED12 to maintain this structural integrity.
- **Strand Orientation**: PSL files are strand-aware. `bedToPsl` uses the strand column in the BED file to determine the orientation in the resulting PSL. If no strand is provided in the BED file, it defaults to the positive strand.
- **Validation**: After conversion, you can validate the resulting PSL file using `pslCheck` to ensure it meets the structural requirements for the UCSC Genome Browser.
- **Coordinate Systems**: Remember that both BED and PSL use 0-indexed, half-open coordinates. The conversion is a direct mapping of these coordinates, but the PSL format adds additional fields for match/mismatch counts (which are typically zeroed out or estimated during this conversion as the underlying sequence alignment is not present in a BED file).



## Subcommands

| Command | Description |
|---------|-------------|
| bedSort | Sort a BED file. The input and output can be the same file. |
| bedToPsl | Convert BED format to PSL format. |
| fetchChromSizes | Fetch chromosome sizes for a specified UCSC genome database (e.g., hg38, mm10). |
| pslCheck | Check PSL files for correctness. |

## Reference documentation
- [UCSC Genome Browser Kent Source Utilities](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.aarch64.v492.md)
- [UCSC Genome Browser Source README](./references/github_com_ucscGenomeBrowser_kent.md)