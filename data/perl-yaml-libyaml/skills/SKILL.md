---
name: perl-yaml-libyaml
description: This tool provides a Perl interface to the libyaml C library for high-performance YAML parsing and serialization. Use when user asks to validate YAML syntax, convert YAML files into Perl data structures, or serialize Perl data into YAML format.
homepage: https://github.com/ingydotnet/yaml-libyaml-pm
---


# perl-yaml-libyaml

## Overview
The `perl-yaml-libyaml` package provides the `YAML::XS` module, a Perl XS binding to the `libyaml` C library. It is designed for speed and strict adherence to the YAML 1.1 specification. This tool is the industry standard for Perl applications that require efficient processing of large YAML datasets or secure handling of untrusted YAML input.

## Installation
Install the package via Bioconda:
```bash
conda install bioconda::perl-yaml-libyaml
```

## Common CLI Patterns
While primarily a library, `YAML::XS` is frequently used in Perl one-liners for rapid data processing and validation.

### Validating YAML Files
To check if a file is syntactically valid YAML:
```bash
perl -MYAML::XS -e 'LoadFile("config.yaml")'
```

### Inspecting YAML as Perl Data Structures
To visualize how a YAML file is parsed into Perl hashes and arrays:
```bash
perl -MYAML::XS -MData::Dumper -e 'print Dumper(LoadFile("config.yaml"))'
```

### Quick Serialization
To dump a Perl data structure (e.g., an array of numbers) to the terminal:
```bash
perl -MYAML::XS -e 'print Dump([1..10])'
```

## Expert Tips and Best Practices

### Security: Disabling Object Blessing
By default, older versions of `YAML::XS` might attempt to bless data into objects, which can lead to arbitrary code execution if the input is untrusted.
- **Best Practice**: Explicitly set `$YAML::XS::LoadBlessed = 0;` when loading data from external or untrusted sources. This forces the loader to ignore tags and load data as plain unblessed Perl structures (similar to PyYAML's SafeLoad).

### Strictness: Forbidding Duplicate Keys
To ensure data integrity and follow strict YAML specifications:
- **Best Practice**: Set `$YAML::XS::ForbidDuplicateKeys = 1;`. This causes the `Load` function to die if it encounters duplicate keys in a hash, preventing accidental data loss or ambiguity in large configuration files.

### Handling Booleans
Boolean handling varies by Perl version:
- **Perl 5.36+**: Built-in booleans are recognized automatically by `Dump` and created by `Load`.
- **Older Versions**: Set `$YAML::XS::Boolean = "JSON::PP"` or `"boolean"` to ensure that `true` and `false` are loaded as objects that survive round-tripping through JSON encoders.

### Unicode Handling
`YAML::XS` operates on streams of UTF-8 octets.
- **Best Practice**: Ensure your input strings are UTF-8 encoded before calling `Load`, and treat the output of `Dump` as a UTF-8 octet stream. If you encounter encoding issues, use `Devel::Peek` to inspect the internal state of your scalars.

### Preserving Numeric Formats
To prevent strings that look like numbers (e.g., "0123") from being converted to integers and losing leading zeros:
- **Best Practice**: Keep `$YAML::XS::QuoteNumericStrings = 1;` (the default) to ensure that non-numified numeric strings are quoted during serialization.

## Reference documentation
- [GitHub README](./references/github_com_ingydotnet_yaml-libyaml-pm.md)
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-yaml-libyaml_overview.md)