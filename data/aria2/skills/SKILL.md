---
name: aria2
description: aria2 is a lightweight, high-performance download utility that excels at maximizing bandwidth by downloading files from multiple sources or through multiple connections simultaneously.
homepage: https://aria2.github.io/
---

# aria2

## Overview
aria2 is a lightweight, high-performance download utility that excels at maximizing bandwidth by downloading files from multiple sources or through multiple connections simultaneously. It is particularly useful for large file transfers, automated download scripts, and environments where low resource consumption (CPU/RAM) is critical.

## Common CLI Patterns

### Basic Downloads
- **Single file**: `aria2c http://example.org/file.iso`
- **Multiple sources**: `aria2c http://host1/file.iso ftp://host2/file.iso`
- **From a list**: `aria2c -i uris.txt` (reads URIs from a text file)

### Performance Optimization
- **Multiple connections**: Use `-x` to set connections per server (default is 1).
  `aria2c -x16 http://example.org/file.iso`
- **Split downloading**: Use `-s` to split a file into multiple segments.
  `aria2c -s10 -x10 http://example.org/file.iso`

### BitTorrent and Metalink
- **Magnet link**: `aria2c 'magnet:?xt=urn:btih:...'` (always wrap in quotes)
- **Torrent file**: `aria2c http://example.org/file.torrent` or `aria2c local.torrent`
- **Metalink**: `aria2c http://example.org/file.metalink`

### Advanced Control
- **Resume**: aria2 resumes downloads by default if a `.aria2` control file exists.
- **Limit bandwidth**: Use `--max-download-limit` (e.g., `aria2c --max-download-limit=500K URL`).
- **Backgrounding**: Use `-D` to run the process as a daemon.

## Expert Tips
- **Resource Efficiency**: aria2 typically uses only 4MB-9MB of RAM, making it superior to GUI clients for headless servers.
- **RPC Interface**: For remote management, start aria2 with `--enable-rpc`. This allows interaction via JSON-RPC or XML-RPC.
- **Verification**: When using Metalink or BitTorrent, aria2 automatically verifies file integrity using checksums. For standard HTTP/FTP, you can manually provide a checksum: `--checksum=sha-256=<hash>`.

## Reference documentation
- [aria2 Index](./references/aria2_github_io_index.md)
- [aria2 English Manual](./references/aria2_github_io_manual_en_html_index.html.md)