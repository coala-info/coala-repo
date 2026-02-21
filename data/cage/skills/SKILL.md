---
name: cage
description: The `cage` tool (internally referred to as `cagent`) is a declarative framework for creating and deploying intelligent AI agents.
homepage: https://github.com/docker/cagent
---

# cage

## Overview
The `cage` tool (internally referred to as `cagent`) is a declarative framework for creating and deploying intelligent AI agents. It provides a runtime environment where agents can collaborate, utilize a rich ecosystem of tools (including MCP servers), and perform complex reasoning tasks. This skill focuses on the command-line interface (CLI) for initializing, executing, and serving these agents.

## CLI Usage and Commands

### Core Execution
*   **Run the default agent**: Execute `cage run` in a directory containing an agent configuration to start the primary assistant.
*   **Run a specific configuration**: Use `cage run <filename.yaml>` to launch a specific agent definition.
*   **Run from the catalog**: Access pre-built agents by running `cage run agentcatalog/<agent-name>` (e.g., `cage run agentcatalog/pirate`).
*   **Interactive Creation**: Use `cage new` to start an interactive wizard that generates a new agent configuration based on your requirements.

### Advanced Operations
*   **API Mode**: Run `cage api` to expose the agent via a REST API. By default, this serves on `127.0.0.1:8080`.
*   **Agent-to-Agent (A2A)**: Use `cage a2a` to enable communication between different agent instances.
*   **MCP Integration**: Use `cage mcp` to run the tool in Model Context Protocol mode, allowing it to act as a host or client for standardized tool sets.
*   **Multi-turn Execution**: Use `cage exec` or `cage run` for persistent sessions that support multiple turns of interaction.

## Environment Configuration
Before running agents, ensure the necessary provider API keys are exported to your environment:
*   **OpenAI**: `export OPENAI_API_KEY=sk-...`
*   **Anthropic**: `export ANTHROPIC_API_KEY=sk-...`
*   **Google Gemini**: `export GOOGLE_API_KEY=...`
*   **Local Models**: If using Docker Model Runner (DMR) for local execution, ensure the DMR service is accessible.

## Best Practices and Expert Tips
*   **Registry Integration**: Agents can be packaged as OCI artifacts. You can pull and run agents directly from a registry using standard image naming conventions.
*   **TUI Responsiveness**: When using the Terminal User Interface (TUI), use the built-in navigation shortcuts to scroll through long reasoning chains or "think" blocks.
*   **Session Management**: Use the `/compact` command within interactive sessions to manage context window limits without losing critical state.
*   **Tool Troubleshooting**: If an MCP toolset fails to load, verify the connection string or Docker image reference used in the toolset definition.
*   **Port Management**: If running multiple services (API, A2A, MCP), use flags to specify different ports to avoid address-already-in-use errors, as these services default to similar port ranges.

## Reference documentation
- [Docker cagent README](./references/github_com_docker_cagent.md)