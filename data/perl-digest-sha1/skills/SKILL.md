---
name: perl-digest-sha1
description: This tool calculates SHA-1 message digests for strings, data streams, and files using the Perl Digest::SHA1 module. Use when user asks to calculate SHA-1 hashes, perform data integrity checks, or generate checksums for files and incremental data streams.
homepage: http://metacpan.org/pod/Digest::SHA1
---


# perl-digest-sha1

## Overview
This skill provides guidance on using the `Digest::SHA1` Perl module to calculate SHA-1 message digests. While SHA-1 is no longer recommended for high-security applications due to collision vulnerabilities, it remains a standard for data integrity checks in legacy workflows, Git-like object hashing, and non-cryptographic checksumming. This tool allows for high-performance hashing of strings, data streams, and files.

## Functional Usage
The procedural interface is best for simple, one-off hashing of complete data strings.

```perl
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);

# Returns 20-byte binary digest
$binary = sha1($data);

# Returns 40-character hexadecimal string (most common for CLI/logs)
$hex = sha1_hex($data);

# Returns 27-character base64 string (unpadded)
$b64 = sha1_base64($data);
```

## Object-Oriented Usage
Use the OO interface for large files, data streams, or when you need to calculate a digest incrementally.

```perl
use Digest::SHA1;

$sha1 = Digest::SHA1->new;

# Add data in chunks
$sha1->add($data_part1);
$sha1->add($data_part2);

# Add content of a file directly
open(my $fh, '<', 'file.bin') or die $!;
binmode($fh);
$sha1->addfile($fh);

# Retrieve result (resets the object automatically)
$digest = $sha1->hexdigest;
```

## Expert Tips & Best Practices
- **Memory Efficiency**: For large files, always use `$sha1->addfile($fh)` instead of reading the file into a scalar. This prevents high memory consumption.
- **Binary Mode**: When hashing files on non-Unix systems or handling binary data, always use `binmode($fh)` before calling `addfile` to ensure the digest is calculated correctly.
- **Cloning State**: If you need a "running" digest (e.g., hashing a log file while still adding to it), use `$sha1->clone->hexdigest`. This provides the current digest without resetting the main object's state.
- **Base64 Padding**: The `sha1_base64` and `b64digest` methods do not include trailing `=` padding. If your application expects standard RFC-compliant base64, append `=` manually to the 27-character output.
- **Security Note**: If the application requires collision resistance (e.g., digital signatures), prefer `Digest::SHA` (SHA-256/512) over `Digest::SHA1`.

## Reference documentation
- [Digest::SHA1 - Perl interface to the SHA-1 algorithm](./references/metacpan_org_pod_Digest__SHA1.md)
- [perl-digest-sha1 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-digest-sha1_overview.md)