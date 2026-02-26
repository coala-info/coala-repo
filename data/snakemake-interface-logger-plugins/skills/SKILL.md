---
name: snakemake-interface-logger-plugins
description: This package provides the Python interface for developing custom Snakemake logger plugins to capture and redirect execution events. Use when user asks to create a custom log handler, migrate legacy log handler scripts to the modern plugin architecture, or implement specialized logging for Snakemake events.
homepage: https://github.com/snakemake/snakemake-interface-logger-plugins
---


# snakemake-interface-logger-plugins

## Overview
The `snakemake-interface-logger-plugins` package provides the foundational Python interface for building Snakemake logger plugins. This skill guides the implementation of custom log handlers that can capture, format, and redirect Snakemake's internal execution events. It is essential for developers moving away from legacy `--log-handler-script` implementations toward the modern, stable plugin architecture.

## Implementation Patterns

### Core Plugin Structure
Every logger plugin must implement two primary classes: a settings class and a handler class.

1.  **Settings Class**: Inherit from `LogHandlerSettingsBase`. Use `dataclasses.field` to define parameters.
    *   Use `metadata={"help": "..."}` for CLI documentation.
    *   Use `metadata={"env_var": True}` only for sensitive data like credentials.
    *   Required fields should be marked with `metadata={"required": True}`.

2.  **Handler Class**: Inherit from `LogHandlerBase`.
    *   **Initialization**: Do not override `__init__`. Use `__post_init__(self)` to set up additional attributes.
    *   **Settings Access**: Access plugin-specific settings via `self.settings` and general Snakemake output settings via `self.common_settings`.
    *   **Mandatory Method**: You must implement `emit(self, record)`.

### Handling LogRecords
Snakemake logs are passed as standard Python `LogRecord` objects but contain specialized attributes:
*   `record.event`: Indicates the type of event (e.g., job start, error, progress).
*   `record.msg`: The primary log message.

### Plugin Properties
Override these properties in your `LogHandler` class to inform Snakemake of your plugin's behavior:

*   `writes_to_stream`: Return `True` if outputting to stdout/stderr. Snakemake will then disable its own stderr logging to prevent duplication.
*   `writes_to_file`: Return `True` if logging to a file. If `True`, you must provide a `self.baseFilename` attribute.
*   `has_filter` / `has_formatter`: Return `True` if you provide custom logic; otherwise, Snakemake attaches its `DefaultFilter` or `DefaultFormatter`.
*   `needs_rulegraph`: Return `True` if your plugin requires access to the workflow DAG.

## Migration from Legacy Scripts
When converting an old `--log-handler-script` to a plugin:
1.  Map the dictionary keys from the old `log_handler(msg)` function to the attributes of the `LogRecord` object.
2.  Move setup logic (like opening connections) into `__post_init__`.
3.  Move the core logic into the `emit` method.

## Best Practices
*   **Scaffolding**: Use the `poetry-snakemake-plugin` to generate the initial project structure and automated testing suite.
*   **Environment Variables**: Avoid manual environment variable parsing. Let the interface handle it via the `env_var` metadata in your settings class.
*   **Formatting**: If your plugin is intended for terminal output, consider using the `rich` library within your `emit` method for enhanced formatting.

## Reference documentation
- [Snakemake Logger Plugin Interface Overview](./references/github_com_snakemake_snakemake-interface-logger-plugins.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_snakemake-interface-logger-plugins_overview.md)