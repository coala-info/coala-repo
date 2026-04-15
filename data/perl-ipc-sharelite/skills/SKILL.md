---
name: perl-ipc-sharelite
description: This tool provides a lightweight interface for Perl processes to exchange data through shared memory segments. Use when user asks to facilitate inter-process communication, store data in shared memory, or implement atomic data operations between multiple scripts.
homepage: http://metacpan.org/pod/IPC::ShareLite
metadata:
  docker_image: "quay.io/biocontainers/perl-ipc-sharelite:0.17--pl5321h9948957_7"
---

# perl-ipc-sharelite

## Overview
This skill provides guidance on utilizing the `IPC::ShareLite` Perl module to facilitate efficient data exchange between processes via shared memory. Unlike standard pipes or sockets, this tool allows multiple processes to access a common memory segment. It is particularly useful for high-speed applications where serializing large datasets through files or network interfaces is too slow. The module handles the complexities of SysV IPC, including segment management and semaphore-based locking, while allowing for data larger than the standard kernel segment size.

## Implementation Patterns

### Basic Shared Memory Setup
To initialize a shared memory segment, use the `new` constructor. Always define a unique key to ensure different processes can attach to the same segment.

```perl
use IPC::ShareLite;

my $share = IPC::ShareLite->new(
    -key     => 1971,     # Unique integer or 4-char string
    -create  => 'yes',    # Create if it doesn't exist
    -destroy => 'no'      # Keep segment after script exits
) or die "Could not create shared memory: $!";
```

### Atomic Data Operations
The `store` and `fetch` methods are internally atomic, meaning they handle locking during the specific operation.

- **Storing Data**: `$share->store("data_string");`
- **Retrieving Data**: `my $data = $share->fetch();`

### Handling Complex Data Structures
`IPC::ShareLite` only stores scalars. To share hashes or arrays, you must manually serialize them using `Storable`.

```perl
use Storable qw(freeze thaw);

# Writing a hash
my $hash = { status => 'active', count => 42 };
$share->store(freeze($hash));

# Reading a hash
my $retrieved_hash = thaw($share->fetch);
```

### Advisory Locking for Multi-Step Operations
When performing a "read-modify-write" cycle, use explicit locking to prevent race conditions.

```perl
use IPC::ShareLite qw( :lock );

$share->lock( LOCK_EX ); # Exclusive lock

my $val = $share->fetch();
$val++;
$share->store($val);

$share->unlock(); # Or $share->lock( LOCK_UN );
```

### Non-blocking Locks
To avoid hanging a process if a lock is already held:
```perl
if ($share->lock( LOCK_EX | LOCK_NB )) {
    # Perform task
    $share->unlock();
} else {
    # Handle busy state
}
```

## Expert Tips
- **Key Selection**: Use a consistent integer key across all cooperating scripts. If using a string, ensure it is exactly four characters.
- **Memory Cleanup**: If `-destroy => 'yes'` is set, the segment is removed when the *last* object pointing to it is destroyed. For persistent caches, set this to 'no'.
- **Performance**: This module is written in C and is significantly faster than `IPC::Shareable` for raw data throughput.
- **Kernel Limits**: If `store` fails for very large data, check system-wide limits (`SHMALL` and `SHMMNI`). `IPC::ShareLite` will attempt to span multiple segments automatically if the data exceeds the segment size.

## Reference documentation
- [IPC::ShareLite - Lightweight interface to shared memory](./references/metacpan_org_pod_IPC__ShareLite.md)