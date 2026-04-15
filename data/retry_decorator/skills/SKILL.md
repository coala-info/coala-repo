---
name: retry_decorator
description: The retry_decorator library provides a Python decorator to automatically re-execute functions when specific exceptions occur. Use when user asks to handle transient failures, retry functions after a delay, or configure maximum execution attempts for unstable code.
homepage: https://github.com/pnpnpn/retry-decorator
metadata:
  docker_image: "quay.io/biocontainers/retry_decorator:1.1.1--py_0"
---

# retry_decorator

## Overview
The `retry_decorator` is a specialized Python library designed to simplify exception handling through a declarative decorator. It allows you to define specific failure conditions (exceptions) under which a function should be re-executed, the total number of attempts allowed, and the duration of the pause between those attempts. This prevents temporary glitches from causing permanent application failures.

## Usage Instructions

### Installation
Install the package via Conda from the Bioconda channel:
```bash
conda install bioconda::retry_decorator
```

### Basic Implementation
To use the decorator, import the `retry` function and apply it to your target function.

```python
from retry_decorator import retry

@retry(Exception, tries=3, timeout_secs=0.5)
def unstable_function():
    # Your code that might fail here
    pass
```

### Configuration Parameters
- **Exception Type**: The first argument defines which exception(s) trigger a retry. Use specific exceptions (e.g., `ConnectionError`) rather than a broad `Exception` to avoid masking logic errors.
- **tries**: The total number of execution attempts (initial call + retries).
- **timeout_secs**: The sleep interval (in seconds) between failed attempts.

## Best Practices and Expert Tips

### Specificity in Exception Handling
Always target the narrowest possible exception. Retrying on a `ValueError` or `SyntaxError` is usually counterproductive as these are rarely transient. Focus on `IOError`, `Timeout`, or custom API exceptions.

### Managing Latency
When setting `timeout_secs`, consider the downstream service's rate limits. While this library provides a fixed delay, ensure the cumulative time (`tries` * `timeout_secs`) does not exceed your application's request timeout or user experience thresholds.

### Callback Logic
The library supports advanced handling via `callback_by_exception`. This allows you to execute specific logic (like logging or cleanup) when a particular exception is caught before the next retry attempt occurs.

### Integration with Logging
Since retries can hide underlying issues, it is recommended to wrap the decorated function's call in a try/except block at the top level to catch the final failure if all retries are exhausted.

## Reference documentation
- [retry_decorator - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_retry_decorator_overview.md)
- [GitHub - pnpnpn/retry-decorator: Decorator for retrying when exceptions occur](./references/github_com_pnpnpn_retry-decorator.md)