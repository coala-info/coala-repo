---
name: perl-data-dumper
description: This tool converts Perl memory structures into stringified Perl syntax for debugging or data persistence. Use when user asks to stringify complex variables, print debug Perl data structures, or export data as valid Perl code.
homepage: http://metacpan.org/pod/Data::Dumper
---


# perl-data-dumper

## Overview
The `perl-data-dumper` skill provides the procedural knowledge required to use the `Data::Dumper` module effectively. This tool converts Perl memory structures into stringified Perl syntax. This is primarily used for "print debugging" to see exactly what a complex variable contains, but it can also be used for data persistence since the output is valid Perl code that can be re-imported using `eval`.

## Core Usage Patterns

### Quick Inspection (One-liners)
To quickly dump a variable or environment state from the command line:
```bash
# Dump the environment variables
perl -MData::Dumper -e 'print Dumper(\%ENV)'

# Dump a specific module's configuration or output
perl -MModule::Name -MData::Dumper -e '$obj = Module::Name->new; print Dumper($obj)'
```

### Procedural Interface
The most common way to use the tool within a script:
```perl
use Data::Dumper;

my $complex_structure = {
    users => [ { id => 1, name => "Alice" }, { id => 2, name => "Bob" } ],
    metadata => { version => "1.0", tags => ["admin", "test"] }
};

print Dumper($complex_structure);
```

### Object-Oriented Interface
Use the OO interface when you need to maintain specific configuration states for different dumping tasks:
```perl
use Data::Dumper;

my $d = Data::Dumper->new([$foo, $bar], [qw(foo bar)]);
$d->Indent(1)->Terse(1);
print $d->Dump;
```

## Configuration and Best Practices

### Essential Configuration Variables
Adjust these variables to change the output format:

*   **$Data::Dumper::Terse**: Set to `1` to omit the `$VAR1 = ` prefix. Useful for clean logs.
*   **$Data::Dumper::Indent**: 
    *   `0`: No newlines or indentation (compact).
    *   `1`: Simple indentation.
    *   `2`: Full indentation (default).
    *   `3`: Full indentation with additional formatting.
*   **$Data::Dumper::Sortkeys**: Set to `1` to sort hash keys alphabetically. **Critical for comparing/diffing two dumps.**
*   **$Data::Dumper::Purity**: Set to `1` to handle self-referential/circular structures correctly for `eval`.
*   **$Data::Dumper::Deepcopy**: Set to `1` to avoid cross-referencing identical substructures.

### Expert Tips
1.  **Naming Variables**: When dumping multiple variables, pass an array reference of names to the `Dump` method to make the output readable:
    `print Data::Dumper->Dump([$user, $settings], [qw(user settings)]);`
2.  **Dereferencing**: To see the actual content of a reference rather than the reference address, use the `*` prefix in the name:
    `print Data::Dumper->Dump([$array_ref], ['*my_array']);`
3.  **Security Warning**: While `Data::Dumper` output can be `eval`ed to restore data, never `eval` data from untrusted sources as it can execute arbitrary Perl code.

## Reference documentation
- [Data::Dumper - stringified perl data structures](./references/metacpan_org_pod_Data__Dumper.md)
- [perl-data-dumper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-data-dumper_overview.md)