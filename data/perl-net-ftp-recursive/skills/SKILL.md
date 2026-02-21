---
name: perl-net-ftp-recursive
description: The `Net::FTP::Recursive` module extends the standard Perl `Net::FTP` class to support recursive directory traversal.
homepage: http://metacpan.org/pod/Net::FTP::Recursive
---

# perl-net-ftp-recursive

## Overview
The `Net::FTP::Recursive` module extends the standard Perl `Net::FTP` class to support recursive directory traversal. It is essential for automated workflows where a simple `mget` or `mput` is insufficient because the task involves nested subdirectories. This skill provides the syntax for establishing connections, navigating remote paths, and executing recursive transfers with advanced options like symlink handling and file renaming.

## Implementation Patterns

### Basic Recursive Download (rget)
To download an entire remote directory structure into the current local directory:
```perl
use Net::FTP::Recursive;

my $ftp = Net::FTP::Recursive->new("ftp.example.com", Debug => 0) 
    or die "Cannot connect: $@";
$ftp->login("user", "password") or die "Cannot login: ", $ftp->message;

$ftp->cwd("/remote/path");
# Returns '' on success, or a string of error messages on failure
my $error = $ftp->rget();
die "Download failed: $error" if $error;

$ftp->quit;
```

### Advanced rget Options
*   **Symlink Handling**: Control how links are treated using `SymlinkIgnore` (default), `SymlinkCopy`, `SymlinkFollow` (recurse into linked dirs), or `SymlinkLink`.
*   **Flattening**: Use `FlattenTree => 1` to pull all files from subdirectories into a single local directory, auto-incrementing filenames (e.g., `file.1`, `file.2`) to avoid collisions.
*   **Filtering**: Use regex objects (`qr//`) to include or exclude specific items:
    *   `MatchFiles` / `OmitFiles`: Filter regular files.
    *   `MatchDirs` / `OmitDirs`: Filter directory recursion.
    *   `MatchAll` / `OmitAll`: Global filters.

Example with filtering:
```perl
$ftp->rget(
    MatchFiles => qr/\.txt$/, 
    OmitDirs   => qr/temp|cache/
);
```

### Recursive Upload (rput)
To upload the local directory structure to the remote server:
```perl
$ftp->cwd("/remote/target");
$ftp->rput(
    FlattenTree => 0,
    RemoveLocalFiles => 0 # Set to 1 to delete local files after successful upload
);
```

### Cleanup and Verification
*   **RemoveRemoteFiles**: In `rget`, setting this to `1` deletes the remote file after retrieval.
*   **CheckSizes**: When combined with removal options, this ensures the local and remote file sizes match before the source is deleted.
*   **KeepFirstLine**: Use `KeepFirstLine => 1` if the FTP server's `dir` output does not include a "total" summary line (common on non-wuftpd servers).

## Expert Tips
*   **Error Handling**: Unlike most Perl modules, `rget` and `rput` return an **empty string** on success and a **true value** (the error message) on failure. Always check the return value explicitly.
*   **Debugging**: Set `Debug => 1` in the constructor to see the raw FTP commands and recursive traversal logic printed to STDERR.
*   **Custom Parsing**: If the remote server uses a non-UNIX directory listing format, provide a custom parser via `ParseSub => \&your_sub`. Your subroutine must return a list of `Net::FTP::Recursive::File` objects.

## Reference documentation
- [Net::FTP::Recursive - Recursive FTP Client class](./references/metacpan_org_pod_Net__FTP__Recursive.md)