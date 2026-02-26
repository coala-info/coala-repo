---
name: snakeparse
description: Snakeparse is a wrapper for Snakemake that provides a command-line interface for executing workflows using Python's argparse logic. Use when user asks to run Snakemake workflows with custom command-line arguments, manage multiple pipelines, or define argument parsers within Snakefiles.
homepage: https://github.com/nh13/snakeparse
---


# snakeparse

## Overview
Snakeparse is a wrapper for Snakemake that simplifies the execution of workflows by providing a robust command-line interface. Instead of requiring users to pass complex `--config` key-value pairs or manually edit configuration files, Snakeparse allows developers to define arguments using Python's `argparse` logic directly within or alongside their Snakefiles. This makes workflows more accessible to non-programmers and organizes multiple pipelines into a cohesive toolset similar to established bioinformatics suites.

## CLI Usage Patterns

### Executing a Single Workflow
To run a specific Snakefile and pass custom arguments, use the `--snakefile` flag followed by a double dash `--` to separate snakeparse options from your workflow arguments.

```bash
snakeparse --snakefile workflow.smk -- --sample_id S1 --threads 8
```

### Managing Multiple Workflows
If you have a directory of workflows, you can use globs to load them all. Snakeparse will use the workflow name (often derived from the filename or a class name) to determine which one to execute.

```bash
snakeparse --snakefile-globs "pipelines/*.smk" -- MyWorkflowName --input data.fq
```

### Viewing Help
To see the auto-generated help message for a specific workflow's arguments:

```bash
snakeparse --snakefile workflow.smk -- --help
```

## Workflow Integration Best Practices

### Defining the Parser
To enable CLI parsing, you must define a `snakeparser` method within your Snakefile. This method should return a parser object populated with your desired arguments.

```python
from snakeparse.parser import argparser

def snakeparser(**kwargs):
    '''Defines the CLI arguments for this workflow.'''
    p = argparser(**kwargs)
    p.parser.add_argument('--input', help='Path to input file', required=True)
    p.parser.add_argument('--threshold', type=float, default=0.05)
    return p

# Initialize and parse the config
args = snakeparser().parse_config(config=config)

# Access arguments directly in the Snakefile
rule all:
    input: args.input
```

### Expert Tips
- **The Double Dash**: Always remember the `--` separator. Arguments before it are for `snakeparse` and `snakemake`; arguments after it are passed to your custom `argparser`.
- **Config Injection**: Snakeparse works by injecting parsed arguments into the Snakemake `config` object. Ensure your `snakeparser().parse_config(config=config)` call is at the top of your Snakefile to make `args` available to all rules.
- **Naming Conventions**: When using `--snakefile-globs`, the command name used to trigger a workflow is typically the CamelCase version of the filename (e.g., `process_data.smk` becomes `ProcessData`) unless explicitly defined in a `SnakeParser` subclass.

## Reference documentation
- [Snakeparse GitHub Repository](./references/github_com_nh13_snakeparse.md)
- [Bioconda Snakeparse Overview](./references/anaconda_org_channels_bioconda_packages_snakeparse_overview.md)