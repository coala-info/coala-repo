---
name: diapysef
description: diapysef is a Python toolset for analyzing, converting, and visualizing diaPASEF mass spectrometry data from Bruker TIMS-TOF instruments. Use when user asks to convert proprietary Bruker data to mzML or sqMass formats, extract specific ion mobility frames, or generate quality control histograms for diaPASEF swaths.
homepage: https://github.com/Roestlab/dia-pasef
---


# diapysef

## Overview

The `diapysef` toolset is a specialized Python library and collection of scripts designed for the analysis, conversion, and visualization of diaPASEF (Data-Independent Acquisition Parallel Accumulation Serial Fragmentation) data produced by Bruker TIMS-TOF mass spectrometers. It serves as a bridge between proprietary raw data formats and open-source analysis pipelines, allowing researchers to extract specific frames, generate quality control histograms, and convert high-dimensional ion mobility data into accessible mzML or sqMass formats.

## Installation and Setup

Install the package via Bioconda:

```bash
conda install bioconda::diapysef
```

Note: Accessing raw Bruker `.d` data typically requires the Bruker SDK. Ensure the SDK is correctly installed and accessible in your environment path.

## Core CLI Workflows

### Data Conversion
The primary use case for `diapysef` is converting proprietary Bruker `.d` directories into open mzML formats.

*   **Single mzML Conversion**: Convert a single `.d` folder into one mzML file where each frame is encoded as a separate spectrum.
    ```bash
    python src/convert_single.py -i input_data.d -o output.mzML
    ```
*   **Multiple mzML Conversion**: Split a single `.d` file into multiple mzML files, which can be useful for parallelizing downstream processing.
    ```bash
    python src/convert_multipleMzML.py -i input_data.d -o output_directory/
    ```

### Visualization and Extraction
To inspect specific ion mobility frames or prepare data for publication-quality plots:

*   **Frame Extraction**: Extract a specific frame from the TIMS data for 2D plotting (m/z vs. ion mobility).
    ```bash
    python src/extract_frame_for_plotting.py -i input_data.d -f <frame_index> -o frame_data.csv
    ```

### Swath Analysis and QC
`diapysef` provides utilities to visualize the distribution of precursors and fragments across different diaPASEF swaths.

*   **Swath Histograms**: Generate histograms to inspect the data density within specific isolation windows.
    ```bash
    python src/histogram_swath.py --input <data_file> --output swath_plot.pdf
    ```
*   **Overlaying Swaths**: Compare multiple swaths to ensure proper coverage and overlap.
    ```bash
    python src/histogram_swath_overlay.py --input <data_file> --output overlay_plot.pdf
    ```

## Expert Tips and Best Practices

*   **Ion Mobility Awareness**: When converting to mzML, `diapysef` preserves the ion mobility dimension by encoding frames. Ensure your downstream search engine (e.g., OpenSwath, MaxQuant) is configured to read these frame-based spectra.
*   **sqMass Export**: For users of the OpenMS/OpenSwath ecosystem, `diapysef` supports exporting to `sqMass`, which is a more efficient format for targeted extraction of ion chromatograms.
*   **Memory Management**: TIMS-TOF data is exceptionally large. When using `convert_multipleMzML.py`, ensure you have sufficient disk space as the resulting mzML files can be significantly larger than the compressed raw data.
*   **Annotation**: Use the plotting classes within the library to add text annotations for intensities and labelled feature contours when generating 2D data visualizations.

## Reference documentation
- [diapysef Overview](./references/anaconda_org_channels_bioconda_packages_diapysef_overview.md)
- [dia-pasef GitHub Repository](./references/github_com_Roestlab_dia-pasef.md)
- [Recent Commits and Features](./references/github_com_Roestlab_dia-pasef_commits_master.md)