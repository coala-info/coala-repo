---
name: bioconductor-biocinstaller
description: This tool manages the installation, update, and versioning of Bioconductor and CRAN packages. Use when user asks to install or update packages using biocLite, validate package consistency with biocValid, manage Bioconductor release or development versions, or install package groups from specific publications.
homepage: https://bioconductor.org/packages/3.8/bioc/html/BiocInstaller.html
---


# bioconductor-biocinstaller

name: bioconductor-biocinstaller
description: Management of Bioconductor and CRAN package installations, updates, and versioning. Use when Claude needs to: (1) Install or update Bioconductor/CRAN packages using biocLite, (2) Validate the consistency of installed packages with biocValid, (3) Manage Bioconductor release vs. development versions, or (4) Identify package groups associated with Bioconductor publications.

# bioconductor-biocinstaller

## Overview
BiocInstaller is the legacy infrastructure package used to install and update Bioconductor, CRAN, and GitHub packages. It ensures that the versions of packages installed are consistent with the version of R and Bioconductor in use. Note: In modern R versions (>= 3.5.0), this package has been largely superseded by `BiocManager`, but it remains the primary tool for older Bioconductor releases (up to 3.8).

## Core Workflows

### Initializing BiocInstaller
To ensure the most recent version of the installer is used, source the initialization script:
```r
source("https://bioconductor.org/biocLite.R")
```

### Installing and Updating Packages
Use `biocLite()` as the primary entry point for installation.
* **Install specific packages**: `biocLite(c("GenomicRanges", "edgeR"))`
* **Update all installed packages**: `biocLite()`
* **Install from GitHub**: `biocLite("user/repository")`
* **Install without updating existing packages**: `biocLite("PackageName", suppressUpdates = TRUE)`

### Validating the Installation
Check if installed packages are out-of-date or "too new" for the current Bioconductor version:
```r
# Check validity
biocValid()

# Check and automatically fix (reinstall/downgrade) invalid packages
biocValid(fix = TRUE)
```

### Managing Bioconductor Versions
* **Check version**: `biocVersion()`
* **Upgrade Bioconductor**: `biocLite("BiocUpgrade")`
* **Switch to Development branch**: `useDevel(TRUE)`
* **Switch to Release branch**: `useDevel(FALSE)`

### Working with Repositories
View the URLs for the current Bioconductor and CRAN repositories:
```r
biocinstallRepos()
```

## Package Groups
BiocInstaller provides convenience functions to install sets of packages associated with specific publications or categories:
* `all_group()`: All Bioconductor software packages.
* `biocases_group()`: Packages used in "Bioconductor Case Studies".
* `RBioinf_group()`: Packages used in "R Programming for Bioinformatics".
* `monograph_group()`: Packages used in "Bioinformatics and Computational Biology Solutions Using R and Bioconductor".

Example usage:
```r
biocLite(biocases_group())
```

## Tips and Best Practices
* **Environment Variables**: Set `options(BIOCINSTALLER_ONLINE_DCF = FALSE)` to use local configuration if internet access is slow or restricted.
* **Update Prompts**: Use `biocLite(ask = FALSE)` in non-interactive scripts to prevent the installer from pausing for user confirmation during updates.
* **Library Location**: Use the `lib` argument in `biocLite()` to specify a custom library path for installation.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)