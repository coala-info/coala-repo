---
name: gnu-wget
description: GNU Wget is a command-line utility for retrieving files and mirroring content from web and FTP servers. Use when user asks to download files, resume interrupted transfers, mirror websites, or recursively crawl directories for offline viewing.
homepage: https://github.com/darnir/wget
metadata:
  docker_image: "quay.io/biocontainers/gnu-wget:1.18--hb829ee6_10"
---

# gnu-wget

## Overview

GNU Wget is a powerful command-line utility for retrieving content from web and FTP servers. Unlike interactive browsers, Wget is designed to function without user supervision, making it ideal for scripts, cron jobs, and background tasks. It excels at "recursive downloading," where it follows links in HTML or FTP listings to recreate remote directory structures locally. It is highly robust, featuring automatic retries for failed downloads and the ability to resume transfers from where they left off if the server supports it.

## Command Line Patterns

### Basic Downloads
*   **Download a single file**: `wget <URL>`
*   **Download and save with a specific name**: `wget -O <filename> <URL>`
*   **Download in the background**: `wget -b <URL>` (Output is logged to `wget-log` by default)
*   **Limit download speed**: `wget --limit-rate=200k <URL>` (Prevents Wget from consuming all available bandwidth)

### Resuming and Robustness
*   **Continue a partial download**: `wget -c <URL>` (Essential for large files interrupted by network issues)
*   **Try multiple times**: `wget --tries=10 <URL>` (Sets the number of retries; use `0` for infinite)
*   **Wait between retries**: `wget --wait=5 <URL>` (Useful to avoid overwhelming a server or getting rate-limited)

### Recursive Downloading and Mirroring
*   **Mirror a website**: `wget -m <URL>` (Enables recursion, infinite depth, time-stamping, and keeps FTP directory listings)
*   **Download for offline viewing**: `wget -p --convert-links <URL>` (Downloads all necessary page requisites like images/CSS and rewrites links to point to local files)
*   **Set recursion depth**: `wget -r -l 2 <URL>` (Downloads the URL and links up to 2 levels deep)
*   **Follow only specific domains**: `wget -r -D example.com <URL>`

### Authentication and Proxies
*   **HTTP/FTP Authentication**: `wget --user=<user> --password=<pass> <URL>`
*   **Use a proxy**: Set the `http_proxy` or `https_proxy` environment variables, or use `.wgetrc`.

## Expert Tips

*   **Respecting Robots.txt**: By default, Wget follows the Robot Exclusion Standard. To override this (only when ethically appropriate), use `-e robots=off`.
*   **Timestamping**: Use the `-N` (or `--timestamping`) flag to only download files if the remote version is newer than the local copy. This is highly efficient for maintaining mirrors.
*   **User-Agent Spoofing**: Some servers block Wget's default user-agent. Use `--user-agent="Mozilla/5.0..."` to identify as a standard web browser.
*   **Input Files**: To download a large list of URLs, save them in a text file (one per line) and use `wget -i list.txt`.
*   **Random Wait**: When crawling, use `--random-wait` along with `--wait` to make the request pattern look less like a bot and avoid automated blocking.

## Reference documentation

- [GNU Wget README](./references/github_com_darnir_wget.md)
- [GNU Wget Wiki](./references/github_com_darnir_wget_wiki.md)