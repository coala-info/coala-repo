---
name: blue-crab
description: blue-crab is a data conversion utility that facilitates the transition between POD5 and S/BLOW5 formats for nanopore sequencing data. Use when user asks to convert POD5 files to SLOW5 or BLOW5 format, or convert SLOW5 or BLOW5 files back to POD5 format.
homepage: https://github.com/Psy-Fer/blue-crab
---


# blue-crab

## Overview

blue-crab is a specialized data conversion utility that facilitates the transition between POD5 and S/BLOW5 formats for nanopore sequencing data. While POD5 is the default output for modern ONT devices, the SLOW5/BLOW5 ecosystem offers optimized row-based access to raw signal data, which is often preferred for downstream bioinformatics tools. This skill provides the necessary command-line patterns to ensure high-fidelity data parity during these conversions.

## Installation and Setup

The tool can be installed via multiple methods, with Conda being the most straightforward for bioinformatics environments:

```bash
# Via Conda
conda install bioconda::blue-crab

# Via Pip
pip install blue-crab
```

*Note: Requires Python 3.8 or higher due to ONT's pod5 library dependencies.*

## Common CLI Patterns

### POD5 to SLOW5/BLOW5 (p2s)

To convert a single file:
```bash
blue-crab p2s input.pod5 -o output.blow5
```

To convert an entire directory of POD5 files:
```bash
blue-crab p2s pod5_directory -d output_directory
```

### SLOW5/BLOW5 to POD5 (s2p)

To convert back to the ONT native format:
```bash
blue-crab s2p input.blow5 -o output.pod5
```

## Expert Tips and Best Practices

### Compression Selection
By default, blue-crab uses `zlib` compression for maximum compatibility across different systems. However, `zstd` offers significantly better performance and smaller file sizes.

- **For better performance**: Use `-c zstd` if your environment supports it.
- **For portability**: Stick with the default `zlib`.

```bash
# Example using zstd compression
blue-crab p2s -c zstd input_dir -d output_dir
```

### Data Integrity Verification
Because ONT frequently updates the POD5 specification, it is a best practice to verify the integrity of created files using `slow5tools`.

1. Run `slow5tools quickcheck` on the resulting BLOW5 files.
2. Use `slow5tools index` to ensure the files are ready for high-speed access.

### Real-time Conversion
For high-throughput environments, blue-crab can be used in conjunction with wrapper scripts to perform real-time conversion during a sequencing run, though this typically requires custom pipeline integration.

### Environment Variables
If building from source or using specific compression libraries, you may need to set the following to enable ZSTD support:
```bash
export PYSLOW5_ZSTD=1
```

## Reference documentation
- [blue-crab GitHub Repository](./references/github_com_Psy-Fer_blue-crab.md)
- [Bioconda blue-crab Overview](./references/anaconda_org_channels_bioconda_packages_blue-crab_overview.md)