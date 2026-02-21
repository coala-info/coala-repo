---
name: perl-module-load
description: The `Module::Load` Perl module provides a "Do What I Mean" (DWIM) interface for loading modules and files.
homepage: http://metacpan.org/pod/Module::Load
---

# perl-module-load

## Overview

The `Module::Load` Perl module provides a "Do What I Mean" (DWIM) interface for loading modules and files. Unlike the built-in `require` or `use` statements, which have different syntax for loading a `.pm` module versus a `.pl` file, this tool provides a unified `load` function that automatically determines the correct loading mechanism based on the input.

## Usage Guidelines

### Basic Module Loading
Use `load` to pull in a module using its standard package name. This eliminates the need to convert `::` to `/` or append `.pm`.

```perl
use Module::Load;

# Load a module from a string or variable
my $module = "Data::Dumper";
load $module;

# Now you can use the module's functions
print Dumper({ a => 1 });
```

### Loading Files
If the input looks like a filename (contains dots or slashes), the tool treats it as a file path.

```perl
use Module::Load;

# Loads a specific file
load "My/Local/Script.pl";
```

### Conditional Loading
This tool is ideal for optional dependencies or platform-specific modules where you want to avoid compile-time failures.

```perl
use Module::Load;

eval {
    load "JSON::XS";
};
if ($@) {
    load "JSON::PP";
}
```

### Exporting Symbols
By default, `load` does not import symbols into your namespace (it behaves like `require`). To import symbols, call the `import` method manually after loading:

```perl
use Module::Load;

load "LWP::UserAgent";
# If you need to import specific functions:
# "LWP::UserAgent"->import();
```

## Best Practices
- **Variable Names**: Always use `load` when the module name is stored in a variable to avoid the complex `eval "require $module"` syntax.
- **Error Handling**: Wrap `load` in an `eval` block or use `Try::Tiny` if there is a risk the module is not installed, as `load` will `die` on failure.
- **Distinction**: Use `autoload` (provided by the same package) if you want to load a module and have it automatically call its `import` method, though `load` is generally preferred for clarity.

## Reference documentation
- [Module::Load Documentation](./references/metacpan_org_pod_Module__Load.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-module-load_overview.md)