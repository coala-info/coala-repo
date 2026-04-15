---
name: paidiverpy
description: paidiverpy automates the transformation of raw biodiversity imagery into standardized, analysis-ready datasets. Use when user asks to process batches of biological images, run image processing pipelines, synchronize metadata with imagery, or convert raw image formats for biodiversity analysis.
homepage: https://github.com/paidiver/paidiverpy
metadata:
  docker_image: "quay.io/biocontainers/paidiverpy:0.2.1--pyhdfd78af_0"
---

# paidiverpy

## Overview
`paidiverpy` is a specialized Python framework that automates the transformation of raw biodiversity imagery into standardized, analysis-ready datasets. It bridges the gap between field data collection and automated image analysis by providing a structured pipeline for image cleaning, format conversion, and metadata synchronization. Use this skill when you need to process large batches of biological images (such as plankton or benthic surveys) while maintaining strict metadata integrity.

## Installation
The package can be installed via standard Python package managers:
- **Pip**: `pip install paidiverpy`
- **Conda**: `conda install bioconda::paidiverpy`

## Command Line Interface (CLI)
The CLI is the most direct way to execute pre-configured pipelines.
- **Execute Pipeline**: `paidiverpy -c "path/to/config.yml"`
- **Docker Execution**: When using the Docker container, you must map local directories to the container's expected paths:
  ```bash
  docker run --rm \
    -v <INPUT_PATH>:/app/input/ \
    -v <OUTPUT_PATH>:/app/output/ \
    -v <METADATA_PATH>:/app/metadata/ \
    -v <CONFIG_DIR>:/app/config_files/ \
    paidiverpy -c /app/config_files/<CONFIG_FILE>
  ```

## Python API Integration
For programmatic control or integration into Jupyter notebooks, use the `Pipeline` and `PaidiverpyData` classes.

### Running a Pipeline
```python
from paidiverpy.pipeline import Pipeline

# Initialize with a configuration file
pipeline = Pipeline(config_file_path="config.yml")

# Execute all steps
pipeline.run()

# Export processed images
pipeline.save_images(image_format="png")
```

### Accessing Sample Datasets
Use the built-in data utility to fetch standardized biodiversity datasets for testing:
```python
from paidiverpy.utils.data import PaidiverpyData

# Available datasets: 'plankton_csv', 'benthic_csv', 'benthic_ifdo', 'nef_raw'
PaidiverpyData().load("plankton_csv")
```

## Expert Tips and Best Practices
- **Metadata First**: Ensure your metadata files (CSV or IFDO) are correctly formatted before running the pipeline, as `paidiverpy` relies on these to map processing steps to specific images.
- **Raw Image Processing**: Use the library's specialized loaders for `.nef` (Nikon Raw) files to preserve maximum bit depth during initial preprocessing steps.
- **Parallelization**: For high-volume datasets, leverage the Dask integration to run pipelines across multiple cores or a `LocalCluster`.
- **Incremental Testing**: Use the "test mode" available in the pipeline steps to verify image transformations on a small subset before processing the entire dataset.
- **Output Formats**: While the pipeline processes data internally, always specify your desired output format (e.g., PNG, TIFF) in the `save_images` method to ensure compatibility with downstream AI models.

## Reference documentation
- [paidiverpy GitHub Repository](./references/github_com_paidiver_paidiverpy.md)
- [paidiverpy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_paidiverpy_overview.md)