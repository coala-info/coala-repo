---
name: perl-util-properties
description: This tool manages configuration data in Perl by mimicking the behavior of Java's property files. Use when user asks to load, modify, store, or manage key-value configuration files using the Util::Properties module.
homepage: http://metacpan.org/pod/Util::Properties
---


# perl-util-properties

## Overview
The `perl-util-properties` skill enables seamless management of configuration data within Perl environments by mimicking the behavior of `java.util.Properties`. This is particularly useful for cross-platform projects where configuration files must be shared between Java and Perl components, or when a simple, hierarchical-capable key-value storage format is preferred over complex XML or JSON structures.

## Basic Usage Patterns

### Loading and Accessing Properties
To initialize and read a configuration file:
```perl
use Util::Properties;

my $props = Util::Properties->new();
$props->load("config.properties");

# Retrieve a value
my $val = $props->getProperty("database.host");

# Retrieve with a default fallback
my $port = $props->getProperty("database.port", 3306);
```

### Modifying and Saving
```perl
# Set or update a property
$props->setProperty("last.run", time());

# Save changes back to a file
$props->store("config.properties", "Updated via Perl script");
```

### Handling Hierarchies and Groups
`Util::Properties` supports property grouping, allowing you to extract subsets of configuration:
```perl
# Get all properties starting with a specific prefix
my $db_settings = $props->getGroup("database.");

# Iterate through all keys
foreach my $key ($props->propertyNames()) {
    print "$key => " . $props->getProperty($key) . "\n";
}
```

## Best Practices
- **Encoding**: Ensure property files are saved in ISO-8859-1 encoding if strict Java compatibility is required, though the Perl module handles standard UTF-8 gracefully in most modern environments.
- **Comments**: Use `#` or `!` for comments. When using the `store()` method, the header string provided will be automatically formatted as a comment at the top of the file.
- **Variable Substitution**: While the base module focuses on I/O, always validate keys before usage in system calls to prevent injection if property files are user-writable.
- **Memory Management**: For very large property files, consider loading only necessary groups if memory constraints exist, though typically these files are small enough for full in-memory residency.

## Reference documentation
- [Util::Properties Documentation](./references/metacpan_org_pod_Util__Properties.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-util-properties_overview.md)