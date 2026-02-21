---
name: paf2chain
description: `paf2chain` is a high-performance Rust tool designed to bridge the gap between modern sequence aligners and legacy genomic toolsets.
homepage: https://github.com/AndreaGuarracino/paf2chain
---

# paf2chain

## Overview
`paf2chain` is a high-performance Rust tool designed to bridge the gap between modern sequence aligners and legacy genomic toolsets. While many current aligners (like minimap2) output PAF files, many coordinate transformation tools still rely on the CHAIN format. This tool performs the conversion, provided the input PAF contains detailed alignment information via CIGAR strings.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::paf2chain
```

## Usage Patterns
The primary interface is a simple CLI that reads an input file and writes to standard output.

### Basic Conversion
```bash
paf2chain -i alignments.paf > alignments.chain
```

### Handling Compressed Files
The tool natively supports gzip-compressed PAF files:
```bash
paf2chain -i alignments.paf.gz > alignments.chain
```

## Expert Tips and Requirements
- **CIGAR String Requirement**: The conversion process relies on the `cg:Z:` tag in the PAF file. If your PAF file lacks this tag, the conversion will fail or produce incomplete results.
- **Aligner Configuration**:
    - **minimap2**: Always use the `-c` flag to generate CIGAR strings.
    - **wfmash**: Generates compatible PAF files by default.
    - **lastz**: Use `--format=paf:wfmash` for compatibility.
- **Workflow Integration**: Since `paf2chain` outputs to stdout, it is easily integrated into shell pipes for on-the-fly conversion during large-scale alignment tasks.
- **Reverse Mapping**: If you need to convert CHAIN files back to PAF, use the companion tool `chain2paf`.

## Reference documentation
- [paf2chain GitHub Repository](./references/github_com_AndreaGuarracino_paf2chain.md)
- [Bioconda paf2chain Overview](./references/anaconda_org_channels_bioconda_packages_paf2chain_overview.md)