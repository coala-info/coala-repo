---
name: perl-cache-cache
description: The `perl-cache-cache` skill enables efficient data persistence within Perl environments.
homepage: http://metacpan.org/pod/Cache::Cache
---

# perl-cache-cache

## Overview
The `perl-cache-cache` skill enables efficient data persistence within Perl environments. It provides a standardized interface for storing data for specific durations, allowing applications to bypass repetitive, high-latency operations like remote API calls or complex database queries. This skill covers the selection of appropriate cache implementations—ranging from volatile memory-based storage to persistent filesystem-based caches—and the management of object expiration and namespace isolation.

## Implementation Patterns

### Selecting the Cache Type
*   **MemoryCache**: Best for single-process applications (like mod_perl) where data only needs to persist across sequential requests within the same process.
*   **FileCache**: The most versatile option. Use this to share data across different processes or script invocations without the size limitations of shared memory.
*   **SharedMemoryCache**: Use for high-speed IPC (Inter-Process Communication), but be aware it is limited by system-level IPC settings and object size.
*   **SizeAware Variants**: Use `SizeAwareFileCache` or `SizeAwareMemoryCache` when you must enforce a strict upper limit on the cache's footprint.

### Basic Usage Pattern
```perl
use Cache::FileCache;

# Initialize with options
my $cache = new Cache::FileCache( { 
    'namespace' => 'customer_data',
    'default_expires_in' => '1 hour' 
} );

# Retrieve data
my $data = $cache->get( $customer_id );

if ( !defined $data ) {
    $data = fetch_from_db( $customer_id );
    # Set with specific expiration
    $cache->set( $customer_id, $data, "10 minutes" );
}
```

### Expiration Formats
The `set` method and `default_expires_in` option accept flexible time strings:
*   **Constants**: `now`, `never`.
*   **Relative**: "10 seconds", "2 minutes", "5 hours", "1 day", "1 week", "3 months", "1 year".

## Expert Tips & Best Practices
*   **Namespace Isolation**: Always define a `namespace` during initialization to prevent key collisions between different parts of an application or different applications using the same cache type.
*   **Automatic Maintenance**: Use the `auto_purge_interval` option to automatically remove expired items during `set` operations. This prevents the cache from growing indefinitely without requiring a separate maintenance script.
*   **Object Integrity**: When using `FileCache`, ensure the cache directory is writable by the user executing the Perl script.
*   **Successor Note**: While `Cache::Cache` is stable, for new projects with high-performance requirements, consider the `CHI` module, which is the modern successor to this interface.

## Reference documentation
- [Cache::Cache - the Cache interface](./references/metacpan_org_pod_Cache__Cache.md)