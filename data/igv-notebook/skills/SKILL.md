---
name: igv-notebook
description: igv-notebook provides interactive genomic visualization within Python-based notebooks by wrapping the igv.js library. Use when user asks to initialize a genome browser, load genomic tracks from local or remote files, and navigate to specific loci in Jupyter or Colab environments.
homepage: https://github.com/igvteam/igv-notebook
---


# igv-notebook

## Overview
The `igv-notebook` skill enables interactive genomic visualization within Python-based notebooks. It acts as a wrapper for the `igv.js` library, allowing researchers to instantiate a genome browser, load tracks, and navigate to specific loci programmatically. A key advantage of this tool is its ability to handle local file paths in Jupyter and Colab environments, bypassing the standard web browser security restrictions that typically limit `igv.js` to URL-based data.

## Installation and Initialization
Install the package via pip or conda:
```bash
pip install igv-notebook
# OR
conda install bioconda::igv-notebook
```

Initialize the module in your notebook:
```python
import igv_notebook
igv_notebook.init()
```
**Note for Google Colab:** Because Colab renders output in sandboxed iFrames, you must call `igv_notebook.init()` in every cell where you intend to display or interact with a browser instance.

## Browser Creation
Create a browser instance by passing a configuration dictionary. This dictionary follows the standard `igv.js` configuration schema.

```python
browser = igv_notebook.Browser({
    "genome": "hg38",
    "locus": "chr22:24,376,166-24,376,456"
})
```

## Loading Tracks
Tracks can be added during initialization or dynamically using `load_track()`.

### Using Remote URLs
Standard for public datasets or cloud-hosted files.
```python
browser.load_track({
    "name": "Remote BAM",
    "url": "https://s3.amazonaws.com/igv.org.demo/gstt1_sample.bam",
    "indexURL": "https://s3.amazonaws.com/igv.org.demo/gstt1_sample.bam.bai",
    "format": "bam",
    "type": "alignment"
})
```

### Using Local File Paths
`igv-notebook` introduces `path` and `indexPath` properties to support local files.
- **Jupyter Notebook:** Supports absolute paths or paths outside the Jupyter root.
- **Google Colab:** Use paths relative to the `/content/` directory or mounted Google Drive.
- **JupyterLab:** Does **not** support the `path` property; local files must be within the Jupyter file tree and referenced via `url`.

```python
# Local file example (Jupyter/Colab)
browser.load_track({
    "name": "Local Alignment",
    "path": "/path/to/data/sample.bam",
    "indexPath": "/path/to/data/sample.bam.bai",
    "format": "bam"
})
```

## Navigation and Control
Control the browser state after creation using the following methods:

- **Navigate to Locus:** `browser.search('chr1:100-200')`
- **Zooming:** `browser.zoom_in()` or `browser.zoom_out()`
- **Regions of Interest (ROI):** Load overlays to highlight specific genomic ranges.
  ```python
  browser.load_roi([{
      "name": "Target Region",
      "url": "data/regions.bed",
      "color": "rgba(255, 0, 0, 0.25)"
  }])
  ```

## Best Practices
- **Performance:** In Jupyter environments, loading files via `url` (relative to the Jupyter startup directory) is generally faster than using the `path` property.
- **Pathing:** For Jupyter URLs, a leading `/` refers to the Jupyter server root. No leading slash refers to the directory containing the current notebook.
- **Session Management:** Use `browser.get_session()` to retrieve the current browser state as a JSON object, which can be used to recreate the exact view later.

## Reference documentation
- [igv-notebook GitHub Repository](./references/github_com_igvteam_igv-notebook.md)
- [igv-notebook Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_igv-notebook_overview.md)