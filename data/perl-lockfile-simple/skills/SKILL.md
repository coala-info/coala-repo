---
name: perl-lockfile-simple
description: This tool manages advisory file locking in Perl by creating physical lockfiles containing process IDs and hostnames. Use when user asks to implement file locking, manage stale locks, or handle concurrent file access in NFS environments.
homepage: http://metacpan.org/pod/LockFile::Simple
metadata:
  docker_image: "quay.io/biocontainers/perl-lockfile-simple:0.208--0"
---

# perl-lockfile-simple

## Overview
This skill provides guidance on implementing the `LockFile::Simple` Perl module. This tool manages advisory file locking by creating physical lockfiles containing the process ID (PID) and optionally the hostname. It is an alternative to system-level locking (like `flock`) and is highly customizable regarding retry logic, stale lock detection, and lockfile naming conventions.

## Implementation Patterns

### Basic Procedural Interface
For simple scripts, import the functional interface. This uses default settings (2s delay, 30 retries, `.lock` extension).

```perl
use LockFile::Simple qw(lock trylock unlock);

# Blocking lock: waits until successful or max retries reached
lock("/path/to/data.txt") or die "Failed to acquire lock";

# Critical Section
# ... perform file operations ...

unlock("/path/to/data.txt");

# Non-blocking attempt
if (trylock("/path/to/config.json")) {
    # Success
    unlock("/path/to/config.json");
}
```

### Object-Oriented Configuration
Use the OO interface when you need to handle NFS environments, custom retry limits, or specific lockfile locations.

```perl
use LockFile::Simple;

my $mgr = LockFile::Simple->make(
    -autoclean => 1,       # Release locks automatically on exit
    -max       => 10,      # Retry 10 times
    -delay     => 5,       # Wait 5s between retries
    -nfs       => 1,       # Include hostname in lock metadata for NFS
    -stale     => 1,       # Break locks if the owning PID is dead
    -hold      => 3600     # Force break locks older than 1 hour
);

# Using a lock handle (recommended for scoped cleanup)
if (my $lock = $mgr->lock("/shared/storage/file.db")) {
    # Do work...
    $lock->release; 
}
```

### Custom Lockfile Naming
By default, a lock for `file.txt` is `file.txt.lock`. Use `-format` to change this behavior:

- `%f`: Full path of the file being locked.
- `%D`: Directory of the file.
- `%F`: Basename of the file.
- `%p`: PID of the current process.

Example for a centralized lock directory:
```perl
my $mgr = LockFile::Simple->make(-format => '/var/run/applocks/%F.lck');
```

## Best Practices
- **Use Autoclean**: Always set `-autoclean => 1` in long-running processes to ensure locks are removed if the script terminates unexpectedly.
- **NFS Safety**: If the filesystem is mounted via NFS, you **must** set `-nfs => 1`. This ensures the lockfile contains the hostname, preventing PID collisions between different nodes.
- **Stale Lock Management**: Enable `-stale => 1` to allow the module to check if the process ID recorded in an existing lockfile is still active. This prevents "deadlock" situations after a system crash.
- **Handle Returns**: Always check the return value of `lock()`. It returns a lock handle (true) on success and `undef` on failure.

## Reference documentation
- [LockFile::Simple Documentation](./references/metacpan_org_pod_LockFile__Simple.md)