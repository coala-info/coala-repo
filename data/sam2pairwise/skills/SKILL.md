---
name: sam2pairwise
description: sam2pairwise is a specialized bioinformatics utility that transforms the compact alignment information stored in SAM files (specifically the CIGAR string and MD tag) into an explicit, four-line pairwise alignment format.
homepage: https://github.com/mlafave/sam2pairwise
---

# sam2pairwise

## Overview
sam2pairwise is a specialized bioinformatics utility that transforms the compact alignment information stored in SAM files (specifically the CIGAR string and MD tag) into an explicit, four-line pairwise alignment format. This tool is particularly useful when you need to see exactly how a read aligns to a reference sequence without manually decoding complex CIGAR operations or MD mismatch strings. It supports a wide range of CIGAR operations including matches, mismatches, gaps, clipping, and padding.

## Installation and Setup
The tool can be installed via Bioconda or compiled from source:

- **Conda**: `conda install bioconda::sam2pairwise`
- **Source**: Navigate to the `src/` directory and run `make`.

## Common CLI Patterns

### Processing SAM Files
The tool reads from standard input and writes to standard output.
```bash
sam2pairwise < input.sam > alignment_output.txt
```

### Processing BAM Files
Since sam2pairwise requires text-based SAM input, use `samtools view` to pipe data from BAM files.
```bash
samtools view input.bam | sam2pairwise > alignment_output.txt
```

### Checking Version
```bash
sam2pairwise --version
```

## Output Format
For every input SAM record, the tool generates four lines:
1. **Header**: Reproduces the first nine mandatory fields of the SAM entry.
2. **Read Sequence**: The sequence of the read, including gaps (`-`) or padding.
3. **Match Line**: Visual indicators where `|` represents a match and a space represents a mismatch or gap.
4. **Reference Sequence**: The reconstructed reference sequence, including gaps (`-`) or skipped regions (`N`).

## Expert Tips and Best Practices

### MD Tag Requirement
The MD tag (Field 13+ in SAM) is strictly required to resolve mismatches for 'M', '=', and 'X' CIGAR operations. If the MD tag is missing and the CIGAR string requires it to resolve a mismatch, the tool will output an error message for that specific record while maintaining the four-line output structure to preserve file periodicity.

### Handling Different CIGAR Operations
- **Soft Clipping (S)**: Represented as the actual characters on the read and as `N`s on the reference.
- **Hard Clipping (H)**: These characters are not present in the read sequence and are skipped in the output.
- **Deletions (D)**: Indicated by a `-` on the read sequence.
- **Insertions (I)**: Indicated by a `-` on the reference sequence.
- **Skipped Regions (N)**: Represented as `.` on the read and `N` on the reference.

### Error Handling
Errors (such as unsupported CIGAR characters or missing MD tags) are printed to **STDERR**. When processing large batches, it is recommended to redirect STDERR to a log file to identify problematic reads without interrupting the STDOUT stream.

## Reference documentation
- [github_com_mlafave_sam2pairwise.md](./references/github_com_mlafave_sam2pairwise.md)
- [anaconda_org_channels_bioconda_packages_sam2pairwise_overview.md](./references/anaconda_org_channels_bioconda_packages_sam2pairwise_overview.md)