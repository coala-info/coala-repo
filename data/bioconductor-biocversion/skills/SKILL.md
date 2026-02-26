---
name: bioconductor-biocversion
description: This package defines and identifies the specific Bioconductor repository version currently active in an R session. Use when user asks to check the Bioconductor version, determine which repository is being used for package installations, or verify version mapping for BiocManager.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocVersion.html
---


# bioconductor-biocversion

name: bioconductor-biocversion
description: Manage and identify the Bioconductor repository version. Use this skill when you need to determine which version of Bioconductor is currently active in an R session or to ensure the correct repository synchronization for package installations.

# bioconductor-biocversion

## Overview

The `BiocVersion` package is a core infrastructure component of the Bioconductor project. Its primary purpose is to define the specific version of Bioconductor (e.g., 3.20, 3.21, 3.22) that is currently in use. The package version itself (specifically the major and minor components) acts as a marker that the `BiocManager` installation tool uses to point to the correct set of software repositories.

## Usage

### Identifying the Bioconductor Version

The most common use case is checking which Bioconductor version is associated with the current R installation.

```r
# Check the version of the BiocVersion package
# The first two digits represent the Bioconductor version
packageVersion("BiocVersion")[, 1:2]
```

### Role in Package Installation

While users rarely call functions within `BiocVersion` directly, the package must be present for `BiocManager` to function correctly. It serves as a "sentinel" package.

1.  **Version Mapping**: If `BiocVersion` 3.22.0 is installed, `BiocManager::install()` will pull packages from the Bioconductor 3.22 repositories.
2.  **Updating Bioconductor**: When performing a Bioconductor version upgrade, `BiocManager` updates the `BiocVersion` package to the next release version, which subsequently changes the repository URLs for all other packages.

### Troubleshooting

If you encounter issues where `BiocManager` is attempting to install packages from an older or incorrect Bioconductor release:
- Verify the version of `BiocVersion` installed.
- Ensure R is at the required version (e.g., R >= 4.5.0 is required for Bioconductor 3.22).

## Reference documentation

- [BiocVersion Reference Manual](./references/reference_manual.md)