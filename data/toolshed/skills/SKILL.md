---
name: toolshed
description: Toolshed provides Unix-like utilities within the Elixir interactive shell for debugging and system exploration. Use when user asks to monitor processes, explore file systems, list hardware devices, diagnose network issues, retrieve external data, execute system commands, or get help on available commands.
homepage: https://github.com/elixir-toolshed/toolshed
---


# toolshed

## Overview
Toolshed is a collection of IEx helpers that provides a Unix-like toolbox within the Elixir interactive shell. It is designed to simplify debugging and system exploration by implementing common shell utilities as Elixir functions. This is especially valuable when working on Nerves devices or remote production nodes where a standard bash/zsh prompt is either unavailable or difficult to access.

## Usage and Best Practices

### Getting Started
To enable the helpers in your current IEx session, run:
```elixir
use Toolshed
```
For permanent access, add `use Toolshed` to your `.iex.exs` file.

### System Exploration
*   **Process Monitoring**: Use `top()` to see a live-updating list of processes sorted by CPU and memory usage. This is the Elixir equivalent of the Unix `top` command.
*   **File System**: Use `tree()` to visualize directory structures or `cmd("ls -al")` for standard directory listings.
*   **Hardware**: On supported systems (like Nerves), use `lsusb()` to list connected USB devices.

### Network Diagnostics
*   **Connectivity**: Use `ping "hostname"` for ICMP pings or `tcping "hostname", port` to check if a specific service is reachable.
*   **Interfaces**: Run `ifconfig()` to view network interface configurations and IP addresses.
*   **Performance**: Execute `speed_test()` to measure network throughput directly from the node.
*   **External Data**: Use `weather()` to get a quick forecast or `geo()` for geolocation information based on the node's IP.

### Expert Tips
*   **Command Execution**: The `cmd/1` function is a powerful wrapper for running arbitrary system commands. It returns the exit code and prints the output to the console.
*   **Documentation**: If you forget a command name or its arguments, run `h Toolshed` within IEx to see the full list of available helpers and their descriptions.
*   **Non-Intrusive Usage**: If you do not want to import all helpers into your namespace with `use`, you can call them directly via the module: `Toolshed.ping("google.com")`.

## Reference documentation
- [Toolshed README](./references/github_com_elixir-toolshed_toolshed.md)