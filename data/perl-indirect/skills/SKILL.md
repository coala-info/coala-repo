---
name: perl-indirect
description: This module detects and discourages the use of indirect object syntax in Perl to prevent parsing ambiguities. Use when user asks to identify indirect method calls, enforce direct method syntax, or audit Perl scripts for potential bugs caused by indirect calls.
homepage: http://search.cpan.org/dist/indirect/
---


# perl-indirect

## Overview
The `perl-indirect` module is a pragma used to detect and discourage the "indirect object" syntax in Perl. While Perl allows calling methods using `method $object` or `method Class`, this syntax is prone to parsing ambiguities—especially when the method name conflicts with a subroutine in the current namespace. This skill provides the necessary patterns to integrate `indirect` into Perl scripts and one-liners to ensure code clarity and prevent "Dazzler" style bugs.

## Usage Patterns

### Basic Enforcement
To catch indirect calls during compilation, invoke the module within your Perl script. By default, it issues a warning.

```perl
use indirect;

my $x = new Apple; # Triggers warning: "Indirect call of method "new" on object "Apple""
```

### Strict Mode (Fatal)
To treat indirect calls as fatal errors, which is recommended for new projects or strict CI environments:

```perl
no indirect ':fatal';

my $obj = new Class; # Execution dies here
```

### Scoping
The pragma is lexically scoped. You can enable it for specific blocks to gradually refactor large codebases:

```perl
{
    no indirect ':fatal';
    my $item = new Item; # Dies
}
my $other = new Item; # Allowed (if not enabled globally)
```

### Command Line Auditing
Use `perl-indirect` as a one-liner to audit existing files without modifying the source code:

```bash
# Audit a file for indirect constructs
perl -Mindirect -c script.pl

# Force failure on indirect constructs during a syntax check
perl -M-indirect=global,:fatal -c script.pl
```

## Best Practices
- **Prefer Direct Syntax**: Always transform `new Class @args` to `Class->new(@args)`.
- **Identify Ambiguity**: Use this tool specifically when you suspect a core function (like `sort` or `map`) is being misinterpreted as a method call or vice versa.
- **Global Suppression**: In modern Perl environments (v5.36+), while some indirect syntax is being deprecated, `perl-indirect` remains the most robust way to catch all instances, including those involving custom method names.

## Reference documentation
- [MetaCPAN indirect documentation](./references/metacpan_org_release_indirect.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-indirect_overview.md)