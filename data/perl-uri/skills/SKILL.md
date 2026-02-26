---
name: perl-uri
description: This tool provides a programmatic interface for creating, parsing, and manipulating URI references as objects. Use when user asks to parse URLs, resolve relative paths to absolute URIs, normalize URI strings, or convert between file system paths and URI formats.
homepage: https://github.com/libwww-perl/URI
---


# perl-uri

## Overview

The `perl-uri` skill provides a programmatic interface for handling URI references as defined by RFC 2396 and RFC 2732. Instead of using complex regular expressions to parse URLs, this skill utilizes the `URI` class to treat identifiers as objects. This ensures that URI components are handled consistently, percent-encoding is managed correctly, and hierarchical relationships between relative and absolute paths are resolved reliably.

## Installation

To use this module, ensure it is installed in your environment:

```bash
# Via Conda (Bioconda channel)
conda install bioconda::perl-uri

# Via CPAN
cpan URI
```

## Core Usage Patterns

### Creating URI Objects
The constructor identifies the appropriate subclass based on the scheme provided.

```perl
use URI ();

# Create from string
my $u = URI->new("http://www.example.com/foo/bar?q=1#frag");

# Create relative URI with a specific scheme context
my $rel = URI->new("data.txt", "http");
```

### Component Manipulation
Methods act as both getters and setters. Passing an argument updates the component and returns the previous value.

```perl
my $scheme   = $u->scheme;     # http
my $host     = $u->host;       # www.example.com
my $path     = $u->path;       # /foo/bar
my $query    = $u->query;      # q=1
my $fragment = $u->fragment;   # frag

# Updating components
$u->scheme("https");
$u->host("api.example.com");
```

### Resolving Relative URIs
Use `new_abs` or the `abs` method to convert a relative path into a fully qualified absolute URI using a base.

```perl
my $base = URI->new("http://example.com/subdir/index.html");
my $rel  = "images/logo.png";

# Method 1: Constructor
my $abs_uri = URI->new_abs($rel, $base); # http://example.com/subdir/images/logo.png

# Method 2: Existing object
my $u_rel = URI->new($rel);
my $u_abs = $u_rel->abs($base);
```

### Normalization (Canonicalization)
To compare two URIs or ensure they follow standard formatting (e.g., lowercase schemes, removing default ports), use the `canonical` method.

```perl
my $u = URI->new("HTTP://Example.COM:80/path/.././file")->canonical;
print $u; # http://example.com/file
```

### Working with File Paths
The `URI::file` subclass is specialized for converting between native file system paths and URI strings.

```perl
use URI::file;

# Convert OS path to URI
my $u = URI::file->new("/home/user/docs/file.txt");

# Get current working directory as URI
my $cwd = URI::file->cwd;
```

## Expert Tips

*   **Stringification**: URI objects are overloaded to stringify automatically. You can use them directly in strings: `print "URL is: $u";`.
*   **Missing vs. Empty**: Accessor methods return `undef` if a component is missing, but an empty string `""` if the component is present but empty. Always check for definedness when parsing.
*   **Cloning**: Since URI objects are mutable, use `$u->clone` if you need to modify a URI while preserving the original object.
*   **Generic Access**: If a scheme is not recognized by a specific subclass, the object falls back to generic methods like `opaque`, which handles the part of the URI after the scheme.

## Reference documentation
- [The Perl URI module](./references/github_com_libwww-perl_URI.md)
- [perl-uri - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-uri_overview.md)