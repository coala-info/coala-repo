---
name: perl-inline
description: The perl-inline module allows you to embed and execute source code from other programming languages directly within Perl scripts. Use when user asks to write Perl subroutines in foreign languages, optimize performance-critical code with C or C++, or glue existing libraries to Perl without using XS.
homepage: https://github.com/ingydotnet/inline-pm
---


# perl-inline

## Overview
The `perl-inline` module allows you to embed source code from other programming languages directly within your Perl scripts or modules. It automates the process of compiling, loading, and binding these subroutines, making them accessible as native Perl functions. This tool is particularly useful for optimizing performance-critical sections of code or "gluing" existing C/C++ libraries to Perl without the steep learning curve of XS or SWIG.

## Usage Patterns and Best Practices

### The DATA Section Pattern
The most maintainable way to use Inline is by placing the external code in the `__DATA__` section. This keeps the Perl logic at the top and the foreign code at the bottom, avoiding the need to escape characters in Perl strings.

```perl
use Inline C => 'DATA';

print "Result: ", add(10, 20), "\n";

__DATA__
__C__
int add(int x, int y) {
  return x + y;
}
```

### Performance and Compilation
*   **First-run Latency**: Inline compiles code only on the first execution or when the source is modified. Subsequent runs use the cached binary.
*   **Build Directory**: By default, Inline creates a `_Inline/` directory to store build artifacts. Ensure the user running the script has write permissions to the working directory, or configure a specific path using the `DIRECTORY` option.

### Supported Languages
While C is the most common use case, Inline supports a wide array of languages via Inline Language Support Modules (ILSMs):
*   **Systems**: C, C++, Assembler.
*   **Scripting**: Python, Ruby, Tcl, Awk.
*   **Others**: Java, Octave, Basic, and even Template Toolkit (TT).

### Configuration Options
You can pass configuration parameters during the `use` statement to control build behavior:
*   **DIRECTORY**: Specify where to store compiled binaries.
*   **NAME**: Set the name of the extension being built.
*   **VERSION**: Specify the version of the module.

```perl
use Inline C => 'DATA',
           DIRECTORY => '/tmp/perl-inline-cache',
           NAME => 'MyModule';
```

### Expert Tips
*   **Barewords**: Because Inline binds functions at runtime when using the `DATA` keyword, Perl may not recognize the functions as barewords during compilation. Use parentheses `func()` or pre-declare them if necessary.
*   **C Cookbook**: For C-specific integration, refer to `Inline::C-Cookbook` for patterns on handling Perl's internal data structures (SV, AV, HV) within C code.
*   **Distribution**: When distributing modules on CPAN that use Inline, the code is compiled during the installation phase, ensuring the end-user does not experience compilation delays.

## Reference documentation
- [Inline - Write Perl Subroutines in Other Programming Languages](./references/github_com_ingydotnet_inline-pm.md)
- [perl-inline - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-inline_overview.md)