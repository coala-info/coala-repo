---
name: cascade-config
description: `cascade-config` is a Python utility that simplifies the management of application settings by layering multiple configuration sources.
homepage: https://github.com/RalfG/cascade-config
---

# cascade-config

## Overview
`cascade-config` is a Python utility that simplifies the management of application settings by layering multiple configuration sources. It follows a hierarchical "last-in-priority" logic, where each subsequent source updates or overrides the existing configuration. This allows for a clean separation between hardcoded defaults, environment-specific files, and runtime overrides, while ensuring the final result adheres to a predefined JSON schema.

## Core Workflow

### 1. Initialization and Validation
Always initialize the `CascadeConfig` object with a validation schema to ensure the final configuration is predictable and type-safe.

```python
from cascade_config import CascadeConfig

# Initialize with a JSON schema for automatic validation
cascade_conf = CascadeConfig(validation_schema="schema.json")
```

### 2. Adding Configuration Sources
Add sources in order of increasing priority. The standard pattern is:
1.  **Defaults**: Hardcoded or internal JSON files.
2.  **User/System Config**: External JSON files provided by the user.
3.  **Runtime Overrides**: Python dictionaries or CLI arguments.

```python
# 1. Lowest priority (Defaults)
cascade_conf.add_json("defaults.json")

# 2. Medium priority (User overrides)
cascade_conf.add_json("/etc/app/config.json")

# 3. Highest priority (Runtime/Manual)
cascade_conf.add_dict({"debug": True})
```

### 3. Parsing the Result
The `.parse()` method merges all sources and returns a single dictionary. If a schema was provided during initialization, validation occurs during this step.

```python
config = cascade_conf.parse()
# 'config' is now a standard Python dictionary
```

## Advanced Configuration Options

### Handling Null Values
By default, you can control whether a `None` value in a higher-priority source should overwrite an existing value in the configuration.
- Use the `none_overrides_value` parameter if you need to explicitly nullify settings from higher-priority sources.

### Recursion Depth
For deeply nested configuration structures, you can manage the complexity of the merge:
- Use `max_recursion_depth` to prevent infinite loops or excessive processing in highly complex nested dictionaries.

## Expert Tips
- **Schema First**: Always define your `validation_schema` before adding sources. This catches configuration errors early in the development cycle rather than at runtime.
- **Hierarchical Strategy**: Treat `add_json` calls as layers. If you have a "site-wide" config and a "user-specific" config, always add the site-wide one first.
- **CLI Integration**: When building CLI tools, use `add_dict` to inject flags parsed by `argparse` as the final, highest-priority layer in the cascade.

## Reference documentation
- [Overview](./references/anaconda_org_channels_bioconda_packages_cascade-config_overview.md)
- [GitHub Repository](./references/github_com_RalfG_cascade-config.md)