---
name: hictk
description: hictk is a high-performance C++ toolkit for the efficient manipulation, conversion, and normalization of Hi-C data in Cooler and Juicer formats. Use when user asks to convert between .hic and .cool formats, dump interaction matrices, balance matrices, merge datasets, or create multi-resolution files.
homepage: https://github.com/paulsengroup/hictk
---


# hictk

## Overview
`hictk` is a high-performance C++ toolkit designed for efficient manipulation of Hi-C data. It provides native, fast I/O for both Cooler and Juicer (.hic) formats, allowing for seamless interoperability between different genomic data standards. Use this skill to perform heavy-duty data processing tasks—such as merging multiple files, creating multi-resolution datasets (zoomification), or normalizing matrices—with significantly lower memory overhead and higher speed than traditional Python-based tools.

## Common CLI Patterns

### Format Conversion
Convert between `.hic` and `.cool` formats. This is one of the most common use cases for bridging different analysis pipelines.
```bash
# Convert .hic to .cool
hictk convert input.hic output.cool

# Convert .cool to .hic
hictk convert input.cool output.hic
```

### Data Extraction (Dumping)
Extract interaction matrices or metadata to standard output for use in custom scripts or visualization.
```bash
# Dump interactions in BEDPE-like format for a specific region
hictk dump input.hic --range chr1:0-1000000

# List available resolutions in a multi-resolution file
hictk metadata input.mcool --list-resolutions
```

### Normalization (Balancing)
Apply matrix balancing algorithms to remove experimental biases.
```bash
# Balance a file using the ICE algorithm
hictk balance input.cool --mode ice

# Apply SCALE normalization to a .hic file
hictk balance input.hic --mode scale
```

### File Creation and Merging
Build new files from text-based interaction pairs or combine existing datasets.
```bash
# Load interactions from a pairs file into a .cool file
hictk load chromosomes.sizes input.pairs.gz output.cool

# Merge multiple .cool files into one
hictk merge file1.cool file2.cool file3.cool -o merged.cool

# Create a multi-resolution .mcool file from a single-resolution .cool file
hictk zoomify input.cool output.mcool
```

## Best Practices and Expert Tips
- **Memory Efficiency**: `hictk` is optimized for low memory usage. When merging very large files, it is often faster and more stable than `cooler merge`.
- **Native I/O**: Because `hictk` uses a native C++ implementation for both formats, it does not require `JuicerTools` or `straw` to read `.hic` files, making it easier to deploy in containerized environments.
- **Validation**: Use `hictk validate` before starting long-running pipelines to ensure your input files are not corrupted, especially when working with `.mcool` files which can sometimes have indexing issues.
- **Chromosome Renaming**: If your downstream tool expects "chr1" but your file uses "1", use `hictk rename-chromosomes` to fix the metadata without re-generating the entire dataset.
- **Resolution Handling**: When using `hictk dump` on multi-resolution files (`.mcool` or `.hic`), always specify the resolution using the `--resolution` flag to ensure you are querying the correct matrix.

## Reference documentation
- [hictk GitHub Repository](./references/github_com_paulsengroup_hictk.md)
- [hictk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hictk_overview.md)