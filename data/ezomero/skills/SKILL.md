---
name: ezomero
description: ezomero is a Python wrapper that simplifies bioimaging data management and interactions with OMERO servers. Use when user asks to connect to an OMERO server, manage image metadata, or perform bulk table operations between OMERO and Python environments.
homepage: https://github.com/TheJacksonLaboratory/ezomero
metadata:
  docker_image: "quay.io/biocontainers/ezomero:3.2.2--pyhdfd78af_0"
---

# ezomero

## Overview
The `ezomero` library is a high-level Python wrapper designed to simplify interactions with OMERO servers. It replaces the often-verbose native OMERO Python API with streamlined convenience functions. Use this skill to automate bioimaging data management, handle image metadata, and perform bulk table operations (import/export) between OMERO and Python environments.

## Installation and Environment Setup
Due to specific dependency requirements, follow these best practices to avoid environment conflicts:

*   **Dependency Management**: The package depends on `zeroc-ice==3.6.5`. It is highly recommended to install this specific version using wheels from Glencoe Software before installing `ezomero`.
*   **Conda Installation**:
    ```bash
    conda install bioconda::ezomero
    ```
*   **Table Support**: If you intend to work with Pandas DataFrames, ensure you install the optional dependencies:
    ```bash
    pip install ezomero[tables]
    ```

## Core Usage Patterns

### Establishing a Connection
The primary entry point is `ezomero.connect()`, which returns a `BlitzGateway` object (commonly named `conn`). This object must be passed to almost all other helper functions.

```python
import ezomero

# Connect to the server
conn = ezomero.connect(
    user="your_username",
    password="your_password",
    host="omero.server.address",
    port=4064,
    group="your_group",
    secure=True
)

# Always close the connection when finished
conn.close()
```

### Working with Tables
`ezomero` provides simplified functions for handling OMERO tables, which are often used for storing derived measurements or metadata.

*   **Retrieving Tables**: Use `ezomero.get_table(conn, file_id)`. If `ezomero[tables]` is installed, this returns a Pandas DataFrame; otherwise, it returns a list of lists.
*   **Posting Tables**: Use `ezomero.post_table(conn, df, object_type, object_id, title)`. This attaches a table to a specific OMERO object (e.g., Image, Dataset, or Project).

## Expert Tips and Best Practices

*   **Maintenance Status**: Note that as of August 2025, the official repository is in read-only/unmaintained mode. Use with caution for new long-term production pipelines.
*   **Connection Management**: Always wrap your logic in a `try...finally` block or ensure `conn.close()` is called to prevent leaking sessions on the OMERO server.
*   **Virtual Environments**: Always use a clean virtual environment. The `zeroc-ice` dependency is notoriously sensitive to system-level library versions.
*   **Testing**: If developing new scripts, use the provided Docker-based test server configuration found in the source repository to validate your code against a local OMERO instance.

## Reference documentation
- [ezomero GitHub Repository](./references/github_com_TheJacksonLaboratory_ezomero.md)
- [ezomero Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ezomero_overview.md)