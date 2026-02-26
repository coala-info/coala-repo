---
name: cdo
description: CDO provides tools for manipulating and analyzing climate and NWP model data. Use when user asks to merge, resample, calculate statistics, extract subsets, perform arithmetic operations, or convert climate data formats.
homepage: https://github.com/cxong/cdogs-sdl
---


# cdo

cdo/SKILL.md
```yaml
name: cdo
description: |
  Tools for manipulating and analyzing climate and NWP model data.
  Use when Claude needs to perform operations on NetCDF, GRIB, or other climate data formats, such as:
  - Merging or concatenating datasets
  - Resampling or regridding data
  - Calculating statistical summaries (e.g., mean, variance)
  - Extracting time series or spatial subsets
  - Performing arithmetic operations on data fields
  - Converting between different data formats
```
## Overview
The Climate Data Operators (CDO) is a command-line toolset designed for efficient manipulation and analysis of climate and numerical weather prediction (NWP) model data. It supports a wide range of operations on various meteorological data formats, primarily NetCDF and GRIB. Use CDO when you need to process, transform, or analyze large climate datasets through command-line operations.

## Usage Instructions

CDO operates by chaining commands together, often using pipes (`|`) to pass data between operations. The general syntax is `cdo <operator1> [operator1_options] <inputfile1> <outputfile1> [operator2] [operator2_options] <inputfile2> <outputfile2> ...`.

### Core Concepts and Common Operations

*   **Operators**: CDO uses specific operators for different tasks. For example, `addc` for adding a constant, `mul` for multiplication, `merge` for merging files, `remap` for regridding, and `fldmean` for field mean.
*   **File Handling**: CDO can read from and write to various formats, including NetCDF (`.nc`), GRIB (`.grb`, `.grib`), and others.
*   **Piping**: For sequential operations, you can pipe the output of one CDO command to the input of another.

### Common CLI Patterns and Expert Tips

1.  **Merging Datasets**:
    To merge multiple files with the same variables but different time steps:
    ```bash
    cdo merge file1.nc file2.nc file3.nc merged_file.nc
    ```
    For a large number of files, use `cat` and pipe to `merge`:
    ```bash
    cat file_*.nc | cdo merge merged_file.nc
    ```

2.  **Resampling/Regridding Data**:
    To regrid a dataset to a different grid:
    ```bash
    cdo remap,target_grid.txt input.nc output.nc
    ```
    `target_grid.txt` can be a CDO grid description file or a NetCDF file defining the target grid.

3.  **Calculating Statistical Summaries**:
    *   **Field Mean**: Calculate the spatial mean of a field:
        ```bash
        cdo fldmean input.nc output_mean.nc
        ```
    *   **Time Mean**: Calculate the temporal mean over all time steps:
        ```bash
        cdo timmean input.nc output_timmean.nc
        ```
    *   **Zonal Mean**: Calculate the mean along the latitude axis:
        ```bash
        cdo zmean input.nc output_zmean.nc
        ```

4.  **Arithmetic Operations**:
    *   **Add a constant**:
        ```bash
        cdo addc,10 input.nc output.nc
        ```
    *   **Multiply by a constant**:
        ```bash
        cdo mulc,0.5 input.nc output.nc
        ```
    *   **Add two datasets**:
        ```bash
        cdo add file1.nc file2.nc output.nc
        ```

5.  **Extracting Data**:
    *   **Time Series**: Extract a time series for a specific location (requires defining the location, e.g., using `setpoint` or `setgrid` with a point grid):
        ```bash
        cdo setpoint,lon=10,lat=20 input.nc output_ts.nc
        cdo output_ts.nc # This will output the time series data
        ```
    *   **Spatial Subset**: Extract data for a specific region (e.g., bounding box):
        ```bash
        cdo sellonlatbox,lon1,lon2,lat1,lat2 input.nc output_subset.nc
        ```

6.  **Format Conversion**:
    To convert NetCDF to GRIB:
    ```bash
    cdo -f grb copy input.nc output.grb
    ```
    To convert GRIB to NetCDF:
    ```bash
    cdo copy input.grb output.nc
    ```

7.  **Chaining Operations**:
    Combine multiple operations:
    ```bash
    cdo -f nc4 -z zip merge file1.nc file2.nc | fldmean | setmissval,nan > mean_field.nc
    ```
    This example merges two files, calculates the field mean, sets missing values to NaN, and saves to a compressed NetCDF4 file.

### Important Considerations

*   **Operator Documentation**: For a complete list of operators and their options, consult the official CDO documentation. Use `man cdo` or visit the CDO website.
*   **Performance**: For very large datasets, consider using CDO's options for parallel processing (`-P <nthreads>`) and efficient file formats (e.g., NetCDF4 with compression).
*   **Error Handling**: CDO often provides informative error messages. If a command fails, carefully read the output for clues.

## Reference documentation
- [CDO User Guide](https://code.mpimet.mpg.de/projects/cdo/wiki/UserGuide) (This is a conceptual link, as direct file access isn't possible. Claude should be aware of the official documentation for detailed operator information.)