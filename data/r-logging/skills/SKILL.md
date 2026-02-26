---
name: r-logging
description: This tool provides a hierarchical logging system for R based on the log4j and Python logging frameworks. Use when user asks to implement loggers, manage multiple log handlers, set log levels, or customize log formatting in R scripts and packages.
homepage: https://cloud.r-project.org/web/packages/logging/index.html
---


# r-logging

name: r-logging
description: Expert guidance for the 'logging' R package, a log4j-inspired logging system. Use this skill when you need to implement hierarchical logging, manage multiple log handlers (console, file), set log levels (DEBUG, INFO, WARN, ERROR), or customize log formatting and message composition in R scripts and packages.

## Overview

The `logging` package provides a flexible, hierarchical logging system for R, emulating the behavior of Python's logging module and log4j. It allows for fine-grained control over log output through loggers, handlers, and formatters.

## Installation

```R
install.packages("logging")
```

## Core Workflow

### 1. Initialization
By default, the package initializes a root logger. Use `basicConfig()` to quickly set up a console handler.

```R
library(logging)
basicConfig(level = 'INFO') # Sets root logger to INFO
```

### 2. Logging Messages
Use entry-point functions corresponding to log levels. Messages are automatically timestamped.

```R
logdebug("Detailed debugging info")
loginfo("Standard informational message")
logwarn("Warning: something might be wrong")
logerror("An error occurred")
```

### 3. Hierarchical Loggers
Loggers are organized in a dot-separated hierarchy (e.g., "myapp.database"). Child loggers inherit settings from parents unless overridden.

```R
# Get or create a specific logger
log <- getLogger("myapp.module")
loginfo("Message from module", logger = "myapp.module")
```

### 4. Handler Management
Handlers determine where logs go (console, file, etc.).

```R
# Add a file handler to a specific logger
addHandler(writeToFile, logger = "myapp", file = "app.log")

# Remove a handler
removeHandler("writeToFile", logger = "myapp")

# Get a handler to modify it
h <- getHandler("basic.stdout")
```

## Advanced Configuration

### Setting Levels
Levels can be set for both loggers and specific handlers using `setLevel()`.

```R
setLevel("DEBUG", container = "myapp.module")
setLevel("ERROR", container = getHandler("basic.stdout"))
```

### Message Composers
Custom functions can be used to format the raw message before it reaches the handler.

```R
setMsgComposer(function(msg, ...) paste0("PREFIX: ", msg), container = "myapp")
# To revert:
resetMsgComposer(container = "myapp")
```

### Custom Handlers
A handler is an environment containing a `level`, a `formatter`, and an `action`. You can create custom actions:

```R
myAction <- function(msg, handler, ...) {
  cat("CUSTOM:", msg, "\n")
}
addHandler(myAction, logger = "custom")
```

## Tips and Best Practices
- **Resetting**: Use `logReset()` to clear all handlers and loggers and return to a clean state.
- **Formatting**: The default formatter includes the timestamp, level, and logger name. Use `updateOptions()` to modify handler-specific settings.
- **Performance**: Use `sprintf` style formatting within log calls (e.g., `loginfo("Value is %f", x)`) to avoid unnecessary string construction if the log level is suppressed.

## Reference documentation

- [R Logging Package Reference Manual](./references/reference_manual.md)