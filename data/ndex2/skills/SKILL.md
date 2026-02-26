---
name: ndex2
description: The ndex2 Python client provides a high-level interface for interacting with the Network Data Exchange platform to manage, download, and upload biological networks in CX and CX2 formats. Use when user asks to download or upload networks from NDEx, convert networks between CX format and Pandas or NetworkX, or manipulate network data in Python.
homepage: https://github.com/ndexbio/ndex2-client
---


# ndex2

## Overview
The `ndex2` Python client is the official library for interacting with the NDEx (Network Data Exchange) platform. It provides a high-level interface, primarily through the `NiceCXNetwork` class, which simplifies the handling of CX (Cytoscape Exchange) and the newer CX2 data formats. This tool is designed to bridge the gap between biological network repositories and popular Python data science libraries, allowing researchers to seamlessly move data between NDEx, Pandas, and NetworkX for analysis and visualization.

## Installation and Setup
Install the client via pip or conda:
```bash
pip install ndex2
# OR
conda install bioconda::ndex2
```

## Core Usage Patterns

### 1. Connecting to NDEx
To interact with a server (default is `http://public.ndexbio.org`), initialize the `Ndex2` client:
```python
import ndex2
# For public access
client = ndex2.client.Ndex2()

# For authenticated access
client = ndex2.client.Ndex2(host='http://public.ndexbio.org', username='myuser', password='mypassword')
```

### 2. Working with NiceCXNetwork
The `NiceCXNetwork` class is the preferred way to manipulate networks in memory.
- **Download a network**: `nice_cx = ndex2.create_nice_cx_from_server(server='public.ndexbio.org', uuid='YOUR_NETWORK_UUID')`
- **Upload a network**: `nice_cx.upload_to('public.ndexbio.org', 'username', 'password')`
- **Create from file**: `nice_cx = ndex2.create_nice_cx_from_file('path/to/network.cx')`

### 3. Data Integration (Pandas & NetworkX)
`ndex2` excels at converting biological networks into formats ready for analysis:
- **To NetworkX**: `G = nice_cx.to_networkx()`
- **From NetworkX**: `nice_cx = ndex2.create_nice_cx_from_networkx(G)`
- **From Pandas**: Use `ndex2.create_nice_cx_from_pandas(df, source_field='source', target_field='target')` to convert edge lists into networks.

### 4. CX2 Support
For newer workflows, use the CX2 factory methods to handle the optimized CX2 format:
- Use `ndex2.cx2.RawCX2NetworkFactory` to process CX2 data streams.
- Note that recent versions (3.10.0+) have improved integration for CX2 with NetworkX and Pandas.

## Expert Tips and Best Practices
- **Attribute Management**: Use the `rename_node_attribute()` or `rename_edge_attribute()` methods to clean up network metadata before publication.
- **Large Networks**: When dealing with very large networks, ensure `ijson` is installed (it is a dependency) as the client uses it for iterative parsing to keep memory usage low.
- **Network Sets**: Use the client to organize networks into "Network Sets" for easier sharing of related datasets. Note that adding networks to sets requires the UUID of both the set and the network.
- **Data Types**: When converting from Pandas, explicitly define your data types for attributes to ensure they are correctly mapped to CX/CX2 types (e.g., integer, double, boolean).

## Reference documentation
- [NDEx2 Python Client Overview](./references/github_com_ndexbio_ndex2-client.md)
- [Bioconda ndex2 Package](./references/anaconda_org_channels_bioconda_packages_ndex2_overview.md)
- [Recent Changes and CX2 Updates](./references/github_com_ndexbio_ndex2-client_commits_master.md)