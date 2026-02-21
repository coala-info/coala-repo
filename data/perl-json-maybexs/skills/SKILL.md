---
name: perl-json-maybexs
description: JSON::MaybeXS serves as a smart compatibility layer for JSON handling in Perl.
homepage: http://metacpan.org/pod/JSON::MaybeXS
---

# perl-json-maybexs

## Overview

JSON::MaybeXS serves as a smart compatibility layer for JSON handling in Perl. It eliminates the need to manually check for installed JSON modules by attempting to load the fastest available backend in order: Cpanel::JSON::XS, then JSON::XS (v3.0+), and finally falling back to the pure-Perl JSON::PP. It provides a consistent API that ensures high performance where possible and guaranteed functionality everywhere else.

## Installation

Install the package via Bioconda to ensure all C-based dependencies are correctly linked:

```bash
conda install bioconda::perl-json-maybexs
```

## Core Usage Patterns

### Functional Interface
For standard tasks, use the exported functions which handle UTF-8 encoding/decoding automatically.

```perl
use JSON::MaybeXS;

# Convert Perl hash/array to UTF-8 encoded JSON
my $json_bytes = encode_json($data_structure);

# Convert UTF-8 encoded JSON to Perl data structure
my $data = decode_json($json_bytes);
```

### Object-Oriented Interface
Use the `new` method to set specific options. This is preferred over calling mutators on the object.

```perl
use JSON::MaybeXS;

my $json_engine = JSON::MaybeXS->new(
    utf8   => 1,
    pretty => 1,
    canonical => 1
);

my $json_text = $json_engine->encode($data);
```

### Handling Booleans
To ensure cross-backend compatibility for boolean values, use the `JSON` constant or the `is_bool` function.

```perl
use JSON::MaybeXS qw(JSON is_bool);

my $data = {
    is_active => JSON()->true,
    is_admin  => JSON()->false,
};

# Check if a value is a JSON boolean
if (is_bool($data->{is_active})) {
    # ...
}
```

## Expert Tips and Best Practices

- **Avoid :legacy tags**: Do not use `use JSON::MaybeXS ':legacy';` or the `to_json`/`from_json` functions in new code. These are provided for backward compatibility and can lead to subtle UTF-8 encoding errors if not handled carefully.
- **Backend Discovery**: Use the `JSON` constant to identify which backend was actually loaded. `print JSON();` will return the class name (e.g., `Cpanel::JSON::XS`).
- **Constructor Arguments**: Always pass configuration options directly to `JSON::MaybeXS->new()`. While backends like `JSON::PP` support mutator methods (e.g., `$json->pretty(1)`), passing them to the constructor is more idiomatic and reliable across different backends.
- **Performance**: In performance-critical environments (like high-throughput bioinformatics pipelines), ensure `Cpanel::JSON::XS` is installed in the environment so `JSON::MaybeXS` can pick it up as the primary backend.

## Reference documentation
- [JSON::MaybeXS - Metacpan](./references/metacpan_org_pod_JSON__MaybeXS.md)
- [perl-json-maybexs - Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-json-maybexs_overview.md)