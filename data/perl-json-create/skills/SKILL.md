---
name: perl-json-create
description: This tool encodes Perl data structures into JSON format with a focus on speed and UTF-8 output. Use when user asks to convert Perl variables to JSON, handle boolean values in JSON output, or serialize Perl objects using TO_JSON methods.
homepage: https://metacpan.org/pod/distribution/JSON-Create/lib/JSON/Create.pod
metadata:
  docker_image: "quay.io/biocontainers/perl-json-create:0.35--pl5321h7b50bb2_5"
---

# perl-json-create

## Overview
The `perl-json-create` skill provides a streamlined interface for encoding Perl variables into JSON format. It is designed for speed and simplicity, focusing strictly on UTF-8 output. This tool is ideal for backend Perl scripts, API development, or data processing pipelines where performance and memory footprint are prioritized over complex configuration options.

## Usage Patterns

### Basic Encoding
To convert a Perl data structure to a JSON string:

```perl
use JSON::Create 'create_json';

my %data = (
    name => "Example",
    id   => 123,
    tags => ["perl", "json"]
);

my $json = create_json(\%data);
```

### Handling Booleans
The module recognizes specific Perl types to output JSON `true` and `false`:

- Use `JSON::Create::bool` for explicit boolean values.
- Use `Types::Serialiser` if available.

```perl
use JSON::Create 'create_json';

my $data = {
    active => JSON::Create::true,
    hidden => JSON::Create::false,
};

print create_json($data);
```

### Object Serialization
To serialize objects, the module looks for a `TO_JSON` method:

```perl
package MyObject;
sub new { bless { key => 'value' }, shift }
sub TO_JSON { return { %{$_[0]} } }

package main;
use JSON::Create 'create_json';
my $obj = MyObject->new();
print create_json($obj);
```

## Best Practices
- **UTF-8 Consistency**: Ensure your Perl strings are upgraded to UTF-8 before encoding, as the module assumes UTF-8 input and produces UTF-8 output.
- **Minimalism**: Use this module when you do not need JSON parsing (decoding). If you need to read JSON, pair this with a dedicated parser like `JSON::Parse`.
- **Performance**: For maximum speed in tight loops, import `create_json` directly rather than calling it via the fully qualified package name.

## Reference documentation
- [JSON::Create - MetaCPAN](./references/metacpan_org_pod_distribution_JSON-Create_lib_JSON_Create.pod.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-json-create_overview.md)