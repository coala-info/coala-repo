---
name: perl-net-http
description: The perl-net-http tool provides a low-level Perl interface for managing HTTP protocol communication and socket-level interactions. Use when user asks to initialize HTTP connections, manually format request headers, read response bodies in chunks, or handle chunked transfer encoding.
homepage: https://github.com/libwww-perl/Net-HTTP
---


# perl-net-http

## Overview
The `perl-net-http` skill provides guidance on using the `Net::HTTP` module, a low-level interface for HTTP communication. It is designed for scenarios where you need to interact with HTTP servers at the protocol level. This module allows for manual header manipulation, explicit management of chunked transfer encoding, and socket-level optimizations. It is a subclass of `IO::Socket::INET` (or `IO::Socket::IP`), meaning it inherits standard socket methods while adding HTTP-specific logic.

## Usage Instructions

### Initializing a Connection
The constructor requires a `Host`. By default, it connects to port 80.

```perl
use Net::HTTP;

my $s = Net::HTTP->new(
    Host => "www.example.com",
    KeepAlive => 1,
    HTTPVersion => "1.1"
) || die "Connection failed: $@";
```

### Sending Requests
Use `write_request` to format and send the HTTP request line and headers.

```perl
$s->write_request(GET => "/", 
    'User-Agent' => "MyClient/1.0",
    'Accept'     => "*/*"
);
```

If sending content (e.g., POST), pass it as the final argument. `Content-Length` is added automatically if content is provided.

### Reading Responses
The response process is split into two phases: headers and body.

1. **Read Headers**: Returns the status code, message, and a list of header key/value pairs.
   ```perl
   my ($code, $mess, %h) = $s->read_response_headers;
   print "Response: $code $mess\n";
   ```

2. **Read Body**: Use a loop to read the entity body in chunks. This method handles `Content-Length` and `Transfer-Encoding: chunked` automatically.
   ```perl
   while (1) {
       my $buf;
       my $n = $s->read_entity_body($buf, 4096);
       die "Read error: $!" unless defined $n;
       last unless $n; # EOF
       print $buf;
   }
```

### Handling Chunked Uploads
If you need to stream data using chunked transfer encoding:

1. Send the request with the `Transfer-Encoding: chunked` header.
2. Use `write_chunk($data)` for each segment.
3. Use `write_chunk_eof()` to terminate the stream.

### Expert Tips
*   **Lax Mode**: If dealing with non-compliant or legacy servers (pre-HTTP/1.0), use the `laxed` option in `read_response_headers(laxed => 1)`. This prevents the module from dying on missing headers or malformed status lines.
*   **Header Limits**: To prevent DoS from malicious servers, `Net::HTTP` defaults to `MaxLineLength => 8192` and `MaxHeaderLines => 128`. Adjust these in the constructor if your specific use case involves unusually large headers.
*   **Socket Access**: Since `$s` is an `IO::Socket` object, you can use `select()` or `can_read()` for non-blocking I/O patterns, though `Net::HTTP` methods are generally synchronous.

## Reference documentation
- [Net::HTTP Main Documentation](./references/github_com_libwww-perl_Net-HTTP.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-net-http_overview.md)