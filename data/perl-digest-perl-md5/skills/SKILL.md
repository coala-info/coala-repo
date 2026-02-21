---
name: perl-digest-perl-md5
description: The `Digest::Perl::MD5` module provides a robust, platform-independent way to generate 128-bit fingerprints (message digests) for arbitrary data.
homepage: http://metacpan.org/pod/Digest-Perl-MD5
---

# perl-digest-perl-md5

## Overview
The `Digest::Perl::MD5` module provides a robust, platform-independent way to generate 128-bit fingerprints (message digests) for arbitrary data. While slower than the C-based `Digest::MD5`, it is functionally compatible and serves as a reliable fallback for bioinformatics pipelines or legacy Perl scripts running in restricted environments (like certain Conda environments or "noarch" platforms) where binary extensions cannot be compiled.

## Usage Patterns

### Basic Functional Interface
For quick one-off checksums of strings, use the exported functional interface.

```perl
use Digest::Perl::MD5 qw(md5 md5_hex md5_base64);

my $data = "sequence_data_or_string";

# Returns binary digest (16 bytes)
my $binary = md5($data);

# Returns 32-character hexadecimal string (Most Common)
my $hex = md5_hex($data);

# Returns 22-character base64 string
my $b64 = md5_base64($data);
```

### Object-Oriented Interface
Use the OO approach when processing large files or streaming data to avoid loading everything into memory at once.

```perl
use Digest::Perl::MD5;

my $ctx = Digest::Perl::MD5->new;

# Add data in chunks
$ctx->add($part1);
$ctx->add($part2);

# Add content of a filehandle directly
open(my $fh, '<', 'data.fasta') or die $!;
$ctx->addfile($fh);
close($fh);

# Finalize and get result
my $digest = $ctx->hexdigest;
```

## Best Practices
- **Compatibility**: This module is a drop-in replacement for `Digest::MD5`. If your script needs to be portable, you can use a conditional wrapper:
  ```perl
  eval { require Digest::MD5; import Digest::MD5 qw(md5_hex); 1; } 
  or do { require Digest::Perl::MD5; import Digest::Perl::MD5 qw(md5_hex); };
  ```
- **Performance**: Be aware that as a pure-Perl implementation, it is significantly slower than the XS version. Avoid using it for high-throughput cryptographic hashing of terabyte-scale genomic data if a C-based alternative is available.
- **Data Integrity**: Always ensure input strings are in the expected encoding (usually UTF-8 or raw bytes) before hashing, as MD5 is sensitive to character encoding differences.

## Reference documentation
- [Digest::Perl::MD5 Documentation](./references/metacpan_org_pod_Digest-Perl-MD5.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-digest-perl-md5_overview.md)