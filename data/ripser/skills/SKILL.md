---
name: ripser
description: "Ripser is a high-performance C++ tool designed for a singular purpose: computing Vietoris–Rips persistence barcodes."
homepage: http://ripser.org/
---

# ripser

## Overview
Ripser is a high-performance C++ tool designed for a singular purpose: computing Vietoris–Rips persistence barcodes. It is optimized for speed and memory efficiency, significantly outperforming other TDA (Topological Data Analysis) software. It is best used when dealing with large datasets where you need to identify topological features like components (H0), loops (H1), or voids (H2) that persist across a range of distance thresholds.

## Input Formats
Ripser is flexible with input, supporting several formats via the `--format` flag:
- `point-cloud` (Default): A list of coordinates, one point per line.
- `distance`: A full distance matrix (only the lower triangular part is read).
- `lower-distance`: Lower triangular entries, lexicographically sorted.
- `upper-distance`: Upper triangular entries (compatible with MATLAB `pdist` output).
- `sparse`: Sparse triplet format (`i j distance`).
- `dipha`: DIPHA-specific distance matrix format.
- `binary`: 32-bit float little-endian lower triangular matrix.

## Common CLI Patterns

### Basic Point Cloud Analysis
To compute persistence barcodes for a 3D point cloud up to 1-dimensional homology (loops):
```bash
ripser --format point-cloud --dim 1 data.txt
```

### Limiting Computation Scale
For large datasets, it is often necessary to set a distance threshold to prevent the Rips complex from becoming too dense:
```bash
ripser --threshold 0.5 data.csv
```

### Filtering Noise
To focus on significant topological features, use the ratio flag to filter out points with low persistence (death/birth ratio):
```bash
ripser --ratio 1.2 data.txt
```

### Working with Coefficients
If the binary was compiled with `USE_COEFFICIENTS`, you can specify the prime field for homology:
```bash
ripser --modulus 3 data.txt
```

## Expert Tips
- **Memory Management**: If you encounter memory issues with high-dimensional homology, always set a `--threshold`. Without it, Ripser defaults to the enclosing radius, which can lead to a combinatorial explosion of simplices.
- **Performance**: Ripser computes persistent *cohomology*, which is mathematically equivalent to persistent homology but much faster to compute for Vietoris–Rips filtrations.
- **Piping**: Ripser supports `stdin`. You can pipe pre-processed distance matrices directly into the tool:
  ```bash
  cat matrix.csv | ripser --format distance
  ```

## Reference documentation
- [Ripser GitHub Repository](./references/github_com_Ripser_ripser.md)
- [Bioconda Ripser Overview](./references/anaconda_org_channels_bioconda_packages_ripser_overview.md)