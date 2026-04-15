---
name: perl-module-list
description: This tool inspects the Perl module namespace to discover installed modules, sub-namespaces, and their file system paths. Use when user asks to list installed Perl modules, find the file path of a module, or search for documentation files within a specific namespace.
homepage: http://metacpan.org/pod/Module::List
metadata:
  docker_image: "quay.io/biocontainers/perl-module-list:0.005--pl5321hdfd78af_0"
---

# perl-module-list

## Overview

The `perl-module-list` skill provides a specialized interface for inspecting the Perl module namespace. Unlike standard directory listings, this tool abstracts away the complexities of `@INC` (Perl's library search path), treating multiple physical directory trees as a single logical namespace. Use this skill to automate the discovery of installed components, verify module existence, or retrieve file system paths for `.pm` and `.pod` files.

## Usage Guidelines

### Core Function: `list_modules`
The primary entry point is the `list_modules(PREFIX, OPTIONS)` function. It requires a prefix string and a configuration hash reference.

**Key Options:**
- `list_modules`: Set to `1` to return actual module names.
- `list_prefixes`: Set to `1` to return sub-namespaces (directories).
- `recurse`: Set to `1` to search all sub-levels; otherwise, it only looks one level deep.
- `return_path`: Set to `1` to get the absolute file system path instead of just a boolean existence check.

### Common Patterns

#### 1. Basic Module Discovery
To find all modules directly under a specific namespace (e.g., `MyApp::Plugin::`):
```perl
use Module::List qw(list_modules);

my $modules = list_modules("MyApp::Plugin::", { list_modules => 1 });
# Returns: { "MyApp::Plugin::Auth" => undef, "MyApp::Plugin::Log" => undef }
```

#### 2. Deep Discovery with Paths
To find every module under a namespace, including nested ones, and locate their files:
```perl
my $results = list_modules("MyNamespace::", { 
    list_modules => 1, 
    recurse      => 1, 
    return_path  => 1 
});

foreach my $mod (keys %$results) {
    print "Found $mod at " . $results->{$mod}{module_path} . "\n";
}
```

#### 3. Finding Documentation (POD)
To locate standalone documentation files that might not be inside `.pm` files:
```perl
my $docs = list_modules("Project::", { list_pod => 1, return_path => 1 });
```

### Expert Tips
- **Trailing Colons**: Always ensure the `PREFIX` ends with `::` (e.g., `File::`) unless searching the top-level namespace (use `""`).
- **Empty Options**: Calling `list_modules` with an empty options hash `{}` returns nothing. You must explicitly enable `list_modules`, `list_prefixes`, or `list_pod`.
- **Trivial Syntax**: If working with tools like `perldoc` that might pass non-standard module strings, enable `trivial_syntax => 1` to allow more relaxed naming conventions that don't strictly follow Perl bareword rules.
- **Performance**: For very large library paths, avoid `recurse => 1` unless necessary, as it performs a directory crawl across all entries in `@INC`.

## Reference documentation
- [Module::List Documentation](./references/metacpan_org_pod_Module__List.md)