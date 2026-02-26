---
name: perl-module-implementation
description: This tool implements the LWP::UserAgent Perl module to dispatch web requests and manage HTTP responses. Use when user asks to fetch web content, handle cookies, configure secure SSL connections, or use command-line utilities like lwp-request.
homepage: https://github.com/libwww-perl/libwww-perl
---


# perl-module-implementation

## Overview
The libwww-perl (LWP) collection is the industry-standard suite of Perl modules for World-Wide Web interaction. This skill focuses on the implementation of `LWP::UserAgent` to dispatch requests and receive `HTTP::Response` objects. It emphasizes robust error handling, security best practices like protocol whitelisting, and efficient session management through cookie jars and connection caching.

## Core Implementation Patterns

### Basic Request Handling
The primary workflow involves initializing a user agent, executing a request method (get, post, put, delete, head), and inspecting the response object.

```perl
use LWP::UserAgent ();

my $ua = LWP::UserAgent->new(timeout => 10);
$ua->env_proxy; # Load proxy settings from environment variables

my $response = $ua->get('https://example.com');

if ($response->is_success) {
    # Use decoded_content to automatically handle character set conversions
    print $response->decoded_content;
} else {
    die "HTTP Error: " . $response->status_line;
}
```

### Secure Configuration
To prevent unauthorized protocol usage or insecure connections, explicitly define allowed protocols and SSL options.

- **Protocol Whitelisting**: Use `protocols_allowed => ['http', 'https']` to prevent the agent from using potentially dangerous protocols like `file` or `gopher`.
- **SSL Verification**: By default, `ssl_opts` has `verify_hostname => 1`. Do not disable this in production environments.
- **Identity**: Set a custom `agent` string to identify your application to server administrators.

### Session and Cookie Management
For stateful interactions (logins, multi-step forms), use `HTTP::CookieJar::LWP`.

```perl
use HTTP::CookieJar::LWP ();
my $ua = LWP::UserAgent->new(
    cookie_jar => HTTP::CookieJar::LWP->new,
);
```

## CLI Tool Usage
LWP bundles several command-line utilities (often symlinked as `GET`, `POST`, `HEAD`) for rapid testing without writing scripts.

- **Basic Fetch**: `lwp-request http://example.com`
- **Inspect Headers**: Use the `-e` flag to show response headers only: `lwp-request -e http://example.com`
- **Custom Methods**: Use the `-m` flag: `lwp-request -m POST http://example.com < data.txt`
- **Authentication**: Use the `-C` flag for basic credentials: `lwp-request -C user:pass http://example.com`

## Expert Tips
- **Content Handling**: Always prefer `$response->decoded_content` over `$response->content`. The former handles Gzip decompression and Charset decoding automatically.
- **Cloning**: Use `$ua->clone` to create a new agent with the same configuration, but note that the `cookie_jar` is not cloned and will be `undef` in the new instance.
- **Connection Caching**: For high-performance scripts making many requests to the same host, enable `keep_alive` in the constructor to reuse TCP connections.
- **Large Downloads**: For memory efficiency when downloading large files, use the `:content_file` or `:content_cb` (callback) arguments in the request methods to stream data directly to disk.

## Reference documentation
- [LWP::UserAgent Main Documentation](./references/github_com_libwww-perl_libwww-perl.md)
- [Security Policy](./references/github_com_libwww-perl_libwww-perl_security.md)