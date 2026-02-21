---
name: staphb_toolkit
description: The StaPH-B ToolKit (staphb-tk) is a wrapper for a suite of open-source bioinformatics tools and workflows maintained by the State Public Health Bioinformatics (StaPH-B) consortium.
homepage: https://staphb.org/staphb_toolkit/
---

# staphb_toolkit

## Overview
The StaPH-B ToolKit (staphb-tk) is a wrapper for a suite of open-source bioinformatics tools and workflows maintained by the State Public Health Bioinformatics (StaPH-B) consortium. It eliminates the complexity of manual container mounting and dependency management by automatically handling file system paths and container execution via Docker or Singularity. This skill provides the procedural knowledge to execute individual applications, run multi-step genomic workflows, and manage environment-specific configurations.

## Core Command Patterns

### Basic Application Execution
The standard syntax follows a `staphb-tk <tool> <args>` pattern.
```bash
# List all available tools
staphb-tk --list_tools

# Run a specific tool (e.g., BWA)
staphb-tk bwa mem ref.fa reads_R1.fq reads_R2.fq
```

### Handling Paths and Pipes
Because tools run inside containers, specific syntax is required for internal paths and shell redirections:
- **Internal Paths**: Use the `$` prefix to indicate a path exists inside the container (e.g., a bundled database).
- **Escaping Pipes**: Use a backslash `\` before pipes (`|`) or redirections (`>`, `<`) to ensure they are executed inside the container rather than by the host shell.

```bash
# Example: Using internal database and escaped redirection
staphb-tk mash dist $/db/RefSeqSketchesDefaults.msh sample.msh \> distances.tab
```

## Running Workflows
The toolkit provides access to curated Nextflow pipelines.

### Workflow Management
- **List Workflows**: `staphb-tk --list_workflows`
- **Get Help**: `staphb-tk <workflow_name> -h`
- **Version Control**: Use `-wv` for the workflow version and `-nv` for the Nextflow version.

```bash
# Run a specific version of the Cecret workflow
staphb-tk -nv 22.04.5 -wv 3.3.20220810 cecret --input ./reads/
```

### Configuration
To customize a workflow, first extract the default configuration, modify it, and then run the workflow with the `-c` flag.
```bash
# 1. Download configuration
staphb-tk cecret --get_configuration

# 2. Run with custom config
staphb-tk cecret -c custom_cecret.config --input ./reads/
```

## Best Practices and Tips
- **Automatic Pathing**: The toolkit automatically mounts host directories. Ensure you are running the command from a parent directory that contains all necessary input files to avoid mounting issues.
- **Updates**: Keep the toolkit and its container references current using `staphb-tk --update`.
- **Permissions**: Ensure the user is in the `docker` group to avoid needing `sudo` for every toolkit command.
- **Resource Allocation**: When running workflows, check the specific workflow help (`-h`) for flags related to CPU and memory limits, as these are passed directly to the underlying Nextflow engine.

## Reference documentation
- [Using the ToolKit](./references/staphb_org_staphb_toolkit_using_tk.md)
- [Installing the ToolKit](./references/staphb_org_staphb_toolkit_install.md)
- [StaPH-B ToolKit Workflows](./references/staphb_org_staphb_toolkit_workflows.md)