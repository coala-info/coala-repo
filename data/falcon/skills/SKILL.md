---
name: falcon
description: Falcon is a minimalist, "no-magic" web framework for Python, specifically engineered for building high-performance REST APIs and microservices.
homepage: https://github.com/falconry/falcon
---

# falcon

---

## Overview

Falcon is a minimalist, "no-magic" web framework for Python, specifically engineered for building high-performance REST APIs and microservices. Unlike frameworks that rely on global state or heavy abstractions, Falcon emphasizes explicit code, strict adherence to HTTP RFCs, and bare-metal performance. It is ideal for mission-critical applications where reliability and low latency are paramount, supporting both traditional WSGI and modern ASGI/asyncio workflows.

## Core Principles & Best Practices

- **Explicit is Better than Implicit**: Avoid "magic" globals. Always pass request and response objects explicitly through responders and middleware.
- **Resource-Oriented Routing**: Map URI templates to class-based resources. Use centralized routing to maintain a clear map of the API surface.
- **Adherence to RFCs**: Falcon follows HTTP standards strictly. Leverage built-in error classes (e.g., `falcon.HTTPBadRequest`) to ensure idiomatic HTTP responses.
- **Performance Optimization**: 
    - Use **PyPy** for the fastest execution environment.
    - Ensure **Cython** is available during installation to allow Falcon to compile itself for an extra speed boost.
    - Prefer **ASGI** for I/O-bound applications requiring native `asyncio` support.

## Common Patterns

### Installation
Install the stable version via pip:
```bash
pip install falcon
```
For the latest features or pre-release testing (e.g., CPython 3.14/3.15 support):
```bash
pip install --pre falcon
```

### Application Initialization
- **WSGI**: Use `falcon.App()` for standard synchronous deployments.
- **ASGI**: Use `falcon.asgi.App()` for asynchronous deployments and WebSocket support.

### Resource Implementation
Responders should be named `on_get`, `on_post`, `on_put`, etc., corresponding to HTTP methods.
- Use `req.get_param_as_media()` or `req.get_param_as_dict()` for structured parameter extraction.
- Use `req.get_query_string_as_media()` to handle complex query strings.

### Middleware and Hooks
- Use **Middleware** for cross-cutting concerns (authentication, logging) that apply to all or most routes.
- Use **Hooks** (`@falcon.before`, `@falcon.after`) for logic specific to individual resources or responders.
- **New Pattern**: You can now override default responders via `on_request()` for advanced routing logic.

## Expert Tips

- **No-Magic Debugging**: Because Falcon does not mask unhandled exceptions, use standard Python debugging tools. Logic paths are kept simple to ensure that inputs lead predictably to outputs.
- **Testing**: Utilize Falcon's built-in testing helpers (`falcon.testing`) for both WSGI and ASGI. These allow for snappy, mock-based testing without spinning up a full network server.
- **Content Negotiation**: Falcon handles content type negotiation out of the box. Ensure your resources set `resp.media` to take advantage of automatic serialization.
- **WebSocket Sinks**: When using ASGI, be mindful of the interaction between WebSockets and standard sinks to avoid hanging scenarios in unit tests.

## Reference documentation

- [The Falcon Web Framework](./references/github_com_falconry_falcon.md)
- [Falcon Wiki & Community Resources](./references/github_com_falconry_falcon_wiki.md)
- [Falcon Release Tags & Versioning](./references/github_com_falconry_falcon_tags.md)