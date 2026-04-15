---
name: slicedimage
description: This tool provides efficient access to large, multi-dimensional imaging datasets stored in a tiled format. Use when user asks to load image sets, access specific slices or subsets of data, or work with tiled imaging data.
homepage: https://github.com/spacetx/slicedimage
metadata:
  docker_image: "quay.io/biocontainers/slicedimage:3.1.2--py_0"
---

# slicedimage

A Python module for accessing and manipulating sliced imaging data.
  Use this skill when you need to work with large, multi-dimensional image datasets that are stored in a tiled format, allowing for efficient retrieval of specific slices without downloading the entire dataset. This is particularly useful for scientific research and analysis where data size is a significant concern.
body: |
  ## Overview
  The `slicedimage` Python module is designed to efficiently handle large, multi-dimensional imaging datasets by storing them in a tiled format. This allows users to access specific slices or subsets of the data without needing to download the entire dataset, making it ideal for cloud-based storage and interactive local analysis. It provides a Python API to retrieve data in NumPy format by accessing a manifest that describes how the image set is tiled.

  ## Usage Instructions

  The `slicedimage` library is primarily used programmatically within Python. The core functionality revolves around loading an image set via its manifest and then querying for specific slices.

  ### Loading an Image Set

  To begin, you'll need to point the `slicedimage` API to the manifest file of your image set.

  ```python
  import slicedimage

  # Assuming your manifest file is named 'manifest.json'
  image_set = slicedimage.open('manifest.json')
  ```

  ### Accessing Slices

  Once an `image_set` object is created, you can access slices by specifying ranges across its dimensions. The dimensions are defined in the manifest.

  ```python
  # Example: Accessing a slice from a 3D image set (e.g., x, y, z dimensions)
  # Assuming dimensions are 'x', 'y', 'z' and you want a specific z-slice
  # The exact syntax for slicing will depend on the dimensions defined in the manifest.
  # For a typical 3D image, you might slice like this:

  # Get a specific slice along the 'z' dimension
  z_slice_data = image_set.get_slice(z=5) # Retrieves data for z=5

  # Get a range of slices along the 'y' dimension
  y_range_data = image_set.get_slice(y=(10, 20)) # Retrieves data for y from 10 up to (but not including) 20

  # You can combine slices across multiple dimensions
  multi_dim_slice = image_set.get_slice(x=100, y=(50, 75), z=10)

  # The returned data is typically a NumPy array.
  print(type(z_slice_data))
  ```

  ### Understanding the Manifest Structure

  The `slicedimage` library relies on a structured manifest file to understand how the image data is organized. This manifest is a hierarchical tree of JSON documents.

  *   **Collections**: These are non-leaf documents that map names to relative paths or URLs of other collections or tile sets.
  *   **Tile Sets**: These are leaf documents that describe a list of tiles. They contain:
      *   `version`: Semantic versioning of the file format.
      *   `dimensions`: Names of the dimensions (must include 'x' and 'y').
      *   `tiles`: A dictionary describing the location and properties of each tile.
      *   `shape`: Maps non-geometric dimensions to possible values.

  Each item in the `tiles` section describes a file, including its `file` path, `coordinates` (geometric space ranges), and `indices` (non-geometric space values).

  ## Expert Tips

  *   **Parallel Fetching**: The `slicedimage` API is designed to fetch tiles in parallel, significantly speeding up data retrieval for large datasets. Ensure your environment supports parallel operations.
  *   **Manifest Location**: The `slicedimage.open()` function expects a path to the manifest file. This manifest can point to tiles stored locally or remotely (e.g., S3).
  *   **Dimension Names**: Pay close attention to the dimension names defined in your manifest (`dimensions` field in the Tile Set). These are crucial for correctly querying slices. Common dimensions include 'x', 'y', 'z', and potentially others for time, channels, etc.
  *   **Error Handling**: Be prepared to handle potential errors related to file access, network issues (if accessing remote tiles), or malformed manifests.

  ## Reference documentation
  - [GitHub - spacetx/slicedimage](https://github.com/spacetx/slicedimage)
  - [Anaconda.org - slicedimage](https://anaconda.org/bioconda/slicedimage)