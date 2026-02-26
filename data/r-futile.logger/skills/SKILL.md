---
name: r-futile.logger
description: This tool provides a scoped logging utility for R based on the log4j framework. Use when user asks to implement structured logging, manage log levels, redirect output to files, or format log messages in R scripts and packages.
homepage: https://cloud.r-project.org/web/packages/futile.logger/index.html
---


# r-futile.logger

name: r-futile.logger
description: A logging utility for R based on log4j. Use this skill when you need to implement structured logging, manage log levels (DEBUG, INFO, WARN, ERROR), or redirect R output to files and custom appenders. It is ideal for replacing cat() and print() statements with professional logging in R scripts and packages.

## Overview

`futile.logger` provides a scoped logging mechanism for R. It supports hierarchical loggers, custom formatting (layouts), and multiple output targets (appenders). It automatically handles package-level scoping, allowing users to toggle logging for specific packages without modifying their code.

## Installation

```R
install.packages("futile.logger")
```

## Core Logging Functions

The package uses a `flog.<level>` syntax. The default threshold is `INFO`.

```R
library(futile.logger)

# Basic logging (supports sprintf-style formatting)
flog.info("System initialized with %d cores", parallel::detectCores())
flog.warn("Low disk space: %s", "/var/log")
flog.error("Connection failed: %s", "Timeout")

# These will not print if threshold is INFO
flog.debug("Variable x is %f", 3.14)
flog.trace("Entering loop")
```

## Configuration

### Thresholds (Log Levels)
Control the verbosity of the logger. Available levels: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`.

```R
# Get current threshold
flog.threshold()

# Set threshold for the ROOT logger
flog.threshold(DEBUG)

# Set threshold for a specific named logger
flog.threshold(ERROR, name = "my_module")
```

### Appenders (Output Targets)
Appenders define where the logs go.

```R
# Log to console (default)
flog.appender(appender.console())

# Log to a file
flog.appender(appender.file("app.log"))

# Log to both console and file (tee)
flog.appender(appender.tee("app.log"))

# Multi-file logging based on level (e.g., mylog-INFO.log, mylog-ERROR.log)
flog.appender(appender.file2("mylog-~l.log"), name = "my_logger")
```

### Layouts (Formatting)
Layouts define the string structure of the log message.

```R
# Simple layout: LEVEL [datetime] Message
flog.layout(layout.simple)

# Custom format string
# ~l: level, ~t: timestamp, ~m: message, ~n: namespace/logger
flog.layout(layout.format("[~l] [~t] ~m"))

# Include Process ID (useful for parallel processing)
flog.layout(layout.simple.parallel)
```

## Advanced Workflows

### Package-Scoped Logging
When used inside an R package, `futile.logger` automatically creates a logger named after the package. Users can control your package's logging independently:

```R
# In a user script, silence a specific package
flog.threshold(WARN, name = "PackageName")
```

### Error Handling with ftry
Wrap expressions in `ftry` to automatically log errors if the execution fails.

```R
# Logs the error to the logger before stopping/returning error
result <- ftry(log("a")) 
```

### Managing Loggers
```R
# Create/Update a logger with specific settings
flog.logger("my_app", DEBUG, appender = appender.file("debug.log"))

# Remove a logger to revert to ROOT settings
flog.remove("my_app")
```

## Tips
- **Avoid Reserved Names**: Do not name loggers after levels (e.g., do not name a logger "DEBUG").
- **Performance**: Logging statements have low overhead when the threshold is not met, as the message string is not evaluated unless the log is actually triggered.
- **Complex Objects**: Use `layout.tracearg` to dump variable names and values for debugging.

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)