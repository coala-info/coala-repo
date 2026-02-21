---
name: perl-libwww-perl
description: The `perl-libwww-perl` suite (commonly known as LWP) is the standard toolkit for web programming in Perl.
homepage: https://metacpan.org/pod/HTTP::CookieJar
---

# perl-libwww-perl

## Overview
The `perl-libwww-perl` suite (commonly known as LWP) is the standard toolkit for web programming in Perl. It provides a consistent object-oriented interface for making HTTP requests, handling responses, and managing web state. This skill focuses on utilizing the core LWP components and the `HTTP::CookieJar` module for efficient, RFC-compliant session management and web automation.

## Core Usage Patterns

### Basic GET Request
The most common entry point is `LWP::UserAgent`.
```perl
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

my $req = HTTP::Request->new(GET => 'http://www.example.com/');
my $res = $ua->request($req);

if ($res->is_success) {
    print $res->content;
} else {
    die $res->status_line;
}
```

### Handling Cookies with HTTP::CookieJar
For modern, minimalist cookie handling that adheres to RFC 6265, use `HTTP::CookieJar`. This is often preferred over the older `HTTP::Cookies` for its simplicity and strictness.

**Manual Cookie Management:**
```perl
use HTTP::CookieJar;

my $jar = HTTP::CookieJar->new;

# Add a cookie from a response header
$jar->add("http://www.example.com/", "session=12345; Path=/; Domain=example.com");

# Generate a header string for a new request
my $cookie_header = $jar->cookie_header("http://www.example.com/api");
```

**Integration with LWP:**
To use the minimalist jar directly with LWP, use the `HTTP::CookieJar::LWP` adapter.
```perl
use LWP::UserAgent;
use HTTP::CookieJar::LWP;

my $ua = LWP::UserAgent->new(
    cookie_jar => HTTP::CookieJar::LWP->new
);
```

### Persistence
To save and load cookies between script executions:
```perl
# Saving
my @dump = $jar->dump_cookies({ persistent => 1 });
# Write @dump to a file...

# Loading
my $new_jar = HTTP::CookieJar->new->load_cookies(@dump);
```

## Expert Tips
- **User Agent Strings**: Always set a custom `agent` string to avoid being blocked by servers that filter the default "libwww-perl" identifier.
- **Timeout Management**: Set `$ua->timeout(10)` to prevent scripts from hanging indefinitely on unresponsive servers.
- **Secure Cookies**: `HTTP::CookieJar` automatically respects the `Secure` flag; cookies marked secure will only be returned for `https` request URLs.
- **Public Suffixes**: If `Mozilla::PublicSuffix` is installed, the cookie jar will automatically prevent "supercookies" from being set on top-level domains (e.g., .com or .co.uk).

## Reference documentation
- [HTTP::CookieJar Documentation](./references/metacpan_org_pod_HTTP__CookieJar.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-libwww-perl_overview.md)