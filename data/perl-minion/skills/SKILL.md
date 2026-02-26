---
name: perl-minion
description: Perl-minion is a high-performance job queue for the Mojolicious framework used to manage background tasks and asynchronous processing. Use when user asks to manage background jobs, start workers, inspect the job queue, or enqueue non-blocking tasks.
homepage: https://mojolicious.org
---


# perl-minion

## Overview
Minion is a high-performance job queue for the Mojolicious real-time web framework. This skill provides guidance on deploying Minion via the Bioconda ecosystem and utilizing its native command-line interface to manage background processing. It should be used when an application requires non-blocking task execution, such as sending emails, processing heavy data, or performing long-running computations outside the main request-response cycle.

## Installation
The package is available through the Bioconda channel.

```bash
conda install bioconda::perl-minion
```

## Common CLI Patterns
Minion integrates directly with the Mojolicious command system. Assuming your application script is `app.pl`:

### Worker Management
Start a worker to begin processing jobs from the queue:
```bash
perl app.pl minion worker
```

### Job Inspection and Management
List all jobs in the queue:
```bash
perl app.pl minion job
```

List jobs with a specific state (inactive, active, failed, finished):
```bash
perl app.pl minion job -s failed
```

View details about a specific job by ID:
```bash
perl app.pl minion job <job_id>
```

Remove a finished or failed job from the queue:
```bash
perl app.pl minion job -r <job_id>
```

### Task Execution
Manually enqueue a task from the command line:
```bash
perl app.pl minion job -e <task_name> '["argument1", "argument2"]'
```

## Best Practices
- **Process Management**: In production environments, use a process manager like `systemd` or `supervisord` to keep `minion worker` processes running.
- **Database Backend**: Minion requires a backend (typically PostgreSQL via `Mojo::Pg`). Ensure the backend is initialized before starting workers.
- **Graceful Shutdown**: Minion workers handle `SIGTERM` and `SIGINT` gracefully, finishing the current job before exiting. Use these signals when restarting services.
- **Job Idempotency**: Ensure that tasks are idempotent, meaning they can be run multiple times without side effects, in case a job is retried after a failure.

## Reference documentation
- [perl-minion - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-minion_overview.md)
- [Mojolicious - Perl real-time web framework](./references/mojolicious_org_index.md)