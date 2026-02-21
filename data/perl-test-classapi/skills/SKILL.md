---
name: perl-test-classapi
description: `Test::ClassAPI` is a specialized Perl testing utility designed for "first-pass" verification of large software libraries.
homepage: https://github.com/karenetheridge/Test-ClassAPI
---

# perl-test-classapi

## Overview
`Test::ClassAPI` is a specialized Perl testing utility designed for "first-pass" verification of large software libraries. Rather than testing logic, it focuses on structural correctness—ensuring that all expected classes are loadable, required methods are implemented, and inheritance relationships are intact. It uses a concise, INI-style configuration embedded in the test script's `__DATA__` section to automate what would otherwise be hundreds of repetitive `can_ok` and `isa_ok` tests.

## Installation
The package is available via Bioconda for environment-managed Perl setups:
```bash
conda install bioconda::perl-test-classapi
```

## Basic Usage Pattern
A typical test script using `Test::ClassAPI` follows this structure:

```perl
#!/usr/bin/perl
use strict;
use Test::More;
use Test::ClassAPI;

# Load the modules you want to test
use My::Project::Base;
use My::Project::User;

# Execute the tests based on the __DATA__ section
Test::ClassAPI->execute;

__DATA__
# Class Manifest: ClassName=Type
My::Project::Base=abstract
My::Project::User=class

[My::Project::Base]
id=method
created_at=method

[My::Project::User]
My::Project::Base=isa
username=method
password=method
```

## Manifest Definitions
The root of the `__DATA__` section defines the "Class Manifest". Each entry must be one of three types:

*   **class**: A standard, instantiable class. The tool verifies the class loads and implements all methods listed in its section and its superclasses.
*   **abstract**: A base class that is part of your tree but not instantiated directly. Methods listed here are expected to be found in the subclasses.
*   **interface**: An external set of methods (like `File::Handle`). The tool does not check if the interface itself exists, only that your classes claiming to implement it actually have the methods.

## Class Section Directives
Each class defined in the manifest must have a corresponding `[ClassName]` section:

*   **method**: Checks for method existence using `UNIVERSAL::can`.
    *   Example: `save=method`
*   **isa**: Checks inheritance. This is recursive; if `Class B` is an `isa` of `Class A`, `Class A` will also be tested for all methods defined in the `Class B` section.
    *   Example: `Parent::Class=isa`

## Expert Tips
### Enforcing API Completeness
By default, the tool only checks for the *existence* of methods you list. To ensure your documentation/manifest hasn't missed any public methods, use the `complete` option:

```perl
Test::ClassAPI->execute( complete => 1 );
```
This triggers an additional check for every class to ensure that every public method (those not starting with an underscore) present in the package is also explicitly detailed in your API description.

### Integration with Test::More
While `Test::ClassAPI` can generate its own plan, it is best practice to let it work alongside `Test::More`. If you don't provide a plan, `Test::ClassAPI` will attempt to create one, but for complex test suites, you should manage the plan at the top of the script.

### Handling Large Trees
For very large projects, organize your `__DATA__` section alphabetically by class name. Since the tool performs recursive `isa` checks, keeping the manifest organized helps maintainers identify where inherited methods are defined.

## Reference documentation
- [github_com_karenetheridge_Test-ClassAPI.md](./references/github_com_karenetheridge_Test-ClassAPI.md)
- [anaconda_org_channels_bioconda_packages_perl-test-classapi_overview.md](./references/anaconda_org_channels_bioconda_packages_perl-test-classapi_overview.md)