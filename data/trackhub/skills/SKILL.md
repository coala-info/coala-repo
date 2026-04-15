---
name: trackhub
description: The `trackhub` Python package programmatically creates and manages UCSC track hubs. Use when user asks to create a UCSC track hub, define tracks, add tracks to a hub, or deploy a track hub.
homepage: http://github.com/daler/trackhub
metadata:
  docker_image: "quay.io/biocontainers/trackhub:1.0--pyh7cba7a3_0"
---

# trackhub

## Overview
The `trackhub` Python package provides a programmatic interface for building UCSC track hubs, replacing the tedious and error-prone process of manual text file configuration. It allows you to define the hierarchical structure of a hub—including the hub properties, genome specifications, and individual track metadata—directly in Python code. Key advantages include automatic validation of track settings, intelligent handling of file paths through symlinking, and built-in support for uploading the final hub to a remote server.

## Core Workflow
Creating a track hub typically follows a four-step process:

1.  **Initialization**: Use `trackhub.default_hub()` to create the base components (Hub, Genomes file, Genome, and TrackDB).
2.  **Track Creation**: Define individual `Track` objects, specifying the source file, track type, and visual properties.
3.  **Assembly**: Add the tracks to the `TrackDB` object.
4.  **Deployment**: Use `trackhub.upload.upload_hub()` to stage the files locally or push them to a remote server.

## Implementation Patterns

### Basic Hub Construction
```python
import trackhub

# Initialize the hub structure
hub, genomes_file, genome, trackdb = trackhub.default_hub(
    hub_name="experiment_hub",
    short_label="Exp1",
    long_label="Experimental Results Hub",
    genome="hg38",
    email="user@example.com"
)

# Define a track
track = trackhub.Track(
    name="signal_track",
    source="data/sample1.bw",
    visibility="full",
    color="128,0,0",
    autoScale="on",
    tracktype="bigWig"
)

# Add track to the database
trackdb.add_tracks(track)
```

### Sanitizing Track Names
UCSC track names cannot contain spaces or special characters. Always sanitize filenames when using them as track names:
```python
import os
from trackhub.helpers import sanitize

filename = "Sample 1-Signal.bw"
clean_name = sanitize(os.path.basename(filename))
track = trackhub.Track(name=clean_name, source=filename, ...)
```

### Staging and Uploading
The `upload_hub` function is versatile. It can "upload" to a local directory for testing or use `rsync` for remote servers.

**Local Staging (for testing):**
```python
trackhub.upload.upload_hub(
    hub=hub,
    host='localhost',
    remote_dir='staging/my_hub'
)
```

**Remote Deployment:**
```python
trackhub.upload.upload_hub(
    hub=hub,
    host='your-server.edu',
    user='username',
    remote_dir='/var/www/html/hubs/my_hub'
)
```

## Expert Tips and Best Practices
- **Validation**: `trackhub` automatically validates parameters against UCSC's documented options. If you provide an invalid color format or an unsupported visibility setting, the library will raise an error during construction rather than failing later in the browser.
- **Symlinking**: By default, the library symlinks data files to the staging area. This prevents duplicating large genomic files while ensuring the hub directory structure is self-contained for the `rsync` process.
- **Documentation**: You can write track documentation in ReStructured Text (.rst). The library will convert it to HTML and link it to the track automatically during the upload process.
- **Iterative Updates**: Because it uses `rsync` under the hood, subsequent calls to `upload_hub` only transfer files that have changed, making it efficient for updating large hubs.

## Reference documentation
- [github_com_daler_trackhub.md](./references/github_com_daler_trackhub.md)
- [anaconda_org_channels_bioconda_packages_trackhub_overview.md](./references/anaconda_org_channels_bioconda_packages_trackhub_overview.md)