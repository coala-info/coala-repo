---
name: gzrt
description: The gzip Recovery Toolkit (gzrt) extracts readable data from corrupted gzip archives by bypassing damaged sectors and bitstream errors. Use when user asks to recover data from a corrupted gzip file, extract files from a damaged tarball, or bypass CRC errors during decompression.
homepage: https://www.urbanophile.com/arenn/hacking/gzrt
metadata:
  docker_image: "quay.io/biocontainers/gzrt:0.9.1--h577a1d6_0"
---

# gzrt

## Overview

The gzip Recovery Toolkit (gzrt) provides the `gzrecover` utility, designed to bypass corrupted sectors in gzip archives and extract any remaining readable data. While standard decompression tools usually abort upon encountering a CRC error or invalid header, `gzrecover` attempts to find the next valid bitstream to continue extraction. This skill is particularly useful for recovering files from backups with bad sectors or interrupted transfers.

## Usage Patterns

### Basic Recovery
To recover data from a corrupted file, run `gzrecover` followed by the filename. By default, it creates a new file with the `.recovered` extension.

```bash
gzrecover corrupted_file.tar.gz
# Resulting file: corrupted_file.tar.recovered
```

### Pipeline and Stream Handling
For integration into shell pipelines, use the `-p` flag to write to standard output or read from standard input by omitting the filename.

```bash
# Reading from stdin and writing to stdout
cat corrupted.gz | gzrecover -p > recovered_data

# Specifying a custom output file
gzrecover -o output_filename.dat corrupted.gz
```

### Recovering Tarballs (.tar.gz)
Standard `tar` often fails when encountering errors in the underlying stream. Use `cpio` to extract files from the recovered tarball, as it is more resilient to format inconsistencies.

```bash
# 1. Recover the gzip stream
gzrecover backup.tar.gz

# 2. Extract using cpio
cpio -F backup.tar.recovered -i -v
```

## Expert Tips and Best Practices

*   **Check Transfer Mode First**: Before attempting recovery, ensure the corruption wasn't caused by an ASCII-mode FTP transfer. If the file was transferred incorrectly, re-transferring in binary mode is the only way to get a 100% valid file.
*   **Verbose Logging**: Use the `-v` flag to identify exactly where bad bytes are located. Because this output can be voluminous, redirect stderr to a log file:
    `gzrecover -v corrupted.gz 2> recovery_log.txt`
*   **Manual Verification**: Data recovered by `gzrt` is not guaranteed to be perfect. Always manually inspect the recovered files, as the tool may occasionally "recover" garbage data that happens to look like a valid bitstream.
*   **Performance**: `gzrecover` is slower than `gunzip` because it performs more intensive bitstream analysis. The more corrupted the file, the longer the process will take.
*   **Large File Support**: The tool is compiled with large file support, making it suitable for multi-gigabyte archives.

## Reference documentation
- [The gzip Recovery Toolkit](./references/www_urbanophile_com_arenn_hacking_gzrt.md)
- [gzrt ChangeLog](./references/www_urbanophile_com_arenn_hacking_gzrt_ChangeLog.md)