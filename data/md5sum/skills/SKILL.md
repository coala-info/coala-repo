---
name: md5sum
description: Compute and check MD5 message digests. Use when Claude needs to: (1) Generate checksums for file integrity verification, (2) Verify files against existing .md5 manifests, (3) Perform bulk integrity checks in a multi-core environment, (4) Calculate hashes within a data pipeline, or (5) Validate data consistency after file transfers. Trigger this skill for any request involving MD5 hashing, checksum generation, or file verification.
---

# md5sum

## Basic Operations

Generate a checksum for a file:
`md5sum <file>`

Verify files against a checksum manifest:
`md5sum -c <checksum_file>`

## Expert Workflows

GNU `md5sum` follows the UNIX philosophy of tool composition. Use these patterns to implement advanced functionality that is not natively built into the tool.

### Parallel Execution
Process multiple files using all available CPU cores (replaces the need for a `--threads` flag):
`find . -type f | xargs -P $(nproc) md5sum`

### Hash Extraction
Isolate the hexadecimal digest for use in scripts or comparisons (replaces the need for a `--no-filename` flag):
`md5sum <file> | awk '{print $1}'`

### Pipeline Integration
Calculate a hash while simultaneously passing data to another process (replaces the need for a `--pipe` flag):
`cat <file> | tee >(md5sum > hash.txt) | <next_command>`

### I/O Buffering Control
Adjust buffering for high-latency environments (e.g., network filesystems) using the `stdbuf` utility:
`stdbuf -oL md5sum <file>`

### Recursive Processing and Filtering
Generate a manifest for an entire directory tree while excluding specific paths (replaces the need for an `--ignore-dirs` flag):
`find . -type f -not -path '*/.*' -exec md5sum {} + > manifest.md5`