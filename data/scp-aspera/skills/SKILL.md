---
name: scp-aspera
description: The scp-aspera tool performs high-speed downloads of metabolomics datasets from the MetaboLights database using the Aspera FASP protocol. Use when user asks to download public or private MetaboLights studies, transfer large metabolomics data files, or retrieve specific study metadata.
homepage: https://github.com/phnmnl/container-scp-aspera
---


# scp-aspera

## Overview
The scp-aspera tool is a specialized downloader designed to interface with the MetaboLights database. It leverages the Aspera FASP (Fast, Adaptive, and Secure Protocol) to provide high-speed data transfers that significantly outperform standard FTP or HTTP for large metabolomics datasets. This skill provides the necessary command-line patterns to execute these transfers via Docker, ensuring that complex dependencies like the Aspera client and environment configurations are handled automatically.

## Core CLI Usage

The tool is primarily invoked via Docker. The standard pattern requires mounting a local directory to the container's `/data` path and providing the Aspera password via an environment variable.

### Basic Download Pattern
To download a public study (e.g., MTBLS174), use the following structure:

```bash
docker run -v $(pwd):/data \
  -e "ASPERA_SCP_PASS=Xz68YfDe" \
  container-registry.phenomenal-h2020.eu/phnmnl/scp-aspera \
  -QT -l 1g \
  fasp-ml@fasp.ebi.ac.uk:/studies/public/MTBLS174 /data
```

### Command Flags and Parameters
*   `-QT`: Enables "Quiet" mode and optimizes for transfer performance.
*   `-l <limit>`: Sets the maximum bandwidth limit (e.g., `1g` for 1Gbps, `100m` for 100Mbps). This is critical for preventing the transfer from saturating your network connection.
*   `ASPERA_SCP_PASS`: The default password for public MetaboLights access is `Xz68YfDe`.
*   **Source Path**: Follows the format `fasp-ml@fasp.ebi.ac.uk:/studies/[public|private]/[STUDY_ID]`.
*   **Destination Path**: Always use `/data` within the container context if you have mapped your host directory to `/data`.

## Expert Tips and Best Practices

### Bandwidth Management
In shared research environments, always use the `-l` flag. Without it, Aspera will attempt to use all available bandwidth, which can lead to network instability for other users.

### Downloading Specific Metadata
While the tool defaults to full study downloads, you can target specific files or directories within a study by appending the relative path to the study ID in the source URL. This is useful for retrieving only the `i_Investigation.txt` or `s_*.txt` metadata files without the heavy raw data files.

### Handling Private Studies
To download private studies, you must replace the default `ASPERA_SCP_PASS` with the specific API key or password provided by MetaboLights for that private submission, and change the path segment from `/public/` to `/private/`.

### Troubleshooting Connection Errors
If a download fails with a "Bad error" message, verify:
1.  The `ASPERA_SCP_PASS` environment variable is correctly exported.
2.  UDP port 33001 is open on your firewall (Aspera requires UDP for data transfer, while using TCP for the initial handshake).
3.  The study ID is correctly prefixed (e.g., `MTBLS` followed by the number).

## Reference documentation
- [MetaboLights Downloader Main Page](./references/github_com_phnmnl_container-scp-aspera.md)
- [Known Issues and Feature Requests](./references/github_com_phnmnl_container-scp-aspera_issues.md)