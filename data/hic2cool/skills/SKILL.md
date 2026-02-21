---
name: hic2cool
description: "hic2cool is a specialized utility designed to bridge the gap between two major Hi-C data formats: the Java-based `.hic` format used by Juicer and the HDF5-based `.cool` format used by the Cooler suite."
homepage: https://github.com/4dn-dcic/hic2cool
---

# hic2cool

## Overview
hic2cool is a specialized utility designed to bridge the gap between two major Hi-C data formats: the Java-based `.hic` format used by Juicer and the HDF5-based `.cool` format used by the Cooler suite. It allows for both single-resolution and multi-resolution conversions, ensuring that data generated in one pipeline can be utilized in tools like HiGlass or Open2C analysis packages.

## Command Line Interface (CLI) Usage

### Basic Conversion
The primary command is `hic2cool convert`.

**Create a multi-resolution file (.mcool):**
By default, setting resolution to 0 (or omitting it) will convert all resolutions found in the `.hic` file.
```bash
hic2cool convert input.hic output.mcool -r 0
```

**Create a single-resolution file (.cool):**
Specify a specific base pair resolution. Note that single-resolution files are generally not compatible with HiGlass.
```bash
hic2cool convert input.hic output.cool -r 10000
```

### Performance and Logging
- **Multiprocessing**: Use `-p` to specify the number of processes. This is most effective for large, high-resolution matrices.
- **Silent Mode**: Use `-s` to suppress console output.
- **Warnings**: Use `-w` to explicitly print warnings during the conversion process.

```bash
hic2cool convert input.hic output.mcool -p 4 -s
```

### Managing Normalization Vectors
hic2cool handles the conversion of normalization vectors (e.g., KR, VC). Since version 0.5.0, it preserves the divisive nature of `.hic` normalization for compatibility with HiGlass.

**Extracting norms to an existing cooler:**
If you already have a `.cool` file and only need the normalization vectors from a `.hic` file:
```bash
hic2cool extract-norms input.hic existing_output.cool
```
*Note: The resolutions in the `.cool` file must match those in the `.hic` file.*

**Updating legacy files:**
If you have `.cool` files created with hic2cool versions prior to 0.5.0, update them to the current normalization standard:
```bash
hic2cool update legacy_input.cool updated_output.cool
```

## Python API Usage
You can integrate the converter directly into Python workflows.

```python
from hic2cool import hic2cool_convert

# Convert to multi-res
hic2cool_convert('input.hic', 'output.mcool', 0)

# Convert to single-res
hic2cool_convert('input.hic', 'output.cool', 50000)
```

## Expert Tips
- **HiGlass Compatibility**: Always produce multi-resolution files (`-r 0`) if the intended use is visualization in HiGlass.
- **Mitochondrial DNA**: When extracting norms, use the `-e` flag to automatically exclude mitochondrial chromosomes (searches for 'M', 'MT', 'chrM', etc.).
- **Resolution Constraints**: You can only convert to resolutions that already exist within the source `.hic` file. hic2cool does not perform re-binning.
- **Memory Management**: While `hic2cool` is designed to be lightweight, converting very high-resolution matrices (e.g., 1kb or 5kb) for large genomes requires significant RAM.

## Reference documentation
- [github_com_4dn-dcic_hic2cool.md](./references/github_com_4dn-dcic_hic2cool.md)
- [anaconda_org_channels_bioconda_packages_hic2cool_overview.md](./references/anaconda_org_channels_bioconda_packages_hic2cool_overview.md)