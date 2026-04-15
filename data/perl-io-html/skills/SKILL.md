---
name: perl-io-html
description: This tool automatically detects and handles HTML character encoding in Perl using the HTML5 algorithm. Use when user asks to open HTML files with automatic charset detection, find the encoding of an HTML string, or handle character sets via meta tags and BOMs.
homepage: http://metacpan.org/pod/IO-HTML
metadata:
  docker_image: "quay.io/biocontainers/perl-io-html:1.004--pl5321hdfd78af_0"
---

# perl-io-html

## Overview
The `perl-io-html` skill provides a reliable way to handle the complexities of HTML character encoding in Perl. Instead of manually guessing or hardcoding encodings, this tool implements the HTML5 algorithm to find the correct charset via Byte Order Marks (BOM), `<meta>` tags, or HTTP headers. This is essential for web scraping, data migration, or any task where HTML source files come from diverse or unknown origins.

## Usage Guidelines

### Core Functionality
The primary interface is the `html_file` function, which opens a file and automatically sets the appropriate Perl IO layer.

```perl
use IO::HTML;

# Open a file with automatic encoding detection
my $fh = html_file($filename);

# Read content as decoded Unicode strings
while (<$fh>) {
    print $_;
}
```

### Handling Encodings Manually
If you already have the content in a scalar or want to detect the encoding without opening a file handle, use `find_charset_in`.

```perl
use IO::HTML qw(find_charset_in);

my $encoding = find_charset_in($html_content);
# Returns the canonical name of the encoding (e.g., "UTF-8")
```

### Best Practices
- **Prefer `html_file` over `open`**: When dealing with HTML, standard `open($fh, "<:encoding(UTF-8)", $file)` will fail or corrupt data if the file is actually encoded in `ISO-8859-1`. `html_file` handles this transition gracefully.
- **Default Fallback**: If no encoding is detected, the tool defaults to `UTF-8` (per HTML5 specs), but you can provide a fallback if necessary.
- **Dependencies**: Ensure the `IO::HTML` module is installed via CPAN or Bioconda (`conda install bioconda::perl-io-html`) before execution.

## Reference documentation
- [IO::HTML - Open an HTML file with automatic charset detection](./references/metacpan_org_pod_IO-HTML.md)
- [Bioconda perl-io-html Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-io-html_overview.md)