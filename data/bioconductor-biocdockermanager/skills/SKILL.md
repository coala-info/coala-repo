---
name: bioconductor-biocdockermanager
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.11/bioc/html/BiocDockerManager.html
---

# bioconductor-biocdockermanager

name: bioconductor-biocdockermanager
description: Manage Bioconductor-provided Docker images from within R. Use this skill to find available Bioconductor images, install (pull) them, check local installations, verify image validity against Dockerhub, and generate Dockerfile templates for Bioconductor contributions.

# bioconductor-biocdockermanager

## Overview

The `BiocDockerManager` package provides an R interface to manage Docker images provided by the Bioconductor project, functioning similarly to how `BiocManager` manages R packages. It allows users to interact with the Docker engine and Dockerhub REST API to ensure their analysis environments are up-to-date and valid.

## Prerequisites

- The Docker engine must be installed and running on the system.
- On Linux, ensure the user has permissions to run Docker without `sudo`.
- For some functions, being signed into Docker Desktop may be required.

## Core Functions

### Finding Images
Use `available()` to browse Bioconductor images on Dockerhub.
```r
library(BiocDockerManager)

# List all available Bioconductor images
res <- available()

# Search for a specific image pattern
res_spec <- available(pattern = "bioconductor_docker")

# List deprecated images
deprecated_imgs <- available(deprecated = TRUE)
```

### Managing Local Images
Install (pull) or list images currently on your machine.
```r
# Pull the latest bioconductor_docker image
install(repository = "bioconductor/bioconductor_docker", tag = "latest")

# List all installed images on the local machine
installed()

# Filter local images by repository
installed(repository = "bioconductor/bioconductor_docker")
```

### Image Metadata and Validity
Query specific `LABEL` fields (maintainer, version) and check if local images match the remote versions.
```r
# Get the maintainer of an image
maintainer(tag = "latest")

# Get the Bioconductor/Dockerfile version (x.y.z format)
version(tag = "devel")

# Check if the local image digest matches Dockerhub
# Returns a tibble of images that need updates
valid(repository = "bioconductor/bioconductor_docker", tag = "latest")
```

### Developer Tools
Generate a template for contributing new Docker images to the Bioconductor ecosystem.
```r
# Creates a directory with a standardized Dockerfile and README.md
use_dockerfile()
```

## Typical Workflow

1.  **Discover**: Check `available()` to find the correct image and tag (e.g., `devel`, `latest`, or a specific release like `RELEASE_3_11`).
2.  **Install**: Use `install()` to pull the image.
3.  **Verify**: Periodically run `valid()` to see if the local image is out of date.
4.  **Update**: If `valid()` returns a mismatch, run `install()` again to pull the updated layers.
5.  **Inspect**: Use `version()` to confirm the specific Bioconductor environment version you are running.

## Reference documentation

- [BiocDockerManager Vignette (Rmd)](./references/BiocDockerManager.Rmd)
- [BiocDockerManager Vignette (md)](./references/BiocDockerManager.md)