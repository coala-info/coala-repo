---
name: negspy
description: "negspy is a Python toolkit for managing genomic assembly metadata and converting chromosome coordinates into global genome positions. Use when user asks to retrieve chromosome sizes, get standard chromosome orderings, or convert chromosome-specific positions to absolute genome coordinates."
homepage: https://github.com/pkerpedjiev/negspy
---


# negspy

## Overview
`negspy` is a specialized Python toolkit designed to handle the metadata of reference genomes. It simplifies the process of working with different genomic assemblies by providing a central repository of chromosome lengths and standard orderings. This is critical for bioinformatics tasks that require "linearizing" the genome—treating all chromosomes as a single continuous sequence—which is a common requirement for large-scale genomic visualizations (like Hi-C heatmaps) and data processing.

## Installation
Install via bioconda:
`conda install bioconda::negspy`

## Common CLI Patterns

### Coordinate Conversion
Convert a specific chromosome and position to a global genome position (absolute coordinate):
`chr_pos_to_genome_pos.py [chromosome] [position] [assembly]`

Example:
`chr_pos_to_genome_pos.py chr2 10 hg19`

### Retrieving Chromosome Sizes
Print the lengths of all chromosomes for a given assembly:
`python -m negspy.chrom_sizes hg38`

## Python API Usage
For integration into bioinformatics pipelines, use the `coordinates` module:

```python
import negspy.coordinates as nc

# List all supported assemblies (e.g., hg19, hg38, mm10, dm6)
assemblies = nc.available_chromsizes()

# Get absolute genome position
# Returns the position as if all chromosomes were laid end-to-end
abs_pos = nc.chr_pos_to_genome_pos('chr1', 1000, 'hg19')

# Get the standard chromosome order for an assembly
order = nc.get_chromorder('mm10')
```

## Expert Tips

- **Assembly Naming**: Note that `GRCh37` and `hg19` are functionally identical in `negspy` but use different naming conventions (e.g., "1" vs "chr1"). Ensure your input matches the assembly's expected prefix to avoid lookup errors.
- **Custom Assemblies**: You can extend the tool by adding new assembly data. Create a directory under `negspy/data/${ASSEMBLY}/` containing:
  - `chromInfo.txt`: A tab-delimited file with `[chromosome] [size]`.
  - `chromSizes.txt` (Optional): Defines the specific linear ordering of chromosomes (e.g., putting numbered chromosomes first, followed by X, Y, and M).
- **Linearization Logic**: When converting to genome positions, `negspy` calculates the offset by summing the lengths of all chromosomes that precede the target chromosome according to the assembly's defined `chromOrder`.
- **Smart Open**: Recent versions (0.3.0+) use `smart_open`, allowing for better handling of compressed or remote data files if configured.

## Reference documentation
- [negspy GitHub Repository](./references/github_com_pkerpedjiev_negspy.md)
- [negspy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_negspy_overview.md)