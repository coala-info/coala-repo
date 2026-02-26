---
name: snakemake-interface-report-plugins
description: This package provides the official API and base classes for developing external reporting plugins for the Snakemake workflow engine. Use when user asks to create a custom report plugin, implement a reporter class, or define plugin-specific command-line settings.
homepage: https://github.com/snakemake/snakemake-interface-report-plugins
---


# snakemake-interface-report-plugins

## Overview

The `snakemake-interface-report-plugins` package serves as the official bridge between the Snakemake core engine and external reporting tools. It provides a stable API that ensures custom report plugins can access workflow metadata, job results, and configuration settings consistently. By using this interface, developers can create plugins that automatically integrate with Snakemake's command-line interface, allowing users to configure report-specific parameters directly via standard Snakemake flags.

## Implementation Patterns

### Plugin Skeleton
To create a compliant report plugin, you must implement a `Reporter` class and optionally a `ReportSettings` class. It is highly recommended to use `Snakedeploy` to generate the initial package structure.

```python
from dataclasses import dataclass, field
from typing import Optional
from snakemake_interface_report_plugins.reporter import ReporterBase
from snakemake_interface_report_plugins.settings import ReportSettingsBase

@dataclass
class ReportSettings(ReportSettingsBase):
    # Settings automatically become CLI arguments: 
    # --report-<reporter-name>-<param-name>
    myparam: Optional[int] = field(
        default=None, 
        metadata={"help": "Description for the CLI help text"}
    )

class Reporter(ReporterBase):
    def __post_init__(self):
        # Use __post_init__ for initialization. 
        # Do NOT override __init__.
        # Access settings via self.settings.myparam
        pass

    def render(self):
        # Core logic to generate the report
        # Use attributes from ReporterBase (e.g., self.dag, self.workflow)
        ...
```

### Defining Plugin Settings
The `ReportSettings` class uses Python dataclasses to map code variables to Snakemake CLI flags.

*   **Naming Convention**: A field named `output_format` in a plugin named `myplugin` will be exposed as `--report-myplugin-output-format`.
*   **Required Fields**: Set `"required": True` in the field metadata to force user input when the reporter is active.
*   **Sensitive Data**: Use `"env_var": True` in metadata for passwords or API keys. This maps the setting to `SNAKEMAKE_REPORT_<REPORTER>_<PARAM>`, all uppercase.
*   **Complex Types**: If a setting is not a simple string/int, provide `parse_func` and `unparse_func` in the metadata to handle CLI string conversion.

## Best Practices

*   **Initialization**: Always use `__post_init__` for setup logic. The base class `__init__` handles the complex injection of workflow objects and settings; overriding it will break the plugin.
*   **Attribute Access**: The `ReporterBase` provides several critical attributes out of the box:
    *   `self.settings`: The instance of your `ReportSettings`.
    *   `self.dag`: The directed acyclic graph of the workflow.
    *   `self.workflow`: The Snakemake workflow object.
*   **Error Handling**: Import and raise `WorkflowError` from `snakemake_interface_common.exceptions` for user-facing errors during the rendering process.
*   **Default Values**: Ensure all fields in `ReportSettings` have a default value (usually `None` or `False`) to prevent instantiation errors when the plugin is loaded but not actively used.

## CLI Integration Patterns

When a plugin is installed, Snakemake dynamically extends its help menu. 

*   **Discovery**: Snakemake identifies plugins based on the entry point naming convention (typically `snakemake_report_plugin_<name>`).
*   **Flag Usage**: Users invoke your plugin using `--report <name>`.
*   **Parameter Passing**: Any attributes defined in your `ReportSettings` dataclass are automatically prefixed with `--report-<name>-`.

## Reference documentation
- [Snakemake interface for report plugins](./references/github_com_snakemake_snakemake-interface-report-plugins.md)
- [Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-interface-report-plugins_overview.md)