---
name: r-downloader
description: The r-downloader tool provides a cross-platform, dependency-free way to download files over HTTP and HTTPS in R. Use when user asks to download data from secure URLs, retrieve scripts or archives, or ensure cross-platform compatibility for file downloads without external libraries.
homepage: https://cloud.r-project.org/web/packages/downloader/index.html
---


# r-downloader

name: r-downloader
description: Download files over HTTP and HTTPS in R with cross-platform support. Use this skill when you need a reliable, dependency-free way to download data, scripts, or archives from secure URLs (HTTPS) that works consistently across Windows, macOS, and Linux without requiring external libraries like RCurl.

# r-downloader

## Overview
The `downloader` package provides a lightweight wrapper for R's `download.file()` function. It ensures that downloads over HTTPS work seamlessly across different operating systems (Windows, macOS, and Unix-like systems) by automatically selecting the appropriate download method. It is specifically designed to avoid the external dependencies required by packages like `RCurl`.

## Installation
Install the package from CRAN:

```R
install.packages("downloader")
```

## Core Functions

### download()
The main function used to retrieve files from a URL. It passes arguments directly to `download.file()` but handles the HTTPS configuration automatically.

**Basic Usage:**
```R
library(downloader)
download(url = "https://example.com/file.txt", destfile = "file.txt")
```

## Common Workflows

### Downloading Binary Files
When downloading non-text files such as ZIP archives, RData files, or PDFs, always specify `mode = "wb"` (write binary). This is critical for preventing file corruption, especially on Windows.

```R
# Download a source code ZIP from GitHub
url <- "https://github.com/wch/downloader/zipball/master"
download(url, "downloader.zip", mode = "wb")
```

### Ensuring Cross-Platform Compatibility
Use `downloader::download()` in scripts intended for distribution to ensure that users on different platforms do not encounter "unsupported protocol" errors when accessing HTTPS links, which can occur with the default settings of base `download.file()`.

## Tips
- **Arguments:** Since `download()` wraps `download.file()`, you can use any additional arguments supported by the base function, such as `quiet = TRUE` to suppress status messages.
- **Dependencies:** This package is ideal for use in other packages or lightweight scripts because it does not require system-level encryption libraries to be manually installed.

## Reference documentation
- [README](./references/README.md)