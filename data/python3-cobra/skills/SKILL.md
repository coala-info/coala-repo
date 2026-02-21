---
name: python3-cobra
description: Cobra is a high-performance, realtime messaging server built with Python 3, WebSockets, and Redis.
homepage: https://github.com/machinezone/cobra
---

# python3-cobra

# python3-cobra

## Overview
Cobra is a high-performance, realtime messaging server built with Python 3, WebSockets, and Redis. It functions as both a PubSub system and a key-value store, allowing clients to broadcast messages to channels or record and retrieve data using keys. This skill provides the necessary procedural knowledge to initialize the server, manage authentication, and perform core messaging operations via the command line.

## Core Operations
Cobra supports four primary operations:
1. **publish**: Sends data to a specific channel for real-time broadcast.
2. **subscribe**: Listens for and receives real-time events from a channel.
3. **write**: Records data addressed by a specific key (similar to a dictionary or memcached).
4. **read**: Retrieves previously recorded data by its key.

## CLI Usage Patterns

### Server Initialization and Setup
Before running the server, you must generate a configuration file which stores roles, secrets, and application settings.
- Run `cobra init` to generate the default configuration file at `~/.cobra.yaml`.
- Use `cobra secret` to generate new secrets for secure authentication.

### Running the Server
- Start the server using the command: `cobra run`.
- For production environments, ensure a Redis instance (version 5 or higher) is available to support Redis Streams and message history.

### Health and Monitoring
- Check the status of a running instance: `cobra health --endpoint <ws_url> --appkey <key> --rolesecret <secret> --rolename <name>`.
- Use `cobra monitor` to observe server activity in real-time.

### Testing Messaging
- **Subscribe**: Open a terminal and run `cobra subscribe --channel <name>` to listen for messages.
- **Publish**: In another terminal, use `cobra publish --channel <name> --data <message>` to broadcast data.
- **Bavarde**: For a higher-level test, use the built-in chat client `bavarde client` to verify end-to-end connectivity.

## Production Best Practices

### Scalability
To scale Cobra, you can point it to multiple Redis instances using environment variables:
- Set `COBRA_REDIS_URLS` to a semicolon-separated list of Redis URLs (e.g., `redis://redis1;redis://redis2`).

### Network Configuration
By default, the server may bind to localhost. For external access:
- Set `COBRA_HOST` to `0.0.0.0`.

### Configuration Management
In containerized environments where mounting volumes is difficult, you can pass the configuration as a base64-encoded string:
- Set `COBRA_APPS_CONFIG_CONTENT` to the output of `gzip -c ~/.cobra.yaml | base64`.

## Reference documentation
- [Cobra Main README](./references/github_com_machinezone_cobra.md)
- [Cobra Documentation Index](./references/github_com_machinezone_cobra_tree_master_docs.md)