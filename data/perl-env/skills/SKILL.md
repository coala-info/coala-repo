---
name: perl-env
description: The `perl-env` skill facilitates the use of the `Env` module, which automates the binding of environment variables to Perl global variables.
homepage: http://search.cpan.org/dist/Env
---

# perl-env

## Overview
The `perl-env` skill facilitates the use of the `Env` module, which automates the binding of environment variables to Perl global variables. Instead of manually accessing the `%ENV` hash (e.g., `$ENV{PATH}`), this module allows you to treat environment variables as standard scalars (`$PATH`) or arrays (`@PATH`), simplifying script logic and improving readability when dealing with system configurations or tool paths.

## Usage Patterns

### Importing Scalars
To map specific environment variables to scalars, list them in the import line.
```perl
use Env qw(HOME USER SHELL);
print "Hello $USER, your shell is $SHELL and your home is $HOME\n";
```

### Importing Arrays
For variables containing delimited lists (like `PATH` or `LD_LIBRARY_PATH`), you can map them to Perl arrays. The module automatically handles the platform-specific delimiter (colon on Unix, semicolon on Windows).
```perl
use Env qw(@PATH @LD_LIBRARY_PATH);
push @PATH, "/opt/custom/bin"; # Dynamically updates the environment
```

### Global Import
If no arguments are provided, the module attempts to map all existing environment variables to scalars. Note that this only maps variables that are valid Perl identifiers.
```perl
use Env;
# All environment variables are now accessible as $VARIABLE_NAME
```

## Best Practices
- **Selective Import**: Always prefer naming specific variables (e.g., `use Env qw(PATH)`) rather than a global import to avoid namespace pollution and accidental variable shadowing.
- **Array Manipulation**: Use the array mapping for `PATH`-like variables. Modifying the Perl array (using `push`, `pop`, or `shift`) immediately updates the underlying environment, which is inherited by child processes.
- **Namespace Safety**: Be cautious when using `Env` in large projects, as it creates global variables. If a variable name conflicts with a local script variable, the `Env` mapping may cause unexpected behavior.
- **Case Sensitivity**: Remember that environment variables are case-sensitive on Linux/macOS. Ensure the case in the `qw()` list matches the shell environment exactly.

## Reference documentation
- [Env - perl module that imports environment variables as scalars or arrays](./references/metacpan_org_release_Env.md)
- [perl-env Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-env_overview.md)