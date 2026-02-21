---
name: perl-log-log4perl
description: `perl-log-log4perl` is the definitive logging framework for Perl, modeled after the Java Log4j library.
homepage: http://metacpan.org/pod/Log::Log4perl
---

# perl-log-log4perl

## Overview
`perl-log-log4perl` is the definitive logging framework for Perl, modeled after the Java Log4j library. It allows developers to insert logging statements into their code and then control the verbosity and destination of those logs through an external configuration or simple API calls. This skill covers the initialization of loggers, the use of categories for granular control, and the configuration of appenders and layouts to ensure logs are both actionable and performant.

## Core Implementation

### Quick Start (Easy Mode)
For simple scripts where a full configuration file is overkill, use the `:easy` mode:

```perl
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($DEBUG);

DEBUG "This is a debug message";
INFO  "This is an info message";
ERROR "Something went wrong";
```

### Standard Initialization
In production applications, initialize the logger once at the entry point (e.g., `main.pl`) using a configuration file:

```perl
use Log::Log4perl;
Log::Log4perl->init("log.conf");

my $logger = Log::Log4perl->get_logger("My::Module");
$logger->info("Application started");
```

## Configuration Best Practices
Log4perl typically uses a properties-style configuration. Avoid hardcoding paths; use environment variables or relative paths where possible.

### Basic File and Screen Configuration
```properties
# log.conf
log4perl.rootLogger              = DEBUG, LOGFILE, SCREEN

# File Appender
log4perl.appender.LOGFILE          = Log::Log4perl::Appender::File
log4perl.appender.LOGFILE.filename = /var/log/app.log
log4perl.appender.LOGFILE.layout   = Log::Log4perl::Layout::PatternLayout
log4perl.appender.LOGFILE.layout.ConversionPattern = %d %p %c - %m%n

# Screen Appender
log4perl.appender.SCREEN           = Log::Log4perl::Appender::Screen
log4perl.appender.SCREEN.stderr    = 0
log4perl.appender.SCREEN.layout    = Log::Log4perl::Layout::SimpleLayout
```

## Expert Tips and Patterns

### Performance Optimization
Constructing complex log strings can be expensive even if the log level is suppressed. Use the `is_LEVEL` methods to wrap expensive operations:

```perl
if ($logger->is_debug()) {
    $logger->debug("Data dump: " . Data::Dumper::Dumper($complex_obj));
}
```

### Category-Based Logging
Use `__PACKAGE__` as the category name to allow fine-grained control over specific modules in your configuration:

```perl
package My::App::Database;
use Log::Log4perl;
my $logger = Log::Log4perl->get_logger(__PACKAGE__);
```

In the config, you can then silence just this module:
`log4perl.logger.My::App::Database = ERROR`

### Stealth Loggers
If you cannot easily pass logger objects through a legacy codebase, use the "stealth logger" shortcuts:

```perl
use Log::Log4perl qw(:resurrect);
# This allows using logging functions in any package 
# once Log4perl is initialized elsewhere.
```

### Handling Newlines
By default, Log4perl does not append newlines unless specified in the `ConversionPattern`. Always include `%n` at the end of your pattern to ensure logs are readable.

## Common CLI Patterns
While Log4perl is a library, you can verify your configuration or installation via the command line:

**Check if the module is installed:**
```bash
perl -MLog::Log4perl -e 'print $Log::Log4perl::VERSION'
```

**Install via Bioconda:**
```bash
conda install bioconda::perl-log-log4perl
```

## Reference documentation
- [Log::Log4perl - Log4j implementation for Perl](./references/metacpan_org_pod_Log__Log4perl.md)
- [perl-log-log4perl - bioconda](./references/anaconda_org_channels_bioconda_packages_perl-log-log4perl_overview.md)