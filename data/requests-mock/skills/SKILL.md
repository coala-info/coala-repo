---
name: requests-mock
description: requests-mock intercepts and simulates HTTP responses in Python applications to facilitate deterministic testing without network calls. Use when user asks to mock API responses, simulate network errors, test specific HTTP status codes, or verify request parameters in unit tests.
homepage: https://github.com/getsentry/responses
---


# requests-mock

## Overview
The `requests-mock` skill (utilizing the `responses` library) allows you to intercept and simulate HTTP responses in Python applications without hitting actual network endpoints. This is essential for creating deterministic unit tests, simulating API failures, and testing edge cases like timeouts or specific header requirements. By using decorators or context managers, you can redirect `requests` calls to a local registry that returns predefined data.

## Mocking Workflows

### Basic Setup
The most common way to use the tool is via the `@responses.activate` decorator. This ensures that all `requests` calls within the function are intercepted.

```python
import responses
import requests

@responses.activate
def test_api_call():
    # Register a mock response
    responses.add(
        responses.GET,
        "https://api.example.com/data",
        json={"status": "ok"},
        status=200
    )
    
    response = requests.get("https://api.example.com/data")
    assert response.json() == {"status": "ok"}
```

### Using Context Managers
If you only want to mock requests within a specific block of code, use the `RequestsMock` context manager.

```python
with responses.RequestsMock() as rsps:
    rsps.add(responses.POST, "https://api.com/login", status=201)
    requests.post("https://api.com/login")
```

### Advanced Matching Patterns
*   **URL Regex**: Match multiple endpoints using compiled regular expressions.
*   **Query Parameters**: Use `responses.matchers.query_param_matcher` to match specific URL parameters regardless of order.
*   **JSON Body Matching**: Use `responses.matchers.json_params_matcher` to ensure the outgoing POST/PUT body matches a specific dictionary.

### Handling Errors and Exceptions
You can simulate network failures or server errors by passing an exception as the `body` argument:

```python
responses.add(
    responses.GET,
    "https://api.com/fail",
    body=requests.exceptions.ConnectionError("Timeout")
)
```

## Expert Tips & Best Practices
*   **Assert Call Counts**: Always verify that your code actually fired the expected requests using `responses.assert_call_count("https://url", 1)`.
*   **Passthrough**: Use `responses.add_passthrough("https://internal-api.com")` if you need certain requests to hit real servers while mocking others.
*   **Dynamic Responses**: Use a callback function in `responses.add` to generate responses dynamically based on the request headers or body.
*   **Order Matters**: If multiple mocks match a request, the first one registered is typically used. Use the `OrderedRegistry` if you need to mock a sequence of different responses for the same URL.
*   **Avoid Global State**: Prefer the decorator or context manager over manual `start()` and `stop()` calls to prevent mock leakage between test cases.

## Reference documentation
- [Main Documentation](./references/github_com_getsentry_responses.md)
- [Issues and Troubleshooting](./references/github_com_getsentry_responses_issues.md)