---
name: msaconverter
description: msaconverter is a specialized utility designed to transform Multiple Sequence Alignment (MSA) files across a variety of standard bioinformatics formats.
homepage: https://github.com/linzhi2013/msaconverter
---

# msaconverter

## Overview
msaconverter is a specialized utility designed to transform Multiple Sequence Alignment (MSA) files across a variety of standard bioinformatics formats. Built upon the Biopython AlignIO engine, it provides a streamlined command-line interface for reformatting sequence data. This tool is particularly useful for resolving compatibility issues between different alignment programs and phylogenetic inference software, offering support for both standard and "relaxed" formats to accommodate modern naming conventions.

## Installation
The tool can be installed via pip or the Bioconda channel:
- **Conda**: `conda install bioconda::msaconverter`
- **Pip**: `pip install msaconverter`

## Command Line Usage
The primary command is `msaconverter` (or `msaconverter.py` depending on the installation environment).

### Basic Syntax
```bash
msaconverter -i <INFILE> -o <OUTFILE> -p <INPUT_FORMAT> -q <OUTPUT_FORMAT> -t <MOLECULE_TYPE>
```

### Supported Formats
- **Input (-p)**: `fasta` (default), `clustal`, `stockholm`, `nexus`, `phylip`, `phylip-sequential`, `phylip-relaxed`, `mauve`, `maf`.
- **Output (-q)**: `phylip-relaxed` (default), `fasta`, `clustal`, `stockholm`, `nexus`, `phylip`, `phylip-sequential`, `phylip-sequential-relaxed`, `mauve`, `maf`.

### Molecule Types (-t)
Specify the type of sequences in the alignment:
- `DNA` (default)
- `RNA`
- `protein`

## Common CLI Patterns

### Convert FASTA to Relaxed PHYLIP
Standard PHYLIP has a strict 10-character limit for sequence names. Use `phylip-relaxed` to allow longer names:
```bash
msaconverter -i alignment.fasta -o alignment.phy -p fasta -q phylip-relaxed
```

### Prepare Data for Nexus-based Tools (e.g., MrBayes, PAUP*)
When converting to Nexus, always specify the molecule type to ensure the DATA block is correctly formatted:
```bash
msaconverter -i alignment.fasta -o alignment.nex -p fasta -q nexus -t DNA
```

### Handling Long Names in Sequential PHYLIP
Use the custom `phylip-sequential-relaxed` output format to maintain a sequential structure while supporting long sequence identifiers:
```bash
msaconverter -i input.fasta -o output.phy -q phylip-sequential-relaxed
```

## Expert Tips and Best Practices
- **Format Verification**: If you are unsure of the input format, `fasta` is the most common default. However, for Stockholm files (often from Pfam or Rfam), explicitly set `-p stockholm` to preserve annotation metadata.
- **Nexus Metadata**: The `-t` flag is critical for Nexus output. If omitted, the tool defaults to DNA, which will cause errors in phylogenetic software if your data is actually protein sequences.
- **Sequential vs. Interleaved**: Standard `phylip` often defaults to interleaved. If your downstream tool requires sequential format (where each sequence is written in full before the next), use `phylip-sequential`.
- **Biopython Dependency**: Since this tool is a wrapper for Biopython's AlignIO, any format-specific limitations in Biopython will apply here. Refer to Biopython documentation for deep technical details on how specific formats like `maf` or `mauve` are parsed.

## Reference documentation
- [msaconverter GitHub Repository](./references/github_com_linzhi2013_msaconverter.md)
- [msaconverter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_msaconverter_overview.md)