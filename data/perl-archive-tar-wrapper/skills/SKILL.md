---
name: perl-archive-tar-wrapper
description: This tool provides a Perl interface to the system's native tar binary for high-performance archive manipulation. Use when user asks to create, extract, or inspect tar archives while preserving file permissions and minimizing memory usage.
homepage: http://metacpan.org/pod/Archive::Tar::Wrapper
---


# perl-archive-tar-wrapper

## Overview
This skill provides guidance on using `Archive::Tar::Wrapper`, a Perl interface that executes the system's native `tar` binary rather than processing archives in-memory. This approach is superior for high-performance file manipulation, preserving complex file permissions, and handling massive datasets that would otherwise exhaust system memory. It is commonly encountered in bioinformatics pipelines (via Bioconda) and legacy Perl automation scripts.

## Core Usage Patterns

### Initialization and Configuration
Always specify the `tar` binary path if it is in a non-standard location, and define a temporary directory for extraction operations.

```perl
use Archive::Tar::Wrapper;

my $arch = Archive::Tar::Wrapper->new(
    tar       => '/usr/bin/tar',    # Path to system tar
    tmpdir    => '/tmp/tar_work',   # Working directory for wrapping
    dirs      => 1,                 # Preserve directory structures
    compression => 'gzip',          # Options: gzip, bzip2, none
);
```

### Creating Archives
To create an archive, add files to the object and then write the compressed file.

```perl
# Add a file from disk to the archive at a specific internal path
$arch->add($internal_path, $external_path);

# Add content directly from a string
$arch->add_data("README.txt", "This is the archive content.");

# Write the final tarball
$arch->write("output.tar.gz");
```

### Extracting and Inspecting
The wrapper works by exploding the tarball into a temporary directory, allowing for file-system-based manipulation.

```perl
# Open an existing archive
$arch->read("input.tar.gz");

# List files contained in the archive
my $files = $arch->list_all();
foreach my $file (@$files) {
    print "Found: " . $file->[0] . "\n";
}

# Locate a specific file in the temporary extraction path
my $local_path = $arch->locate("data/config.xml");
```

## Best Practices
- **Memory Efficiency**: Use this module instead of `Archive::Tar` when dealing with archives larger than available RAM, as it streams data to disk.
- **Error Handling**: Always check the return value of `read()` and `write()`. The module returns a boolean indicating success or failure based on the system `tar` exit code.
- **Cleanup**: The module automatically cleans up its `tmpdir` when the object goes out of scope, but ensure the process has write permissions to the designated temporary path.
- **Permissions**: Because it uses the system `tar`, it is highly reliable for preserving symlinks and execution bits which pure-Perl modules may struggle with.

## Reference documentation
- [Archive::Tar::Wrapper Documentation](./references/metacpan_org_pod_Archive__Tar__Wrapper.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-archive-tar-wrapper_overview.md)