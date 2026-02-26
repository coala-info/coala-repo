---
name: ray-extra
description: ray-extra automates the scraping, verification, and organization of proxy configuration strings from Telegram channels into protocol-specific subscription files. Use when user asks to scrape VPN configurations, verify proxy connectivity, or generate updated subscription feeds for protocols like VLESS, VMess, and Trojan.
homepage: https://github.com/arshiacomplus/v2rayExtractor
---


# ray-extra

## Overview

`ray-extra` is a specialized utility for maintaining high-availability proxy subscription feeds. It automates the process of scraping configuration strings from Telegram channels, verifying their connectivity via a built-in checker, and organizing the functional results into protocol-specific subscription files. This tool is essential for users or administrators who need to provide or consume updated, verified VPN configurations without manual intervention.

## Core Workflows

### Initial Setup
Before running the extractor, ensure the environment is prepared:
1. Install required Python dependencies: `pip install -r requirements.txt`.
2. Ensure the directory structure for outputs (e.g., `mix/`, `loc/`) exists or is writable by the script.

### Execution
Run the primary extraction and checking logic using the Python interpreter:
`python main.py`

This command triggers the full pipeline:
- Scrapes configurations from defined Telegram sources.
- Filters and validates configs using the `sub-checker` module.
- Generates updated HTML subscription files for each protocol.

## Configuration and Environment Variables

The tool relies on environment variables for its Telegram integration features. These must be set in the shell environment before execution:

- `SEND_TO_TELEGRAM`: Set to `true` to enable automated broadcasting of results.
- `TELEGRAM_BOT_TOKEN`: The API token provided by BotFather.
- `TELEGRAM_CHAT_ID`: The username or ID of the primary channel for summary reports (e.g., `@your_summary_channel`).
- `TELEGRAM_CHANNEL_ID`: The username or ID of the channel where grouped, healthy configurations are posted (e.g., `@your_config_channel`).

## Output Management

The tool generates several HTML files that serve as subscription endpoints for VPN clients. Access these files directly after a successful run:

- **Protocol-Specific Links**: `vless.html`, `vmess.html`, `trojan.html`, `ss.html`, `hy2.html`.
- **Aggregated Link**: `mix/sub.html` (contains a combination of all working protocols).

## Best Practices

- **Validation Frequency**: Run the script via a scheduler (like a cron job or GitHub Action) to ensure subscription links remain populated with working proxies, as these configurations often have short lifespans.
- **Admin Permissions**: If using the Telegram broadcast feature, ensure the bot is added as an administrator to both the summary and config channels with "Post Messages" permissions.
- **Dependency Management**: Regularly check the `requirements.txt` for updates to the underlying scraping or checking libraries to maintain compatibility with Telegram's web interface.

## Reference documentation
- [Main Repository Overview](./references/github_com_arshiacomplus_v2rayExtractor.md)
- [Workflow and Environment Setup](./references/github_com_arshiacomplus_v2rayExtractor_tree_main_.github_workflows.md)