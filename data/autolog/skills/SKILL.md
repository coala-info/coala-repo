---
name: autolog
description: The autolog tool simplifies the process of setting up logging in Python environments.
homepage: http://noble.gs.washington.edu/~mmh1/software/autolog/
---

# autolog

## Overview
The autolog tool simplifies the process of setting up logging in Python environments. It provides a streamlined way to initialize loggers that automatically handle file rotation, timestamping, and stream redirection. This skill helps you implement consistent logging practices across scripts and applications with minimal configuration overhead.

## Usage Instructions

### Basic Initialization
To start logging in a Python script, import and initialize autolog at the entry point:

```python
import autolog

# Initialize with default settings (logs to console)
autolog.init()

# Initialize with a specific log file and level
autolog.init(logfile='app.log', level='INFO')
```

### Logging Levels
Use standard logging levels to categorize information:
- `DEBUG`: Detailed information for diagnosing problems.
- `INFO`: Confirmation that things are working as expected.
- `WARNING`: Indication that something unexpected happened.
- `ERROR`: More serious problem; the software has not been able to perform a function.
- `CRITICAL`: A serious error, indicating that the program itself may be unable to continue running.

### Capturing Output
Autolog can be configured to capture all standard output and error streams:

```python
# Redirect stdout and stderr to the log file
autolog.init(logfile='process.log', capture_stdout=True, capture_stderr=True)
```

### Best Practices
- **Early Initialization**: Call `autolog.init()` as early as possible in your main script to ensure all subsequent logs and imported module logs are captured.
- **Consistent Naming**: Use descriptive log file names that include the script name or process ID if running multiple instances.
- **Environment Awareness**: Use environment variables to toggle between `DEBUG` and `INFO` levels without changing code.

## Reference documentation
- [autolog Overview](./references/anaconda_org_channels_bioconda_packages_autolog_overview.md)