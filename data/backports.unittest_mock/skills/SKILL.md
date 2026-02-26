---
name: backports.unittest_mock
description: This package provides a compatibility layer that installs the mock library into the unittest namespace for legacy Python environments. Use when user asks to provide unittest.mock support for Python versions 3.2 and below, write forward-compatible test code, or integrate mock backports with pytest.
homepage: https://github.com/jaraco/backports.unittest_mock
---


# backports.unittest_mock

## Overview

The backports.unittest_mock package is a compatibility layer designed for legacy Python environments where the `unittest.mock` module is not available in the standard library (Python 3.2 and below). It provides a mechanism to "install" the mock library into the `unittest` namespace, allowing developers to write forward-compatible test code that uses `import unittest.mock` regardless of the underlying Python version.

## Usage Instructions

### Installation

The package can be installed via conda or pip depending on the environment requirements:

```bash
# Using Conda (Bioconda channel)
conda install bioconda::backports.unittest_mock

# Using pip
pip install backports.unittest_mock
```

### Automated Integration with Pytest

If the project uses `pytest`, the integration is automatic. Simply installing the package in the test environment activates a plugin that configures `unittest.mock` before tests run. No additional code changes are required in the test files.

### Manual Implementation

For non-pytest environments or scripts that require the backport, the installation must be triggered imperatively. This must occur before attempting to import `unittest.mock`.

```python
import backports.unittest_mock
backports.unittest_mock.install()

# Now unittest.mock is available even on Python < 3.3
import unittest.mock
```

## Best Practices and Expert Tips

- **Early Initialization**: When using the manual installation method, call `backports.unittest_mock.install()` as early as possible, ideally in the test suite's entry point or the top-level `conftest.py` or `__init__.py` of the test package.
- **Conditional Dependency**: Since this is a backport, it is best practice to list it as a conditional dependency in `setup.cfg` or `pyproject.toml` so it is only installed on older Python versions:
  ```ini
  install_requires =
      backports.unittest_mock; python_version < "3.3"
  ```
- **Namespace Awareness**: Note that this tool specifically targets the `unittest.mock` namespace. If the codebase uses the standalone `mock` package, this backport may not be necessary unless you are specifically trying to standardize on the `unittest` namespace.
- **Archived Status**: Be aware that the upstream repository is archived. While functional for its specific purpose, it is intended for maintenance of legacy systems rather than new development.

## Reference documentation
- [backports.unittest_mock - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_backports.unittest_mock_overview.md)
- [GitHub - jaraco/backports.unittest_mock](./references/github_com_jaraco_backports.unittest_mock.md)