---
name: perl-file-find-rule
description: File::Find::Rule simplifies the process of traversing directory trees in Perl.
homepage: https://metacpan.org/pod/File::Find::Rule
---

# perl-file-find-rule

## Overview
File::Find::Rule simplifies the process of traversing directory trees in Perl. Instead of writing complex callback functions for the core File::Find module, you build a rule object by chaining criteria—such as file extensions, size thresholds, or directory depth—and then execute that rule against target paths. It is particularly useful for administrative scripts, data processing pipelines, and any scenario where you need to isolate specific files within a nested structure.

## Core Usage Patterns

### Basic Chaining
The most common way to use the tool is by chaining criteria and ending with the `in(@directories)` method to return a list of matches.

```perl
use File::Find::Rule;

# Find all Perl modules in @INC
my @files = File::Find::Rule->file()
                            ->name('*.pm')
                            ->in(@INC);
```

### Logical Operations
Rules are "ANDed" by default. Use `any` (OR) or `not` (negation) for complex logic.

*   **OR Logic**: `any( @rules )`
*   **Negation**: `not( $rule )` or the shorthand `not_name('*.tmp')`

```perl
# Find files that are either large OR very old
my $rule = File::Find::Rule->any(
    File::Find::Rule->size(">100M"),
    File::Find::Rule->mtime("<" . (time - 86400 * 30))
);
```

### Depth Control
To prevent deep recursion or skip the top-level directory:
*   `maxdepth($level)`: Descend at most $level deep.
*   `mindepth($level)`: Do not apply tests to files above $level.

### Content Filtering
Use `grep` to filter files based on their internal content without manually opening handles.

```perl
# Find files containing a perl shebang
my @perls = File::Find::Rule->file
                            ->grep(qr/^#!.*\bperl/)
                            ->in('.');
```

## Expert Tips and Best Practices

### Memory Efficiency with Iterators
For extremely large directory trees, avoid `in()` as it returns the entire list at once. Use the iterator interface instead:

```perl
my $rule = File::Find::Rule->file->name("*.dat")->start("/data");
while ( defined ( my $file = $rule->match ) ) {
    process($file); # Process one by one
}
```

### Custom Logic with `exec`
If the built-in tests (size, name, etc.) are insufficient, use `exec` to run a custom subroutine. The subroutine receives the short name, the path, and the full relative name.

```perl
# Find files where the filename length is greater than 20
$rule->exec( sub { length $_ > 20 } );
```

### Handling Symlinks
By default, File::Find::Rule does not follow symlinks. To enable this, pass options to the underlying File::Find engine using `extras`:

```perl
my $rule = File::Find::Rule->extras({ follow => 1 })->file->in($dir);
```

### CLI One-Liners
You can use the module directly from the command line for quick file discovery:

```bash
# Find and print all directories named 'lib'
perl -MFile::Find::Rule -e 'print "$_\n" for File::Find::Rule->directory->name("lib")->in(".")'
```

## Reference documentation
- [File::Find::Rule - Alternative interface to File::Find](./references/metacpan_org_pod_File__Find__Rule.md)