---
name: firecloud
description: The firecloud skill provides a programmatic and command-line interface for interacting with the FireCloud and Terra execution engines to automate workspace and workflow management. Use when user asks to manage workspaces, monitor workflows, perform batch operations on data entities, or clean up cloud storage costs using the mop utility.
homepage: https://github.com/broadinstitute/fiss
metadata:
  docker_image: "quay.io/biocontainers/firecloud:0.16.38--pyhdfd78af_0"
---

# firecloud

## Overview

The `firecloud` skill (FISS) provides a programmatic and command-line interface for interacting with the FireCloud/Terra execution engine. It is designed for biomedical researchers and bioinformaticians who need to automate repetitive tasks—such as workspace creation, entity management, and workflow monitoring—without navigating the web GUI or writing raw REST API calls. It excels at batch operations across workspaces and managing large-scale data models.

## Configuration and Setup

To avoid passing project and workspace flags for every command, create a configuration file at `$HOME/.fissconfig`.

```ini
[DEFAULT]
project=your-google-billing-project
workspace=your-target-workspace
method_ns=your-method-namespace
```

Verify your active configuration using:
`fissfc config`

## Command Discovery

FISS is self-documenting. Use these flags to explore available functionality:

- **List all commands**: `fissfc -l`
- **Show command help**: `fissfc <command> --help`
- **Inspect implementation**: `fissfc -F <command>` (displays the underlying Python code for that method)

## Common CLI Patterns

### Workspace and Cost Management
- **Check storage usage**: `fissfc space_size`
- **Estimate workspace cost**: `fissfc space_cost`
- **Get storage cost estimates**: `fissfc get_storage_cost`

### Data Entity Operations
- **List entities**: `fissfc entity_list`
- **Delete attributes**: `fissfc attr_delete` (works on samples, pairs, and other entity types)
- **Batch export**: Use `sample_list`, `pair_list`, or `participant_list` to retrieve entity sets.

### Storage Optimization (MOP)
The `mop` command is a critical utility for reducing cloud storage costs by deleting intermediate files (like large BAMs or FASTQs) that are no longer needed after a workflow completes.
- **Run cleanup**: `fissfc mop`
- **Note**: `mop` recurses into arrays and complex data structures to identify files referenced by attributes.

## Python API Usage

For complex automation, use the low-level or high-level Python bindings.

```python
import firecloud.api as fapi

# List workspaces
workspaces = fapi.list_workspaces().json()

# Get specific workspace metadata with field filtering for performance
ws_info = fapi.get_workspace("project-name", "workspace-name", fields="workspace.bucketName,workspace.attributes").json()
```

## Expert Tips

- **Performance**: When calling `get_workspace`, always use the `fields` parameter to limit the returned JSON. This significantly reduces latency for workspaces with large data models.
- **Environment**: If running on a Google VM, ensure `$HOME/.local/bin` is in your `$PATH` if you installed via `pip` without sudo.
- **Supervise Mode**: Use this for monitoring long-running submissions and handling job failures programmatically.

## Reference documentation
- [FISS Overview and CLI Guide](./references/github_com_broadinstitute_fiss.md)
- [FISS Wiki and MOP Utility](./references/github_com_broadinstitute_fiss_wiki.md)
- [Version Tags and API Updates](./references/github_com_broadinstitute_fiss_tags.md)