---
name: perl-yaml
description: The perl-yaml skill provides procedural knowledge for utilizing the `YAML.pm` module (and its variants) via the command line.
homepage: https://github.com/ingydotnet/yaml-pm
---

# perl-yaml

## Overview
The perl-yaml skill provides procedural knowledge for utilizing the `YAML.pm` module (and its variants) via the command line. While primarily a Perl library, it is frequently used in shell environments for rapid data serialization and deserialization. This skill focuses on efficient one-liner patterns, security configurations for loading untrusted data, and navigating the ecosystem of Perl YAML implementations to ensure the best performance and compatibility for specific tasks.

## Installation and Setup
The package is commonly available via the Bioconda channel for bioinformatics and general-purpose environments.
- **Conda Installation**: `conda install bioconda::perl-yaml`
- **Verification**: `perl -MYAML -e 'print "YAML module version: $YAML::VERSION\n"'`

## Command Line Usage Patterns
Since `perl-yaml` is a library, "native" command line usage is achieved through Perl one-liners.

### Basic Data Processing
- **Validate and Reformat**: To check if a file is valid and print it in a standard format, use the Load/Dump round-trip:
  `perl -MYAML -e 'print Dump(Load(do { local $/; <> }))' input_file`
- **Extract Specific Elements**: Use Perl's data access syntax within the one-liner:
  `perl -MYAML -e '$data = Load(do { local $/; <> }); print $data->{key_name}' input_file`

### Handling Multiple Documents
The `Load` function can handle streams containing multiple documents.
- **Process All Documents**:
  `perl -MYAML -e '@docs = Load(do { local $/; <> }); foreach $d (@docs) { ... }' input_file`

## Expert Tips and Best Practices

### Security and Safety
- **Disable Blessed Objects**: By default, loading "blessed" (objects) can be a security risk. Ensure `$YAML::LoadBlessed` is set to false (0) when handling untrusted input.
  `perl -MYAML -e '$YAML::LoadBlessed = 0; $data = Load(<>); ...'`
- **Code Execution**: Loading code references is experimental and disabled by default. Only enable `$YAML::LoadCode` if you explicitly trust the source and require subroutine serialization.

### Implementation Selection
- **Performance (YAML::XS)**: For large files or high-performance requirements, use `YAML::XS` instead of the pure-Perl `YAML.pm`. It is a C-based wrapper around `libyaml` and is significantly faster.
- **Modern Standards (YAML::PP)**: For better compliance with YAML 1.2 specifications, the maintainers recommend `YAML::PP`.
- **Minimal Footprint (YAML::Tiny)**: Use `YAML::Tiny` for simple configuration files where a small, dependency-free implementation is preferred.

### Global Configuration Variables
- **$YAML::Indent**: Adjust the number of spaces used for indentation in `Dump`.
- **$YAML::SortKeys**: Controls whether hash keys are sorted alphabetically in the output (default is 1/true).
- **$YAML::UseFold**: Determines if long strings should be folded.

## Reference documentation
- [YAML Perl Module Overview](./references/github_com_ingydotnet_yaml-pm.md)
- [Bioconda perl-yaml Package Details](./references/anaconda_org_channels_bioconda_packages_perl-yaml_overview.md)
- [YAML.pm Tags and Releases](./references/github_com_ingydotnet_yaml-pm_tags.md)