---
name: perl-data-uuid
description: The `perl-data-uuid` skill provides a high-performance interface for generating 128-bit unique identifiers based on RFC 4122.
homepage: https://metacpan.org/pod/Data::UUID
---

# perl-data-uuid

## Overview

The `perl-data-uuid` skill provides a high-performance interface for generating 128-bit unique identifiers based on RFC 4122. It is capable of generating identifiers at extremely high rates (up to 10 million per second), making it suitable for both short-lived and persistent objects. The tool supports multiple output formats including binary, standard string representation, hex, and Base64, and allows for deterministic UUID generation using specific namespaces (DNS, URL, OID, X500).

## Installation

To use this tool, ensure the module is installed via Bioconda or CPAN:

```bash
# Via Bioconda
conda install bioconda::perl-data-uuid

# Via CPAN
cpanm Data::UUID
```

## Common Usage Patterns

### Quick UUID Generation (CLI One-liner)
Generate a standard UUID string directly from the command line:
```bash
perl -MData::UUID -e '$ug = Data::UUID->new; print $ug->create_str(), "\n"'
```

### Deterministic Namespace-based UUIDs
Use this pattern when you need the same input (namespace + name) to always produce the same UUID:
```perl
use Data::UUID;
$ug = Data::UUID->new;

# Generate a UUID based on a URL
$uuid = $ug->create_from_name_str(NameSpace_URL, "www.example.com");
```

### Format Conversions
The tool is often used to convert between compact binary storage and human-readable strings:

```perl
use Data::UUID;
$ug = Data::UUID->new;

# Convert a binary UUID to various string formats
$bin_uuid = $ug->create();
$str  = $ug->to_string($bin_uuid);      # Standard: 601E9C40-1DD2-11B2-B17E-C09EFE1DC403
$hex  = $ug->to_hexstring($bin_uuid);   # Hex: 0x...
$b64  = $ug->to_b64string($bin_uuid);   # Base64 encoded

# Convert back to binary
$bin = $ug->from_string($str);
```

## Expert Tips and Best Practices

- **Case Sensitivity**: Note that `create_str()` and `to_string()` return capitalized hex digits (A-F). This differs from the lowercase preference in some RFC 4122 implementations. If your downstream application requires lowercase, pipe the output through `lc()`.
- **Performance**: For bulk generation, instantiate the `Data::UUID` object once and reuse it. The object maintains state necessary for the generation algorithm.
- **Binary Storage**: When performance and storage are critical (e.g., in high-volume databases), store UUIDs in their 16-byte binary form using `create_bin()` rather than the 36-character string representation.
- **Comparison**: Always use the built-in `compare()` method for binary UUIDs rather than string comparisons to ensure accuracy and performance:
  ```perl
  # Returns -1, 0, or 1
  $is_equal = ($ug->compare($uuid1, $uuid2) == 0);
  ```

## Reference documentation
- [Data::UUID - Globally/Universally Unique Identifiers](./references/metacpan_org_pod_Data__UUID.md)
- [perl-data-uuid Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-data-uuid_overview.md)