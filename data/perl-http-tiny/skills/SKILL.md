---
name: perl-http-tiny
description: perl-http-tiny is a lightweight HTTP/1.1 client for Perl used for making web requests and retrieving data. Use when user asks to fetch web content, interact with APIs, or perform basic HTTP requests within Perl scripts.
homepage: https://github.com/chansen/p5-http-tiny
metadata:
  docker_image: "quay.io/biocontainers/perl-http-tiny:0.076--pl526_0"
---

# perl-http-tiny

## Overview

The `perl-http-tiny` tool (implemented as the `HTTP::Tiny` Perl module) is a small, simple, and correct HTTP/1.1 client. It is designed to be self-contained with no non-core dependencies, making it the preferred choice for bootstrapping, basic API interactions, and lightweight data retrieval. It provides a consistent interface for handling requests and responses while maintaining a tiny footprint.

## Usage and Best Practices

### Basic Request Pattern
Instantiate the client and execute requests using the standard method calls. Each method returns a hash reference containing the response data.

```perl
use HTTP::Tiny;

my $http = HTTP::Tiny->new();
my $response = $http->get('http://example.com');

if ($response->{success}) {
    print $response->{content};
}
```

### Error Handling
`HTTP::Tiny` does not throw exceptions for connection failures or HTTP errors. Instead, it returns a response hash where the `success` field is false.
- **Internal Errors**: If a request fails before reaching the server (e.g., DNS failure, connection timeout), the status code is set to `599`.
- **Status Check**: Always verify `$response->{success}` or check if `$response->{status}` is in the 2xx range.

### SSL/TLS Configuration
- **Verification**: As of version 0.083, `verify_SSL` is enabled by default (set to 1).
- **Insecure Requests**: To disable SSL verification (not recommended for production), set `verify_SSL => 0` in the constructor or use the environment variable `PERL_HTTP_TINY_SSL_INSECURE_BY_DEFAULT=1`.

### Working with Content
- **Raw Bytes**: Both request and response content are treated as raw bytes. Ensure data is encoded (e.g., UTF-8) before sending and decoded after receiving if necessary.
- **Form Data**: Use the `post_form` method for `application/x-www-form-urlencoded` submissions. Note that `post_form` does not modify the original options hashref passed to it.

### Timeouts and Retries
- **Timeouts**: The default timeout is 60 seconds. Adjust this in the constructor: `HTTP::Tiny->new(timeout => 10)`.
- **Idempotent Retries**: The client may automatically retry idempotent requests (like GET) on certain SSL read errors to improve reliability.

### Common One-Liner Patterns
For quick CLI tasks, use Perl's `-M` flag:

```bash
# Fetch and print content
perl -MHTTP::Tiny -e 'print HTTP::Tiny->new->get("http://example.com")->{content}'

# Check status of a URL
perl -MHTTP::Tiny -e 'print HTTP::Tiny->new->get("http://example.com")->{status}'
```

## Reference documentation
- [bioconda | perl-http-tiny Overview](./references/anaconda_org_channels_bioconda_packages_perl-http-tiny_overview.md)
- [GitHub | p5-http-tiny Repository](./references/github_com_chansen_p5-http-tiny.md)
- [GitHub | p5-http-tiny Commits](./references/github_com_chansen_p5-http-tiny_commits_master.md)