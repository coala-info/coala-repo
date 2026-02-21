---
name: perl-inline-c
description: `Inline::C` is a powerful Perl module that allows you to write C code directly inside your Perl source files.
homepage: https://github.com/ingydotnet/inline-c-pm
---

# perl-inline-c

## Overview

`Inline::C` is a powerful Perl module that allows you to write C code directly inside your Perl source files. It eliminates the traditional overhead of creating separate XS files, running `h2xs`, and managing complex build systems. When the script runs, the module automatically compiles the C code, generates the necessary "glue" code to bridge the two languages, and loads the resulting shared library. This makes it an essential tool for developers who need the speed of C with the flexibility of Perl.

## Core Usage Patterns

### Basic Implementation
The most common way to use the tool is by placing C code after the `__DATA__` or `__END__` tokens in your Perl script.

```perl
use Inline C;

print "9 + 16 = ", add(9, 16), "\n";

__DATA__
__C__
int add(int x, int y) {
  return x + y;
}
```

### Configuration and External Libraries
For more complex tasks, such as linking against system libraries or adding include paths, use the `Config` option.

```perl
use Inline C => Config =>
           LIBS => '-lgsl -lgslcblas -lm',
           INC  => '-I/usr/local/include';
use Inline C => <<'END_C';
#include <gsl/gsl_zeta.h>
double my_zeta(double x) {
    return gsl_sf_zeta(x);
}
END_C
```

## Expert Tips and Best Practices

### 1. Use `SV*` for Perl Scalars
While `Inline::C` handles basic types like `int`, `double`, and `char*` automatically, use the `SV*` (Scalar Value) type when you need to manipulate Perl variables directly or return complex data.

### 2. Extending Compiler Flags
Avoid using `ccflags` directly as it replaces the default Perl compiler flags, which may lead to compilation errors. Instead, use `ccflagsex` to append your custom flags to the existing environment.
```perl
use Inline C => Config => ccflagsex => '-DXTRA_DEBUG -O3';
```

### 3. Automatic Wrapping
If you are interfacing with a library that has many simple functions, enable `autowrap`. This allows `Inline::C` to parse function prototypes and create wrappers automatically without you having to write a C body for every function.
```perl
use Inline C => Config => autowrap => 1;
```

### 4. Handling Function Signatures
*   **Return Types**: Ensure the return type is on the same line as the function name for the parser to recognize it correctly.
*   **Void Arguments**: To define a function with no arguments, use `SV* MyFunc()` or `void MyFunc()`. Note that `void MyFunc(void)` is only supported if using the `ParseRegExp` parser.

### 5. Preprocessing
If your C code relies on complex macros or conditional compilation, use the `Preprocess` filter.
```perl
use Inline C => DATA => 
           CPPFLAGS => '-DDEBUG_MODE',
           FILTERS => 'Preprocess';
```

## Installation
The tool is available via Bioconda for environment-managed setups:
```bash
conda install bioconda::perl-inline-c
```

## Reference documentation
- [Inline::C - C Language Support for Inline](./references/github_com_ingydotnet_inline-c-pm.md)
- [perl-inline-c - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-inline-c_overview.md)