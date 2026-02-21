---
name: perl-yaml-tiny
description: This skill provides guidance on using `YAML::Tiny`, a Perl module designed to handle a subset of YAML with minimal overhead.
homepage: http://search.cpan.org/dist/YAML-Tiny/lib/YAML/Tiny.pm
---

# perl-yaml-tiny

## Overview
This skill provides guidance on using `YAML::Tiny`, a Perl module designed to handle a subset of YAML with minimal overhead. It is ideal for configuration files and simple data structures where the full YAML specification is not required. It is particularly useful in bioinformatics pipelines (via bioconda) and restricted Perl environments because it is implemented in pure Perl and has no non-core dependencies.

## Basic Usage Patterns

### Reading YAML
To load a YAML file into a Perl data structure:
```perl
use YAML::Tiny;

# Open a file and read the first document
my $yaml = YAML::Tiny->read('config.yml');

# Get the root of the first document (usually a hash or array reference)
my $data = $yaml->[0];

# Access data
my $value = $data->{key};
```

### Writing YAML
To save a Perl data structure to a file:
```perl
use YAML::Tiny;

# Create a new object
my $yaml = YAML::Tiny->new;

# Add data (must be a reference)
$yaml->[0] = {
    name => 'example',
    version => 1.0,
    tags => ['perl', 'tiny']
};

# Save to file
$yaml->write('output.yml');
```

### String Manipulation
To parse or generate YAML from strings instead of files:
```perl
# Parse from string
my $yaml = YAML::Tiny->read_string($yaml_text);

# Generate string from object
my $string = $yaml->write_string;
```

## Best Practices and Constraints
- **Subset Support**: `YAML::Tiny` only supports a functional subset of YAML. Avoid using complex features like aliases, anchors, or custom data types.
- **Single vs. Multi-document**: The `YAML::Tiny` object acts as an array reference where each element is a separate YAML document. Always access `$yaml->[0]` for single-document files.
- **Error Handling**: Check the return value of `read()`. If it fails, the error message is stored in `$YAML::Tiny::errstr`.
- **UTF-8**: Ensure your Perl script handles layers correctly (e.g., `use utf8;`) if your YAML contains non-ASCII characters, as `YAML::Tiny` handles raw octets.

## Reference documentation
- [YAML::Tiny CPAN Documentation](./references/metacpan_org_pod_distribution_YAML-Tiny_lib_YAML_Tiny.pm.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-yaml-tiny_overview.md)