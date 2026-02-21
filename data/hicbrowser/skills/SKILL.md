---
name: hicbrowser
description: HiCBrowser is a lightweight web-based visualization tool designed specifically for Hi-C data and associated genomic tracks.
homepage: https://github.com/maxplanck-ie/HiCBrowser
---

# hicbrowser

## Overview
HiCBrowser is a lightweight web-based visualization tool designed specifically for Hi-C data and associated genomic tracks. It acts as a wrapper for HiCExplorer's plotting functions, allowing users to interactively browse TADs (Topologically Associating Domains), gene neighborhoods, and multi-omic data tracks. Use this skill when you need to move from static command-line analysis to an interactive visual inspection of chromosome interactions.

## Installation and Setup
HiCBrowser requires HiCExplorer to be installed as a backend dependency.

- **Conda (Recommended):** `conda install -c bioconda hicbrowser`
- **Pip:** `pip install git+https://github.com/deeptools/HiCBrowser`
- **Docker:** `docker run --rm -p 80:80 bgruening/docker-hicbrowser`

## Configuration Files
The browser requires three primary `.ini` configuration files to function.

### 1. Browser Configuration (`browserConfig.ini`)
Defines the server environment and paths to other track configurations.
- **[directories]**: Specify where images are cached.
- **[tracks]**: Point to the file paths for `gene_tracks.ini` and `region_tracks.ini`.

### 2. Region Tracks (`region_tracks.ini`)
Defines the genomic tracks (BigWig, BED, Hi-C matrices) to be displayed in the standard browser view.
- Follows the same syntax as HiCExplorer's `plotTADs`.
- Supports `[hic matrix]`, `[bigwig]`, `[vlines]` (for TAD boundaries), and `[spacer]` sections.

### 3. Gene Tracks (`gene_tracks.ini`)
Specifically used for the "Gene View" to visualize interactions and tracks centered around specific gene coordinates.

## Execution Patterns
To launch the browser, use the `runBrowser` command.

```bash
# Basic execution
runBrowser --config browserConfig.ini --port 8888

# High-performance execution for multiple users
runBrowser --config browserConfig.ini --port 8888 --numProcessors 10
```

## Expert Tips
- **PYTHONPATH Issues**: If running from source or a custom environment, ensure both HiCExplorer and HiCBrowser are in your path:
  `export PYTHONPATH=/path/to/HiCExplorer:/path/to/HiCBrowser`
- **Data Preparation**: Since HiCBrowser relies on HiCExplorer, ensure your Hi-C matrices are in `.h5` or `.cool` format before attempting to load them in the `.ini` files.
- **Interactive Testing**: Use the `example_browser` directory within the repository to test your installation using the provided `run_server.sh` script.

## Reference documentation
- [HiCBrowser GitHub Repository](./references/github_com_deeptools_HiCBrowser.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hicbrowser_overview.md)