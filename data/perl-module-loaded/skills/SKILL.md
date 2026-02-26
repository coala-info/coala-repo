---
name: perl-module-loaded
description: This tool manages Perl's internal module tracking to mark packages as loaded or unloaded without modifying the filesystem. Use when user asks to fake the presence of a module, check if a package is registered, or force Perl to forget a loaded module for reloading.
homepage: http://metacpan.org/pod/Module::Loaded
---


# perl-module-loaded

## Overview
The `Module::Loaded` utility provides a clean interface for manipulating Perl's module tracking mechanism. In standard Perl operations, the `%INC` hash tracks which files have already been loaded to prevent redundant processing. This skill allows you to programmatically "fake" the presence of a module (making `require` or `use` a no-op) or "forget" a loaded module so that Perl attempts to find and load it again from `@INC`. This is primarily used in test environments to simulate the presence or absence of heavy dependencies or to isolate code from the local environment.

## Usage Patterns

### Marking a Module as Loaded
To prevent Perl from searching for a module on disk, mark it as loaded. This is useful for mocking.
```perl
use Module::Loaded;

# Mark 'Database::Connection' as loaded
mark_as_loaded('Database::Connection');

# This require will now do nothing and return true
eval "require Database::Connection"; 
```

### Checking Load Status
Verify if a package is currently registered in the internal load path.
```perl
my $location = is_loaded('My::Module');
if ($location) {
    print "Module is registered at: $location\n";
} else {
    print "Module is not currently marked as loaded.\n";
}
```

### Unloading a Module
Force Perl to "forget" a module. This is useful when you need to reload a modified version of a module or test how code behaves when a dependency is missing.
```perl
mark_as_unloaded('Experimental::Feature');

# Perl will now search @INC for Experimental/Feature.pm again
eval "require Experimental::Feature";
```

## Best Practices
- **Barewords vs. Strings**: The functions accept both barewords and strings (e.g., `mark_as_loaded(Foo)` or `mark_as_loaded('Foo')`). Use strings for dynamic package names.
- **Error Handling**: If you attempt to mark a module as loaded that is already in `%INC`, the module will issue a warning (carp). Check `is_loaded()` first if you want to avoid noise in test logs.
- **Testing Isolation**: Use `mark_as_loaded` in `BEGIN` blocks to ensure that subsequent `use` statements in the main script do not trigger actual file system lookups for the mocked modules.
- **Scope**: Remember that these changes affect the global `%INC` for the duration of the Perl process.

## Reference documentation
- [Module::Loaded - mark modules as loaded or unloaded](./references/metacpan_org_pod_Module__Loaded.md)