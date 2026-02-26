---
name: perl-module-util
description: This tool manages the relationship between Perl module names and their locations on the filesystem. Use when user asks to validate module names, locate installed modules, find modules within a namespace, or convert between module names and file paths.
homepage: http://metacpan.org/pod/Module::Util
---


# perl-module-util

## Overview
The `perl-module-util` skill provides a set of tools for handling the relationship between Perl module names and the underlying filesystem. It simplifies the process of validating module naming conventions, finding where modules are installed within `@INC`, and performing transformations between canonical module names and relative or absolute paths. This is essential for developers writing scripts that interact with the Perl ecosystem or need to verify the presence and location of specific dependencies.

## Core Functions and Usage

### Module Validation and Canonicalization
Before performing operations on a string intended to be a module name, validate its format to avoid runtime errors.
- **Validate name**: Use `is_valid_module_name($name)` to check if a string follows Perl's naming rules.
- **Canonicalize**: Use `canonical_module_name($name)` to replace older apostrophe separators (`'`) with the modern `::` syntax.

### Locating Installed Modules
Find exactly where a module is located on the disk without manually searching `@INC`.
- **Find first instance**: `find_installed($module)` returns the absolute path to the first version of the module found in the search path.
- **Find all instances**: `all_installed($module)` returns a list of all paths where the module exists (useful for detecting version conflicts).
- **Namespace search**: `find_in_namespace($namespace)` lists all modules installed under a specific prefix (e.g., `find_in_namespace("File")` might return `File::Spec`, `File::Copy`, etc.).

### Path Transformations
Convert between Perl's logical module names and the physical file paths required by the OS.
- **Module to Relative Path**: `module_path("My::Module")` returns `My/Module.pm`.
- **Module to Native Path**: `module_fs_path("My::Module")` returns the path using the current system's directory separators (e.g., `My\Module.pm` on Windows).
- **Path to Module**: `path_to_module("My/Module.pm")` returns `My::Module`.

### Runtime Introspection
- **Check if loaded**: `module_is_loaded($module)` checks `%INC` to see if the module has already been required or used in the current process.

## CLI Utility: pm_which
This package bundles `pm_which`, a command-line tool for quickly locating modules from the shell.
- **Locate a module**: `pm_which Module::Name`
- **Locate all versions**: `pm_which -a Module::Name`
- **List modules in namespace**: `pm_which -r Namespace`

## Best Practices
- **Importing**: Use `use Module::Util qw( :all );` to gain access to all utility functions in a single statement.
- **Dynamic Loading**: When using `require` with a variable, use `require module_path($module_name);` to ensure the path is formatted correctly for the Perl interpreter.
- **Cross-Platform Safety**: Prefer `module_fs_path` over `module_path` if you are passing the result to external system commands or non-Perl IO functions.

## Reference documentation
- [Module::Util - Module name tools and transformations](./references/metacpan_org_pod_Module__Util.md)