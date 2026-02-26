---
name: perl-socket6
description: This Perl module provides IPv6 networking support and protocol-independent address resolution. Use when user asks to handle IPv6 socket structures, perform protocol-independent name resolution with getaddrinfo, or convert between human-readable and binary IPv6 addresses.
homepage: http://metacpan.org/pod/Socket6
---


# perl-socket6

## Overview
This skill provides guidance on using the `Socket6` Perl module to bridge the gap between traditional IPv4 networking and IPv6. It is essential for scripts that need to handle `sockaddr_in6` structures, perform lookups that return both IPv4 and IPv6 addresses, or use constants not available in older versions of the core `Socket` module.

## Implementation Patterns

### Protocol-Independent Name Resolution
Instead of using `gethostbyname`, use `getaddrinfo` to ensure your code works across both IPv4 and IPv6.

```perl
use Socket;
use Socket6;

my @res = getaddrinfo("www.example.com", "http", AF_UNSPEC, SOCK_STREAM);
while (scalar @res >= 5) {
    my ($family, $socktype, $proto, $saddr, $canonname) = splice @res, 0, 5;
    
    # Create socket based on the returned family (AF_INET or AF_INET6)
    socket(my $fd, $family, $socktype, $proto) or next;
    connect($fd, $saddr) or next;
    
    # Connection successful
    last;
}
```

### Handling IPv6 Addresses
Use `inet_pton` and `inet_ntop` for converting between human-readable strings and binary network addresses.

```perl
use Socket6;

# String to Binary (IPv6)
my $bin = inet_pton(AF_INET6, "2001:db8::1");

# Binary to String
my $addr_str = inet_ntop(AF_INET6, $bin);
```

### Socket Address Packing
When manually constructing or deconstructing socket addresses for IPv6:

- **Packing**: Use `pack_sockaddr_in6($port, $address)` where `$address` is the binary form from `inet_pton`.
- **Unpacking**: Use `unpack_sockaddr_in6($sin6)` to retrieve the port and binary address.

## Best Practices
- **AF_UNSPEC**: Always prefer `AF_UNSPEC` in `getaddrinfo` hints to allow the system to return the best available address family (IPv6 or IPv4).
- **Scope IDs**: When working with Link-Local addresses (fe80::), remember that `pack_sockaddr_in6` can accept `scope_id` as a fourth argument.
- **Error Handling**: `getaddrinfo` returns an empty list on failure. In a scalar context, it returns an error string; always check the result before attempting to `splice`.

## Reference documentation
- [Socket6 Perl Documentation](./references/metacpan_org_pod_Socket6.md)