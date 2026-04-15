---
name: cwltest
description: cwltest is a framework for validating the output of tools and workflows described in the Common Workflow Language. Use when user asks to run CWL conformance tests, validate CWL-compliant software, generate status badges for CI/CD pipelines, or list available test cases.
homepage: https://github.com/common-workflow-language/cwltest
metadata:
  docker_image: "quay.io/biocontainers/cwltest:2.2.20220521103021--pyhdfd78af_0"
---

# cwltest

## Overview
`cwltest` is the standard framework for validating the output of tools and workflows described in the Common Workflow Language. It is the primary tool used for running CWL conformance tests, ensuring that a given CWL runner or implementation behaves according to the specification. Use this skill when you need to automate the validation of CWL-compliant software, generate status badges for CI/CD pipelines, or extend the testing framework to handle remote data storage.

## Installation
The tool can be installed via Python's package manager or Conda:
- **Pip**: `pip install cwltest`
- **Conda**: `conda install -c bioconda cwltest`

## Core CLI Patterns

### Running Tests
The primary use case involves pointing `cwltest` to a test description file and specifying the CWL runner to be tested.
```bash
cwltest --test test-descriptions.yml --tool cwl-runner
```

### Generating Conformance Badges
`cwltest` can output JSON files compatible with badgen.net to visualize test results in project READMEs.
```bash
cwltest --test test-descriptions.yml --tool cwl-runner --badgedir ./badges
```
The resulting JSON files (e.g., `command_line_tool.json`) will contain the status percentage and color coding based on test success.

### Listing Tests
To view available tests within a description file without executing them:
- Use the `-l` flag to list test cases and their associated documentation strings or labels.

## Advanced Configuration: Custom File Access
If the CWL implementation interacts with remote storage (e.g., S3, Arvados) rather than a local filesystem, `cwltest` supports custom filesystem access modules.

1.  **Implementation**: Create a class that implements the `StdFsAccess` interface (specifically the `open`, `size`, `isfile`, and `isdir` methods).
2.  **Entry Point**: Register the custom implementation in your package's metadata so `cwltest` can discover it.
    - **pyproject.toml**:
      ```toml
      [project.entry-points.'cwltest.fsaccess']
      fsaccess = 'my_module.fsaccess:get_fsaccess'
      ```
3.  **Execution**: Once your package is installed in the same environment as `cwltest`, the tool will automatically query the metadata and use the custom object to access test outputs via URIs.

## Expert Tips
- **Environment Consistency**: Always ensure `cwltest` and the `tool` (runner) you are testing are installed in the same virtual environment to avoid path resolution issues.
- **Validation**: If a test fails without clear feedback, verify that the test description file is valid YAML and that the runner specified in `--tool` is accessible in the system PATH.
- **CI/CD Integration**: Use the `--badgedir` option in GitHub Actions or other CI runners to automatically update conformance status on every push.

## Reference documentation
- [cwltest GitHub README](./references/github_com_common-workflow-language_cwltest.md)
- [cwltest Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cwltest_overview.md)