---
name: fitbit
description: This tool deploys and maintains a data pipeline for retrieving health metrics from Fitbit servers and visualizing them in Grafana. Use when user asks to deploy the fitbit-grafana pipeline, configure OAuth 2.0 tokens, manage InfluxDB storage, or troubleshoot data visualization dashboards.
homepage: https://github.com/arpanghosh8453/fitbit-grafana
---


# fitbit

## Overview

This skill provides procedural knowledge for deploying and maintaining the `fitbit-grafana` data pipeline. It enables the automated retrieval of comprehensive health metrics—including intraday heart rate, sleep regularity, SpO2, and breathing rates—from Fitbit's servers. By utilizing this skill, you can manage OAuth 2.0 token refreshes, configure time-series database storage (InfluxDB), and ensure high-fidelity data visualization within Grafana dashboards.

## Tool-Specific Best Practices

### OAuth 2.0 Configuration
*   **Application Type**: When creating your application on the Fitbit Developer Portal, you must select **Personal** as the Application Type. Selecting "Server" or "Client" will result in a `KeyError: 'activities-heart-intraday'` because intraday data access is restricted to Personal apps.
*   **Redirect URL**: Use a dummy URL like `http://localhost:8888` or `http://localhost:8000`. The actual content of the page doesn't matter; you only need to copy the tokens from the URL after the redirect.
*   **Access Type**: Set the default access type to **Read Only**.

### Database Selection and Performance
*   **Version Recommendation**: Use **InfluxDB 1.11** for the most stable experience. While 2.x and 3.x are supported, the Grafana dashboards for this tool are optimized for InfluxQL.
*   **InfluxDB 3.0 Limits**: Be aware that InfluxDB 3.x OSS has a default query time limit of 72 hours. For long-term trend visualization, InfluxDB 1.11 is preferred to avoid OOM (Out of Memory) errors associated with extending this limit.

### Deployment and Permissions
*   **Volume Ownership**: The Docker container runs as user **UID 1000**. Before launching, you must create the `logs` and `tokens` directories and change their ownership: `chown -R 1000:1000 logs tokens`. Failure to do this results in read/write permission denied errors.
*   **Plugin Requirements**: Heatmap panels in Grafana require the `marcusolsson-hourly-heatmap-panel` plugin. Install it via the environment variable `GF_PLUGINS_PREINSTALL` or manually inside the container.

## Common CLI Patterns

### Initial Token Setup
To perform the initial authentication and save the refresh token to local storage, use the interactive run command:
`docker compose run --rm fitbit-fetch-data`
Follow the prompt to enter the refresh token obtained from the Fitbit OAuth 2.0 tutorial.

### Managing InfluxDB 3.0 Admin Tokens
If using the experimental InfluxDB 3.0 support, generate the required admin token using:
`docker exec influxdb influxdb3 create token --admin`
Store this token immediately in the `INFLUXDB_V3_ACCESS_TOKEN` environment variable, as it cannot be retrieved again.

### Troubleshooting and Logs
To debug API request failures or permission issues, follow the container logs in real-time:
`docker compose logs --follow`

### Manual Data Backfilling
To fetch historical data or specific ranges, utilize the `MANUAL_START_DATE` environment variable within your environment configuration to trigger the backfilling logic during the next fetch cycle.

## Reference documentation
- [Fitbit-Grafana Main Documentation](./references/github_com_arpanghosh8453_fitbit-grafana.md)
- [InfluxDB Schema and Measurements](./references/github_com_arpanghosh8453_fitbit-grafana_commits_main.md)