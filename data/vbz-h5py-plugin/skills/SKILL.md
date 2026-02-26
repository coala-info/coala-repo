---
name: vbz-h5py-plugin
description: The vbz-h5py-plugin enables h5py to read and write HDF5 files compressed with the VBZ algorithm. Use when user asks to read VBZ-compressed HDF5 files, write VBZ-compressed HDF5 files, or interact with Oxford Nanopore raw data.
homepage: https://github.com/nanoporetech/vbz-h5py-plugin
---


# vbz-h5py-plugin

## Overview

The `vbz-h5py-plugin` is a critical utility for bioinformaticians working with Oxford Nanopore raw data. While older Nanopore files used GZIP, modern datasets utilize the VBZ algorithm because it provides >30% better compression and significantly faster CPU performance (up to 10x for compression and 5x for decompression). This skill provides the necessary steps to register the VBZ filter so that standard `h5py` commands can interact with compressed datasets without "Unknown Filter" errors.

## Installation

The plugin is most reliably installed via the Bioconda channel:

```bash
conda install bioconda::vbz-h5py-plugin
```

## Usage Instructions

### Plugin Registration
To use VBZ compression in a Python script, you must import the plugin module. This registration step must occur before attempting to access a VBZ-compressed dataset via `h5py`.

```python
import h5py
import vbz_h5py_plugin

# After importing, h5py is now aware of the VBZ filter
```

### Reading VBZ Data
Once the plugin is imported, reading data is transparent. You do not need to specify the filter manually when opening a file.

```python
import h5py
import vbz_h5py_plugin

with h5py.File("raw_data.fast5", "r") as f:
    # Accessing a dataset that uses VBZ compression
    data = f["read_1/Raw/Signal"][:]
```

### Writing VBZ Data
When creating new HDF5 files, you can specify the VBZ filter. Note that the filter is typically identified by its HDF5 filter ID or name once registered.

```python
import h5py
import vbz_h5py_plugin
import numpy as np

data = np.random.randint(0, 1000, size=1000, dtype='int16')

with h5py.File("output.fast5", "w") as f:
    # The filter is registered under the name 'vbz'
    f.create_dataset("signal", data=data, compression="vbz")
```

## Best Practices and Tips

- **Environment Consistency**: Ensure that the environment where the Python script runs has the `vbz-h5py-plugin` installed. If the plugin is missing, `h5py` will raise an `OSError` or `RuntimeError` stating that the filter is unavailable.
- **Performance**: Use VBZ instead of GZIP for any Nanopore-related raw signal storage to reduce I/O bottlenecks during basecalling or signal analysis.
- **POD5 Transition**: While this plugin is essential for HDF5 (Fast5) files, note that Oxford Nanopore is transitioning to the POD5 format. For POD5 files, use the `pod5` library instead of `h5py`.

## Reference documentation
- [vbz-h5py-plugin Overview](./references/anaconda_org_channels_bioconda_packages_vbz-h5py-plugin_overview.md)
- [Nanoporetech vbz-h5py-plugin GitHub](./references/github_com_nanoporetech_vbz-h5py-plugin.md)