---
name: curl
description: curl is a command-line utility for transferring data to or from a server using various network protocols. Use when user asks to execute API requests, download or upload files, inspect HTTP headers, or troubleshoot network connections.
homepage: https://github.com/curl/curl
metadata:
  docker_image: "quay.io/biocontainers/curl:7.80.0"
---

# curl

## Overview
`curl` is the industry-standard utility for executing network requests directly from the terminal. It supports a vast array of protocols and provides granular control over headers, authentication, and data transfer behavior. This skill focuses on high-utility CLI patterns for API interaction, resilient scripting, and advanced network troubleshooting.

## Core CLI Patterns

### API Interaction
- **GET Request**: `curl https://api.example.com/resource`
- **POST with JSON**: `curl -X POST https://api.example.com/data -H "Content-Type: application/json" -d '{"key":"value"}'`
- **Custom Headers**: Use `-H "Header-Name: Value"` for authorization tokens or content types.
- **Inspect Headers**: Use `-i` to include response headers in the output or `-I` to perform a HEAD request only.

### File Handling
- **Download**: `curl -O https://example.com/file.zip` (saves with the remote filename) or `curl -o local_name.zip https://example.com/file.zip` (custom filename).
- **Resume Transfer**: Use `-C -` to automatically resume a previously interrupted download.
- **Upload**: Use `-T filename.txt` for FTP/SFTP or `-F "file=@path/to/file"` for multipart/form-data POST uploads.

### Debugging & Performance
- **Verbose Mode**: Use `-v` to see the full request and response exchange, including TLS handshake details.
- **Trace**: Use `--trace-ascii -` for a detailed hex/ascii dump of all incoming and outgoing data.
- **Follow Redirects**: Use `-L` to ensure curl follows HTTP 3xx redirects.
- **Response Metrics**: Use `-w` (write-out) to extract specific timing or status data:
  `curl -s -o /dev/null -w "Status: %{http_code}\nTime: %{time_total}s\n" https://example.com`

### Resilience & Scripting
- **Silent Mode**: Use `-s` to hide the progress meter and error messages; combine with `-S` to show only errors.
- **Fail on Error**: Use `-f` or `--fail` to make the command return a non-zero exit code if the server returns an HTTP error (4xx/5xx).
- **Retries**: `--retry 3 --retry-delay 5` to handle transient network failures.
- **Timeouts**: Set limits with `--connect-timeout 10` (connection phase) and `-m 30` (total operation time).

### Security & Authentication
- **Basic Auth**: Use `-u username:password`.
- **Bearer Token**: Use `-H "Authorization: Bearer <token>"`.
- **SSL/TLS**: Use `-k` or `--insecure` to bypass certificate validation during testing (avoid in production).

## Reference documentation
- [curl README](./references/github_com_curl_curl.md)
- [curl Wiki](./references/github_com_curl_wiki.md)