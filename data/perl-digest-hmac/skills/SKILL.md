---
name: perl-digest-hmac
description: The `perl-digest-hmac` skill provides the procedural knowledge required to utilize the `Digest::HMAC` module suite.
homepage: https://metacpan.org/pod/Digest-HMAC
---

# perl-digest-hmac

## Overview
The `perl-digest-hmac` skill provides the procedural knowledge required to utilize the `Digest::HMAC` module suite. This tool is essential for generating message authentication codes, which ensure that data has not been tampered with during transit and originates from a trusted source. It acts as a wrapper around other `Digest` modules, providing a standardized way to apply the HMAC algorithm as defined by RFC 2104.

## Implementation Patterns

### Functional Interface
For simple, one-shot HMAC generation, use the functional interface. This is the most common pattern for verifying small strings or API signatures.

```perl
use Digest::HMAC_MD5 qw(hmac_md5 hmac_md5_hex);

# Returns raw binary digest
my $digest = hmac_md5($data, $key);

# Returns hexadecimal string (most common for web APIs)
my $digest_hex = hmac_md5_hex($data, $key);
```

### Object-Oriented Interface
Use the OO interface when processing large files, streaming data, or when the hash algorithm needs to be swapped dynamically.

```perl
use Digest::HMAC;
use Digest::SHA qw(sha256);

# Initialize with key and the underlying hash function
my $hmac = Digest::HMAC->new($key, "Digest::SHA", 256);

# Add data in chunks
$hmac->add($chunk1);
$hmac->add($chunk2);

# Finalize
my $hex_output = $hmac->hexdigest;
```

## Best Practices
- **Key Management**: Ensure the secret key is handled securely and not hard-coded in scripts. Use environment variables or secure configuration files.
- **Algorithm Selection**: While `HMAC-MD5` is supported for legacy systems, prefer `HMAC-SHA256` or higher for modern security requirements to mitigate collision risks.
- **Binary vs. Hex**: Always clarify if the receiving system expects a raw binary HMAC or a hexadecimal representation. Most command-line tools and web interfaces expect hex.
- **Installation**: On systems using Conda/Bioconda, ensure the environment is active before execution: `conda install bioconda::perl-digest-hmac`.

## Reference documentation
- [Digest::HMAC Documentation](./references/metacpan_org_pod_Digest-HMAC.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-digest-hmac_overview.md)