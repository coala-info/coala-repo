---
name: perl-test-cleannamespaces
description: Test::CleanNamespaces is a specialized Perl testing utility designed to identify "namespace pollution." In Perl, when a module imports functions from another package, those functions often remain visible in the importing package's symbol table.
homepage: https://github.com/karenetheridge/Test-CleanNamespaces
---

# perl-test-cleannamespaces

## Overview

Test::CleanNamespaces is a specialized Perl testing utility designed to identify "namespace pollution." In Perl, when a module imports functions from another package, those functions often remain visible in the importing package's symbol table. If the importing package is an object-oriented class, these imported functions can be mistakenly invoked as methods. This tool automates the process of checking that such imports have been properly scrubbed—usually by modules like `namespace::clean` or `namespace::autoclean`—ensuring a clean and predictable public API for your modules.

## Installation

To install the tool via Conda (Bioconda channel):

```bash
conda install bioconda::perl-test-cleannamespaces
```

## Usage Patterns

### Standard Distribution Test
The most common way to use this tool is to create a test file (e.g., `t/clean-namespaces.t`) that checks every module found in the distribution's `lib/` or `blib/` directories.

```perl
use strict;
use warnings;
use Test::CleanNamespaces;

all_namespaces_clean;
```

### Testing Specific Modules
If you only want to audit specific namespaces or are working on a subset of a large project, use `namespaces_clean`.

```perl
use strict;
use warnings;
use Test::CleanNamespaces;

# Test specific modules only
namespaces_clean('My::Module::Web', 'My::Module::API');
```

### Integration with Dist::Zilla
For developers using `Dist::Zilla`, you can automate the generation of these tests by adding the following to your `dist.ini`:

```ini
[Test::CleanNamespaces]
```

## Expert Tips and Best Practices

*   **Pair with Scrubber Modules**: This tool is a validator, not a fixer. Always use it in conjunction with `namespace::clean`, `namespace::autoclean`, or `namespace::sweep` in your actual module code to perform the cleaning.
*   **Mouse Class Limitations**: Be aware that uncleaned imports from `Mouse` classes are only partially detected. `Mouse` lacks the ability to return a perfect method list; the tool relies on a heuristic that assumes subs are methods unless they originate from a known list of core Mouse/utility packages (e.g., `Carp`, `Scalar::Util`).
*   **Handling Skipped Modules**: If a module cannot be loaded (e.g., due to missing dependencies in the test environment), `namespaces_clean` will skip it rather than failing the entire test suite. Ensure your test environment has all prerequisites installed to get a comprehensive report.
*   **Manual Module Discovery**: If you need to filter which modules are tested programmatically, use the `find_modules` method to get the list before passing it to the test function.

## Reference documentation
- [Test::CleanNamespaces GitHub Repository](./references/github_com_karenetheridge_Test-CleanNamespaces.md)
- [Bioconda perl-test-cleannamespaces Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-cleannamespaces_overview.md)