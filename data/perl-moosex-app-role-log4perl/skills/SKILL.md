---
name: perl-moosex-app-role-log4perl
description: This skill enables the rapid integration of professional logging into Perl CLI applications.
homepage: https://github.com/gitpan/MooseX-App-Role-Log4perl
---

# perl-moosex-app-role-log4perl

## Overview

This skill enables the rapid integration of professional logging into Perl CLI applications. By applying the `MooseX::App::Role::Log4perl` role to a `MooseX::App` or `MooseX::App::Simple` class, the application automatically inherits a pre-configured logging infrastructure. This includes standard command-line arguments for controlling log output and a `$self->log` object for emitting messages at various severity levels.

## Implementation

To add logging to your MooseX::App application, consume the role in your main application class or specific command classes:

```perl
package My::App;
use MooseX::App::Simple; # or MooseX::App
with 'MooseX::App::Role::Log4perl';

sub run {
    my $self = shift;
    
    # Access the logger via the 'log' method
    $self->log->info("Application started");
    
    if ($some_condition) {
        $self->log->debug("Detailed variable state: " . $self->some_attr);
    }
}
```

## Logging Methods

The `$self->log` object provides methods corresponding to standard Log4perl levels:

*   `$self->log->debug("message")`: For detailed diagnostic information.
*   `$self->log->info("message")`: For general operational entries (Default minimum level for STDOUT).
*   `$self->log->warn("message")`: For non-critical anomalies.
*   `$self->log->error("message")`: For errors that permit continued execution.
*   `$self->log->fatal("message")`: For severe errors that will lead to application termination.

## Command Line Interface (CLI) Usage

Once the role is applied, the following options are automatically added to your application's help and argument parsing:

| Option | Description |
| :--- | :--- |
| `--logfile <path>` | Directs Log4perl output to the specified file instead of or in addition to the terminal. |
| `--debug` | Sets the logging threshold to DEBUG, showing all messages including developer-level traces. |
| `--quiet` | Suppresses all output to the terminal (STDOUT). Useful for cron jobs or background processing. |

### Common Patterns

**1. Standard Execution (INFO level to STDOUT):**
```bash
perl my_app.pl
```

**2. Debugging Mode:**
```bash
perl my_app.pl --debug
```

**3. Silent Logging to File:**
```bash
perl my_app.pl --logfile /var/log/my_app.log --quiet
```

## Best Practices

*   **Default Behavior**: Remember that by default, the role logs to STDOUT with a priority of INFO or higher.
*   **Contextual Logging**: Use `debug` liberally for information that is only useful during troubleshooting, as it is hidden from users unless they explicitly pass the `--debug` flag.
*   **Error Handling**: Use `fatal` immediately before a `die` or `exit` call to ensure the reason for the crash is captured in the logs.

## Reference documentation
- [MooseX::App::Role::Log4perl README](./references/github_com_gitpan_MooseX-App-Role-Log4perl.md)