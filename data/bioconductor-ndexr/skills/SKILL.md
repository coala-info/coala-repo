---
name: bioconductor-ndexr
description: This package provides an R interface to the Network Data Exchange (NDEx) server API for biological network manipulation and management. Use when user asks to search for, upload, download, or modify biological networks on NDEx servers using R.
homepage: https://bioconductor.org/packages/release/bioc/html/ndexr.html
---


# bioconductor-ndexr

name: bioconductor-ndexr
description: Interface to the Network Data Exchange (NDEx) server API for biological network manipulation. Use this skill when you need to search, upload, download, or modify biological networks on public or private NDEx servers using R. It supports the CX (Cytoscape Cyberinfrastructure) format via the RCX package and allows conversion to igraph or Bioconductor graph objects.

# bioconductor-ndexr

## Overview
The `ndexr` package provides a comprehensive R interface for interacting with NDEx servers. It allows users to programmatically access pathway collections (like NCI-PID), manage private network repositories, and perform collaborative network curation. The package uses the `RCX` data model, which is an aspect-oriented format for biological networks.

## Connection and Authentication
Every workflow begins with establishing a connection object (`ndexcon`).

```r
library(ndexr)

# Anonymous connection (read-only for public networks)
ndexcon <- ndex_connect()

# Authenticated connection (required for creating/modifying networks)
ndexcon <- ndex_connect(username = "my_user", password = "my_password")

# Connecting to a private/local NDEx instance
ndexcon <- ndex_connect(host = "localhost:8888/ndex/rest")
```

## Finding and Exploring Networks
Search for networks by keywords, account names, or specific UUIDs.

```r
# Search by keyword
networks <- ndex_find_networks(ndexcon, searchString = "EGFR")

# Find all networks owned by a specific user
user_networks <- ndex_find_networks(ndexcon, accountName = "nci-pid")

# Get a summary of a specific network (check size before downloading)
network_id <- networks[1, "externalId"]
summary <- ndex_network_get_summary(ndexcon, network_id)
print(summary$nodeCount)
print(summary$edgeCount)
```

## Network Data Operations
Download networks as `RCX` objects or upload new/updated versions.

```r
# Download entire network
rcx_net <- ndex_get_network(ndexcon, network_id)

# Inspect metadata/aspects
rcx_net$metaData

# Create a new network on the server
new_id <- ndex_create_network(ndexcon, rcx_net)

# Update an existing network
ndex_update_network(ndexcon, rcx_net, networkId = new_id)

# Delete a network (Caution: irreversible)
ndex_delete_network(ndexcon, new_id)
```

## Selective Aspect Retrieval
For large networks, download only specific components (aspects) to save bandwidth.

```r
# Get metadata first
metadata <- ndex_network_get_metadata(ndexcon, network_id)

# Retrieve only network attributes
net_attr <- ndex_network_get_aspect(ndexcon, network_id, "networkAttributes")

# Retrieve only nodes
nodes <- ndex_network_get_aspect(ndexcon, network_id, "nodes")
```

## Managing Permissions and Properties
Control visibility and access for collaborative projects.

```r
# Change visibility to PUBLIC
ndex_network_set_systemProperties(ndexcon, network_id, visibility = "PUBLIC")

# Set to read-only for publication
ndex_network_set_systemProperties(ndexcon, network_id, readOnly = TRUE)

# Grant permissions to another user
ndex_network_update_permission(ndexcon, network_id, user = "other_user_uuid", "WRITE")
```

## Integration with Other Packages
`ndexr` works seamlessly with `RCX` for visualization and `igraph` for analysis.

```r
# Visualize using RCX
RCX::visualize(rcx_net)

# Convert to igraph for topological analysis
ig_net <- RCX::toIgraph(rcx_net)
```

## Reference documentation
- [NDExR - R implementation for NDEx server API](./references/ndexr-vignette.Rmd)
- [NDExR - R implementation for NDEx server API (Markdown)](./references/ndexr-vignette.md)