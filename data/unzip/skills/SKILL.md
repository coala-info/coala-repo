---
name: unzip
description: This tool extracts compressed archive files. Use when user asks to uncompress ZIP, RAR, TAR, GZ, or other common archive formats, extract the contents of a compressed file to a specified directory, or list the contents of an archive without extracting them.
homepage: https://github.com/peazip/PeaZip
metadata:
  docker_image: "quay.io/biocontainers/unzip:6.0--2"
---

# unzip

Handles the extraction of compressed archive files. Use this skill when Claude needs to:
  - Uncompress ZIP, RAR, TAR, GZ, or other common archive formats.
  - Extract the contents of a compressed file to a specified directory.
  - List the contents of an archive without extracting them.
  - Handle various archive types supported by standard command-line utilities.
---
## Overview
This skill provides capabilities for extracting compressed archive files. It is designed to handle common archive formats such as ZIP, RAR, TAR, and GZ, allowing Claude to access the contents of compressed data. This is useful for scenarios where files are distributed in archives and need to be unpacked for further processing or analysis.

## Usage Instructions

The `unzip` command-line utility is a powerful tool for extracting archive files. Here are some common and expert usage patterns:

### Basic Extraction

To extract all files from a ZIP archive:
```bash
unzip archive.zip
```

To extract all files from a ZIP archive into a specific directory:
```bash
unzip archive.zip -d /path/to/destination
```

### Extracting Specific Files

To extract only specific files from an archive:
```bash
unzip archive.zip file1.txt path/to/file2.jpg
```

### Listing Archive Contents

To view the contents of an archive without extracting them:
```bash
unzip -l archive.zip
```

### Handling Different Archive Types

While `unzip` is primarily for `.zip` files, many systems have related utilities or `unzip` can sometimes handle other formats with specific options or by leveraging other tools. For broader archive support (like `.tar.gz`, `.rar`), consider using `tar` or dedicated tools like `7z` or `peazip` if available.

For `.tar.gz` or `.tgz` files:
```bash
tar -xzf archive.tar.gz
```

For `.rar` files, you might need the `unrar` command-line tool:
```bash
unrar x archive.rar
```

### Advanced Tips

*   **Overwriting Files**: By default, `unzip` will prompt before overwriting existing files. Use the `-o` flag to overwrite without prompting.
    ```bash
    unzip -o archive.zip
    ```
*   **Case Insensitivity**: Use the `-i` flag to treat uppercase and lowercase letters as the same when matching filenames.
    ```bash
    unzip -i archive.zip
    ```
*   **Testing Archives**: Before extracting, you can test an archive for integrity using the `-t` flag.
    ```bash
    unzip -t archive.zip
    ```
*   **Verbose Output**: For more detailed information during extraction, use the `-v` flag.
    ```bash
    unzip -v archive.zip
    ```

## Reference documentation
- [PeaZip - Free Zip / Unzip software and Rar file extractor.](./references/github_com_peazip_PeaZip.md)