---
name: perl-file-copy-link
description: The `perl-file-copy-link` tool (and its associated Perl module `File::Copy::Link`) provides a reliable way to transform symbolic links into regular files.
homepage: https://metacpan.org/pod/File::Copy::Link
---

# perl-file-copy-link

## Overview
The `perl-file-copy-link` tool (and its associated Perl module `File::Copy::Link`) provides a reliable way to transform symbolic links into regular files. Instead of manually identifying a link's target and performing a manual copy-and-replace, this tool automates the process of reading the link, deleting the symlink, and writing the actual file content to that same location. This is particularly useful for preparing data for environments that do not support symlinks or for "freezing" a specific version of a linked resource.

## Usage Patterns

### Command Line Interface
The primary command provided by this package is `copylink`.

- **Basic Usage**: Replace a symlink with a copy of its target.
  ```bash
  copylink path/to/link
  ```
- **Multiple Files**: You can pass multiple links to the command to process them in bulk.
  ```bash
  copylink link1 link2 link3
  ```

### Perl Module Integration
If writing a Perl script, you can use the module directly for more control over the copying mechanism.

- **Standard Copy (`copylink`)**: Opens a filehandle to the link, deletes the link, and then writes the data back.
  ```perl
  use File::Copy::Link;
  copylink 'file.lnk';
  ```
- **Safe Copy (`safecopylink`)**: Uses `File::Spec::Link` to resolve the target path first, then copies from the source to the destination. This is generally safer if you want to avoid deleting the link before the copy operation is fully initialized.
  ```perl
  use File::Copy::Link qw(safecopylink);
  safecopylink 'file.lnk';
  ```

## Best Practices
- **Verify Link Status**: Before running the tool, ensure the target is actually a symbolic link. While the tool is designed to handle links, running it on regular files may result in no action or errors depending on the environment.
- **Permissions**: Ensure you have write permissions for the directory containing the link, as the tool must delete the existing symlink to place the new file.
- **Disk Space**: Remember that "un-linking" files increases disk usage, as the data is duplicated from the source to the new location.

## Reference documentation
- [File::Copy::Link Documentation](./references/metacpan_org_pod_File__Copy__Link.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-copy-link_overview.md)