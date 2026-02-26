---
name: pcdl
description: The pcdl tool loads PhysiCell simulation data into Python-native structures like Pandas DataFrames and AnnData objects for analysis and visualization. Use when user asks to load agent-based modeling data, list cell attributes, extract spatial data, render images with Neuroglancer, or generate time-series plots.
homepage: https://github.com/elmbeech/physicelldataloader
---


# pcdl

## Overview
The `pcdl` (PhysiCell Data Loader) tool is a specialized interface designed to bridge the gap between PhysiCell's raw simulation output and standard data analysis environments. It allows researchers to load complex agent-based modeling data into Python-native structures like Pandas DataFrames and AnnData objects, facilitating downstream analysis with tools like Scanpy, Matplotlib, or ParaView. It is particularly useful for handling large time-series datasets and converting them into formats compatible with the scverse ecosystem.

## Core CLI Commands
The package provides several command-line utilities for quick data inspection and transformation without writing Python scripts.

- **List Cell Attributes**: Identify what data is tracked for each cell in a simulation.
  `pcdl_get_cell_attribute_list -path /path/to/output`
- **Extract Spatial Data**: Generate spatial data structures from simulation snapshots.
  `pcdl_get_spatialdata -path /path/to/output`
- **Visualize with Neuroglancer**: Render OME-TIFF images for interactive viewing.
  `pcdl_render_neuroglancer -path /path/to/images`
- **Generate Time-Series Plots**: Create plots of substrate concentrations or cell counts over time.
  `pcdl_plot_timeseries -path /path/to/output`

## Python API Best Practices
For more complex workflows, use the `TimeStep` and `TimeSeries` classes to interact with the data programmatically.

### Loading Data
- **Single Snapshot**: Use `pcdl.TimeStep("output00000001.xml")` to analyze a specific point in time.
- **Full Series**: Use `pcdl.TimeSeries("/path/to/output_folder")` to handle the entire simulation progression.

### Filtering and Analysis
- **Categorical Filtering**: In version 4.0.5+, use `cat_keep` and `cat_drop` in `plot_scatter` and `plot_timeseries` to isolate specific cell types or behaviors.
- **Substrate Analysis**: By default, calling `plot_timeseries(frame='conc')` will plot all substrate concentrations across the time series.
- **Attribute Discovery**: Use the `get_cell_attribute_list()` method on a `TimeStep` object to see available labels before attempting to plot or filter by them.

## Expert Tips
- **Performance Optimization**: In recent PhysiCell versions, set `settingxml=False` when initializing loaders. This skips parsing the configuration XML as the cell-type mapping is often available in the output XMLs themselves, significantly speeding up load times.
- **Flexible Plotting Outputs**: The `ext` parameter in plotting functions is highly versatile. It can return a Matplotlib figure object (`ext='fig'`), a Pandas DataFrame (`ext='df'`), or save directly to a file (`ext='png'` or `ext='csv'`).
- **SpatialData Integration**: Use `get_spatialdata()` to export simulation states into the `spatialdata` format, which is the standard for interoperability within the scverse ecosystem (e.g., for use with Napari).
- **Legacy Support**: If working with older PhysiCell-Tools scripts, `pcdl` v4 maintains a more Pythonic backend but provides similar functionality to the original `pyMCDS` and `pyMCDSts` modules.

## Reference documentation
- [pcdl Overview](./references/anaconda_org_channels_bioconda_packages_pcdl_overview.md)
- [PhysiCell Data Loader GitHub](./references/github_com_elmbeech_physicelldataloader.md)