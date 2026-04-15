---
name: slow5curl
description: slow5curl enables efficient, range-based retrieval of specific nanopore signal data from remote SLOW5 or BLOW5 files via HTTP/HTTPS. Use when user asks to fetch specific read IDs from a remote URL, inspect metadata headers, list all read IDs in a remote file, or extract raw signal data for downstream analysis.
homepage: https://github.com/BonsonW/slow5curl
metadata:
  docker_image: "quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0"
---

# slow5curl

## Overview
slow5curl is a specialized utility designed for the SLOW5 data ecosystem, enabling efficient access to nanopore signal data hosted on remote servers (via HTTP/HTTPS). It solves the problem of needing to download massive binary BLOW5 files just to access a subset of reads. By utilizing SLOW5 indexes (.idx), it performs range-based fetches to pull only the specific raw signal data requested. This skill provides the necessary command patterns for data extraction, format conversion, and integration into bioinformatics pipelines.

## Core Commands

### 1. Fetching Specific Reads (`get`)
The primary use case is retrieving specific records from a remote URL.
- **Single/Multiple IDs**: `slow5curl get https://url/file.blow5 read_id1 read_id2`
- **Batch from List**: `slow5curl get https://url/file.blow5 --list read_ids.txt -o output.blow5`
- **Format Conversion**: Use `--to slow5` to output in ASCII format for human inspection or `--to blow5` (default) for compressed binary.

### 2. Inspecting Metadata (`head`)
View the SLOW5 header to check run information, sample IDs, and attribute metadata.
- `slow5curl head https://url/file.blow5`

### 3. Listing All Read IDs (`reads`)
Retrieve a complete list of every read ID present in the remote file.
- `slow5curl reads https://url/file.blow5`

## Expert Tips and Best Practices

### Index Management
slow5curl requires an index file. By default, it looks for `https://url/file.blow5.idx`.
- **Avoid Repeated Downloads**: Use `--cache my_index.idx` to save the index locally on the first run.
- **Use Local Index**: If you already have the index, use `--index my_index.idx` to skip the remote check entirely.

### Performance Tuning
- **Thread Count**: The default is 128 threads. For high-latency connections or large batches, you can increase this (e.g., `-t 256`), but be mindful of server-side rate limits.
- **Batch Size**: Use `-K [size]` to adjust the number of records kept in memory. Larger batches improve multi-threaded throughput at the cost of RAM.

### Signal Extraction One-Liners
To quickly "eyeball" raw signal data without permanent files:
- **Extract Raw Signal Column**:
  `slow5curl get --to slow5 https://url/file.blow5 "read_id" | grep -v '^[#@]' | awk '{print $8}'`
- **Extract Specific Signal Samples (e.g., 100-200)**:
  `slow5curl get --to slow5 https://url/file.blow5 "read_id" | grep -v '^[#@]' | awk '{print $8}' | cut -d, -f 100-200`

### Compression Options
When saving to BLOW5, you can specify compression to save space:
- **Standard**: `-c zlib` (most compatible).
- **High Performance**: `-c zstd` (requires zstd-enabled build).
- **Signal Compression**: `-s svb-zd` (StreamVByte zig-zag delta) is the default and highly recommended for raw signal data.

## Common Workflows

### Genomic Region Extraction
To get reads mapping to a specific genomic coordinate:
1. Get Read IDs from a BAM/PAF file for that region.
2. Pass the list to `slow5curl get`.
3. Pipe to a basecaller like `buttery-eel`.

```bash
# Example: Extracting reads for a specific region
samtools view https://url/reads.bam chr1:1000-2000 | cut -f1 | sort -u > rids.txt
slow5curl get https://url/reads.blow5 --list rids.txt -o region_reads.blow5
```



## Subcommands

| Command | Description |
|---------|-------------|
| slow5curl head | Prints the header for a remote BLOW5 file. |
| slow5curl_get | Display the read entry for each specified READ_ID from a blow5 file. If READ_ID is not specified, a newline separated list of read ids will be read from the standard input. |
| slow5curl_reads | Prints the reads in a remote BLOW5 file. |

## Reference documentation
- [Commands and Options](./references/bonsonw_github_io_slow5curl_commands.html.md)
- [Bash One-liners](./references/bonsonw_github_io_slow5curl_oneliners.html.md)
- [Example Workflows](./references/bonsonw_github_io_slow5curl_workflows.html.md)
- [C API Reference](./references/bonsonw_github_io_slow5curl_slow5curl_api_slow5curl.html.md)