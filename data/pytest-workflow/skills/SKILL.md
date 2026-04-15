---
name: pytest-workflow
description: pytest-workflow is a pytest plugin for language-agnostic testing and verification of workflow pipelines. Use when user asks to execute workflow test cases, filter tests by tags, debug pipeline execution, or optimize test performance with symlinking and git-aware file copying.
homepage: https://github.com/LUMC/pytest-workflow
metadata:
  docker_image: "quay.io/biocontainers/pytest-workflow:1.2.0--py_0"
---

# pytest-workflow

## Overview
pytest-workflow is a pytest plugin that enables language-agnostic testing of workflow systems. It allows developers to define test cases that execute pipeline commands and verify outcomes—such as exit codes, file existence, and content matches—without writing complex Python test logic. It is particularly useful in bioinformatics and data science for ensuring pipeline reproducibility and correctness across different environments.

## CLI Execution Patterns

### Basic Usage
Run all discovered workflow tests in the current directory and subdirectories:
```bash
pytest
```

### Filtering Tests
Use tags to run specific subsets of tests (defined in the YAML configuration):
```bash
pytest --tag my_specific_tag
```

### Debugging and Logging
When a pipeline fails, use these flags to inspect the execution environment:
* **Keep Working Directory**: Use `--kwd` or `--keep-workflow-wd` to prevent pytest from deleting the temporary execution directory. This allows you to manually inspect logs and intermediate files.
* **Verbose Output**: Use `-v` to see a detailed overview of which specific checks (exit code, file existence, etc.) passed or failed.
* **Adjust Error Logs**: Use `--sb` or `--stderr-bytes` followed by a number to change the amount of stderr/stdout displayed upon failure (default is often truncated).

### Performance and Efficiency
For large projects or repositories with many files, use these flags to optimize the setup phase:
* **Git-Aware Copying**: Use `--ga` or `--git-aware` to only copy files tracked by Git to the test directory. This ignores the `.git` folder and untracked/ignored files, significantly speeding up test initialization.
* **Symlinking**: Use `--symlink` to create symbolic links to input files instead of performing a full file copy. This is essential when dealing with large datasets.

## Best Practices

* **Test Discovery**: Ensure your test files are located in a `tests/` directory and follow the naming convention `test*.yaml` or `test*.yml`.
* **Environment Variables**: pytest-workflow supports environment variables. You can pass them via the standard `pytest` environment or define them in your shell before execution.
* **Configuration**: For project-wide settings (like always using `--git-aware`), add a `[tool:pytest]` section to your `pytest.ini` or `setup.cfg`.
* **Exit Code Priority**: Note that if a workflow fails with an unexpected exit code, pytest-workflow will skip subsequent file and content checks for that specific test to reduce log noise.

## Reference documentation
- [pytest-workflow GitHub Repository](./references/github_com_LUMC_pytest-workflow.md)
- [pytest-workflow Version Tags and Changelog](./references/github_com_LUMC_pytest-workflow_tags.md)