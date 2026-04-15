---
name: tiara
description: Tiara monitors the Internet Archive for new content by comparing search results against a local database of previously discovered items. Use when user asks to track new archive uploads, automate keyword searches on the Internet Archive, or generate reports on newly discovered digital resources.
homepage: https://github.com/ibe-uw/tiara
metadata:
  docker_image: "quay.io/biocontainers/tiara:1.0.3"
---

# tiara

## Overview
Tiara (The Internet Archive Research Assistant) is a Python-based automation tool designed to monitor the Internet Archive for new content. It functions by comparing current search results against a local database of previously discovered items, ensuring that you only receive alerts for truly new material. It is specifically built to run as a background process, generating HTML reports or email notifications to keep you informed of new resources relevant to your ongoing research.

## Installation and Requirements
Before running tiara, ensure the environment has the necessary dependencies:

1.  **Python 3**: The tool is written in Python.
2.  **Internet Archive CLI**: Install the official library via pip:
    ```bash
    pip3 install internetarchive
    ```
3.  **Permissions**: The tool requires read/write access to its own directory to maintain the history of discovered items and update the search list.

## Configuration and Search Syntax
The core of the tool's logic resides in the `Source/searchlist.txt` file.

*   **Keyword Matching**: Enter one keyword or phrase per line.
*   **Exact Phrases**: Use double quotes for exact matches (e.g., `"Atari 1200XL"`). Without quotes, the search treats words as an "AND" query, potentially finding them far apart in a document.
*   **Specificity**: Avoid generic terms like "history" or "books." Use specific names, locations, or technical terms to prevent being overwhelmed by irrelevant daily hits.

## Execution Patterns
Tiara is designed for headless, automated execution.

### Manual Run
To trigger a search manually and generate the findings report:
```bash
python3 Source/tiara.py
```

### Automated Daily Updates
The most effective way to use tiara is via `crontab`. To receive a daily update at 8:00 AM, add the following entry to your crontab:
```text
0 8 * * * cd /path/to/tiara && /usr/bin/python3 Source/tiara.py
```

## Output and Notifications
*   **HTML Report**: Findings are automatically formatted into an HTML file within the tool's directory.
*   **Email Integration**: Tiara can be configured to send these findings via SendGrid or the local system's mail agent. This is particularly useful when running the tool on a remote server or VPS.

## Expert Tips
*   **Throttling**: The tool includes built-in sleep commands to throttle searches. Do not remove these, as aggressive searching can lead to IP rate-limiting by the Internet Archive.
*   **History Management**: If you need to "reset" your research and see all items again, you must clear the local history file (typically found in the tool's data directory) that tracks previously seen identifiers.
*   **Thumbnail Support**: The tool generates thumbnail URLs for discovered items, making the HTML report a visual dashboard for new archive entries.

## Reference documentation
- [savetz/tiara: The Internet Archive Research Assistant](./references/github_com_savetz_tiara.md)