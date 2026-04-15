---
name: perl-module-runtime
description: This tool provides functions to manage the dynamic loading and validation of Perl modules at runtime. Use when user asks to load modules from string variables, validate module names, or instantiate classes dynamically.
homepage: http://metacpan.org/pod/Module-Runtime
metadata:
  docker_image: "quay.io/biocontainers/perl-module-runtime:0.016--pl526_0"
---

# perl-module-runtime

## Overview
The `perl-module-runtime` skill provides guidance on using the `Module::Runtime` Perl library to manage module loading dynamically. This is essential for plugin systems, factory patterns, or any scenario where the specific module to be used isn't known until the code is running. It replaces the standard `use` or `require` statements with more robust, string-aware alternatives that handle Perl's internal module naming conventions correctly.

## Implementation Patterns

### Core Module Loading
Use `require_module` to load a module from a string variable. This is safer than a raw `eval "require $module"`.

```perl
use Module::Runtime qw(require_module);

my $module = "Data::Dumper";
require_module($module);
# Module is now loaded and available
```

### Safe Instantiation
When creating objects from dynamic classes, use `use_module` which both loads the module and returns the module name, allowing for clean method chaining.

```perl
use Module::Runtime qw(use_module);

my $class = "My::App::Plugin";
my $object = use_module($class)->new(%args);
```

### Module Name Validation
Before attempting to load, verify that a string is a syntactically valid Perl module name to prevent injection or runtime crashes.

```perl
use Module::Runtime qw(is_module_name check_module_name);

my $input = "Invalid-Module-Name";

if (is_module_name($input)) {
    # Safe to proceed
}

# Or throw an exception if invalid
check_module_name($input);
```

### Composing Module Names
When building sub-module names (e.g., adding a prefix to a user-provided plugin name), use `module_notional_filename` to handle path conversions correctly.

```perl
use Module::Runtime qw(module_notional_filename);

my $name = "My::Module";
my $rel_path = module_notional_filename($name); 
# Result: "My/Module.pm"
```

## Best Practices
- **Avoid string eval**: Always prefer `require_module` over `eval "require $module"` to avoid security vulnerabilities and subtle parsing bugs.
- **Check availability**: Use `is_module_name` on any user-provided strings before attempting to load them.
- **Namespace Safety**: When loading plugins, consider prepending a base namespace to the input string to ensure the code only loads modules from an expected directory.

## Reference documentation
- [Module::Runtime Documentation](./references/metacpan_org_pod_Module-Runtime.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-module-runtime_overview.md)