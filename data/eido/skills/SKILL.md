---
name: eido
description: Eido is a framework and command-line tool for managing SQLite-based personal knowledge bases and processing Portable Encapsulated Projects. Use when user asks to create tables with schema inference, import JSON data, manage relay service messages, or validate and convert PEP formats.
homepage: https://github.com/mayneyao/eidos
---


# eido

## Overview
Eidos is an extensible, local-first framework designed to transform SQLite into a personal knowledge base. This skill facilitates the use of the `eidos` CLI and its associated SDK to automate data management tasks. Use this skill when you need to programmatically interact with Eidos tables, migrate data from JSON sources, or develop custom scripts for data processing and relay handling.

## CLI Usage Patterns

### Table Management
The `eidos` CLI allows for rapid table creation and data ingestion.

*   **Create with Schema Inference**: Automatically generate a table structure by piping JSON data.
    `cat sample.json | eidos table create "My New Table"`
*   **Explicit Schema Creation**: Define field types during creation.
    `eidos table create "Tasks" --fields "title:text,done:checkbox,priority:select"`
*   **Template-based Creation**: Create a new table based on an existing table's structure.
    `eidos table create "2026 Goals" --template tb_source_id`
*   **Data Import**: Import JSON files into existing tables.
    `eidos table import tb_target_id --file data.json`
    `cat data.json | eidos table tb_target_id`

### System Maintenance
*   **Node Uniqueness**: Ensure "Node name uniqueness validation" is enabled in Space Data Management to use the CLI effectively.
*   **Repair Tables**: Use the `fix` command in the CMDK (Command Palette) within the UI if tables become unresponsive after schema changes.

## Relay Service Integration
Relay acts as a cloud-based message queue that buffers data (webhooks, IoT, Telegram bots) until the local Eidos instance is online to process it.

### Relay Handlers
To process incoming Relay messages, implement a `relayHandler` script:

1.  **Define Metadata**: Specify the channel and function name.
2.  **Batch Processing**: Relay delivers messages in batches for efficiency.
3.  **File System Access**: Use `eidos.space.fs` to write processed data directly to local markdown or JSON files.

### Manual Message Pulling
For custom integrations outside of the Eidos script environment, use the HTTP API:
*   **Pull**: `POST https://api.eidos.space/v1/relay/channels/{channel}/messages/pull`
*   **Acknowledge**: `POST https://api.eidos.space/v1/relay/channels/{channel}/messages/ack` (requires `lease_ids`).

## Expert Tips
*   **Prisma-style SDK**: When writing internal Eidos scripts, use the `eidos.space.table("tableName")` client for type-safe CRUD operations (e.g., `.findMany`, `.create`, `.update`).
*   **Local-First Performance**: Since data is stored in a local SQLite database, batch your `writeFile` operations in Relay handlers to minimize disk I/O overhead.
*   **Mounting**: Use the `/@/{mount-name}` pattern to access files outside the standard Eidos workspace via the File System API.



## Subcommands

| Command | Description |
|---------|-------------|
| eido_convert | Convert PEP format using filters |
| eido_inspect | Inspect a PEP |
| eido_validate | Validate a PEP or its components |

## Reference documentation
- [Eidos Changelog](./references/eidos_space_changelog.md)
- [Eidos Relay Service](./references/eidos_space_relay.md)
- [Eidos GitHub Repository](./references/github_com_mayneyao_eidos.md)