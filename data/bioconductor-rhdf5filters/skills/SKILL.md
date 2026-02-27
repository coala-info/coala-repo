---
name: bioconductor-rhdf5filters
description: This package provides external HDF5 compression filters like Blosc, bzip2, LZF, and Zstandard for use with R and external applications. Use when user asks to write HDF5 files with specialized compression algorithms, read datasets compressed with non-standard filters, or configure the HDF5 plugin path for external tools.
homepage: https://bioconductor.org/packages/release/bioc/html/rhdf5filters.html
---


# bioconductor-rhdf5filters

name: bioconductor-rhdf5filters
description: Provides external HDF5 compression filters (Blosc, bzip2, LZF, Zstandard, VBZ) for use with the rhdf5 R package and external HDF5 applications. Use this skill when you need to write HDF5 files with specific compression algorithms not included in the standard HDF5 library, or when you need to enable an R session or external tool to read HDF5 data compressed with these specialized filters.

## Overview

The `rhdf5filters` package provides a collection of dynamically loaded HDF5 compression plugins. While the standard HDF5 library supports *deflate* (zlib) and *szip*, `rhdf5filters` extends this to include `bzip2`, `LZF`, `VBZ`, `Zstandard`, and the `Blosc` meta-compressor (which includes `blosclz`, `lz4`, `lz4hc`, `snappy`, `zstd`, and `zlib`).

The package is designed to work transparently with the `rhdf5` Bioconductor package, but it also provides the necessary paths to enable these filters in external applications like `h5dump` or HDFView.

## Usage in R

### Reading Compressed Data
If `rhdf5filters` is installed, `rhdf5` will automatically and transparently decompress datasets using any of the supported filters. No explicit function calls are required during the read process.

### Writing Compressed Data
To create a dataset with a specific filter, use `rhdf5::h5createDataset()` or specific property list setters.

#### Using h5createDataset
Specify the filter name in the `filter` argument:

```r
library(rhdf5)
library(rhdf5filters)

h5file <- "example.h5"
h5createFile(h5file)

# Create a dataset using the blosc filter
h5createDataset(h5file, "data_blosc", dims = c(100, 100), 
                storage.mode = "double", chunk = c(10, 10), 
                filter = "BLOSC")

# Create a dataset using the bzip2 filter
h5createDataset(h5file, "data_bzip2", dims = c(100, 100), 
                storage.mode = "double", chunk = c(10, 10), 
                filter = "BZIP2")
```

#### Using Property Lists
For more granular control, use the `H5Pset_*` functions modeled after the standard HDF5 interface:

```r
p_list <- H5Pcreate("H5P_DATASET_CREATE")
H5Pset_chunk(p_list, c(10, 10))

# Set specific filters
H5Pset_blosc(p_list, method = 1) # 1 = blosclz
# OR
H5Pset_bzip2(p_list, level = 9)
# OR
H5Pset_lzf(p_list)

# Use the property list to create the dataset
h5createDataset(h5file, "custom_data", dims = c(100, 100), dcpl = p_list)
H5Pclose(p_list)
```

## Integration with External Applications

If you need to use these filters with system tools (like `h5dump`) or other HDF5-aware software, you must point the HDF5 library to the plugin directory provided by this package.

### Setting the Plugin Path
In R, you can retrieve the path and set the environment variable:

```r
# Get the path to the compiled filter plugins
plugin_path <- rhdf5filters::hdf5_plugin_path()

# Set the environment variable so external system calls recognize the filters
Sys.setenv("HDF5_PLUGIN_PATH" = plugin_path)

# Example: Calling system h5dump on a blosc-compressed file
system2("h5dump", args = c("-p", "-d /dset", "compressed_file.h5"))
```

## Supported Filters
The following filter strings/types are available:
- `bzip2`
- `blosclz`, `lz4`, `lz4hc`, `snappy`, `Zstandard`, `zlib` (via the `BLOSC` meta-compressor)
- `LZF`
- `VBZ`

## Reference documentation
- [rhdf5filters](./references/rhdf5filters.md)