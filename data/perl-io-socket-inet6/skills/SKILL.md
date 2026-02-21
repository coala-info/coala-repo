---
name: perl-io-socket-inet6
description: The `IO::Socket::INET6` module provides an object-oriented interface for creating and using sockets in both the AF_INET (IPv4) and AF_INET6 (IPv6) domains.
homepage: http://metacpan.org/pod/IO::Socket::INET6
---

# perl-io-socket-inet6

## Overview

The `IO::Socket::INET6` module provides an object-oriented interface for creating and using sockets in both the AF_INET (IPv4) and AF_INET6 (IPv6) domains. It is designed to be a drop-in replacement for the standard `IO::Socket::INET`, allowing Perl scripts to handle IPv6 addresses transparently. This skill is essential for network programming where protocol independence is required.

## Usage Patterns

### Basic Client Connection
To create a client socket that can connect to either an IPv4 or IPv6 host:

```perl
use IO::Socket::INET6;

my $socket = IO::Socket::INET6->new(
    PeerAddr => 'www.example.com',
    PeerPort => 80,
    Proto    => 'tcp',
) or die "Could not create socket: $!";
```

### Basic Server Setup
To create a listening server socket that accepts connections on all available interfaces (IPv4 and IPv6):

```perl
use IO::Socket::INET6;

my $server = IO::Socket::INET6->new(
    LocalPort => 8080,
    Listen    => 5,
    Reuse     => 1,
    Domain    => AF_INET6, # Forces IPv6/Dual-stack
) or die "Could not create server: $!";
```

## Best Practices

- **Protocol Independence**: Avoid hardcoding `AF_INET`. Use `AF_UNSPEC` (default) to allow the module to resolve the best available protocol for a given hostname.
- **Error Handling**: Always check `$!` or `$@` after a constructor call, as network failures or address resolution errors are common.
- **Multi-homed Hosts**: When a hostname resolves to multiple IP addresses, `IO::Socket::INET6` will attempt to connect to them in order until one succeeds.
- **Legacy Compatibility**: If you are updating an old script, simply changing `use IO::Socket::INET;` to `use IO::Socket::INET6;` is often sufficient to enable IPv6 support.

## Reference documentation

- [IO::Socket::INET6 Documentation](./references/metacpan_org_pod_IO__Socket__INET6.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-io-socket-inet6_overview.md)