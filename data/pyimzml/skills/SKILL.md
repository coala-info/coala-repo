---
name: pyimzml
description: pyimzml is a Python-based parser for reading and extracting data from imaging mass spectrometry files in the imzML format. Use when user asks to parse imzML files, extract m/z and intensity spectra, access spatial coordinates, or generate ion images from mass spectrometry data.
homepage: https://github.com/alexandrovteam/pyimzML
---


# pyimzml

## Overview

`pyimzml` is a specialized Python-based parser for the imzML format, which is the community standard for imaging mass spectrometry data. This tool transforms complex binary IMS data into accessible Python structures (lists and dictionaries). Use this skill to programmatically interact with mass spectrometry images, extract ion images (heatmaps), and perform statistical analysis on spectral data.

## Installation

Install the package via pip or conda:

```bash
pip install pyimzml
# OR
conda install -c bioconda pyimzml
```

## Core Usage Patterns

### Initializing the Parser
The primary interface is the `ImzMLParser` class. It requires the path to the `.imzML` file (the corresponding `.ibd` file must be in the same directory).

```python
from pyimzml.ImzMLParser import ImzMLParser

# Load the dataset
p = ImzMLParser('data.imzML')
```

### Accessing Spectral Data
Spectra are accessed by index. The parser returns two arrays: m/z values and their corresponding intensities.

```python
# Get the spectrum for the first pixel
mzs, intensities = p.get_spectrum(0)

# Access spatial coordinates (x, y, z) for a specific spectrum
x, y, z = p.coordinates[0]
```

### Metadata and Properties
The parser exposes several attributes to understand the dataset's characteristics:

- `p.coordinates`: A list of (x, y, z) tuples for all spectra.
- `p.polarity`: Returns the ion polarity (e.g., "positive", "negative").
- `p.spectrum_mode`: Indicates if the data is in "profile" or "centroid" mode.

### Generating Ion Images
To visualize the spatial distribution of a specific mass, use the `getionimage` functionality (often implemented via helper scripts or manual iteration in basic versions).

```python
from pyimzml.ImzMLParser import getionimage

# Generate an image for a specific m/z with a tolerance
# Note: This requires the coordinates to be mapped to a grid
ion_img = getionimage(p, mz_value=885.5, tol=0.1)
```

## Best Practices and Expert Tips

- **Performance with getionimage**: When extracting multiple ion images, performance can degrade. It is more efficient to iterate through the spectra once and bin the intensities if you need hundreds of different m/z images.
- **Dependency Management**: `pyimzml` will use `lxml` if available for faster XML parsing. If `lxml` is missing, it falls back to the built-in `ElementTree`, which may be slower for very large metadata headers.
- **Coordinate Systems**: Always verify the coordinate range in `p.coordinates`. Some instruments use 1-based indexing, while others might have offsets.
- **Memory Mapping**: The parser uses memory mapping to handle large `.ibd` files without loading the entire dataset into RAM. Avoid moving or renaming the `.ibd` file while the parser object is active.
- **Handling Missing Data**: Be aware that `get_spectrum` might behave unexpectedly if the index is out of range or if the `.ibd` file is truncated. Always validate the length of `p.coordinates` before looping.

## Reference documentation
- [pyimzML GitHub Repository](./references/github_com_alexandrovteam_pyimzML.md)
- [pyimzml Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyimzml_overview.md)