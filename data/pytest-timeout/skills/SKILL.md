---
name: pytest-timeout
description: pytest-timeout terminates tests that exceed a specified duration to prevent test suites from hanging. Use when user asks to set global test timeouts, override timeouts for specific tests, or debug deadlocks by dumping stack traces upon timeout.
homepage: https://github.com/pytest-dev/pytest-timeout
---


# pytest-timeout

## Overview
The `pytest-timeout` skill enables the automatic termination of tests that exceed a specified duration. This is primarily used to prevent CI/CD pipelines from hanging indefinitely due to deadlocks or infinite loops. It allows for both global enforcement across a whole suite and granular control for specific long-running tests.

## Installation
```bash
pip install pytest-timeout
```

## Core Usage Patterns

### Global Timeouts
Set a maximum duration (in seconds) for every test in the suite.
- **CLI**: `pytest --timeout=300`
- **Environment Variable**: `export PYTEST_TIMEOUT=300`
- **Configuration (pytest.ini / tox.ini)**:
  ```ini
  [pytest]
  timeout = 300
  ```

### Individual Test Overrides
Use the `timeout` marker to set specific limits for individual test functions. This override takes precedence over global settings.
```python
import pytest

@pytest.mark.timeout(60)
def test_specific_operation():
    # This test will time out after 60 seconds
    pass

@pytest.mark.timeout(0)
def test_no_timeout():
    # Setting timeout to 0 disables it for this specific test
    pass
```

## Timeout Methods
The plugin supports two primary methods for interrupting tests. Choosing the right one depends on your platform and the nature of the code being tested.

| Method | Description | Best For |
| :--- | :--- | :--- |
| `signal` | Uses `SIGALRM`. Graceful; allows pytest to continue and report results. | POSIX systems; tests that don't use signals themselves. |
| `thread` | Starts a separate timer thread. Hard termination (`os._exit()`); no teardown. | Windows; tests that hang so hard they block signals; portable fallback. |

### Specifying the Method
- **CLI**: `pytest --timeout_method=thread`
- **Marker**: `@pytest.mark.timeout(60, method="thread")`
- **Configuration**:
  ```ini
  [pytest]
  timeout_method = signal
  ```

## Expert Tips & Best Practices

### Debugging Timeouts
When a timeout occurs, the plugin dumps the stack traces of all running threads to `stderr`. This is the most critical information for identifying where a deadlock is occurring.

### Handling Fixtures
The timeout duration covers the entire lifecycle of a test: **Setup + Call + Teardown**.
- If a timeout occurs during fixture teardown while using the `signal` method, subsequent fixtures might not be cleaned up.
- If using the `thread` method, the process exits immediately, meaning no teardown code is executed.

### Debugger Detection
By default, `pytest-timeout` attempts to stay disabled if it detects a debugger (like `pdb` or `pydevd`) to prevent the test from timing out while you are stepping through code.
- To force timeouts even while debugging, use the configuration: `timeout_disable_debugger_detection = true`.

### Combining with xdist
If using `pytest-xdist`, timeouts are applied to the individual worker processes. If a worker process hangs, the `thread` method is often more reliable for ensuring the worker is killed so the controller can recover.

## Reference documentation
- [README](./references/github_com_pytest-dev_pytest-timeout.md)
- [Issues](./references/github_com_pytest-dev_pytest-timeout_issues.md)