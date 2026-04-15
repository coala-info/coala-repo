---
name: wtv
description: The wtv tool performs ion selection and filtering on mass spectrometry datasets. Use when user asks to select ions, filter mass spectrometry data, extract representative ions, adjust ion selection parameters, read MSP files, or write MSP files.
homepage: https://recetox.github.io/wtv/
metadata:
  docker_image: "quay.io/biocontainers/wtv:0.1.0--pyhdfd78af_0"
---

# wtv

## Overview
The `wtv` tool provides a specialized workflow for ion selection within mass spectrometry datasets. It operates primarily on MSP files, allowing users to extract high-quality, representative ions by applying filters for mass-to-charge (m/z) ratios, retention time (RT) windows, and spectral similarity. Whether used as a standalone command-line utility or integrated into a Python pipeline, it streamlines the reduction of complex spectral data into manageable, high-confidence ion sets.

## CLI Usage Patterns
The primary interface for the tool is `wtv-cli`.

### Basic Execution
To run a standard ion selection with default parameters:
```bash
wtv-cli --msp_path input.msp --outpath ./results
```

### Targeted Filtering
For specific experimental setups, adjust the m/z range and intensity requirements:
```bash
wtv-cli --msp_path input.msp \
        --outpath ./filtered_results \
        --mz_min 50 \
        --mz_max 600 \
        --min_ion_intensity_percent 10 \
        --min_ion_num 3
```

### Parameter Reference
- `--rt_window`: Sets the retention time window (default: 2.00).
- `--similarity_threshold`: Controls how strictly ions are grouped (default: 0.85).
- `--fr_factor`: Adjusts the FR factor for selection logic (default: 2.0).
- `--retention_time_max`: Caps the retention time considered (default: 68.80).

## Library Integration
For programmatic workflows, use the `ion_selection` module.

### Core Selection Logic
```python
from wtv.ion_selection import main

main(
    msp_file_path="data.msp",
    output_directory="output_dir",
    mz_min=35,
    mz_max=400,
    rt_window=2.0,
    similarity_threshold=0.85
)
```

### Utility Functions
Use `wtv.utils` for manual handling of MSP data:
- `read_msp(path)`: Returns a tuple of metadata (Dict) and retention time data (DataFrame).
- `write_msp(df, output_dir, source_path)`: Saves filtered ion DataFrames back to the MSP format.

## Expert Tips
- **Intensity Thresholding**: If your data is noisy, increase `--min_ion_intensity_percent` (default 7) to ensure only robust peaks are selected.
- **m/z Thresholding**: Use `--prefer_mz_threshold` (default 60) to prioritize ions above a certain mass, which is often useful for avoiding low-mass background noise.
- **Environment Setup**: The tool is available via Bioconda. Use `conda install bioconda::wtv` for the most stable dependency management.

## Reference documentation
- [CLI Usage](./references/recetox_github_io_wtv_cli_usage.md)
- [Ion Selection API](./references/recetox_github_io_wtv_api_ion_selection.md)
- [Library Usage](./references/recetox_github_io_wtv_library_usage.md)
- [Utils API](./references/recetox_github_io_wtv_api_utils.md)