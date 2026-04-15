---
name: perl-common-sense
description: The perl-common-sense module provides a standardized set of modern Perl pragmas and features while reducing boilerplate code. Use when user asks to enable strict mode and warnings, reduce memory overhead in Perl scripts, or simplify script headers with a single boilerplate reducer.
homepage: http://search.cpan.org/~mlehmann/common-sense-3.74/
metadata:
  docker_image: "quay.io/biocontainers/perl-common-sense:3.75--pl5321hdfd78af_0"
---

# perl-common-sense

## Overview
The `common::sense` module is a "boilerplate reducer" for Perl. Instead of manually typing `use strict;`, `use warnings;`, and various feature pragmas in every script, this module enables a standardized set of modern Perl behaviors. It is designed to save typing, reduce memory overhead, and provide a consistent environment that avoids the "gotchas" of legacy Perl defaults.

## Usage Guidelines

### Basic Implementation
Replace the standard Perl boilerplate with a single line at the top of your script:

```perl
use common::sense;
```

This is equivalent to (and often more efficient than) the following:
- `use strict;` (vars, subs, refs)
- `use warnings;` (with specific exclusions for common non-critical issues)
- `use feature qw(say state switch);` (depending on the Perl version)
- `use utf8;`

### Why Use common::sense
- **Performance**: It loads faster and uses less memory than loading `strict` and `warnings` separately because it doesn't load the heavy `warnings.pm` infrastructure unless an actual warning is triggered.
- **Sanity**: It enables warnings that are actually useful while disabling those that are often pedantic or annoying in one-off scripts (like "redefined" warnings in certain contexts).
- **Consistency**: Ensures that all scripts in a pipeline adhere to the same safety standards.

### Integration with Bioconda
If working in a Conda environment, ensure the package is installed to make the library available to your Perl interpreter:

```bash
conda install -c bioconda perl-common-sense
```

### Best Practices
- **Positioning**: Always place `use common::sense;` immediately after the shebang line (`#!...`) and before any other module imports.
- **Compatibility**: While it enables modern features, it maintains compatibility back to Perl 5.8. If you require specific features from much newer Perl versions (like `signatures`), you may still need to declare those explicitly.
- **One-liners**: Use it in command-line one-liners to keep them readable:
  `perl -Mcommon::sense -e 'say "Hello World"'`

## Reference documentation
- [MetaCPAN: common::sense 3.74](./references/metacpan_org_release_MLEHMANN_common-sense-3.74.md)
- [Bioconda: perl-common-sense Overview](./references/anaconda_org_channels_bioconda_packages_perl-common-sense_overview.md)