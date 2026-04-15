---
name: perl-test-requires
description: This Perl testing utility checks for module or version availability and skips tests if requirements are not met. Use when user asks to declare test dependencies, skip tests for missing modules, or enforce minimum Perl versions in test scripts.
homepage: https://github.com/tokuhirom/Test-Requires
metadata:
  docker_image: "quay.io/biocontainers/perl-test-requires:0.11--pl5321hdfd78af_1"
---

# perl-test-requires

## Overview
Test::Requires is a Perl testing utility that provides a clean way to declare dependencies within test scripts. Instead of the test failing because a module is not installed, Test::Requires checks for the module's availability and skips the tests if the requirement is not met. This is particularly useful for testing optional features or ensuring compatibility across different environments where certain non-core modules might be absent.

## Usage Patterns

### 1. Basic Module Requirement
To skip all tests in a file if a specific module is missing:
```perl
use Test::More;
use Test::Requires qw( some::optional::module );

# Tests here only run if the module is present
```

### 2. Version-Specific Requirements
You can specify a minimum version for the required module using a hash reference:
```perl
use Test::Requires {
    'HTTP::MobileAttribute' => 0.01,
};
```

### 3. Perl Version Requirements
Test::Requires can also enforce a minimum Perl version. **Note:** The version string must be quoted to be interpreted correctly.
```perl
use Test::Requires "5.010"; 
# or
use Test::Requires "v5.10";
```

### 4. Procedural Interface
If you need to check for modules dynamically during test execution:
```perl
use Test::Requires;

test_requires 'Some::Module';
```

## Expert Tips and Best Practices

### Handling Release Testing
By default, Test::Requires skips tests silently. However, if you are a module maintainer and want to ensure all dependencies are present during your release process, set the `RELEASE_TESTING` environment variable to true.
- **Behavior**: When `RELEASE_TESTING=1`, Test::Requires will `BAIL_OUT` (stop all testing immediately) instead of skipping if a module is missing.
- **CLI Example**: `RELEASE_TESTING=1 make test`

### Integration in Build Systems
When using `Module::Install`, ensure you declare the dependency in your `Makefile.PL`:
```perl
test_requires 'Test::Requires';
```

### Installation via Conda
In bioinformatics or data science environments using Bioconda, install the package using:
```bash
conda install bioconda::perl-test-requires
```

## Reference documentation
- [perl-test-requires - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-test-requires_overview.md)
- [tokuhirom/Test-Requires: Checks to see if the module can be loaded](./references/github_com_tokuhirom_Test-Requires.md)