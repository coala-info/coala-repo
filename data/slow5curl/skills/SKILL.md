---
name: slow5curl
description: slow5curl is a specialized tool designed for efficient, random access to remote BLOW5 files.
homepage: https://github.com/BonsonW/slow5curl
---

# slow5curl

## Overview
slow5curl is a specialized tool designed for efficient, random access to remote BLOW5 files. By leveraging libcurl, it allows users to stream specific nanopore signal records (reads) from cloud storage or web servers. This is particularly useful for large-scale genomic datasets where downloading the full multi-gigabyte BLOW5 file is impractical.

## Installation
The quickest way to install slow5curl is via Bioconda:
```bash
conda install bioconda::slow5curl
```

## Common CLI Patterns

### Inspecting Remote Files
To view the header information or list all available read IDs in a remote BLOW5 file:
```bash
# View the BLOW5 header
slow5curl head https://url/to/data.blow5

# List all read IDs present in the file
slow5curl reads https://url/to/data.blow5
```

### Fetching Specific Reads
You can fetch reads by providing IDs directly or using a list file.
```bash
# Fetch a single read by ID
slow5curl get https://url/to/data.blow5 <READ_ID> -o output.blow5

# Fetch multiple reads using a text file containing IDs (one per line)
slow5curl get https://url/to/data.blow5 --list read_ids.txt -o output.blow5
```

### Index Management
slow5curl requires a `.idx` index file to perform random access. It can fetch this automatically, but manual management is more efficient for repeated access.
```bash
# Download and cache the index locally for future use
slow5curl get https://url/to/data.blow5 <READ_ID> --cache local_index.idx

# Use a pre-existing local index to speed up fetching
slow5curl get https://url/to/data.blow5 --index local_index.idx --list read_ids.txt

# Use a specific remote index URL
slow5curl get https://url/to/data.blow5 --index https://url/to/data.blow5.idx <READ_ID>
```

## Expert Tips & Troubleshooting

### Connection Issues
If you encounter "Issue establishing connection" or backend errors, it is often due to the server rate-limiting concurrent connections.
*   **Fix**: Limit the number of threads/connections using the `-t` flag. Start with `-t 1` and gradually increase it.
    ```bash
    slow5curl get -t 1 https://url/to/data.blow5 <READ_ID>
    ```

### Zstd Compression
If the remote BLOW5 file uses `zstd` compression, ensure slow5curl was built with zstd support (standard in Bioconda versions). If building from source, use `make zstd=1`.

### Performance
For high-throughput fetching of thousands of reads, always use the `--index` flag with a local file to avoid the overhead of slow5curl attempting to resolve the index location on every command.

## Reference documentation
- [slow5curl GitHub Repository](./references/github_com_BonsonW_slow5curl.md)
- [Bioconda slow5curl Package](./references/anaconda_org_channels_bioconda_packages_slow5curl_overview.md)