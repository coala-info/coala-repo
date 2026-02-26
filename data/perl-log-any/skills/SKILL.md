---
name: perl-log-any
description: "Log::Any provides a transparent logging interface for Perl that decouples log production in modules from log consumption in applications. Use when user asks to implement a standardized logging API, add logging to Perl modules, or configure log adapters to direct output to specific destinations."
homepage: https://github.com/preaction/Log-Any
---


# perl-log-any

## Overview
Log::Any is a transparent logging interface for Perl that separates log production from log consumption. This skill helps you implement a standardized logging API within CPAN-style modules or private libraries without forcing a specific logging framework (like Log4perl or Log::Dispatch) on the end user. It is particularly useful for ensuring that library code remains "silent" by default while allowing application developers to easily hook into various output destinations.

## Implementation Patterns

### For Module Authors (Log Production)
To add logging to a module, use the package-level logger. This is the most common and efficient pattern.

```perl
package My::Module;
use Log::Any qw($log);

sub do_something {
    my ($self, @args) = @_;
    
    $log->debug("Starting process...");
    
    if (not @args) {
        $log->error("No arguments provided");
        return;
    }
    
    # Structured logging (hashref as last argument)
    $log->info("Process complete", { duration => 5, status => 'success' });
}
```

### For Application Developers (Log Consumption)
Applications must choose an adapter to direct the logs. Without an adapter, all logs are sent to a 'null' sink.

```perl
use My::Module;
use Log::Any::Adapter;

# Simple output to STDERR
Log::Any::Adapter->set('Stderr');

# Output to a file
Log::Any::Adapter->set('File', '/var/log/app.log');

# Integration with Log4perl
Log::Any::Adapter->set('Log4perl');
```

## Best Practices

### Use Formatting Methods
Instead of manual string concatenation, use the "f" suffix methods (infof, debugf, etc.). These handle `sprintf` formatting and automatically stringify complex references using `Data::Dumper`.

```perl
# Good: Efficient and handles references
$log->debugf("Processing items: %s", \@items);

# Avoid: Manual stringification is brittle
$log->debug("Processing items: " . join(',', @items));
```

### Conditional Logging for Performance
If generating the log message involves expensive operations, wrap the call in a level check.

```perl
if ($log->is_debug) {
    my $heavy_data = $self->calculate_expensive_stats();
    $log->debugf("Stats: %s", $heavy_data);
}
```

### Stack Traces
For deep debugging, use the `WithStackTrace` proxy to automatically include caller information.

```perl
my $log = Log::Any->get_logger(
    proxy_class => 'WithStackTrace',
    proxy_show_stack_trace_args => 0 # Hide sensitive args in trace
);
```

## Log Levels
Log::Any supports the following levels (from highest to lowest priority):
- `emergency`, `alert`, `critical` (alias: `crit`, `fatal`)
- `error` (alias: `err`)
- `warning` (alias: `warn`)
- `notice`
- `info` (alias: `inform`)
- `debug`
- `trace`

## Reference documentation
- [Log::Any GitHub Repository](./references/github_com_preaction_Log-Any.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-log-any_overview.md)
- [Version Tags and Changelog](./references/github_com_preaction_Log-Any_tags.md)