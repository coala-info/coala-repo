---
name: minimock
description: MiniMock is a minimalist Python library for creating simple mock objects that record calls and return predefined values. Use when user asks to create mock objects, replace functions in modules with mocks, or verify function calls and arguments in tests.
homepage: http://pypi.python.org/pypi/MiniMock
---


# minimock

## Overview
MiniMock is a minimalist Python library designed for creating mock objects with the least amount of ceremony possible. Unlike more feature-rich mocking frameworks, MiniMock focuses on simplicity: it creates objects that record how they are called and can return predefined values. It is particularly useful for "doctest" style testing or quick scripts where you need to intercept calls to external dependencies and verify the arguments passed to them.

## Usage Guidelines

### Basic Mocking
Create a mock object to replace a dependency. By default, calling a MiniMock object returns another MiniMock object.

```python
from minimock import Mock
my_mock = Mock('my_mock')
my_mock.some_method(1, 2, key='value')
# Output: Called my_mock.some_method(1, 2, key='value')
```

### Controlling Return Values
Use the `returns` parameter to specify what a mock should return when called.

```python
fetcher = Mock('fetcher', returns='{"status": "ok"}')
result = fetcher() 
# result is now '{"status": "ok"}'
```

### Mocking Functions in Modules
To mock a function within an existing module, use `minimock.mock` and `minimock.restore`.

```python
import os
import minimock

# Replace os.remove with a mock
minimock.mock('os.remove', returns=None)

os.remove('some_file.txt')
# Output: Called os.remove('some_file.txt')

# Restore the original function
minimock.restore()
```

### Verifying Calls with TraceTracker
For more programmatic verification (instead of just printing to stdout), use a `TraceTracker`.

```python
from minimock import Mock, TraceTracker
import io

out = io.StringIO()
tracker = TraceTracker(out)

# Pass the tracker to the mock
m = Mock('m', tracker=tracker)
m(1, 2)

assert 'Called m(1, 2)' in out.getvalue()
```

## Best Practices
- **Keep it Simple**: Only use MiniMock for straightforward dependency injection or call verification. If you need complex side effects or assertion matchers, consider the standard `unittest.mock`.
- **Always Restore**: When using `minimock.mock()` to patch modules, ensure `minimock.restore()` is called in the `tearDown` of your test to avoid side effects in other tests.
- **Naming**: Always provide a name to the `Mock()` constructor (e.g., `Mock('database')`). This name appears in the trace output and makes debugging significantly easier.

## Reference documentation
- [MiniMock Project Page](./references/pypi_org_project_MiniMock.md)