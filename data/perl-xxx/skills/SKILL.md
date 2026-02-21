---
name: perl-xxx
description: The `perl-xxx` skill enables efficient "print-debugging" for Perl developers.
homepage: https://github.com/ingydotnet/xxx-pm
---

# perl-xxx

## Overview
The `perl-xxx` skill enables efficient "print-debugging" for Perl developers. Instead of manually configuring `Data::Dumper` or `YAML`, this tool allows you to insert short, memorable function calls anywhere in your code to dump data to the terminal, logs, or test output. It is particularly useful for inspecting nested data structures in the middle of method chains or during unit testing.

## Core Functions
- `XXX(@args)`: Immediately `die` with a YAML dump of the arguments. Use this for "stop-the-world" debugging.
- `WWW(@args)`: Issues a `warn` with the dump and returns the original arguments. Ideal for inserting into expressions without breaking logic.
- `YYY(@args)`: Prints the dump and returns the arguments. In `Test::More` environments, it automatically uses `note()`.
- `ZZZ(@args)`: Performs a `Carp::confess` with the dump, providing a full stack trace.
- `DDD(@args)`: Triggers an interactive debugger session (requires `Enbugger`).

## Usage Patterns

### Inline Debugging
Because `WWW` and `YYY` return their arguments, you can wrap them around variables or method calls:
```perl
my $result = WWW($self->calculate_data($input));
# The calculation proceeds normally, but the result is dumped to STDERR.
```

### Global Loading
To use these functions without adding `use XXX;` to every file, set the `PERL5OPT` environment variable:
```bash
export PERL5OPT='-MXXX=global'
# Now you can use ::XXX or $::WWW in any package.
```

### Method Chaining
Use the global scalar version to inspect objects in the middle of a chain:
```perl
$object->fetch_data->$::WWW->process_data;
```

## Configuration
Change the output format by specifying a dumper module during import or via environment variables:

**In Code:**
```perl
use XXX -with => 'Data::Dump';
use XXX -with => 'JSON::Color';
```

**Via Environment:**
```bash
PERL_XXX_DUMPER=JSON::Color perl script.pl
```

## Expert Tips
- **Test Integration**: When using `WWW` or `YYY` inside `Test::More` scripts, the output is automatically redirected to `diag()` or `note()`, keeping your TAP output clean.
- **Custom Debuggers**: If using `DDD`, you can switch to the `Devel::Trepan` debugger by setting `PERL_XXX_DEBUGGER=trepan`.
- **Stack Traces**: If you wrap `XXX` in your own helper function, define `use constant XXX_skip => 1;` in your helper's package to ensure the output points to the actual caller rather than your helper.

## Reference documentation
- [GitHub Repository - XXX-pm](./references/github_com_ingydotnet_xxx-pm.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xxx_overview.md)