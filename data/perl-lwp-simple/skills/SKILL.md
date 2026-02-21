---
name: perl-lwp-simple
description: The `perl-lwp-simple` skill provides a streamlined way to interact with web resources via the libwww-perl library.
homepage: https://metacpan.org/pod/LWP::Simple
---

# perl-lwp-simple

## Overview
The `perl-lwp-simple` skill provides a streamlined way to interact with web resources via the libwww-perl library. It focuses on a procedural approach, allowing for rapid execution of GET and HEAD requests. This tool is best suited for tasks like mirroring remote files, printing web content to the terminal, or fetching page source code into variables with minimal boilerplate.

## Common CLI Patterns
While `LWP::Simple` is a Perl module, it is frequently used as a powerful command-line tool via Perl one-liners.

### Fetching and Printing Content
To fetch a URL and pipe its content directly to standard output:
```bash
perl -MLWP::Simple -e 'getprint("http://example.com/data.txt")'
```

### Downloading and Storing Files
To download a remote resource and save it to a specific local file:
```bash
perl -MLWP::Simple -e 'getstore("http://example.com/image.png", "local_image.png")'
```

### Efficient File Mirroring
The `mirror` function is preferred for repetitive downloads because it checks the `Last-Modified` header and only downloads the file if the remote version is newer:
```bash
perl -MLWP::Simple -e 'mirror("http://example.com/bigfile.zip", "bigfile.zip")'
```

### Checking URL Status (HEAD Request)
To retrieve basic metadata about a resource (like content type or size) without downloading the body:
```bash
perl -MLWP::Simple -e 'print join(", ", head("http://example.com"))'
```

## Expert Tips and Best Practices
- **Return Value Validation**: The `get($url)` function returns `undef` if the request fails. When writing scripts, always check if the returned content is defined before processing.
- **Status Codes**: Functions like `getstore` and `mirror` return the HTTP response code (e.g., 200, 404). Use these values to implement basic error handling in your one-liners.
- **Environment Variables**: `LWP::Simple` respects the `http_proxy` and `ftp_proxy` environment variables. Ensure these are set in your shell if you are working behind a corporate firewall.
- **When to Upgrade**: If your task requires custom HTTP headers, cookies, authentication, or POST requests, `LWP::Simple` will be insufficient. In those cases, transition to the full `LWP::UserAgent` module.
- **Bioconda Installation**: If the tool is missing in a bioinformatics environment, it can be installed via:
  ```bash
  conda install bioconda::perl-lwp-simple
  ```

## Reference documentation
- [LWP::Simple - simple procedural interface to LWP](./references/metacpan_org_pod_LWP__Simple.md)
- [perl-lwp-simple - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-lwp-simple_overview.md)