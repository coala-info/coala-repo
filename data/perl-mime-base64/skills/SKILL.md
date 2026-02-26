---
name: perl-mime-base64
description: This tool encodes and decodes data using the Base64 format to facilitate the transmission of binary data over text-based transport layers. Use when user asks to encode files to Base64, decode Base64 strings to binary, or perform URL-safe Base64 transformations.
homepage: http://metacpan.org/pod/MIME::Base64
---


# perl-mime-base64

## Overview
The `perl-mime-base64` skill enables the transformation of arbitrary sequences of octets into a printable 65-character subset of US-ASCII. This is essential for transmitting binary data over transport layers that are not 8-bit clean. This skill covers both standard MIME encoding and the "URL-safe" variant, providing efficient patterns for both script-based and command-line usage.

## CLI Usage Patterns

### Encoding Files
To encode a file into Base64 using a one-liner, use the "slurp" mode (`-0777`) to read the entire file into memory:
```bash
perl -MMIME::Base64 -0777 -ne 'print encode_base64($_)' < input.bin > output.b64
```

### Decoding Files
To decode a Base64 file back to binary:
```bash
perl -MMIME::Base64 -ne 'print decode_base64($_)' < input.b64 > output.bin
```
*Note: Decoding does not require slurp mode if every line in the input contains a multiple of four Base64 characters.*

## Scripting Best Practices

### Handling Large Files
When processing files too large for memory, read and encode in chunks. To ensure lines align perfectly without internal padding, use chunks that are multiples of **57 bytes**. This produces exactly 76 characters of Base64 output per line.

```perl
use MIME::Base64 qw(encode_base64);

open(my $fh, "<", "large_file.dat") or die $!;
binmode($fh);
while (read($fh, my $buf, 57 * 100)) { # 5700 byte chunks
    print encode_base64($buf);
}
```

### URL-Safe Encoding
For web applications where `+` and `/` characters cause issues in URLs, use the URL-safe functions which use `-` and `_` and omit padding:
- `encode_base64url($bytes)`
- `decode_base64url($str)`

### Unicode and Wide Characters
`MIME::Base64` only operates on single-byte characters (0-255). If you attempt to encode a Perl string containing Unicode characters, it will throw a "Wide character in subroutine entry" error. You must encode the string to a byte sequence (e.g., UTF-8) first:

```perl
use MIME::Base64 qw(encode_base64);
use Encode qw(encode);

my $utf8_bytes = encode("UTF-8", $unicode_string);
my $base64 = encode_base64($utf8_bytes);
```

### Efficiency Tips
If you only need to know the size of the resulting data without performing the actual transformation, use the length functions to save CPU cycles:
- `encoded_base64_length($bytes)`
- `decoded_base64_length($str)`

## Reference documentation
- [MIME::Base64 - Encoding and decoding of base64 strings](./references/metacpan_org_pod_MIME__Base64.md)
- [perl-mime-base64 bioconda package](./references/anaconda_org_channels_bioconda_packages_perl-mime-base64_overview.md)