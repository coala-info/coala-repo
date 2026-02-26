---
name: perl-http-server-simple
description: This tool provides a minimal, pure-Perl HTTP server implementation designed to be embedded directly into applications. Use when user asks to create a standalone web server, embed a lightweight HTTP service in a Perl script, or run a background server for integration testing.
homepage: https://metacpan.org/pod/HTTP::Server::Simple
---


# perl-http-server-simple

## Overview

The `perl-http-server-simple` tool (specifically the `HTTP::Server::Simple` Perl module) provides a minimal, pure-Perl HTTP server implementation. It is designed to be embedded directly into applications. By default, it is a single-process, non-forking server, making it extremely easy to debug and deploy for low-concurrency tasks. It can be extended via `Net::Server` if more complex behaviors like forking or pre-forking are required.

## Implementation Patterns

### Basic Standalone Server
To create a server, you typically subclass `HTTP::Server::Simple::CGI`. This allows you to handle requests using a standard CGI-like interface.

```perl
package MyServer;
use base qw(HTTP::Server::Simple::CGI);

sub handle_request {
    my ($self, $cgi) = @_;
    
    # Output headers and content directly to STDOUT
    print "HTTP/1.0 200 OK\r\n";
    print $cgi->header;
    print $cgi->start_html("Hello World");
    print $cgi->h1("Hello from Perl!");
    print $cgi->end_html;
}

# Start the server on port 8080
my $server = MyServer->new(8080);
$server->run();
```

### Running in the Background
For integration tests or tools that need to continue execution after starting the server, use the `background()` method. It returns the PID of the server process.

```perl
my $pid = MyServer->new(8080)->background();
print "Server running on PID: $pid\n";
# ... perform other tasks ...
kill 'TERM', $pid;
```

### Routing and Dispatching
Since the module is "simple," it does not include a built-in router. Use a hash map to dispatch requests based on `path_info()`.

```perl
sub handle_request {
    my ($self, $cgi) = @_;
    my $path = $cgi->path_info();
    
    my %dispatch = (
        '/api/status' => \&send_status,
        '/api/data'   => \&send_data,
    );

    if (exists $dispatch{$path}) {
        print "HTTP/1.0 200 OK\r\n";
        $dispatch{$path}->($cgi);
    } else {
        print "HTTP/1.0 404 Not Found\r\n";
    }
}
```

## Expert Tips

*   **Signal Handling**: The server automatically traps `SIGHUP` to restart itself and `SIGPIPE` to prevent the server from dying if a client closes a connection prematurely. If your request handler forks, ensure you reset the `SIGHUP` handler in the child process.
*   **Port Selection**: If you pass no port to `new()`, it defaults to 8080. Use `0` as the port number if you want the OS to assign an available ephemeral port, then query it using `$server->port()`.
*   **Concurrency**: If you need to handle multiple simultaneous requests, integrate with `Net::Server` by defining a `net_server` method in your class that returns the name of a `Net::Server` subclass (e.g., `Net::Server::PreFork`).
*   **Standard IO**: The server redirects `STDIN` and `STDOUT` to the socket. Anything printed to `STDOUT` inside `handle_request` is sent to the client.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-http-server-simple_overview.md)
- [HTTP::Server::Simple Documentation](./references/metacpan_org_pod_HTTP__Server__Simple.md)
- [HTTP::Server::Simple::CGI Documentation](./references/metacpan_org_pod_HTTP__Server__Simple__CGI.md)