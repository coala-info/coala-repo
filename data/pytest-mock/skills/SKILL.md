---
name: pytest-mock
description: pytest-mock provides a fixture that wraps the standard unittest.mock library to simplify mocking and ensure automatic cleanup in tests. Use when user asks to mock functions or objects, patch imports, spy on existing code, create stubs, or modify dictionaries for testing.
homepage: https://github.com/pytest-dev/pytest-mock
---


# pytest-mock

## Overview
pytest-mock is a pytest plugin that provides the `mocker` fixture, a thin and ergonomic wrapper around the standard `unittest.mock` library. It simplifies the mocking process by automatically handling the cleanup (undoing patches) after each test completes, preventing side effects from leaking between tests. It also integrates with pytest's assertion rewriting to provide detailed failure messages when verifying call arguments.

## Core Usage Patterns

### The mocker Fixture
Always use the `mocker` fixture instead of `unittest.mock.patch` decorators or context managers to ensure automatic teardown.

```python
def test_function(mocker):
    # Patching a function in a module
    mock_get = mocker.patch('requests.get')
    mock_get.return_value.status_code = 200
    
    # Patching an object attribute
    mocker.patch.object(os, 'remove')
```

### Spying on Objects
Use `mocker.spy` to wrap a real object or function. This allows the original code to execute while still tracking calls, arguments, and return values.

```python
def test_spy(mocker):
    import os
    # Tracks calls to os.path.join but doesn't block its execution
    spy = mocker.spy(os.path, 'join')
    
    os.path.join('a', 'b')
    assert spy.call_count == 1
    assert spy.spy_return == 'a/b'
```

### Creating Stubs
Use `mocker.stub` when you need a simple callable object that does nothing but record how it was called.

```python
def test_stub(mocker):
    stub = mocker.stub(name='on_complete_handler')
    
    # Pass the stub as a callback
    run_process(callback=stub)
    
    stub.assert_called_once()
```

## Best Practices and Expert Tips

### Patching Location
Always patch the "target" where it is **imported**, not where it is defined.
*   **Incorrect**: `mocker.patch('os.remove')` if the module under test does `from os import remove`.
*   **Correct**: `mocker.patch('my_module.remove')`.

### Async Support
When mocking asynchronous functions, `pytest-mock` automatically detects coroutines. However, ensure you are using a version compatible with your async runner (like `pytest-asyncio`).
*   For `spy` on async functions, remember that the call is registered when the coroutine is created, but the result is only available after it is awaited.
*   Use `spy_return` to check the result of a synchronous spy.

### Verifying Calls
Leverage pytest's introspection for call verification. Instead of standard mock assertions, you can use:
```python
# Standard mock assertion
mock_func.assert_called_with(1, 2, 3)

# Using pytest-mock's enhanced introspection
assert mock_func.call_args == mocker.call(1, 2, 3)
```

### Mocking Dicts and Multiple Targets
*   **mocker.patch.dict**: Use this to safely modify environment variables or configuration dictionaries for the duration of a single test.
*   **mocker.patch.multiple**: Use this to patch multiple attributes of the same object simultaneously.

## Reference documentation
- [pytest-mock README](./references/github_com_pytest-dev_pytest-mock.md)
- [pytest-mock Issues and Limitations](./references/github_com_pytest-dev_pytest-mock_issues.md)