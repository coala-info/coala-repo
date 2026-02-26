---
name: perl-digest-md5
description: This tool provides an interface to the MD5 message-digest algorithm for calculating 128-bit fingerprints of data in Perl. Use when user asks to calculate MD5 checksums, generate hex or base64 digests for strings, or perform incremental hashing of large files.
homepage: http://metacpan.org/pod/Digest-MD5
---


# perl-digest-md5

## Overview
The `perl-digest-md5` skill provides the procedural knowledge required to interface with the MD5 algorithm using Perl. This module allows for the creation of 128-bit fingerprints (digests) for arbitrary length messages. It is highly efficient, utilizing C implementations where available, and supports incremental hashing of data from strings, filehandles, or objects.

## Usage Patterns

### One-Liner CLI Usage
For quick checksums of strings or files without writing a full script:

```bash
# Digest of a string
perl -MDigest::MD5=md5_hex -e 'print md5_hex("data_to_hash")'

# Digest of a file
perl -MDigest::MD5 -e '$ctx=Digest::MD5->new; open(FH, "<", "file.txt"); $ctx->addfile(*FH); print $ctx->hexdigest, "\n"'
```

### Core Scripting Methods
When writing Perl scripts, use the functional interface for simplicity or the OO interface for large/streaming data.

#### Functional Interface (Best for small strings)
```perl
use Digest::MD5 qw(md5 md5_hex md5_base64);

$hash = md5($data);        # 16-byte binary
$hex  = md5_hex($data);    # 32-character hex string
$b64  = md5_base64($data); # 22-character base64 string
```

#### Object-Oriented Interface (Best for files and streams)
```perl
use Digest::MD5;

$md5 = Digest::MD5->new;

# Add data incrementally
$md5->add($part1);
$md5->add($part2);

# Add content of a file directly (efficient)
open(my $fh, '<', 'large_data.bin') or die $!;
binmode($fh);
$md5->addfile($fh);
close($fh);

$checksum = $md5->hexdigest;
```

## Expert Tips
- **Binary Mode**: Always use `binmode($fh)` when reading files on non-Unix systems (like Windows) before calling `addfile` to ensure the digest is calculated correctly.
- **Memory Efficiency**: For very large files, `addfile` is preferred over reading the file into a scalar variable, as it processes the file in chunks without loading the entire content into RAM.
- **Base64 Padding**: Note that `md5_base64` does not include the trailing `==` padding. If your application requires standard RFC 2045 padding, you must append it manually or use `md5_hex`.
- **Security Warning**: MD5 is no longer considered cryptographically secure against collision attacks. Use it for integrity checks and non-security-critical hashing, but prefer SHA-256 or SHA-512 for security-sensitive applications.

## Reference documentation
- [Digest::MD5 Documentation](./references/metacpan_org_pod_Digest-MD5.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-digest-md5_overview.md)