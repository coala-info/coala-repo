---
name: tciaclient
description: The `tciaclient` is a specialized Python library that provides a simplified interface to the official TCIA REST API.
homepage: https://github.com/moritzschwyzer/tciaclient/tree/master/
---

# tciaclient

## Overview

The `tciaclient` is a specialized Python library that provides a simplified interface to the official TCIA REST API. It allows for the automated retrieval of cancer imaging data directly into Python scripts or Jupyter Notebooks. Use this skill to help users browse available imaging collections, query metadata for specific series based on modalities (like CT or MRI), and download datasets as ZIP files for research and analysis.

## Installation

The package can be installed via pip or conda:

```bash
# Via pip
pip install tciaclient

# Via conda
conda install bioconda::tciaclient
```

## Core Usage Pattern

To interact with the TCIA API, follow this standard workflow:

1.  **Initialize the Client**: Import and instantiate the `TCIAClient`.
2.  **Identify Collections**: Use the collection names found on the [TCIA Collections Wiki](https://wiki.cancerimagingarchive.net/display/Public/Collections).
3.  **Query Metadata**: Retrieve series information, optionally filtering by modality.
4.  **Download Images**: Download specific series using their `SeriesInstanceUID`.

```python
from tciaclient.core import TCIAClient

# 1. Initialize
tc = TCIAClient()

# 2. Define target collection
collection = "NSCLC-Radiomics"

# 3. Get series metadata (filtered by modality)
series = tc.get_series(collection=collection, modality="CT")

# 4. Download a specific series
# The get_image method saves the series as a ZIP file
tc.get_image(
    seriesInstanceUid=series[0]["SeriesInstanceUID"], 
    downloadPath="./downloads", 
    zipFileName="sample_series.zip"
)
```

## Best Practices and Tips

- **Modality Filtering**: Always specify a `modality` (e.g., "CT", "MR", "PT") when calling `get_series` to avoid retrieving unnecessarily large metadata sets.
- **UID Management**: When downloading multiple series in a loop, use the `SeriesInstanceUID` or a zero-padded index in the `zipFileName` to prevent overwriting files.
- **Data Usage Policies**: Remind users that data downloaded via TCIA is subject to specific usage policies and restrictions available on the TCIA Wiki.
- **Path Handling**: Ensure the `downloadPath` exists before calling `get_image`, as the client may not automatically create nested directories.

## Reference documentation
- [TCIA Download Client for Python - GitHub](./references/github_com_moritzschwyzer_tciaclient.md)
- [tciaclient - Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tciaclient_overview.md)