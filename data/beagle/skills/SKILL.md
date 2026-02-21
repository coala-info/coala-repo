---
name: beagle
description: Beagle is a specialized forensics tool designed to simplify incident investigation by converting flat log files into graph-based representations.
homepage: https://github.com/yampelo/beagle
---

# beagle

## Overview

Beagle is a specialized forensics tool designed to simplify incident investigation by converting flat log files into graph-based representations. Instead of parsing thousands of individual events, it centers the visualization on process activity, allowing analysts to see how processes, files, and network connections interact. It is particularly effective for identifying lateral movement, parent-child process anomalies, and malicious file operations across supported data sources like Windows Event Logs and network captures.

## Core Workflows

### Python Library Usage

The most efficient way to use Beagle programmatically is through its high-level functional calls.

**Single Datasource to Graph:**
```python
from beagle.datasources import SysmonEVTX

# Automatically transforms logs into a NetworkX graph object
graph = SysmonEVTX("logs.evtx").to_graph()
```

**Merging Multiple Artifacts:**
Use the `NetworkX` backend to combine different data types (e.g., PCAP and EVTX) into a single unified graph.
```python
from beagle.datasources import SysmonEVTX, PCAP
from beagle.backends import NetworkX

nx = NetworkX.from_datasources(datasources=[
    SysmonEVTX("windows_logs.evtx"),
    PCAP("network_traffic.pcap")
])
G = nx.graph()
```

### Granular Transformation Control
For custom analysis, you can manually trigger the intermediate steps:
1. **Datasource**: Load the raw data.
2. **Transformer**: Convert events into nodes (e.g., `SysmonTransformer`).
3. **Backend**: Build the graph (e.g., `NetworkX`, `Neo4J`).

```python
from beagle.datasources import SysmonEVTX
from beagle.transformers import SysmonTransformer
from beagle.backends import NetworkX

datasource = SysmonEVTX("data.evtx")
transformer = SysmonTransformer(datasource=datasource)
nodes = transformer.run()
backend = NetworkX(nodes=nodes)
G = backend.graph()
```

## Supported Data Sources

| Source | Class Name | Notes |
| :--- | :--- | :--- |
| Windows Event Logs | `SysmonEVTX` / `WindowsEVTX` | Supports standard EVTX and Sysmon |
| FireEye HX | `HXTriage` | Parses HX Triage collections |
| Network Traffic | `PCAP` | Extracts connection relationships |
| Memory Images | `Rekall` | Requires `pybeagle[rekall]` installation |
| Generic JSON | `GenericJSON` | For custom log formats |

## Configuration and Environment

Beagle uses a hierarchical configuration system. You can override any setting using environment variables with the format `BEAGLE__{SECTION}__{KEY}`.

- **VirusTotal Integration**: Set `BEAGLE__VIRUSTOTAL__API_KEY` to enable automated hash lookups during transformation.
- **Storage Directory**: Change where graphs are saved using `BEAGLE__STORAGE__DIR`.
- **Docker Deployment**:
  ```bash
  docker run -v "$PWD/data/beagle":"/data/beagle" -p 8000:8000 yampelo/beagle
  ```

## Best Practices for Analysis

- **Focus on Processes**: Beagle graphs are process-centric. When investigating, start by identifying the "root" process of an alert and use the `Expanding Neighbours` feature (double-click in the Web UI) to see child processes or file modifications.
- **Memory Forensics**: When using the Rekall datasource, ensure you have the correct profile for the memory image to avoid transformation errors.
- **Graph Backends**: Use the default `NetworkX` for quick local analysis. For large-scale investigations involving millions of events, configure a `Neo4J` backend to leverage persistent storage and Cypher queries.
- **Data Volume**: Beagle pulls 25 nodes at a time when expanding neighbors in the UI to prevent browser hang. If a process has high fan-out (e.g., `svchost.exe`), use filters to hide common node types like "Known DLLs" or "Standard Pipes."

## Reference documentation
- [Beagle Repository Overview](./references/github_com_yampelo_beagle.md)