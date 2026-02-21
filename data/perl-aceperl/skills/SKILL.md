---
name: perl-aceperl
description: AcePerl (Ace.pm) is a specialized Perl interface for ACEDB, an object-oriented database system widely used in bioinformatics.
homepage: https://github.com/WormBase/AcePerl
---

# perl-aceperl

## Overview
AcePerl (Ace.pm) is a specialized Perl interface for ACEDB, an object-oriented database system widely used in bioinformatics. This skill enables the management of biological data by providing procedural knowledge on establishing database connections, retrieving genomic objects, and optimizing data access through caching and pre-filling. Use this skill when you need to write or debug Perl scripts that communicate with local or remote ACEDB instances, such as the public WormBase server.

## Connection Patterns
Establish connections using the `Ace->connect()` method. The connection string format determines the protocol used.

### Remote Socket Connection (Recommended)
Used for modern Ace servers (e.g., WormBase).
```perl
use Ace;
my $db = Ace->connect('sace://aceserver.cshl.org:2005') 
    or die "Cannot connect: ", Ace->error;
```

### Local Database Connection
Used when the ACEDB files are on the local filesystem.
```perl
my $db = Ace->connect(-path => '/usr/local/acedb/my_data')
    or die Ace->error;
```

### RPC Connection
Used for older server configurations.
```perl
my $db = Ace->connect('rpc://hostname:port');
```

## Data Retrieval and Querying
AcePerl treats database entries as objects. Efficient retrieval is key to performance.

### Fetching Specific Objects
```perl
# Fetch a specific sequence by name
my $seq = $db->fetch(Sequence => 'B0273');

# Access tags within the object
print $seq->DNA;
```

### Searching with Filters
Use the `search` method to find objects matching specific criteria.
```perl
# Find all sequences matching a pattern
my @sequences = $db->search(Sequence => 'B02*');

# Use -fill to pre-load object data (reduces network round-trips)
my @full_objects = $db->search(-class => 'Author', 
                              -query => 'Name="Stein*"', 
                              -fill  => 1);
```

### Iterating Over Large Result Sets
For memory efficiency with large queries, use the `fetch_many` iterator.
```perl
my $i = $db->fetch_many(Sequence => '*');
while (my $obj = $i->next) {
    print $obj->name, "\n";
}
```

## Performance and Optimization
*   **Object Caching**: AcePerl caches objects in memory. If memory usage becomes an issue in long-running scripts, use `$db->memory_cache_clear()` to flush the cache.
*   **Partial Filling**: When fetching objects, use the `-fill` parameter if you know you will need the internal data immediately. This prevents the "lazy loading" behavior that causes a separate request for every tag access.
*   **Debugging**: Set the environment variable `ACEDB_DEBUG` or use the low-level debugging facilities in the interface to trace communication between the Perl client and the Ace server.

## Environment Configuration
The following environment variables influence AcePerl behavior:
*   `ACEDB_HOST`: Default host for tests.
*   `ACEDB_PORT`: Default port for tests.
*   `ACEDB_MACHINE`: Used during installation to specify the architecture (e.g., `LINUX_4`, `ALPHA_4_GCC`).
*   `PERL5LIB`: Ensure this includes the path to the AcePerl library if installed in a non-standard location.

## Reference documentation
- [Ace.pm - Perl interface to ACEDB databases](./references/github_com_WormBase_AcePerl.md)
- [AcePerl Commits and Updates](./references/github_com_WormBase_AcePerl_commits_master.md)