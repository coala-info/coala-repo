---
name: perl-extutils-cppguess
description: ExtUtils::CppGuess automates the detection of C++ compiler and linker flags for building Perl extensions. Use when user asks to integrate C++ code into Perl modules, configure build flags for ExtUtils::MakeMaker or Module::Build, and detect compiler environments across different operating systems.
homepage: http://metacpan.org/pod/ExtUtils::CppGuess
metadata:
  docker_image: "quay.io/biocontainers/perl-extutils-cppguess:0.27--pl5321h9948957_0"
---

# perl-extutils-cppguess

## Overview
`ExtUtils::CppGuess` is a specialized Perl utility designed to bridge the gap between Perl's `ExtUtils::MakeMaker` or `Module::Build` and C++ code. It automates the "guessing" of compiler environments, ensuring that C++ extensions are built with the correct flags and standard libraries regardless of the underlying operating system. This skill provides the necessary patterns to integrate C++ logic into Perl distributions seamlessly.

## Usage Patterns

### Integration with ExtUtils::MakeMaker
When using `Makefile.PL`, use the object-oriented interface to inject flags into the `WriteMakefile` configuration.

```perl
use ExtUtils::CppGuess;
my $guess = ExtUtils::CppGuess->new;

WriteMakefile(
    NAME          => 'My::Module',
    ( $guess->makemaker_options ), # Automatically adds CC, CCFLAGS, and LDDLFLAGS
    # ... other options
);
```

### Integration with Module::Build
For `Build.PL` setups, use the `module_build_options` method to populate the build configuration.

```perl
use ExtUtils::CppGuess;
my $guess = ExtUtils::CppGuess->new;

my $builder = Module::Build->new(
    module_name => 'My::Module',
    ( $guess->module_build_options ),
    # ... other options
);
```

### Manual Flag Retrieval
If you need fine-grained control or are using a custom build system, extract specific flags directly:

- **Compiler Command**: `$guess->compiler_command`
- **C++ Flags**: `$guess->cpp_flags`
- **Linker Flags**: `$guess->ld_flags`
- **C++ Standard**: Use `$guess->new( cxx => 'C++11' )` to specify a standard version.

### Handling Specific Compilers
The tool identifies the environment as one of the following: `gcc`, `msvc`, or `sun`. You can check this via:
```perl
if ($guess->is_gcc) { ... }
if ($guess->is_msvc) { ... }
```

## Best Practices
- **Always instantiate**: Create a new instance rather than calling methods statically to ensure environment detection runs correctly.
- **Standard Compliance**: If your C++ code requires a specific standard (e.g., C++11 or C++14), pass it to the constructor to ensure the guesser adds the correct compatibility flags for the detected compiler.
- **Cross-Platform Safety**: Avoid hardcoding `-lstdc++` or `-lc++`. Rely on `$guess->ld_flags` to provide the correct library linkage for the platform (e.g., handling the difference between Linux/GCC and macOS/Clang).

## Reference documentation
- [ExtUtils::CppGuess Documentation](./references/metacpan_org_pod_ExtUtils__CppGuess.md)