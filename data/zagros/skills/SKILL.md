---
name: zagros
description: Zagros is a lightweight, high-performance web server built with the Zig programming language. Use when user asks to initialize the server, configure its settings, manage its configuration, implement custom request handlers, serve static assets, handle form data, or optimize content delivery.
homepage: https://github.com/Aryvyo/Zagros
metadata:
  docker_image: "quay.io/biocontainers/zagros:1.0.0--ha24e720_10"
---

# zagros

## Overview
Zagros is a lightweight, high-performance web server built with the Zig programming language. It is designed for speed and simplicity, offering a "DIY" approach to server construction. This skill provides the necessary procedural knowledge to initialize the server, manage its configuration via the CLI, and implement custom request handlers using the native Zig API.

## Installation and Setup
Zagros requires Zig 0.13 or 0.14. To get started, clone the repository and build the project:

```bash
git clone https://github.com/Aryvyo/Zagros.git
cd Zagros
zig build run
```

On the first execution, the server automatically creates a `static/` directory. Any files placed in this directory are served as static assets under a route matching their filename.

## Configuration Management
The server generates a `server.cfg` file upon its first run. You can modify this file to tune performance and network settings.

### CLI Commands
- **Regenerate Config**: To overwrite an existing configuration with default values, use:
  ```bash
  ./Zagros -c
  # OR
  ./Zagros --config
  ```

### Configuration Parameters
Edit `server.cfg` to adjust the following:
- `address`: The IP address to bind to (default: `127.0.0.1`).
- `port`: The listening port (default: `8080`).
- `thread_count`: Number of worker threads for the thread pool (default: `4`).
- `display_time`: Set to `true` to log the time taken to fulfill each request.

## Route Implementation
Zagros uses a thread pool and a router to handle requests. Routes are added using the `addRoute` method.

### Defining a Handler
A handler function must match the `RouterFn` signature, taking a `ThreadPool.RequestContext`.

```zig
fn handleRequest(ctx: ThreadPool.RequestContext) !void {
    const body = "Hello from Zagros!";
    const response = try std.fmt.allocPrint(ctx.allocator,
        "HTTP/1.1 200 OK\r\n" ++
        "Content-Type: text/plain\r\n" ++
        "Content-Length: {d}\r\n" ++
        "Connection: close\r\n\r\n" ++
        "{s}",
        .{ body.len, body }
    );
    defer ctx.allocator.free(response);
    try ctx.client_writer.writeAll(response);
}
```

### Registering Routes
Register handlers in your main initialization block:
```zig
// Path, Method (.GET, .POST, etc.), Handler
try pool.addRoute("api/data", .GET, handleRequest);
```

## Expert Tips
- **Form Data**: Use `utils.parseFormData(allocator, body)` to handle POST requests. It returns a `StringHashMap([]const u8)` containing the parsed fields.
- **Memory Management**: Always utilize the `ctx.allocator` provided in the `RequestContext` for request-scoped allocations to ensure thread safety and proper cleanup.
- **Static Assets**: For CSS or JS, ensure the route registered via `addRoute` matches the link path in your HTML (e.g., `pool.addRoute("styles.css", .GET, serveCss)`).
- **Performance**: Zagros supports Gzip compression and Etags natively for optimized content delivery.

## Reference documentation
- [Zagros Main README](./references/github_com_Aryvyo_Zagros.md)
- [Zagros Source Structure](./references/github_com_Aryvyo_Zagros_tree_master_src.md)