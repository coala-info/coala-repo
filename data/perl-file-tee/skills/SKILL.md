---
name: perl-file-tee
description: This tool multiplexes Perl output streams to send data to multiple destinations simultaneously. Use when user asks to replicate the Unix tee command in Perl, redirect output to multiple files or processes, or capture stream data into scalars.
homepage: http://metacpan.org/pod/File::Tee
---


# perl-file-tee

## Overview
The `perl-file-tee` skill provides guidance on using the `File::Tee` Perl module to multiplex output streams. It allows a single output handle (like STDOUT or a filehandle) to send data to multiple destinations at once without manually repeating print statements. This is the Perl equivalent of the Unix `tee` command but integrated directly into the language's I/O system.

## Core Usage Patterns

### Basic Redirection
To split STDOUT so it continues to the screen while also being saved to a file:
```perl
use File::Tee qw(tee);

# Everything sent to STDOUT now also goes to 'log.txt'
tee(STDOUT, '>', 'log.txt');

print "This goes to both destinations\n";
```

### Multiple Targets
You can pipe a single stream to an unlimited number of destinations, including files, existing filehandles, or even external processes:
```perl
# Send STDOUT to a log file and a grep process simultaneously
tee(STDOUT, '>', 'debug.log', '|', 'grep ERROR > errors.log');
```

### Appending vs. Overwriting
Control how files are opened using standard Perl mode symbols:
- `>` : Overwrite/Create new file.
- `>>` : Append to existing file.

### Capturing to Scalars
Useful for unit testing or internal buffering:
```perl
my $buffer;
tee(STDOUT, '>', \$buffer);
```

## Best Practices
- **Scope Management**: By default, `tee` remains active until the filehandle is closed or the program exits. To limit the effect, use the return object to "un-tee" when it goes out of scope.
- **Error Handling**: Always check if the target files are writable before initiating a `tee` operation to prevent silent data loss.
- **Performance**: Be aware that multiplexing to many slow targets (like network pipes) will throttle the speed of the primary stream.

## Reference documentation
- [File::Tee Documentation](./references/metacpan_org_pod_File__Tee.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-tee_overview.md)