---
name: perl-minion-backend-sqlite
description: This tool provides a lightweight SQLite-based storage engine for the Minion job queue. Use when user asks to set up a file-based job queue, initialize a Minion backend for testing or development, or manage background jobs using a local SQLite database.
homepage: https://github.com/Grinnz/Minion-Backend-SQLite
metadata:
  docker_image: "quay.io/biocontainers/perl-minion-backend-sqlite:5.0.7--pl5321hdfd78af_0"
---

# perl-minion-backend-sqlite

## Overview
The `Minion::Backend::SQLite` module provides a lightweight, file-based storage engine for the Minion job queue. While Minion traditionally defaults to PostgreSQL, this SQLite backend is ideal for development environments, testing suites, and small-scale production applications where a standalone database server is not desired. It leverages `Mojo::SQLite` to handle automatic schema migrations and concurrent access.

## Implementation Patterns

### Initialization
The backend can be initialized standalone or directly through the Minion constructor.

```perl
use Minion;

# Use a local file
my $minion = Minion->new(SQLite => 'sqlite:jobs.db');

# Use a temporary database (useful for unit tests)
my $minion = Minion->new(SQLite => ':temp:');

# Use an existing Mojo::SQLite object for shared connection caching
use Mojo::SQLite;
my $sql = Mojo::SQLite->new('sqlite:jobs.db');
my $minion = Minion->new(SQLite => $sql);
```

### Mojolicious Integration
When using the Mojolicious web framework, load the backend via the Minion plugin.

```perl
# In a Mojolicious::Lite app
plugin Minion => { SQLite => 'sqlite:myapp.db' };

# In a full Mojolicious app
$self->plugin(Minion => { SQLite => 'sqlite:myapp.db' });
```

### Job Management
Use the standard Minion API to interact with the SQLite backend.

*   **Enqueueing**: Add jobs with optional priority, delays, and dependencies.
    ```perl
    # Simple job
    $minion->enqueue('generate_report' => ['user_42']);

    # Advanced job with options
    $minion->enqueue(generate_report => ['user_42'] => {
      priority => 5,
      delay    => 30,
      parents  => [$job_id1, $job_id2]
    });
    ```

*   **Worker Operations**: Dequeue jobs for processing.
    ```perl
    my $worker = $minion->worker;
    my $job    = $worker->dequeue(0.5); # Wait 0.5 seconds for a job
    ```

## Best Practices and Tips

### Performance Tuning
*   **Dequeue Interval**: The `dequeue_interval` attribute defaults to 0.5 seconds. For high-throughput environments, you can lower this to reduce latency, though it increases CPU usage on the SQLite file.
    ```perl
    $minion->backend->dequeue_interval(0.1);
    ```
*   **WAL Mode**: `Mojo::SQLite` (and thus this backend) typically performs better with Write-Ahead Logging enabled. You can configure the underlying SQLite handle via the `sqlite` attribute.

### Database Migrations
The backend handles its own migrations automatically. The tables are created the first time the backend is accessed. If you need to manage the database file manually (e.g., for backups), ensure the process has write permissions to both the database file and the directory it resides in (for journal/WAL files).

### Limitations
SQLite has higher contention limits than PostgreSQL. While this backend supports concurrent workers, extremely high volumes of concurrent writes may result in "database is locked" errors. For massive scaling, consider migrating to the PostgreSQL backend.

## Reference documentation
- [Minion::Backend::SQLite GitHub Repository](./references/github_com_Grinnz_Minion-Backend-SQLite.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-minion-backend-sqlite_overview.md)