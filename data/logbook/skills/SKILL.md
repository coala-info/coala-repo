---
name: logbook
description: Logbook is a Python logging library that provides a flexible alternative to the standard logging module by using handler stacks and context managers. Use when user asks to set up logging handlers, manage logging behavior across threads using context managers, or inject contextual data into logs with processors.
homepage: http://logbook.pocoo.org/
---


# logbook

## Overview
Logbook is a powerful alternative to Python's standard `logging` module, designed to make logging more intuitive and less global. It excels in complex applications where you need to manage logging behavior across different threads or execution contexts without messy configuration. This skill helps you set up handlers, use context managers for temporary logging overrides, and inject extra data into logs using processors.

## Core Usage Patterns

### Basic Setup
Replace the standard logger with a Logbook logger. Unlike the standard library, Logbook handlers are usually pushed onto a stack.

```python
from logbook import Logger, StreamHandler
import sys

# Create a logger
log = Logger('App Name')

# Setup a handler (stdout)
StreamHandler(sys.stdout).push_application()

log.info('Hello World')
```

### Context Management
One of Logbook's strongest features is the ability to change logging behavior for a specific block of code using context managers.

```python
from logbook import FileHandler, Logger

log = Logger('ScopedLogger')

# This handler is only active inside the 'with' block
with FileHandler('app.log').threadbound():
    log.info('This goes to the file')

log.info('This goes to the default handler (e.g., stdout)')
```

### Injecting Data with Processors
Use Processors to automatically add contextual information (like user IDs or request IDs) to every log record within a scope.

```python
from logbook import Processor

def inject_user(record):
    record.extra['user'] = 'current_user_id'

with Processor(inject_user).threadbound():
    log.info('User action performed') # Record now contains 'user' key
```

### Handling Exceptions
Logbook provides a convenient way to log exceptions with full tracebacks.

```python
try:
    1 / 0
except ZeroDivisionError:
    log.exception('An error occurred')
```

## Expert Tips
- **Handler Stacks**: Remember that handlers work on a stack. `push_application()` sets a global handler, while `push_thread()` or the `threadbound()` context manager sets it for the current thread only.
- **Performance**: Logbook is designed to be fast, but avoid heavy processing inside `Processor` functions as they run on every log call.
- **Compatibility**: If you are using libraries that depend on the standard `logging` module, use `logbook.compat.redirect_logging()` to redirect those logs into your Logbook handlers.

## Reference documentation
- [Logbook Overview](./references/anaconda_org_channels_bioconda_packages_logbook_overview.md)
- [Logbook Documentation](./references/pythonhosted_org_Logbook.md)