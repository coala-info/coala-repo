---
name: netcdf-metadata-info
description: The netcdf-metadata-info tool extracts variable names and dimension information from NetCDF files into a concise tabular format. Use when user asks to inspect NetCDF metadata, extract variable names and dimension sizes, or summarize the structure of scientific datasets.
homepage: https://github.com/Alanamosse/Netcdf-Metadata-Info/
metadata:
  docker_image: "quay.io/biocontainers/netcdf-metadata-info:1.1.6--h7b50bb2_7"
---

# netcdf-metadata-info

## Overview
The `netcdf-metadata-info` tool (often invoked as `nc_info`) is a specialized utility designed to inspect the contents of NetCDF files. It extracts high-level metadata—specifically variable names, the number of dimensions per variable, and the sizes of those dimensions—and outputs them in a concise tabular format. This is particularly useful for quickly understanding the "shape" of scientific datasets without the overhead of loading the entire file into a heavy analysis environment.

## Installation
The tool is available via Bioconda. To install it in your environment, use:

```bash
conda install -c bioconda netcdf-metadata-info
```

## Command Line Usage

### Basic Metadata Extraction
To generate a metadata summary of a NetCDF file, provide the path to the `.nc` file as the primary argument:

```bash
nc_info input_file.nc
```

### Accessing Help
To view version information and basic usage flags:

```bash
nc_info -help
```

## Output Structure
The tool produces a tabular output (typically redirected to a `.tabular` or `.tsv` file) with the following space-separated structure for every variable found in the file:

`[Variable-Name] [Number-Of-Dimensions] [Dim1-Name] [Dim1-Size] ... [DimN-Name] [DimN-Size]`

**Example Output Interpretation:**
If a variable named `temperature` has 3 dimensions (time: 10, lat: 180, lon: 360), the output line will look like:
`temperature 3 time 10 lat 180 lon 360`

## Expert Tips and Best Practices

- **Pre-processing Validation**: Use this tool as a lightweight "gatekeeper" in automated pipelines. By checking the dimension sizes (e.g., ensuring a time dimension matches expected bounds) before launching heavy compute tasks, you can fail fast and save resources.
- **Library Dependencies**: The binary requires the NetCDF C library (>= 4.5.0). If running in a custom environment outside of Conda, ensure `libnetcdf` is present in your library path.
- **Tabular Integration**: Since the output is standard tabular text, it is highly compatible with Unix text-processing tools like `awk`, `grep`, and `cut` for further filtering. For example, to list only variables with more than 2 dimensions:
  ```bash
  nc_info data.nc | awk '$2 > 2 {print $1}'
  ```
- **Galaxy Compatibility**: This tool was originally designed for the Galaxy Project. If you are developing tools for Galaxy, the output format is natively compatible with Galaxy's `tabular` datatype.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_netcdf-metadata-info_overview.md)
- [Netcdf-Metadata-Info GitHub README](./references/github_com_Alanamosse_Netcdf-Metadata-Info.md)