---
name: perl-if
description: The perl-if tool enables conditional or lazy loading of Perl modules at compile time based on a specified condition. Use when user asks to load modules based on operating system constraints, handle version-specific requirements, or enable optional dependencies and debugging tools.
homepage: http://metacpan.org/pod/if
metadata:
  docker_image: "quay.io/biocontainers/perl-if:0.0608--pl5321hdfd78af_2"
---

# perl-if

## Overview
The `perl-if` skill provides a mechanism for "lazy" or conditional module loading in Perl. Unlike a standard `use` statement which executes at compile time regardless of logic, `if` allows you to specify a condition. If the condition evaluates to true, the module is loaded; otherwise, it is skipped. This is essential for maintaining cross-platform compatibility and handling optional dependencies without breaking the script.

## Usage Patterns

### Basic Syntax
The module is invoked using the following pattern:
`use if CONDITION, MODULE => ARGUMENTS;`

### Common Scenarios

#### 1. Version-Specific Loading
Load a module only if the Perl interpreter meets a minimum version requirement.
```perl
use if $] >= 5.010, 'feature' => qw(say state);
```

#### 2. Operating System Constraints
Load platform-specific modules (e.g., loading `Win32::Console` only on Windows).
```perl
use if $^O eq 'MSWin32', 'Win32::Console';
```

#### 3. Environment-Based Debugging
Enable developer tools or debugging modules only when a specific environment variable is set.
```perl
use if $ENV{DEBUG}, 'Devel::Trace';
```

#### 4. Conditional Requirement of Optional Dependencies
Prevent the script from failing if a non-essential module is missing, by checking for its existence or a flag.
```perl
use if eval { require Module::Optional; 1 }, 'Module::Optional';
```

## Expert Tips
- **Comma Requirement**: Always remember the comma after the condition. The syntax is `use if CONDITION, MODULE...`.
- **Negative Logic**: To load a module only if a condition is **false**, use the `unless` module (which is part of the same distribution): `use unless $^O eq 'linux', 'POSIX';`.
- **Arguments**: If the module requires arguments, they must be passed after the module name using the fat comma `=>` or a standard comma.
- **Compile-time Execution**: Even though it feels like a runtime check, `use if` happens at compile time. The condition is evaluated immediately when the parser encounters the line.

## Reference documentation
- [if - use a Perl module if a condition holds](./references/metacpan_org_pod_if.md)