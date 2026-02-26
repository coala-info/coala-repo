---
name: perl-data-dump
description: "This tool provides a readable and concise way to pretty-print Perl data structures as valid code. Use when user asks to pretty-print variables, debug complex data structures, or generate string representations of Perl memory objects."
homepage: https://metacpan.org/pod/Data::Dump
---


# perl-data-dump

## Overview
The `Data::Dump` suite provides a more readable and concise alternative to the standard `Data::Dumper` module. It excels at "pretty-printing" by automatically adjusting its output format based on the complexity of the data—using single lines for simple structures and multi-line indentation for complex ones. This skill guides the use of its primary functions and configuration options to produce clean, valid Perl code representations of memory structures.

## Core Functions
- **`dump(...)` or `pp(...)`**: Returns a string containing the Perl representation of the arguments. If multiple arguments are passed, they are wrapped in parentheses.
- **`dd(...)`**: The primary debugging tool. It calls `dump()` on the arguments and prints the result directly to the currently selected output handle (usually STDOUT), followed by a newline.
- **`ddx(...)`**: An enhanced debugging function. It prefixes output with a comment character (`#`) and includes the filename and line number of the call site, making it perfect for tracing execution through multiple files.
- **`quote($string)`**: Returns a safely quoted version of a string without attempting to be "clever" with formatting or base64 encoding.

## Common CLI Patterns
For quick inspection of data from the command line, use the `-M` flag:

```bash
# Inspect a complex structure from a one-liner
perl -MData::Dump -e 'dd \%ENV'

# Debugging a module's output
perl -MMyModule -MData::Dump -e 'dd MyModule->new->get_data'
```

## Configuration and Best Practices
Modify these global variables within a `local` scope to change output behavior without affecting the rest of the program:

- **Indentation**: Set `$Data::Dump::INDENT` to change the prefix (default is "  "). Set to an empty string for compact output.
- **Line Width**: Adjust `$Data::Dump::LINEWIDTH` (default 60) to control when the module starts breaking structures into multiple lines.
- **Binary Data**: `$Data::Dump::TRY_BASE64` (default 50) controls the threshold for encoding long binary strings in base64. Set to 0 to disable.

### Expert Tip: Avoiding Built-in Conflicts
Always import `dump` explicitly or use the alias `pp`. If you call `dump` without importing it from `Data::Dump`, Perl will execute its built-in `dump` function, which causes a core dump.

```perl
use Data::Dump qw(pp);
print pp($my_data);
```

## Filtering Data
Use `Data::Dump::Filtered` when you need to prune large structures or mask sensitive data (like passwords) during a dump.

```perl
use Data::Dump qw(dumpf);

# Example: Hide specific hash keys
my $str = dumpf($data, sub {
    my ($ctx, $obj) = @_;
    if ($ctx->is_hash) {
        return { hide_keys => ['password', 'secret_key'] };
    }
    return;
});
```

## Reference documentation
- [Data::Dump](./references/metacpan_org_pod_Data__Dump.md)
- [Data::Dump::Filtered](./references/metacpan_org_pod_Data__Dump__Filtered.md)
- [Data::Dumper](./references/metacpan_org_pod_Data__Dumper.md)