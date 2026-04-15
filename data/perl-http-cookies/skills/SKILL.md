---
name: perl-http-cookies
description: This tool manages HTTP cookie jars for Perl applications to maintain stateful web interactions and user sessions. Use when user asks to manage cookies, maintain persistent web sessions, or simulate browser behavior in Perl scripts.
homepage: https://github.com/libwww-perl/http-cookies
metadata:
  docker_image: "quay.io/biocontainers/perl-http-cookies:6.11--pl5321hdfd78af_0"
---

# perl-http-cookies

## Overview
The `perl-http-cookies` skill enables the management of "cookie jars" for Perl applications. It is essential for tasks that involve logging into websites, maintaining user sessions across multiple requests, or simulating browser behavior. This module allows you to store, retrieve, and persist cookies in various formats, ensuring that stateful web interactions remain consistent even after a script finishes execution.

## Core Usage Patterns

### Initializing a Persistent Cookie Jar
To save cookies between script runs, initialize the object with a file path and enable `autosave`.
```perl
use HTTP::Cookies;
my $cookie_jar = HTTP::Cookies->new(
    file      => "cookies.dat",
    autosave  => 1,
    ignore_discard => 1 # Save session cookies that would normally be deleted
);
```

### Integrating with LWP::UserAgent
The most common use case is attaching the jar to a UserAgent object so it handles headers automatically.
```perl
use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->cookie_jar($cookie_jar);

# Now, requests to a server will include relevant cookies,
# and responses will update the cookie jar automatically.
$ua->get("https://example.com/login");
```

### Manual Cookie Manipulation
If you need to inject a specific cookie manually:
```perl
$cookie_jar->set_cookie(
    $version, $key, $val, $path, $domain, $port,
    $path_spec, $secure, $maxage, $discard, \%rest
);
```

### Working with Netscape/Mozilla Formats
If you need to read or write cookies in a format compatible with standard web browsers, use the specific subclass:
```perl
use HTTP::Cookies::Netscape;
my $cookie_jar = HTTP::Cookies::Netscape->new(
    file => "cookies.txt",
);
```

## Expert Tips
- **Public Suffix Limitation**: Be aware that `HTTP::Cookies` does not support the Public Suffix List (RFC 6265). This means it may incorrectly allow a site to set cookies for an entire top-level domain (e.g., `.com`). For high-security applications, consider `HTTP::CookieJar::LWP` as an alternative, though it has a more limited feature set.
- **Session Persistence**: By default, cookies marked "discard" (session cookies) are not saved to disk. Set `ignore_discard => 1` in the constructor if you need to maintain a "logged-in" state across separate script executions.
- **Debugging**: Use `$cookie_jar->as_string` to inspect the current state of the jar during development to verify that cookies are being captured correctly from responses.
- **Clearing State**: Use `$cookie_jar->clear()` to wipe the jar, or `$cookie_jar->revert()` to discard current memory changes and reload from the last saved file state.

## Reference documentation
- [GitHub Repository - libwww-perl/HTTP-Cookies](./references/github_com_libwww-perl_http-cookies.md)