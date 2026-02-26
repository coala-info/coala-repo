---
name: perl-config-tiny
description: This tool provides a lightweight interface for reading and writing simple configuration files in the standard Windows-style INI format using Perl. Use when user asks to load settings from .ini files, save configuration data to disk, or manipulate INI-style strings within a Perl script.
homepage: http://metacpan.org/pod/Config::Tiny
---


# perl-config-tiny

## Overview
This skill provides guidance on using the `Config::Tiny` Perl module to handle simple configuration files. It is specifically designed for "Tiny" applications where you need to load or save settings in a standard Windows-style INI format (sections, keys, and values) with the smallest possible code footprint. Use this when you need to automate configuration updates or extract data from `.conf` or `.ini` files within a Perl environment.

## Basic Usage Patterns

### Loading Configuration
To read a file, use the `read` method. Properties at the very top of the file (before any `[section]` header) are stored in the special root section named `_`.

```perl
use Config::Tiny;

# Read a file
my $Config = Config::Tiny->read('config.ini');

# Accessing values
my $root_val = $Config->{_}->{root_property};
my $sec_val  = $Config->{section}->{key};
```

### Creating and Saving Configuration
You can initialize a new object with a hash reference or build it dynamically.

```perl
# Create new
my $Config = Config::Tiny->new;

# Assign data
$Config->{database} = {
    host => 'localhost',
    user => 'root'
};

# Save to file
$Config->write('config.ini');
```

### Handling Arrays (v2.30+)
If a key ends in `[]`, the module treats it as an array, allowing multiple values for the same key.

```perl
# In config.ini:
# [servers]
# ip[]=10.0.0.1
# ip[]=10.0.0.2

my $Config = Config::Tiny->read('config.ini');
my $ips = $Config->{servers}->{ip}; # Returns an array reference
print $ips->[0]; # 10.0.0.1
```

## Expert Tips & Best Practices

- **Encoding**: When dealing with non-ASCII characters, specify the encoding explicitly in the `read` and `write` methods (e.g., `$Config->read('file.ini', 'utf8')`). Note that you do not use the `:` or `<:` prefixes common in standard Perl `open` calls.
- **String Manipulation**: Use `read_string($string)` and `write_string()` to process configuration data already in memory without hitting the disk.
- **Limitations**: 
    - **Comments**: Comments (lines starting with `#` or `;`) are ignored during reading and **deleted** during writing.
    - **Order**: The module does not preserve the order of keys or sections; they are typically output in alphabetical order.
    - **Inline Comments**: Do not put comments on the same line as a value (e.g., `key=val # comment`); the module will include the comment as part of the value.
- **Error Handling**: Always check the return value of `read`. If it fails, the error message is stored in `$Config::Tiny::errstr`.

```perl
my $Config = Config::Tiny->read('file.ini') 
    or die "Failed to read config: " . Config::Tiny->errstr;
```

## Reference documentation
- [Config::Tiny - Read/Write .ini style files](./references/metacpan_org_pod_Config__Tiny.md)