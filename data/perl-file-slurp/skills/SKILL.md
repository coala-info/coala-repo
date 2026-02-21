---
name: perl-file-slurp
description: The `File::Slurp` module provides a highly efficient, functional interface for handling entire files in Perl.
homepage: http://metacpan.org/pod/File::Slurp
---

# perl-file-slurp

## Overview

The `File::Slurp` module provides a highly efficient, functional interface for handling entire files in Perl. It eliminates the need for repetitive `open`, `flock`, and `close` boilerplate. This skill enables the rapid implementation of file-based data processing, ensuring best practices like atomic operations and proper context handling (scalar vs. list) are followed to prevent data corruption and memory inefficiencies.

## Core Functions and Usage

### Reading Files
Load a file's content into a single string or an array of lines based on the calling context.

```perl
use File::Slurp;

# Scalar context: Read entire file into a string
my $content = read_file('data.txt');

# List context: Read file into an array of lines
my @lines = read_file('data.txt');
```

### Writing and Appending
Perform simple writes or safe atomic updates.

```perl
# Standard write
write_file('output.txt', $content);

# Atomic write (writes to temp file then renames to prevent partial writes)
write_file('output.txt', {atomic => 1}, $content);

# Append to existing file
append_file('log.txt', "New entry\n");
```

### In-Place Modification
Modify file content directly using code blocks, mimicking Perl's command-line "pie" mode.

```perl
# Global regex replacement on the whole file
edit_file { s/old_string/new_string/g } 'config.conf';

# Line-by-line modification (e.g., deleting lines containing 'DEBUG')
edit_file_lines { $_ = '' if /DEBUG/ } 'app.log';
```

### Directory Operations
Quickly list directory contents, automatically filtering out `.` and `..`.

```perl
my @files = read_dir('/path/to/dir');
```

## Expert Tips and Best Practices

- **Context Awareness**: Always be mindful of whether you are calling `read_file` in scalar or list context. Slurping a massive file into an array of lines consumes significantly more memory than a single scalar string.
- **Atomic Writes**: Use `{atomic => 1}` for configuration files or critical data to ensure that a system crash or full disk during the write process doesn't leave you with a truncated or corrupted file.
- **Encoding**: For non-ASCII data, specify the `binmode` option:
  `my $val = read_file($file, binmode => ':utf8');`
- **Error Handling**: By default, `File::Slurp` calls `croak` on failure. You can change this behavior using the `err_mode` option (e.g., `err_mode => 'quiet'`).
- **Avoid Special Handles**: Do not use this module for pipes, sockets, or standard I/O (STDIN/STDOUT). It is optimized specifically for filesystem-based files.

## Reference documentation
- [File::Slurp - Simple and Efficient Reading/Writing/Modifying of Complete Files](./references/metacpan_org_pod_File__Slurp.md)
- [perl-file-slurp - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-file-slurp_overview.md)