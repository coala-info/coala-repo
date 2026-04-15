---
name: perl-data-match
description: This tool provides a declarative way to test if complex Perl data structures match specific templates or patterns. Use when user asks to validate nested data structures, perform partial pattern matching, or use wildcards and regular expressions to check Perl variables.
homepage: http://metacpan.org/pod/Data::Match
metadata:
  docker_image: "quay.io/biocontainers/perl-data-match:0.06--pl526_0"
---

# perl-data-match

## Overview
The `perl-data-match` tool (Data::Match) provides a declarative way to test if a complex Perl data structure matches a specific template or pattern. Unlike simple equality checks, it allows for partial matches, type checking, and nested structural validation. This skill helps in crafting match patterns and integrating the library into Perl scripts to handle deeply nested data without writing verbose conditional logic.

## Usage Patterns

### Basic Pattern Matching
To check if a data structure matches a pattern, use the `match` function. The pattern mirrors the structure of the data.

```perl
use Data::Match;

my $data = {
    name => "John Doe",
    ids  => [10, 20, 30],
    meta => { status => "active" }
};

# Simple structural match
if (match($data, { name => "John Doe" })) {
    print "Name matches\n";
}

# Nested match
if (match($data, { meta => { status => "active" } })) {
    print "Status is active\n";
}
```

### Using Wildcards and Types
`Data::Match` supports special markers to match types or "any" value.

- `MATCH_ANY`: Matches any scalar value.
- `MATCH_ARRAY`: Matches any array reference.
- `MATCH_HASH`: Matches any hash reference.
- `MATCH_TYPE($type)`: Matches a specific ref type (e.g., 'Regexp', 'CODE').

```perl
use Data::Match qw(:all);

# Match any ID in the second position of the array
if (match($data, { ids => [MATCH_ANY, 20, MATCH_ANY] })) {
    print "Found 20 in the middle\n";
}
```

### Regular Expression Matching
You can use regex objects within the pattern to validate string content.

```perl
if (match($data, { name => qr/^John/ })) {
    print "Starts with John\n";
}
```

### Best Practices
- **Partial vs. Full**: By default, `match` checks if the pattern is a subset of the data. If the data has extra keys not in the pattern, it still returns true.
- **Booleans**: Remember that `match` returns a boolean. Use it within `if` blocks or `grep` filters.
- **Performance**: For very large structures, define your pattern once as a variable rather than re-declaring it inside a loop to save on reference creation overhead.

## Reference documentation
- [Data::Match Documentation](./references/metacpan_org_pod_Data__Match.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-data-match_overview.md)