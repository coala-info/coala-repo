---
name: perl-file-next
description: This tool provides a memory-efficient iterator for traversing and filtering file systems in Perl. Use when user asks to iterate through directories, filter files during traversal, or process large directory structures without high memory consumption.
homepage: http://metacpan.org/pod/File::Next
metadata:
  docker_image: "quay.io/biocontainers/perl-file-next:1.18--pl5321hdfd78af_0"
---

# perl-file-next

## Overview
This skill provides guidance on implementing `File::Next` within Perl applications. Unlike standard recursive directory traversals that can consume significant memory by building large lists, `File::Next` uses an iterator pattern. This allows your script to process files one at a time as they are discovered, making it ideal for high-performance file searching, filtering, and processing tasks in complex directory structures.

## Implementation Patterns

### Basic File Iteration
To iterate through all files in one or more directories:

```perl
use File::Next;

my $files = File::Next::files( '/path/to/dir' );

while ( defined ( my $file = $files->() ) ) {
    # $file is a File::Next::File object
    print "Found file: $file\n";
}
```

### Filtered Iteration
Use the `file_filter` and `descend_filter` options to control which files are returned and which directories are entered. Filters receive the current path in `$_`.

```perl
my $iter = File::Next::files(
    {
        file_filter => sub { /\.pm$/ },      # Only return Perl modules
        descend_filter => sub { $_ ne '.git' }, # Don't enter .git directories
    },
    $dir
);
```

### Handling Results
The iterator returns a `File::Next::File` object which stringifies to the full path but also provides helper methods:
- `$file->path`: The full path to the file.
- `$file->dir`: The directory containing the file.
- `$file->name`: The filename without the directory path.

### Sorting
By default, `File::Next` does not sort results to maintain speed. If order is required, use the `sort_files` option:

```perl
my $iter = File::Next::files( { sort_files => 1 }, $dir );
```

## Best Practices
- **Memory Efficiency**: Always use the `while( $iter->() )` pattern rather than pushing results into an array unless you specifically need the full list in memory.
- **Error Handling**: `File::Next` generally ignores unreadable directories by default. Use the `error_handler` option if you need to log or react to permission issues.
- **Resumability**: Because it is an iterator, you can stop and start processing easily, which is useful for long-running batch jobs.

## Reference documentation
- [File::Next Documentation](./references/metacpan_org_pod_File__Next.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-next_overview.md)