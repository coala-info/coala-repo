---
name: perl-file-fetch
description: Perl-file-fetch provides a high-level abstraction for retrieving files by automatically selecting the best available download utility on the system. Use when user asks to download files via various protocols, fetch remote content into variables, or create portable Perl-based download scripts.
homepage: https://metacpan.org/pod/File::Fetch
metadata:
  docker_image: "quay.io/biocontainers/perl-file-fetch:1.08--pl5321hdfd78af_0"
---

# perl-file-fetch

## Overview

File::Fetch provides a high-level abstraction for retrieving files without needing to know which specific download utilities are installed on the host system. It acts as a wrapper that probes the environment for available tools—such as LWP, wget, curl, and rsync—and uses them in a predefined priority order to execute the transfer. This skill enables the creation of portable Perl-based download scripts and one-liners that work consistently across different Linux and macOS environments.

## Installation

Install the package via Bioconda to ensure all dependencies are met:

```bash
conda install bioconda::perl-file-fetch
```

## Common CLI Patterns

While File::Fetch is a Perl module, it is frequently used in shell environments via Perl one-liners for quick, protocol-agnostic downloads.

### Basic File Download
Download a file to the current working directory:
```bash
perl -MFile::Fetch -e '$ff = File::Fetch->new(uri => "http://example.com/data.tar.gz"); $ff->fetch() or die $ff->error'
```

### Download to Specific Directory
Specify a target location using the `to` parameter:
```bash
perl -MFile::Fetch -e '$ff = File::Fetch->new(uri => "ftp://server/path/file.txt"); $ff->fetch(to => "/tmp/downloads")'
```

### Slurp File Content to Variable
Fetch a file directly into a scalar variable instead of saving it to disk:
```bash
perl -MFile::Fetch -e '$ff = File::Fetch->new(uri => "http://example.com/config.json"); $ff->fetch(to => \my $content); print $content'
```

## Expert Tips and Best Practices

### Manage Fetcher Priority and Blacklisting
If a specific system utility is failing or producing incorrect output (e.g., a proxy issue with `lynx`), blacklist it globally:
```perl
use File::Fetch;
$File::Fetch::BLACKLIST = [qw|lynx lftp|];
```

### Handle Non-Standard Filenames
When fetching URIs with query strings (e.g., `index.html?version=1`), use the `output_file` accessor to get the cleaned filename:
```perl
my $ff = File::Fetch->new(uri => 'http://example.com/index.html?v=1');
print $ff->output_file; # Returns 'index.html'
```

### Configure Timeouts and Passive FTP
For unstable connections or restrictive firewalls, adjust the global configuration variables:
```perl
$File::Fetch::TIMEOUT = 30;      # Set timeout in seconds
$File::Fetch::FTP_PASSIVE = 1;   # Force passive FTP mode
```

### Protocol Support Order
File::Fetch attempts to use tools in this order. Ensure at least one of the primary tools is in the system PATH:
- **http**: LWP, HTTP::Tiny, wget, curl, lftp, fetch, HTTP::Lite, lynx
- **ftp**: LWP, Net::FTP, wget, curl, lftp, fetch, ncftp, ftp
- **rsync**: rsync
- **git**: git

## Reference documentation
- [File::Fetch - A generic file fetching mechanism](./references/metacpan_org_pod_File__Fetch.md)
- [perl-file-fetch - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-file-fetch_overview.md)