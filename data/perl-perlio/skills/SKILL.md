---
name: perl-perlio
description: This tool extends Perl's standard I/O layers to provide advanced file handling features like automatic locking, output multiplexing, and reverse line reading. Use when user asks to open files with atomic locking, tee output to multiple destinations, or read files backward.
homepage: https://github.com/gfx/Perl-PerlIO-Util
metadata:
  docker_image: "quay.io/biocontainers/perl-perlio:1.09--pl526_1"
---

# perl-perlio

## Overview
The `perl-perlio` skill provides expertise in using the `PerlIO::Util` module to extend Perl's standard I/O layers. It allows for more robust file handling by integrating procedural tasks—like locking and creation—directly into the `open` call or handle configuration. This reduces boilerplate code and improves reliability in concurrent environments or complex data processing tasks.

## Usage Patterns and Best Practices

### Advanced File Opening
Use `PerlIO::Util->open` to combine file modes with specialized pseudo-layers.

*   **Automatic Creation and Locking**: To ensure a file exists and is locked exclusively before writing:
    ```perl
    use PerlIO::Util;
    my $fh = PerlIO::Util->open('+<:creat :flock', $filename);
    ```
*   **Filesystem Encoding**: Use `:fse` to handle files using the native filesystem encoding (especially relevant on Win32 or when `PERLIO_FSE` is set).

### Output Multiplexing (Tee)
The `tee` layer allows you to send output to multiple destinations simultaneously. This is ideal for logging while maintaining standard output.

*   **Pushing a Tee Layer**:
    ```perl
    # Append all STDERR output to a log file as well
    *STDERR->push_layer(tee => ">> error.log");
    ```

### Reverse Line Reading
The `:reverse` layer is highly efficient for tasks like reading the most recent entries in a log file first.

*   **Reading Backward**:
    ```perl
    my $in = PerlIO::Util->open('<:reverse', 'access.log');
    while (my $line = <$in>) {
        print $line; # Prints the last line of the file first
    }
    ```

### Expert Tips
*   **Layer Order**: When pushing layers manually using `push_layer`, remember that PerlIO layers are stacked. The order in which you push them affects the data flow.
*   **Atomic Operations**: Use the `:flock` layer to prevent race conditions in multi-process scripts without needing to call the `flock` function manually after every `open`.
*   **Dependency Check**: Ensure the environment has a C compiler and Perl 5.8.1+ as this module relies on XS code for performance.

## Reference documentation
- [PerlIO::Util - A selection of general PerlIO utilities](./references/github_com_gfx_Perl-PerlIO-Util.md)