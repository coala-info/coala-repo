---
name: perl-config-any
description: This tool provides a unified interface for loading configuration files across multiple formats into a standardized Perl hash. Use when user asks to load configuration files, detect file formats automatically, or parse multiple configuration stems and directories.
homepage: http://metacpan.org/pod/Config-Any
---


# perl-config-any

## Overview
`Config::Any` provides a unified interface for loading configuration files regardless of their format. Instead of manually implementing parsers for different file types, this skill allows you to detect and load configuration data by simply providing a list of files or a directory. It automatically identifies the correct parser based on file extensions or content, returning a standardized Perl hash reference.

## Core Usage Patterns

### Loading Specific Files
To load a specific set of configuration files, use the `load_files` method. This is the most common pattern when the configuration locations are known.

```perl
use Config::Any;

my @files = ('config.json', 'settings.yml', 'local.conf');
my $cfg = Config::Any->load_files({
    files       => \@files,
    use_ext     => 1, # Use file extensions to determine parser
    flatten_to_hash => 1, # Merge results into a single hash
});
```

### Loading from a Directory
To scan a directory for any supported configuration files, use `load_stems`. This is useful for "conf.d" style architectures.

```perl
my $cfg = Config::Any->load_stems({
    stems   => ['/etc/myapp/config', './config'],
    use_ext => 1,
});
```

### Supported Formats and Requirements
`Config::Any` acts as a wrapper. Ensure the underlying Perl modules for your desired formats are installed:
- **JSON**: `JSON` or `JSON::Syck`
- **YAML**: `YAML` or `YAML::Syck`
- **INI**: `Config::Tiny`
- **XML**: `XML::Simple`
- **Perl**: Native support (requires the file to return a hash reference)

## Expert Tips

### Handling Multiple Formats
If multiple files with the same stem but different extensions exist (e.g., `config.json` and `config.yml`), `Config::Any` will load both unless you filter them. Use `flatten_to_hash` to merge them, but be aware that the order in the `files` array determines which values override others in the event of key collisions.

### Forcing Parser Selection
If your configuration files do not have standard extensions, you can force a specific parser by using the `driver` option within the `load_files` arguments, though this bypasses the "format-agnostic" benefit of the module.

### Error Handling
`Config::Any` generally fails silently if a parser is missing or a file is unreadable, simply skipping that file. To debug, check the return value of `load_files` without `flatten_to_hash`; it returns an array of hashes where the key is the filename and the value is the config data (or an error string).

## Reference documentation
- [Config::Any Documentation](./references/metacpan_org_pod_Config-Any.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-config-any_overview.md)