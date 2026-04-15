---
name: perl-test-fatal
description: This Perl testing utility captures and returns exceptions thrown by code blocks to facilitate error inspection. Use when user asks to capture exceptions in Perl tests, verify that code dies with a specific error, or check that a block of code executes without throwing an exception.
homepage: https://github.com/rjbs/Test-Fatal
metadata:
  docker_image: "quay.io/biocontainers/perl-test-fatal:0.016--pl5321hdfd78af_0"
---

# perl-test-fatal

## Overview

`Test::Fatal` is a streamlined Perl testing utility designed to handle exceptions with minimal overhead. Unlike older frameworks that provide many specialized assertions, `Test::Fatal` focuses on a primary helper—`exception { ... }`—which captures and returns whatever error a block of code throws. This allows developers to use standard `Test::More` tools to inspect the results, making tests more readable and easier to debug. It is the modern successor to `Test::Exception`.

## Installation

To install the package via Conda (Bioconda channel):

```bash
conda install bioconda::perl-test-fatal
```

## Core Usage Patterns

### Capturing an Exception
The `exception` function takes a block of code. If the code dies, it returns the exception object or string. If it succeeds, it returns `undef`.

```perl
use Test::More;
use Test::Fatal;

# Test that an exception is thrown
my $err = exception { die "something went wrong" };
like($err, qr/something went wrong/, "Caught the expected error message");

# Test that code succeeds (returns undef)
is(
    exception { my $x = 1 + 1 },
    undef,
    "The code block executed without dying"
);
```

### Testing for Specific Exception Objects
If your code throws objects (e.g., via `Throwable` or `Moose::Exception`), you can use standard `isa_ok` on the result.

```perl
use Test::More;
use Test::Fatal;

my $err = exception { My::Module->throw_error };
isa_ok($err, 'My::Module::Exception', 'The exception object');
is($err->code, 500, "The error code is correct");
```

## Expert Tips and Best Practices

### Avoid `lives_ok` and `dies_ok`
While `Test::Fatal` provides `lives_ok` and `dies_ok` for compatibility with `Test::Exception`, the author recommends using the raw `exception` block. It is more flexible and avoids issues with test counts and nested blocks.

### Handling "False" Exceptions
Perl can technically "die" with a false value (like `die 0` or `die ""`). `Test::Fatal` is designed to handle these correctly, but you should always check for the existence of an exception rather than just truthiness.

**Recommended Pattern:**
```perl
# Good: Explicitly check for undef to confirm success
is( exception { ... }, undef, "Code lived" );

# Good: Explicitly check for definedness to confirm failure
ok( defined exception { ... }, "Code died" );
```

### Wrapping Calls with Stack Traces
Be cautious when wrapping code that generates its own stack traces (like `Carp::confess`). `Test::Fatal` sets `$Carp::MaxArgNums` to -1 internally during execution to ensure it doesn't interfere with the capture of the exception state.

## Reference documentation
- [perl-test-fatal - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-test-fatal_overview.md)
- [rjbs/Test-Fatal GitHub Repository](./references/github_com_rjbs_Test-Fatal.md)