---
name: fastagap
description: `fastagap` is a specialized utility for the curation and cleaning of FASTA-formatted sequence data.
homepage: https://github.com/nylander/fastagap
---

# fastagap

## Overview

`fastagap` is a specialized utility for the curation and cleaning of FASTA-formatted sequence data. While many tools perform global gap removal, `fastagap` provides granular control by distinguishing between leading, trailing, and internal (inner) gaps. This is particularly useful for preparing sequence alignments where "ragged ends" need to be trimmed without disturbing internal insertions or deletions (indels). It also serves as a quality control tool by filtering sequences based on missing data thresholds or sequence length.

## Command Line Usage

The primary script is `fastagap.pl`. By default, it removes all occurrences of the hyphen (`-`) character.

### Basic Operations
- **Count missing data**: `fastagap.pl -c input.fasta`
- **Remove all gaps (default)**: `fastagap.pl input.fasta > clean.fasta`
- **Convert to tab-separated format**: `fastagap.pl --tabulate input.fasta`

### Handling Specific Gap Types
`fastagap` defines gaps based on their position:
- **Leading gaps**: Contiguous missing data at the very start.
- **Trailing gaps**: Contiguous missing data at the very end.
- **Inner gaps**: Any gaps located between the first and last non-gap characters.

**Common Patterns:**
- **Trim ragged ends only**: `fastagap.pl -L -T input.fasta`
- **Remove inner gaps only**: `fastagap.pl -I input.fasta`
- **Replace leading/trailing gaps with 'N'**: `fastagap.pl -l=N -t=N input.fasta`

### Filtering by Quality and Length
- **Percentage-based filtering**: Remove sequences if total missing data exceeds 30%:
  `fastagap.pl -PA=30 input.fasta`
- **End-gap filtering**: Remove sequences if the sum of leading and trailing gaps exceeds 20%:
  `fastagap.pl -PLT=20 input.fasta`
- **Length filtering**: Only keep sequences between 100 and 500 base pairs:
  `fastagap.pl -MIN=100 -MAX=500 input.fasta`

### Defining Missing Data Characters
If your data uses characters other than the default hyphen (`-`):
- **Predefined shortcuts**: `-N` (for N), `-Q` (for ?), `-X` (for X).
- **Custom character**: `-m="*"`
- **Multiple characters**: Combine shortcuts like `-G -Q` to treat both `-` and `?` as missing data.
- **The "Everything" shortcut**: `-Z` (equivalent to `-A -N -Q -G -X`) to remove all common missing data symbols.

## Expert Tips

- **Case Sensitivity**: Use the `-uc` flag to convert sequences to uppercase before processing. This ensures that 'n' and 'N' are both treated as missing data if the `-N` flag is active.
- **Sequence Wrapping**: By default, output FASTA files wrap at 60 characters. Adjust this using `-w <number>` or set it very high to produce single-line sequences.
- **Empty Sequences**: Use `-E` to explicitly remove entries that contain only a header with no sequence data.
- **Precision**: When generating reports, use `-d <number>` to control the number of decimals shown for missing data ratios (default is 4).
- **Aligned Data**: For files where all sequences are of equal length (alignments), `degap_fasta_alignment.pl` is a lighter alternative for basic gap removal.

## Reference documentation
- [Fastagap GitHub Repository](./references/github_com_nylander_fastagap.md)
- [Bioconda Fastagap Overview](./references/anaconda_org_channels_bioconda_packages_fastagap_overview.md)