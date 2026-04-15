---
name: argopy
description: argopy is a Python library designed to retrieve, process, and visualize oceanographic data from Argo floats. Use when user asks to fetch Argo data by region, float WMO, or profile, filter by quality control flags, or visualize float trajectories and topography.
homepage: https://github.com/euroargodev/argopy
metadata:
  docker_image: "quay.io/biocontainers/argopy:0.1.15"
---

# argopy

## Overview

The `argopy` library is a specialized Python tool designed to streamline the retrieval and analysis of Argo float data. It abstracts the complexity of interacting with various data servers (ERDDAP, Argovis, FTP) and provides a unified interface that returns data as `xarray` datasets. This skill enables efficient data discovery, filtering by quality control flags, and high-level visualization of oceanographic trajectories and profiles.

## Core Data Fetching Patterns

The primary entry point is the `DataFetcher`. By default, it uses the ERDDAP data source.

### Fetching by Region
Define a spatial and temporal box: `[min_lon, max_lon, min_lat, max_lat, min_depth, max_depth, min_time, max_time]`.
```python
from argopy import DataFetcher
f = DataFetcher().region([-85, -45, 10., 20., 0, 100.]) # Lon, Lat, Depth
ds = f.to_xarray()
```

### Fetching by Float (WMO)
Retrieve all data for specific float identifiers.
```python
f = DataFetcher().float([6902746, 6902747])
ds = f.load().data
```

### Fetching Specific Profiles
Target a specific cycle from a float.
```python
f = DataFetcher().profile(6902746, 34) # WMO, Cycle number
ds = f.to_xarray()
```

## Expert Usage and Best Practices

### Selecting Data Sources
You can change the backend depending on availability or speed requirements:
- `erddap` (Default, robust)
- `argovis` (Fast for metadata and specific queries)
- `local` (For data already on disk)
```python
f = DataFetcher(src='argovis').float(6902746)
```

### Quality Control (QC) and Data Modes
For scientific analysis, always consider the data mode (Real-time 'R', Delayed-mode 'D', or Adjusted 'A') and QC flags.
- Use `expert` mode for more control over filters.
- Filter by QC flags at fetch time to ensure data reliability.

### Performance Optimization
When dealing with large datasets or repetitive queries:
1. **Caching**: Enable local caching to avoid redundant network requests.
   ```python
   from argopy import set_options
   set_options(cachedir='path/to/cache')
   ```
2. **Parallel Fetching**: Use parallel options when fetching multiple floats or large regions to significantly reduce wait times.

### Visualization
`argopy` includes built-in plotting methods for quick data inspection:
- `f.plot('trajectory')`: Map the path of the floats.
- `f.plot('topography')`: View floats relative to seafloor depth.

## Troubleshooting
- **Version Check**: Ensure you are using Python >= 3.8.
- **Installation**: Prefer `conda-forge` for easier dependency management of spatial libraries like `cartopy`.
  ```bash
  conda install -c conda-forge argopy
  ```

## Reference documentation
- [argopy README](./references/github_com_euroargodev_argopy.md)