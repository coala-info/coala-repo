---
name: perl-http-daemon
description: The perl-http-daemon tool provides a Perl class for instantiating and managing simple HTTP servers to handle network requests. Use when user asks to create a basic web server, handle incoming HTTP requests in Perl, or automate network services.
homepage: http://metacpan.org/pod/HTTP-Daemon
metadata:
  docker_image: "quay.io/biocontainers/perl-http-daemon:6.16--pl5321hdfd78af_0"
---

# perl-http-daemon

## Overview
The `perl-http-daemon` skill provides guidance on utilizing the `HTTP::Daemon` Perl class to instantiate HTTP servers. This tool is a subclass of `IO::Socket::INET`, specifically designed to listen for incoming HTTP requests. It is most effective for developers needing to script quick network services or automate HTTP-based interactions within a Perl environment.

## Implementation Patterns

### Basic Server Setup
To start a daemon, initialize the object and enter a loop to accept connections.
```perl
use HTTP::Daemon;
use HTTP::Status;

my $d = HTTP::Daemon->new(
    LocalAddr => 'localhost',
    LocalPort => 8080,
) || die "Failed to initialize daemon: $!";

print "Server address: ", $d->url, "\n";

while (my $c = $d->accept) {
    while (my $r = $c->get_request) {
        if ($r->method eq 'GET') {
            $c->send_response(RC_OK, "Hello, World!");
        } else {
            $c->send_error(RC_FORBIDDEN);
        }
    }
    $c->close;
    undef($c);
}
```

### Handling Requests and Responses
*   **Request Object**: The `$c->get_request` method returns an `HTTP::Request` object. Use `$r->uri->path` to route requests.
*   **Response Object**: Use `$c->send_response($res)` where `$res` is an `HTTP::Response` object for complex headers, or use helper methods like `$c->send_file($path)` for static content.

### Best Practices
*   **Connection Management**: Always explicitly close the client connection (`$c->close`) and undefine the variable to prevent memory leaks and socket exhaustion.
*   **Security**: By default, `HTTP::Daemon` does not support SSL/TLS. For secure connections, wrap the socket using `IO::Socket::SSL` or use a reverse proxy.
*   **Timeouts**: Set `Timeout` in the constructor to prevent hung processes from slow clients.
*   **Forking**: For concurrent request handling, fork a new process after `$d->accept` returns a connection.

## Reference documentation
- [HTTP::Daemon Documentation](./references/metacpan_org_pod_HTTP-Daemon.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-http-daemon_overview.md)