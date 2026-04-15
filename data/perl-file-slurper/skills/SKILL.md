---
name: perl-file-slurper
description: This Perl module provides a simple and efficient way to read or write entire files with proper encoding and line ending handling. Use when user asks to read a file into a string, load file lines into an array, or write text and binary data to a file.
homepage: http://metacpan.org/pod/File-Slurper
metadata:
  docker_image: "quay.io/biocontainers/perl-file-slurper:0.014--pl5321hdfd78af_0"
---

# perl-file-slurper

## Overview
File::Slurper is a minimalist and high-performance Perl module designed to replace the older, bug-prone File::Slurp. It provides a clean API for "slurping"—the process of loading an entire file into memory at once. Its primary advantage is its "sane" handling of text encodings (defaulting to UTF-8) and line endings, ensuring that data integrity is maintained across different platforms. Use this tool to simplify your Perl code by replacing manual open/read/close loops with single-function calls.

## Core Functions and Usage

### Reading Files
The module provides specific functions based on the type of data you are retrieving:

*   **read_text($filename, $encoding, $crlf)**: Reads a file as a decoded string.
    *   Default encoding is `UTF-8`.
    *   Set `$crlf` to true if you want to translate platform-specific line endings.
*   **read_lines($filename, $encoding, $crlf)**: Returns a list of strings, one per line, with line endings removed (chomped). This is the preferred method for line-by-line processing.
*   **read_binary($filename)**: Reads the file as a raw buffer of bytes. Use this for images, compressed files, or encrypted data.

### Writing Files
*   **write_text($filename, $content, $encoding, $crlf)**: Encodes and writes a string to a file.
*   **write_binary($filename, $content)**: Writes raw bytes to a file.

## Expert Tips and Best Practices

1.  **Encoding Safety**: Unlike older modules, File::Slurper does not try to guess encodings. It defaults to UTF-8. If you are working with legacy Latin-1 files, you must explicitly pass `'latin1'` as the second argument.
2.  **Memory Considerations**: Slurping loads the entire file into RAM. For extremely large files (multi-gigabyte), consider standard Perl `open` and `while` loops to stream the data instead of using this module.
3.  **Atomic Writes**: File::Slurper does not perform atomic writes by default. If you need to ensure a file is never left in a partially written state during a crash, you may need to write to a temporary file and rename it, or use a complementary module like `File::AtomicWrite`.
4.  **Error Handling**: The functions will `die` on failure (e.g., file not found, permission denied). Always wrap these calls in a `try/catch` block or an `eval` if your script needs to continue running after an I/O error.

## Common Patterns

**Slurping a configuration file into a string:**
```perl
use File::Slurper 'read_text';
my $content = read_text('config.conf');
```

**Processing a list of IDs from a file:**
```perl
use File::Slurper 'read_lines';
my @ids = read_lines('ids.txt');
foreach my $id (@ids) {
    # Process each chomped line
}
```

**Quickly saving a log or report:**
```perl
use File::Slurper 'write_text';
write_text('report.log', $report_data);
```

## Reference documentation
- [MetaCPAN File::Slurper Documentation](./references/metacpan_org_pod_File-Slurper.md)
- [Bioconda perl-file-slurper Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-slurper_overview.md)