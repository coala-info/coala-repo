---
name: pytest-cov
description: pytest-cov is a pytest plugin that measures code coverage by tracking which lines of code are executed during test runs. Use when user asks to measure test coverage, generate coverage reports in various formats, or enforce coverage thresholds in Python projects.
homepage: https://github.com/pytest-dev/pytest-cov
metadata:
  docker_image: "quay.io/biocontainers/pytest-cov:2.4.0--py34_0"
---

# pytest-cov

## Overview
`pytest-cov` is a specialized plugin that integrates the `coverage` library into the `pytest` workflow. It automates the process of tracking which lines of code are executed during a test run, handling the complexities of data collection, merging results from parallel processes, and generating human-readable or machine-parseable reports. It is the standard tool for identifying "dead" or untested code in Python applications.

## Core CLI Usage

### Basic Coverage
To measure coverage for a specific package or directory:
```bash
pytest --cov=my_package tests/
```

### Reporting Formats
You can generate multiple report types in a single run. The `term-missing` report is highly recommended for local development as it lists the exact line numbers that were not covered.
```bash
# Terminal report with missing line numbers
pytest --cov=my_package --cov-report=term-missing

# Generate HTML and XML (for CI) reports
pytest --cov=my_package --cov-report=html --cov-report=xml
```

### Enforcing Thresholds
Use the `--cov-fail-under` flag to make the test suite fail if the total coverage is below a certain percentage. This is a best practice for CI pipelines.
```bash
pytest --cov=my_package --cov-fail-under=90
```

## Advanced Patterns

### Distributed Testing (xdist)
`pytest-cov` is designed to work seamlessly with `pytest-xdist`. It automatically collects coverage data from all workers and combines them into a single report.
```bash
pytest -n auto --cov=my_package
```

### Appending Data
If you run tests in multiple stages (e.g., unit tests then integration tests) and want a combined report, use the `--cov-append` flag.
```bash
# Run unit tests
pytest --cov=my_package --cov-append tests/unit
# Run integration tests and add to the same data
pytest --cov=my_package --cov-append tests/integration
```

### Coverage Contexts
To see which specific tests cover which lines of code, enable contexts. This is useful for deep debugging of test suites.
```bash
pytest --cov=my_package --cov-context=test
```

## Expert Tips

1.  **Configuration**: Instead of long CLI commands, move your settings to `pyproject.toml` or `.coveragerc`. `pytest-cov` respects standard coverage configuration.
2.  **Subprocess Coverage**: As of version 7.0.0, `pytest-cov` no longer uses `.pth` files for subprocesses. To measure coverage in subprocesses, you must use the `patch` options provided by the base `coverage` package (e.g., setting `patch = subprocess` in your config).
3.  **Source Filtering**: Always specify the `--cov` source (e.g., `--cov=src`) to avoid measuring coverage of the tests themselves or third-party libraries in your environment.
4.  **Path Consistency**: Running `pytest --cov` ensures a consistent `sys.path`, whereas running `coverage run -m pytest` may inadvertently add the current working directory to the path, leading to "import-from-local" bugs that don't appear in production.

## Reference documentation
- [Main README and Usage Guide](./references/github_com_pytest-dev_pytest-cov.md)
- [Version 7.0.0 Changes and Subprocess Handling](./references/github_com_pytest-dev_pytest-cov_commits_master.md)