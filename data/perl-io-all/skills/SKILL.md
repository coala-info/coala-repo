---
name: perl-io-all
description: The `perl-io-all` (IO::All) module is a comprehensive "Swiss Army Knife" for Perl I/O operations.
homepage: https://github.com/ingydotnet/io-all-pm
---

# perl-io-all

## Overview
The `perl-io-all` (IO::All) module is a comprehensive "Swiss Army Knife" for Perl I/O operations. It provides a single, intuitive interface that wraps numerous standard modules like `IO::File`, `IO::Dir`, `IO::Socket`, and `File::Spec`. Instead of manually managing filehandles, modes (read/write/append), and closing routines, you use the `io` function to create objects that automatically handle these details based on context. This skill helps you leverage its operator overloading and method chaining to write more concise and readable Perl code.

## Installation
Install the package via Bioconda:
```bash
conda install bioconda::perl-io-all
```

## Core Usage Patterns

### File Operations
The most common use case is reading (slurping) and writing (spewing) file contents.

*   **Slurp a file into a scalar:**
    `my $contents = io('file.txt')->slurp;`
    *Alternative (overloaded):* `my $contents < io('file.txt');`
*   **Slurp lines into an array:**
    `my @lines = io('file.txt')->chomp->slurp;` (Automatically chomps newlines)
*   **Write to a file:**
    `$data > io('file.txt');`
*   **Append to a file:**
    `$data >> io('file.txt');`

### Directory Operations
`IO::All` makes directory navigation and file filtering straightforward.

*   **List directory contents:**
    `my @files = io('my_dir')->all;`
*   **Recursive listing:**
    `my @all_files = io('my_dir')->all(0);` (0 indicates infinite depth)
*   **Filter for files only:**
    `my @files = io('lib')->all_files;`
*   **Iterate through a directory:**
    `my $dir = io('src'); while (my $item = $dir->next) { print $item->name if $item->is_file; }`

### Path and File Logic
*   **Path construction:**
    `my $path = io->catfile(qw(path to file.txt));`
*   **File metadata:**
    `my $size = io('file.txt')->size;`
    `my $mimetype = io('image.png')->mimetype;`
*   **Absolute paths:**
    `print io('relative/path')->absolute->pathname;`

### Specialized I/O
*   **Temporary files:**
    `my $temp = io('?');` (Creates a temporary file object)
*   **String I/O:**
    `my $str_io = io('$');` (Treat a scalar as a file)
*   **Pipes:**
    `my $history = io('tail -n 50 app.log |'); while (my $line = $history->getline) { ... }`
*   **UTF-8 Encoding:**
    `my $content = io('file.txt')->utf8->all;`

## Expert Tips
*   **Type Safety:** While `io($input)` is convenient, use explicit constructors like `io->file($name)` or `io->dir($name)` if the input string is ambiguous or provided by a user.
*   **Chaining:** You can chain modifiers before the final action. For example, `io('file.bin')->binary->all` ensures the file is read in binary mode.
*   **In-place Editing:** Use the `tie` method or array dereferencing to modify files in place:
    `my $io = io('config.txt'); $io->[0] = "New Header\n";` (Changes the first line of the file).
*   **Standard Streams:** Use `io('-')` to represent STDIN or STDOUT depending on the direction of the operator.

## Reference documentation
- [IO::All GitHub Repository](./references/github_com_ingydotnet_io-all-pm.md)
- [IO::All Wiki and Usage](./references/github_com_ingydotnet_io-all-pm_wiki.md)
- [Bioconda perl-io-all Package](./references/anaconda_org_channels_bioconda_packages_perl-io-all_overview.md)