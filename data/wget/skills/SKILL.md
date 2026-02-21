---
name: wget
description: Wget is a robust, non-interactive tool for retrieving content from web servers.
homepage: https://github.com/rockdaboot/wget2
---

# wget

## Overview
Wget is a robust, non-interactive tool for retrieving content from web servers. This skill emphasizes the capabilities of Wget2, which improves upon the original with multi-threading and support for modern web standards. Use this skill to construct commands for bulk downloads, site archiving, and efficient file transfers that can resume after network interruptions.

## Core Usage Patterns

### Basic Downloads
*   **Single File**: `wget2 <URL>`
*   **Resume Interrupted Download**: `wget2 -c <URL>`
*   **Download to Specific Filename**: `wget2 <URL> -O <filename>`
*   **Download in Background**: `wget2 -b <URL>`

### High-Performance Downloads (Wget2)
Wget2 is designed for speed. Use these options to maximize throughput:
*   **Multi-threaded Download**: Use `--max-threads` to download multiple files or chunks simultaneously.
    `wget2 --max-threads=10 -i urls.txt`
*   **Chunked Downloads**: For large single files, split the download into parallel chunks.
    `wget2 --chunk-size=1M <URL>`
*   **Enable HTTP/2**: Enabled by default in Wget2, but can be forced.
    `wget2 --http2 <URL>`

### Recursive Mirroring and Archiving
*   **Mirror a Website**: Creates a local copy of a site, following links and preserving structure.
    `wget2 -m <URL>`
*   **Convert Links for Offline Viewing**: Adjusts links in downloaded HTML to point to local files.
    `wget2 -m -k <URL>`
*   **Limit Crawl Depth**: Prevent the crawler from going too deep into a site.
    `wget2 -r -l 2 <URL>`
*   **Respect Robots.txt**: Wget2 respects `robots.txt` by default. To disable (use with caution):
    `wget2 --no-robots <URL>`

### Handling Specific Formats
Wget2 can parse specific file types to find further URLs to download:
*   **Sitemaps**: `wget2 --force-sitemap -i sitemap.xml`
*   **RSS/Atom Feeds**: `wget2 --force-rss -i feed.xml` or `--force-atom`
*   **Metalink**: `wget2 --metalink <file.meta4>`

## Expert Tips

### Configuration and Includes
Wget2 supports an `include` statement in its configuration files, allowing you to modularize settings (e.g., `include /etc/wget/conf.d/*.conf`).

### Compression
Wget2 automatically handles modern compression formats. It sends `Accept-Encoding: gzip, deflate, lzma, bzip2, br, zstd` by default, significantly reducing bandwidth for text-heavy sites.

### Security and Verification
*   **OCSP Stapling**: Enabled by default in Wget2 to verify certificate status efficiently.
*   **TLS Session Resumption**: Use `--tls-resume` to speed up subsequent connections to the same server.
*   **HSTS**: Wget2 supports HTTP Strict Transport Security (HSTS) to ensure secure connections.

### URL and Filename Cleaning
If a site uses heavy tracking or session variables, use these to keep local filenames clean:
*   `--cut-url-get-vars`: Removes GET variables from the URL before processing.
*   `--cut-file-get-vars`: Removes GET variables from the saved filename.

## Reference documentation
- [GNU Wget2 Introduction](./references/github_com_rockdaboot_wget2.md)
- [Wget2 Wiki and CLI Options](./references/github_com_rockdaboot_wget2_wiki.md)