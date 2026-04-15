---
name: loki
description: Grafana Loki is a high-efficiency log aggregation system that indexes metadata labels to optimize for cost and operational simplicity. Use when user asks to build the Loki binary, execute the service with a configuration file, query logs via LogCLI, or inspect data objects and streams.
homepage: https://github.com/grafana/loki
---

# loki

## Overview
Grafana Loki is a high-efficiency log aggregation system inspired by Prometheus. It optimizes for cost and operational simplicity by indexing only metadata labels rather than the full text of log entries. This skill assists in the technical management of Loki environments, focusing on the native command-line workflows required to build the software, execute the service, and inspect internal data structures.

## Building and Running Loki
Loki is typically operated as a single binary for local development or small-scale deployments.

### Building from Source
To build the Loki service binary, ensure a Go environment is configured:
- Standard build: `go build ./cmd/loki`
- Makefile build (Unix systems): `make loki`

### Executing the Service
Run the executable by pointing it to a configuration file:
- Local execution: `./loki -config.file=./cmd/loki/loki-local-config.yaml`

### Building Agents
While Grafana Alloy is the current recommended agent, legacy components can still be built:
- Promtail (Standard): `go build ./clients/cmd/promtail`
- Promtail (Linux with Journal support): `go build --tags=promtail_journal_enabled ./clients/cmd/promtail`
- Promtail (No CGO): `CGO_ENABLED=0 go build ./clients/cmd/promtail`

## Command Line Tools
Loki provides specialized CLI tools for querying and maintenance.

### LogCLI
Use `LogCLI` for command-line log querying and stream inspection. It serves as the primary interface for interacting with the Loki API without a browser.

### Data Object Inspection
For deep troubleshooting of the storage layer, use the `dataobj-inspect` utility:
- List available log streams: `dataobj-inspect list-streams`
- Dump data object contents for analysis: `dataobj-inspect dump`

## Operational Best Practices
- **Label-Based Indexing**: Focus on using the same labels used in Prometheus to allow for seamless switching between metrics and logs.
- **Agent Selection**: Use Grafana Alloy for new log collection setups, as it has replaced Promtail for future development.
- **Storage Inspection**: Use the `dump` and `list-streams` commands when investigating index loading failures or file-descriptor leaks in the compactor.
- **Docker Integration**: Use the Docker Driver Client plugin to ship logs directly from containers to a Loki instance.

## Reference documentation
- [Grafana Loki Repository](./references/github_com_grafana_loki.md)
- [Loki Commit History](./references/github_com_grafana_loki_commits_main.md)