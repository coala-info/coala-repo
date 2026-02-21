---
name: socksipy-branch
description: The `socksipy-branch` skill provides guidance on using a specialized Python module that extends the standard `socket` interface to support SOCKS and HTTP proxying.
homepage: https://github.com/gsutil-mirrors/socksipy-branch
---

# socksipy-branch

## Overview

The `socksipy-branch` skill provides guidance on using a specialized Python module that extends the standard `socket` interface to support SOCKS and HTTP proxying. It allows for the creation of "proxy-aware" sockets that handle the negotiation with a proxy server transparently. This is particularly useful for legacy Python 2.x/3.x environments or simple scripts where a lightweight, single-file proxy solution is preferred over heavier libraries.

## Core Implementation

To use the module, you must use the `socksocket` class, which is a subclass of the standard `socket.socket`.

### Basic Connection Pattern
1. **Initialize**: Create a `socks.socksocket()` instance.
2. **Configure**: Call `setproxy()` with the proxy details.
3. **Connect**: Use the standard `connect()` method to reach the final destination.

```python
import socks

# Create the socket
s = socks.socksocket()

# Configure the proxy (Type, Address, Port)
s.setproxy(socks.PROXY_TYPE_SOCKS5, "proxy.example.com", 1080)

# Connect to the target destination
s.connect(("www.google.com", 80))
```

### Proxy Type Constants
- `socks.PROXY_TYPE_SOCKS4`: For SOCKS4 servers.
- `socks.PROXY_TYPE_SOCKS5`: For SOCKS5 servers (supports authentication and UDP).
- `socks.PROXY_TYPE_HTTP`: For HTTP proxies supporting the `CONNECT` method.

## Advanced Configuration

### DNS Resolution (rdns)
By default, `socksipy-branch` performs DNS resolution on the proxy server (`rdns=True`). 
- Set `rdns=False` if you want to resolve the hostname locally before connecting to the proxy.
- **Note**: SOCKS4 requires an extension (SOCKS4a) for remote DNS; SOCKS5 and HTTP always support it.

### Authentication
For SOCKS5 or SOCKS4 (userid), provide credentials in the `setproxy` method:
```python
s.setproxy(socks.PROXY_TYPE_SOCKS5, "addr", 1080, True, "username", "password")
```

## Error Handling

All module-specific exceptions derive from `socks.ProxyError`. Catching this base class allows you to handle all proxy-related failures.

| Exception | Cause |
|-----------|-------|
| `GeneralProxyError` | Unexpected data from server or bad proxy type. |
| `Socks5AuthError` | Authentication required, rejected, or invalid credentials. |
| `Socks5Error` | Server-side errors (Connection refused, Host unreachable, etc.). |

## Expert Tips

- **Global Monkeypatching**: While not natively a "feature" of the branch, you can often redirect all socket traffic by setting `socket.socket = socks.socksocket` after importing both, though this should be used with caution in complex applications.
- **Timeout Management**: Since proxy negotiation adds latency, always set a timeout on the socket using `s.settimeout(seconds)` before calling `connect()`.
- **Protocol Limitations**: `socksocket` only functions with `AF_INET` (IPv4) and `SOCK_STREAM` (TCP). It is not designed for raw packets or IPv6 in this specific branch.

## Reference documentation
- [Main README and Usage Guide](./references/github_com_gsutil-mirrors_socksipy-branch.md)