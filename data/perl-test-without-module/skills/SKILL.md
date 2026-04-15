---
name: perl-test-without-module
description: This tool simulates the absence of Perl modules to test how applications handle missing dependencies. Use when user asks to hide specific modules during testing, verify graceful degradation, or ensure error handling works when a dependency is unavailable.
homepage: http://metacpan.org/pod/Test-Without-Module
metadata:
  docker_image: "quay.io/biocontainers/perl-test-without-module:0.20--pl526_0"
---

# perl-test-without-module

## Overview
This skill provides instructions for using `Test::Without::Module` to verify that Perl applications handle missing dependencies gracefully. It is essential for testing optional features, graceful degradation, and ensuring that error messages or alternative code paths trigger correctly when a required module is not found in `@INC`.

## Usage Patterns

### Basic Module Hiding
To prevent a module from being loaded during a test script, use the module at the very beginning of your test file:

```perl
use Test::Without::Module qw( Config::JSON );

# This will now fail as if the module isn't installed
eval { require Config::JSON };
if ($@) {
    print "Module correctly hidden\n";
}
```

### Hiding Multiple Modules
You can specify a list of modules to be made unavailable:

```perl
use Test::Without::Module qw( LWP::UserAgent HTTP::Cookies );
```

### Dynamic Hiding and Unhiding
If you need to test both the presence and absence of a module within the same test suite, use the `import` and `unimport` methods:

```perl
# Hide the module
Test::Without::Module->import('Data::Dumper');

# ... run tests where Data::Dumper is missing ...

# Restore the module (make it available again)
Test::Without::Module->unimport('Data::Dumper');
```

### Command Line Usage (One-liners)
You can use this on the command line to run existing scripts or tests while simulating a missing dependency:

```bash
perl -MTest::Without::Module=Target::Module script.pl
```

## Best Practices
- **Placement**: Always place the `use Test::Without::Module` statement before any code that might attempt to load the target module (including other `use` statements).
- **Scope**: Remember that once a module is hidden via `use`, it remains hidden for the duration of the process unless `unimport` is called.
- **CI/CD**: Use this tool in Continuous Integration pipelines to ensure that "optional dependency" logic doesn't bit-rot when the build environment happens to have those dependencies installed.

## Reference documentation
- [Test::Without::Module Documentation](./references/metacpan_org_pod_Test-Without-Module.md)