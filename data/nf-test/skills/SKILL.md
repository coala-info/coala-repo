---
name: nf-test
description: nf-test provides a Domain Specific Language (DSL) to validate Nextflow components in isolation or as full pipelines.
homepage: https://code.askimed.com/nf-test/
---

# nf-test

## Overview
nf-test provides a Domain Specific Language (DSL) to validate Nextflow components in isolation or as full pipelines. It allows for "when/then" style testing where you define inputs and assert expected behaviors. This skill helps you navigate the CLI, structure test files, and implement robust assertions for bioinformatics workflows.

## Core Workflows

### Initialization and Setup
Before writing tests, initialize the environment to create the `nf-test.config` file.
- Run `nf-test init` to set up the project.
- The configuration file defines the test directory (default: `tests/`) and any required plugins.

### Generating Test Templates
Use the generator to create boilerplate code for different Nextflow components:
- **Process:** `nf-test generate process path/to/process.nf`
- **Workflow:** `nf-test generate workflow path/to/workflow.nf`
- **Function:** `nf-test generate function path/to/functions.nf`
- **Pipeline:** `nf-test generate pipeline path/to/main.nf`

### Writing Test Blocks
Tests are structured into `nextflow_process`, `nextflow_workflow`, or `nextflow_pipeline` blocks.
- **when**: Define the input channels or parameters. Use `params` or `input[0]` syntax.
- **then**: Define assertions. Use `assert` for boolean checks or `snapshot()` for regression testing.
- **expect**: An alternative block for defining expected outcomes.

### Common Assertions
- **Success**: `assert process.success` or `assert workflow.success`
- **Output Files**: `assert path(process.out.index.get(0)).exists()`
- **MD5 Checksums**: `assert path(file).md5 == "expected_hash"`
- **JSON/FASTA**: Use `path(file).json` or specialized plugins for deep inspection.

### Snapshot Testing
Snapshots are the preferred way to test complex data structures or large output files.
- Include `snapshot(process.out.version, process.out.results).match()` in the `then` block.
- On the first run, nf-test creates a `.json.snap` file.
- Subsequent runs compare current output against this baseline.
- Update snapshots using `nf-test test --update-snapshot`.

## CLI Usage Patterns
- **Run all tests**: `nf-test test`
- **Run specific test**: `nf-test test tests/my_process.nf.test`
- **List tests**: `nf-test list`
- **Clean temporary files**: `nf-test clean`
- **Check status**: `nf-test status`

## Expert Tips
- **Isolation**: Always mock or provide minimal test data in the `when` block to keep tests fast.
- **Trace Analysis**: Use `workflow.trace` to inspect task execution details like CPU, memory, or exit codes.
- **Plugins**: For specialized files (like FASTA or SAM), ensure the plugin is listed in `nf-test.config` to unlock custom assertion methods.
- **Global Variables**: Define common parameters in the `nf-test.config` to avoid repetition across multiple test files.

## Reference documentation
- [nf-test Home](./references/www_nf-test_com_index.md)
- [Bioconda nf-test Overview](./references/anaconda_org_channels_bioconda_packages_nf-test_overview.md)