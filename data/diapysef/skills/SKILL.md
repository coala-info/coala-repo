---
name: diapysef
description: diapysef processes and converts multi-dimensional Trapped Ion Mobility Spectrometry and Parallel Accumulation-Serial Fragmentation data from Bruker instruments. Use when user asks to convert raw .d files to mzML, extract specific frames for plotting, generate peptide coordinates for targeted extraction, or export data to sqMass and parquet formats.
homepage: https://github.com/Roestlab/dia-pasef
---

# diapysef

## Overview
diapysef is a specialized Python-based toolkit designed for the processing of Trapped Ion Mobility Spectrometry (TIMS) and Parallel Accumulation-Serial Fragmentation (PASEF) data. It provides essential utilities for bridging the gap between raw Bruker instrument data and downstream open-source analysis pipelines by handling the complex multi-dimensional nature (m/z, retention time, and ion mobility) of DIA-PASEF acquisitions.

## Core Workflows

### Data Conversion
The primary use case for diapysef is converting raw Bruker `.d` folders into the more accessible `mzML` format.

*   **Single File Conversion**: To convert a single `.d` directory into one `mzML` file where each frame is encoded as a separate spectrum:
    ```bash
    python3 src/convert_single.py --input input_data.d --output output.mzML
    ```
*   **Multiple File Conversion**: To split a `.d` file into multiple `mzML` files (one per frame), which can be useful for parallel processing or specific frame-level inspections:
    ```bash
    python3 src/convert_multipleMzML.py --input input_data.d --output_dir ./output_frames/
    ```

### Targeted Extraction and Plotting
diapysef allows for the isolation of specific data slices for quality control or manual inspection.

*   **Frame Extraction**: Extract a specific frame from a TIMS-TOF run for plotting:
    ```bash
    python3 src/extract_frame_for_plotting.py --input input_data.d --frame_id 123 --output frame_123.csv
    ```
*   **Swath Analysis**: Generate histograms to visualize data distribution across different DIA swaths:
    ```bash
    python3 src/histogram_swath.py --input data.mzML --swath_id 1
    ```

### Advanced Export Options
The tool supports exporting data to specialized formats for downstream software:
*   **sqMass Export**: Use the `sqMass` exporter when preparing data for OpenSWAT or similar peptide-centric analysis tools.
*   **OSW Integration**: diapysef can incorporate additional information from OpenSWATH (`.osw`) files during processing to refine target generation.

## Best Practices
*   **SDK Requirement**: Ensure the Bruker SDK is installed. You can use the built-in command to download and install it: `python3 src/diapysef/main.py install_bruker_sdk`.
*   **Memory Management**: TIMS-TOF data is high-dimensional and large. When converting, ensure sufficient disk space and consider using `convert_multipleMzML.py` if your downstream tools struggle with very large single `mzML` files.
*   **Ion Mobility**: Remember that diapysef preserves the 1/K0 (ion mobility) values, which are critical for the increased selectivity of DIA-PASEF data.



## Subcommands

| Command | Description |
|---------|-------------|
| diapysef converttdftomzml | Conversion program to convert a Bruker TIMS .d data file to mzML format |
| diapysef export | Export a reduced targeted mzML file to a tsv, parquet or sqMass file |
| diapysef prepare-coordinates | Generate peptide coordinates for targeted extraction of DIA-PASEF data |
| diapysef report | Generate a report for a specfific type of plot |
| diapysef targeted-extraction | Extract from the raw data given a set of target coordinates to extract for. |

## Reference documentation
- [TIMS-TOF Analysis Scripts](./references/github_com_Roestlab_dia-pasef_blob_master_README.md)
- [Singularity Environment Setup](./references/github_com_Roestlab_dia-pasef_blob_master_singularity.def.md)