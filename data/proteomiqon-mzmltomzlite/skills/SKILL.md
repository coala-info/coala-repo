---
name: proteomiqon-mzmltomzlite
description: This tool converts mzML files into the SQLite-based mzLite format to enable faster data access and initial preprocessing for proteomics workflows. Use when user asks to convert mzML to mzLite, perform peak picking on mass spectra, or filter proteomics data by retention time.
homepage: https://csbiology.github.io/ProteomIQon/
---


# proteomiqon-mzmltomzlite

## Overview

The `proteomiqon-mzmltomzlite` tool serves as the primary data ingestion point for the ProteomIQon suite. While mzML is a standard open format, its XML structure can be slow for performance-critical proteomics tasks. This tool converts those files into mzLite—an open, SQLite-based implementation—which allows for significantly faster random access to mass spectra. Beyond simple conversion, it allows users to perform initial preprocessing, such as filtering the data by retention time or converting profile data to centroid data via peak picking.

## CLI Usage

The tool is executed via the `proteomiqon` umbrella command.

### Basic Conversion
To convert a single mzML file using a parameter file:
```bash
proteomiqon -mzmltomzlite -i "path/to/your/run.mzML" -o "path/to/your/outDirectory" -p "path/to/your/params.json"
```

### Batch Processing with Parallelization
If you have multiple files and a multi-core CPU, use the `-c` flag to specify the number of parallel threads:
```bash
proteomiqon -mzmltomzlite -i "run1.mzML" "run2.mzML" "run3.mzML" -o "outputDir" -p "params.json" -c 3
```

## Parameter Configuration

The tool requires a JSON parameter file to define the conversion logic.

### Parameter Fields
- **Compress**: Defines the binary data compression (e.g., `0` for NoCompression, `1` for ZLib).
- **StartRetentionTime / EndRetentionTime**: Use `null` (None) to include all data, or provide a float value to crop the run.
- **MS1PeakPicking / MS2PeakPicking**: 
    - `{"Case":"ProfilePeaks"}`: Keeps the data as is.
    - `{"Case":"Centroid"}`: Performs peak picking to reduce file size and complexity.

### Example Parameter Structure (JSON)
```json
{
  "Compress": 0,
  "StartRetentionTime": null,
  "EndRetentionTime": null,
  "MS1PeakPicking": {
    "Case": "ProfilePeaks"
  },
  "MS2PeakPicking": {
    "Case": "ProfilePeaks"
  }
}
```

## Expert Tips and Best Practices

1. **Upstream Conversion**: Always use `msconvert` (from ProteoWizard) to generate the initial mzML files from vendor-specific raw formats before using this tool.
2. **Performance Gains**: Converting to mzLite is highly recommended before running downstream ProteomIQon tools like `PeptideSpectrumMatching` or `PSMBasedQuantification`, as the SQLite backend reduces I/O overhead.
3. **Peak Picking**: If your downstream tools require centroided data, perform the peak picking during this conversion step to save time and storage space.
4. **Memory Management**: When using high parallelization (`-c` flag), ensure your system has sufficient RAM, as multiple conversion processes can be memory-intensive depending on the size of the mzML files.
5. **Help Command**: For a full list of CLI arguments, run:
   ```bash
   proteomiqon -mzmltomzlite --help
   ```

## Reference documentation
- [MzMLToMzLite Tool Documentation](./references/csbiology_github_io_ProteomIQon_tools_MzMLToMzLite.html.md)
- [ProteomIQon Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_proteomiqon-mzmltomzlite_overview.md)