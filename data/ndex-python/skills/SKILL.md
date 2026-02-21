---
name: ndex-python
description: The `ndex-python` skill provides a programmatic interface for managing biological networks on NDEx servers.
homepage: https://github.com/ndexbio/ndex-python
---

# ndex-python

## Overview

The `ndex-python` skill provides a programmatic interface for managing biological networks on NDEx servers. It facilitates the integration of NDEx into bioinformatics pipelines, allowing for the automated retrieval of network summaries, the streaming of large CX (Cytoscape Exchange) data, and the management of user-specific network collections. While the library is in maintenance mode, it remains the primary tool for applications built on the `NetworkN` and `NdexGraph` object classes.

## Installation

Install the package via pip or conda:

```bash
pip install ndex
# OR
conda install bioconda::ndex-python
```

## Core Usage Patterns

### Initializing the Client
Create a client instance for the public NDEx server. Use authentication for write operations or accessing private networks.

```python
import ndex.client

# Anonymous access
anon_ndex = ndex.client.Ndex("http://public.ndexbio.org")

# Authenticated access
my_ndex = ndex.client.Ndex("http://public.ndexbio.org", username="my_user", password="my_password")
```

### Network Retrieval
Always check the network size before downloading to avoid memory issues with large CX streams.

```python
network_id = "your-uuid-here"

# 1. Get metadata first
summary = my_ndex.get_network_summary(network_id)
print(f"Nodes: {summary.get('nodeCount')}, Edges: {summary.get('edgeCount')}")

# 2. Retrieve as CX stream (returns a response object)
cx_stream = my_ndex.get_network_as_cx_stream(network_id)
network_data = cx_stream.json() # Convert to Python dict
```

### Uploading and Updating Networks
Networks are handled as Python dictionaries representing the CX format.

```python
# Save a new network (cx is a python dict)
new_network_url = my_ndex.save_new_network(cx_data)

# Update an existing network
# Note: Requires WRITE permission or ownership
my_ndex.update_cx_network(cx_stream_data, network_id)
```

## Expert Tips and Best Practices

- **Memory Management**: For very large networks, use `get_network_as_cx_stream` and process the stream iteratively if possible, rather than loading the entire JSON into a dictionary at once.
- **Visibility Control**: By default, new networks are `PRIVATE`. Use `set_network_system_properties` to change visibility to `PUBLIC` or to toggle `readOnly` status.
- **Error Handling**: The client will raise errors if a `network_id` is not found or if an authenticated user lacks `READ` or `WRITE` permissions. Always wrap network operations in try-except blocks to handle 401 (Unauthorized) or 404 (Not Found) responses.
- **Legacy Support**: If your project requires the `NiceCX` object class, you must migrate to the `ndex2` library. This `ndex-python` client is strictly for `NetworkN` and raw CX dictionary manipulations.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_ndexbio_ndex-python.md)
- [Anaconda Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_ndex-python_overview.md)