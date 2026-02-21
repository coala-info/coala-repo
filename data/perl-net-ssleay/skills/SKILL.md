---
name: perl-net-ssleay
description: Net::SSLeay is a high-performance Perl extension that provides a comprehensive interface to the OpenSSL library.
homepage: http://metacpan.org/pod/Net::SSLeay
---

# perl-net-ssleay

## Overview
Net::SSLeay is a high-performance Perl extension that provides a comprehensive interface to the OpenSSL library. It serves two primary purposes: offering high-level convenience functions for rapid web development (such as simple HTTPS GET and POST requests) and providing low-level bindings that map directly to OpenSSL's C functions. This skill helps in configuring secure connections, handling client-side certificates, and ensuring robust error handling in Perl-based security implementations.

## Installation and Setup
In bioinformatics and data science environments, the package is typically managed via Conda:
```bash
conda install bioconda::perl-net-ssleay
```
For standard Perl environments, it is available via CPAN as `Net::SSLeay`.

## High-Level API Usage
For most web-related tasks, use the high-level convenience functions. These handle the socket creation, SSL handshake, and data transfer in a single call.

### Secure Web Requests
- **GET**: `($page, $response, %reply_headers) = Net::SSLeay::get_https($host, $port, $path);`
- **POST**: `($page, $response, %reply_headers) = Net::SSLeay::post_https($host, $port, $path, $make_headers, $body);`

### Working with Proxies
To route HTTPS traffic through a proxy, use the `set_proxy` function before making requests:
`Net::SSLeay::set_proxy($proxy_host, $proxy_port, $user, $pass);`

## Low-Level OpenSSL Integration
When fine-grained control is required (e.g., custom cipher suites or non-standard handshakes), use the low-level API which mirrors the OpenSSL C library.

### Initialization Sequence
Always initialize the library and error strings before performing SSL operations:
1. `Net::SSLeay::load_error_strings();`
2. `Net::SSLeay::SSLeay_add_ssl_algorithms();`
3. `Net::SSLeay::randomize();`

### Context and Connection Management
1. **Create Context**: `$ctx = Net::SSLeay::CTX_new();`
2. **Set Method**: Use `Net::SSLeay::SSLv23_method()` for maximum compatibility (negotiates highest available protocol).
3. **Create SSL Object**: `$ssl = Net::SSLeay::new($ctx);`
4. **Bind to Socket**: `Net::SSLeay::set_fd($ssl, fileno(S));`

## Best Practices and Expert Tips
- **Error Handling**: Always check the return value of SSL operations. Use `Net::SSLeay::print_errs()` to dump the OpenSSL error stack to STDERR for debugging.
- **Certificate Verification**: By default, some high-level functions might not strictly verify certificates. Always implement `CTX_set_verify` in production environments to prevent Man-in-the-Middle (MitM) attacks.
- **Thread Safety**: If using in a multi-threaded Perl application, ensure you are using a version of OpenSSL and Net::SSLeay compiled with thread support, and call `Net::SSLeay::thread_safe()` to verify.
- **Memory Management**: When using the low-level API, remember to explicitly free objects using `CTX_free($ctx)` and `free($ssl)` to prevent memory leaks in long-running processes.

## Reference documentation
- [perl-net-ssleay - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-net-ssleay_overview.md)
- [Net::SSLeay - metacpan.org](./references/metacpan_org_pod_Net__SSLeay.md)