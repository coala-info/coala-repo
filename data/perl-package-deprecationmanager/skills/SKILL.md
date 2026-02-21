---
name: perl-package-deprecationmanager
description: The `Package::DeprecationManager` provides a standardized way for Perl module authors to manage deprecations.
homepage: http://metacpan.org/release/Package-DeprecationManager
---

# perl-package-deprecationmanager

## Overview
The `Package::DeprecationManager` provides a standardized way for Perl module authors to manage deprecations. Instead of scattered `warn` statements, it allows you to tie deprecations to specific package versions. This enables end-users to opt-in or opt-out of specific deprecation warnings by declaring the version of your module they are compliant with.

## Usage Patterns

### Implementing Deprecations in a Module
To use this in your package, import the module and define the deprecations.

```perl
package My::Module;
use Package::DeprecationManager -deprecations => {
    'My::Module::old_method' => '1.00',
    'My::Module::feature_x'  => '1.05',
};

sub old_method {
    my $self = shift;
    # This triggers a warning if the consumer hasn't suppressed it
    deprecated(); 
    # ... method logic ...
}
```

### Consumer Usage (Suppressing Warnings)
Users of your module can suppress warnings by specifying the version they have coded against.

```perl
# No warnings will be issued for deprecations introduced in 1.00 or earlier
use My::Module -api_version => '1.00';
```

## Best Practices
- **Granular Naming**: Use fully qualified sub names or specific feature names in the deprecation hash to give users precise control.
- **Version Alignment**: Always match the version string in the `-deprecations` hash to the actual release version where the feature became deprecated.
- **Global Suppression**: Remind users that they can set the `PACKAGE_DEPRECATION_MANAGER_REPORT_ALL` environment variable to true to see all warnings regardless of `-api_version` settings, which is useful for technical debt audits.

## Reference documentation
- [Package-DeprecationManager on MetaCPAN](./references/metacpan_org_release_Package-DeprecationManager.md)