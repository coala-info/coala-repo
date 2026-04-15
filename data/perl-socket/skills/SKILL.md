---
name: perl-socket
description: The perl-socket module provides a low-level interface for system socket constants and functions to facilitate network programming in Perl. Use when user asks to resolve hostnames, convert IP addresses between string and binary formats, or pack and unpack socket address structures for network communication.
homepage: http://metacpan.org/pod/Socket
metadata:
  docker_image: "quay.io/biocontainers/perl-socket:2.027--pl5321h5c03b87_6"
---

# perl-socket

## Overview
The `perl-socket` module provides a low-level interface to the system's socket-related constants and functions. It is the fundamental building block for networking in Perl, used by higher-level modules like `IO::Socket`. This skill focuses on the procedural use of the module to pack and unpack socket addresses, resolve hostnames, and utilize protocol-specific constants for both IPv4 and IPv6.

## Core Usage Patterns

### Address Resolution (Modern Approach)
Use `getaddrinfo` for protocol-independent programming. It replaces older functions like `gethostbyname`.

```perl
use Socket qw(getaddrinfo SOCK_STREAM);

my %hints = (socktype => SOCK_STREAM);
my ($err, @res) = getaddrinfo("www.google.com", "http", \%hints);

die "Lookup failed: $err" if $err;

foreach my $ai (@res) {
    my $family = $ai->{family};
    my $addr   = $ai->{addr};
    # Use $addr in connect()
}
```

### Converting IP Addresses
For simple string-to-binary conversions:

- **IPv4 (Legacy):** `inet_aton("127.0.0.1")` and `inet_ntoa($bin_addr)`
- **Protocol Independent:** `inet_pton($family, $string)` and `inet_ntop($family, $address)`

```perl
use Socket qw(AF_INET AF_INET6 inet_pton inet_ntop);

# String to Binary
my $bin4 = inet_pton(AF_INET, "192.168.1.1");
my $bin6 = inet_pton(AF_INET6, "::1");

# Binary to String
my $str4 = inet_ntop(AF_INET, $bin4);
```

### Packing Socket Structures
To create the binary structures required by the `connect`, `bind`, and `send` system calls:

```perl
use Socket qw(pack_sockaddr_in inet_aton);

my $port = 80;
my $ip_address = inet_aton("127.0.0.1");
my $sockaddr = pack_sockaddr_in($port, $ip_address);
```

For IPv6, use `pack_sockaddr_in6`.

## Expert Tips

1. **Protocol Independence**: Always prefer `AF_UNSPEC` with `getaddrinfo` if you want your code to support both IPv4 and IPv6 automatically.
2. **Error Handling**: `getaddrinfo` returns a numeric error code. Use it to check against constants like `EAI_NODATA` or `EAI_SERVICE`.
3. **Socket Options**: When using `setsockopt`, use the constants provided by this module (e.g., `SOL_SOCKET`, `SO_REUSEADDR`, `TCP_NODELAY`) to ensure portability across different Unix-like systems.
4. **Shorthand Functions**: The functions `sockaddr_in` and `sockaddr_in6` act as both packers and unpackers depending on the context (argument count), which can lead to cleaner code but requires careful attention to return values.

## Reference documentation
- [Socket - networking constants and support functions](./references/metacpan_org_pod_Socket.md)