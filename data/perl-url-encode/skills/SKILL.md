---
name: perl-url-encode
description: This skill provides guidance on using the `URL::Encode` Perl library to transform strings into a format suitable for URLs and web forms.
homepage: http://metacpan.org/pod/URL-Encode
---

# perl-url-encode

## Overview
This skill provides guidance on using the `URL::Encode` Perl library to transform strings into a format suitable for URLs and web forms. It is essential for ensuring that special characters (like spaces, ampersands, or non-ASCII symbols) do not break URI structures or data transmission. Use this tool when building web scrapers, interacting with REST APIs, or processing raw `application/x-www-form-urlencoded` data.

## Usage Patterns

### Command Line One-Liners
Since `perl-url-encode` is often installed as a library, the most efficient way to use it from the CLI is via Perl one-liners.

**To Encode a String:**
```bash
perl -MURL::Encode=url_encode -e 'print url_encode("hello world & welcome");'
# Output: hello+world+%26+welcome
```

**To Decode a String:**
```bash
perl -MURL::Encode=url_decode -e 'print url_decode("hello+world+%26+welcome");'
# Output: hello world & welcome
```

### Script Integration
Incorporate these functions into Perl scripts for robust data handling:

```perl
use URL::Encode qw(url_encode url_decode);

# Encoding for a URL query parameter
my $raw_string = "data with spaces & symbols";
my $encoded = url_encode($raw_string);

# Decoding incoming form data
my $decoded = url_decode($encoded);
```

## Best Practices
- **UTF-8 Handling**: Always ensure your input strings are properly encoded/decoded relative to UTF-8 if they contain multi-byte characters. Use `url_encode_utf8` and `url_decode_utf8` for automatic UTF-8 processing.
- **Plus vs. Percent**: Note that `application/x-www-form-urlencoded` typically converts spaces to `+`. If you require RFC 3986 encoding (where space is `%20`), verify if your specific implementation requires standard percent-encoding instead.
- **Context**: Only use this for the *values* of query parameters, not the entire URL, as it will encode structural characters like `:` and `/`.

## Reference documentation
- [URL::Encode Documentation](./references/metacpan_org_pod_URL-Encode.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-url-encode_overview.md)