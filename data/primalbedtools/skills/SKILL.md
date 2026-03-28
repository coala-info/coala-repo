---
name: primalbedtools
description: Primalbedtools is a bioinformatic tool for processing, validating, and remapping primer schemes used in amplicon sequencing. Use when user asks to validate primer BED files, upgrade schemes to v3 format, remap coordinates via multiple sequence alignment, or generate amplicon boundaries.
homepage: https://github.com/ChrisgKent/primalbedtools
---


# primalbedtools

## Overview
Primalbedtools is a specialized Python library and CLI designed for the bioinformatic processing of primer schemes used in amplicon sequencing (like ARTIC). It ensures that primer BED files are internally consistent and correctly mapped to their reference sequences. It is particularly useful for upgrading legacy v1/v2 schemes to the current v3 specification, which includes support for probes and key-value metadata.

## Core Workflows

### Validation
Always validate new or modified primer schemes to ensure internal consistency (correct LEFT/RIGHT pairings) and genomic accuracy.
- **Internal Consistency**: `primalbedtools validate_bedfile primers.bed`
- **Genomic Validation**: `primalbedtools validate primers.bed reference.fasta` (checks if primer sequences actually exist at the specified coordinates).

### Format Conversion
The tool handles three versions of primer naming. v3 is the current standard: `{scheme}_{amplicon}_{LEFT|RIGHT|PROBE}_{index}`.
- **Upgrade to v3**: `primalbedtools update primers.v1.bed > primers.v3.bed`
- **Downgrade for legacy tools**: `primalbedtools downgrade primers.v3.bed > primers.v1.bed`
- **Merge Alts**: Use `--merge-alts` during downgrade to remove `_alt` suffixes for tools that cannot handle multiple primers per site.

### Coordinate Remapping
When moving a primer scheme from one reference (e.g., Wuhan-Hu-1) to a new variant (e.g., BA.2), use a Multiple Sequence Alignment (MSA).
```bash
primalbedtools remap --bed primers.bed --msa alignment.fasta --from_id MN908947.3 --to_id BA.2
```

### Amplicon Analysis
Generate expected amplicon boundaries or primer-trimmed regions for downstream analysis.
- **Standard Amplicons**: `primalbedtools amplicon primers.bed`
- **Trimmed Amplicons**: `primalbedtools amplicon primers.bed --primertrim` (useful for calculating actual coverage areas).

## Python API Usage
For complex workflows, use the `Scheme` and `BedLine` objects directly.

```python
from primalbedtools.scheme import Scheme

# Load and manipulate
scheme = Scheme.from_file("primers.bed")

# Access specific attributes
for bl in scheme.bedlines:
    print(f"Amplicon {bl.amplicon_number}: {bl.sequence}")

# Update properties (automatically updates primername)
scheme.bedlines[0].amplicon_prefix = "NewScheme"

# Export to CSV for LIMS/Lab use
csv_output = scheme.to_delim_str(use_header_aliases=True)
```

## Best Practices
- **Sorting**: Always run `primalbedtools sort` before distributing a scheme to ensure it is ordered by chromosome and amplicon number rather than file-append order.
- **Merging**: Use `primalbedtools merge` to consolidate primers with identical properties (chrom, amplicon, direction) into single entries.
- **Metadata**: In v3 files, utilize the 8th column for attributes like `gc` or `ps` (primer score). These are parsed into the `attributes` dictionary in the Python API.



## Subcommands

| Command | Description |
|---------|-------------|
| primalbedtools amplicon | Primertrim the amplicons |
| primalbedtools csv | Convert a BED file to CSV format. |
| primalbedtools downgrade | Downgrades a BED file to a simpler format. |
| primalbedtools fasta | Convert BED file to FASTA format |
| primalbedtools format | Format a BED file. |
| primalbedtools update | Update BED file |
| primalbedtools validate | Validate a BED file against a reference FASTA file. |
| primalbedtools_merge | Merge overlapping intervals in a BED file. |
| primalbedtools_sort | Sort a BED file |
| remap | Remap IDs in a BED file based on an MSA. |
| validate_bedfile | Validate a BED file |

## Reference documentation
- [Primalbedtools CLI Guide](./references/chrisgkent_github_io_primalbedtools_cli.md)
- [How-To Guides and API Examples](./references/chrisgkent_github_io_primalbedtools_how-to-guides.md)
- [API Reference](./references/chrisgkent_github_io_primalbedtools_api.md)
- [Project Overview and Version History](./references/chrisgkent_github_io_primalbedtools.md)