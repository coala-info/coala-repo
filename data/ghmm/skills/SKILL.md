---
name: ghmm
description: ghmm is a relay server that transforms GitHub webhook events into formatted messages for Mattermost channels. Use when user asks to bridge GitHub and Mattermost, receive real-time repository notifications in chat, or map specific GitHub events to different Mattermost channels.
homepage: https://github.com/ulfsauer0815/ghmm
---


# ghmm

## Overview
ghmm is a specialized relay server designed to bridge GitHub and Mattermost. It listens for GitHub webhook events—such as push events, pull requests, and issue comments—and transforms them into formatted messages delivered to specific Mattermost channels. This tool is essential for teams that require real-time visibility into their development lifecycle directly within their chat environment. It supports granular mapping, allowing different repositories or organizations to post to different channels.

## Deployment Patterns

### Docker Deployment
The most efficient way to run ghmm is via the official Docker image.
- **Image**: `UlfS/ghmm`
- **Execution**: Use `docker-compose up -d app` to run the service in the background.
- **Environment Loading**: Ensure configuration variables are exported or defined in a `.env` file before starting the container.

### Heroku Deployment
ghmm can be deployed as a web dyno on Heroku using a Haskell buildpack.
1. Create the app with the specific buildpack: `heroku create --buildpack https://github.com/UlfS/heroku-buildpack-stack.git`
2. Set required config vars: `heroku config:set MATTERMOST_URL=<url> MATTERMOST_API_KEY=<key>`
3. Scale the dyno: `heroku scale web=1`

### Native Build (Stack)
For local development or custom server environments:
- **Build**: `stack build`
- **Run**: `stack exec ghmm-exe <path_to_config_file>`

## Configuration Best Practices

### Configuration Methods
- **File-based (Recommended)**: Use a configuration file (YAML or JSON) passed as the first argument to the executable. This is the only method that supports advanced features like repository-to-channel mapping.
- **Environment-based**: Use for simple setups or when deploying to platforms like Heroku. Note that this method is limited and does not support per-repository routing.

### Key Configuration Parameters
- **mattermost.url**: The base URL of your Mattermost instance.
- **mattermost.apiKey**: The unique token found at the end of your Mattermost incoming webhook URL.
- **github.secret**: An optional but highly recommended shared secret to validate that incoming requests originate from GitHub.
- **repositories**: A mapping object where keys are `Organization/Repository` and values define the target `channel`.
- **_default**: A reserved key used to route events from any repository not explicitly defined in the mapping.

## Webhook Setup
To activate the integration, configure a webhook in your GitHub repository settings:
- **Payload URL**: The public address where your ghmm instance is reachable.
- **Content type**: Must be set to `application/json`.
- **Secret**: Must match the `github.secret` defined in your ghmm configuration.
- **Events**: Select "Individual events" and ensure Push, Pull Request, and Issues are enabled.

## Expert Tips
- **Static Addressing**: When testing locally, use tunneling services like `ngrok` or `beame-insta-ssl`. Using a service that provides a static address prevents the need to update GitHub webhook URLs every time the local process restarts.
- **Bot Customization**: You can override the default bot identity by setting `bot.username` and `bot.iconUrl` in the configuration file to make notifications more recognizable.
- **Log Levels**: For production, set `logging.priority` to `ERROR` or `CRITICAL` to minimize log noise. Use `DEBUG` only during initial setup or troubleshooting.

## Reference documentation
- [GitHub integration for Mattermost](./references/github_com_ulfsauer0815_ghmm.md)