---
name: crunchstat-summary
description: This tool parses Arvados execution logs to provide a human-readable summary of resource consumption such as RAM, CPU, and I/O usage. Use when user asks to summarize resource utilization, identify memory bottlenecks, or optimize compute requirements for Arvados containers.
homepage: https://arvados.org
metadata:
  docker_image: "quay.io/biocontainers/crunchstat-summary:3.2.0--pyhdfd78af_0"
---

# crunchstat-summary

## Overview
The `crunchstat-summary` tool is a specialized utility for the Arvados ecosystem that parses execution logs to provide a human-readable summary of resource consumption. It helps developers and bioinformaticians understand how much RAM, CPU time, and I/O a specific process actually used compared to what was requested. This is essential for right-sizing compute nodes and identifying "out of memory" (OOM) risks or underutilized resources.

## Common CLI Patterns

### Basic Usage
The most common way to use the tool is by piping a log file into it or pointing it to a local log file:
```bash
crunchstat-summary --log-file path/to/crunch.log
```

### Analyzing Arvados Container Logs
If you have the Arvados CLI tools installed, you can fetch a log and summarize it in one pipeline:
```bash
arv container log [uuid] | crunchstat-summary
```

### Output Formats
By default, the tool provides a text summary. You can also generate a format suitable for further plotting or programmatic analysis:
*   **Text Summary (Default):** Provides peak memory usage, CPU user/sys time, and network I/O.
*   **Tabular Data:** Useful for comparing multiple runs.

## Expert Tips for Resource Optimization

### Identifying Memory Bottlenecks
Look for the `Max RSS` (Resident Set Size) value in the summary. 
*   If `Max RSS` is very close to the container's RAM limit, the process is at risk of OOM.
*   If `Max RSS` is significantly lower than requested (e.g., used 2GB but requested 16GB), reduce the RAM requirement to save costs and improve scheduling speed.

### CPU Efficiency
The summary provides "CPU time" and "Elapsed time."
*   **High CPU/Elapsed ratio:** Indicates good parallelization or efficient use of a single core.
*   **Low CPU/Elapsed ratio:** Suggests the process is I/O bound (waiting for disk/network) or blocked by a single-threaded bottleneck.

### Network and Disk I/O
Check the `Keep` and `Network` statistics to determine if data transfer is the primary bottleneck. High "Keep" read/write values indicate heavy interaction with Arvados storage, which might benefit from nodes with higher network throughput.

## Reference documentation
- [crunchstat-summary Overview](./references/anaconda_org_channels_bioconda_packages_crunchstat-summary_overview.md)
- [Arvados Technology Stack](./references/arvados_org_technology.md)