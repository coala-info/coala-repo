---
name: perl-test-script
description: The perl-test-script tool validates the syntax, runnability, and command-line interface behavior of Perl scripts. Use when user asks to verify script compilation, test command-line arguments, or check script output and exit codes.
homepage: https://metacpan.org/pod/Test::Script
metadata:
  docker_image: "quay.io/biocontainers/perl-test-script:1.31--pl5321hdfd78af_0"
---

# perl-test-script

## Overview
The `perl-test-script` skill provides a standardized way to validate the "runnability" of Perl scripts. While many Perl tests focus on internal modules, this tool specifically targets the script files themselves. It ensures that scripts are syntactically correct, have proper shebang lines, and execute successfully in a cross-platform environment. It is essential for maintaining CLI tools and ensuring that changes to underlying libraries haven't broken the primary script entry points.

## Usage Patterns

### Basic Script Validation
The most common use case is verifying that a script compiles and runs without crashing.

```perl
use Test::More tests => 2;
use Test::Script;

# Test if the script compiles (perl -c)
script_compiles('bin/myscript.pl');

# Test if the script runs and exits with 0
script_runs('bin/myscript.pl');
```

### Testing CLI Arguments and Output
You can pass arguments to the script and verify both the exit code and the resulting output.

```perl
# Test with specific arguments
script_runs(['bin/myscript.pl', '--version'], 'Check version flag');

# Verify output content
script_stdout_is("v1.0.0\n", "Version output matches");
script_stdout_like(qr/Copyright/, "Output contains copyright notice");

# Verify error conditions
script_fails(['bin/myscript.pl', '--invalid-opt'], { exit => 1 });
script_stderr_like(qr/Unknown option/, "Error message shown for bad options");
```

### Expert Tips
- **Path Handling**: Always use relative paths from the project root or use `File::Spec` to ensure tests remain cross-platform.
- **Shebang Testing**: `script_compiles` is particularly useful for catching "Variable not found" errors that only trigger when the script is executed as a standalone program rather than a module.
- **Test Grouping**: When testing multiple CLI flags, use `subtest` to group related execution and output checks to keep TAP (Test Anything Protocol) output organized.
- **Environment Isolation**: If your script modifies files, use a temporary directory (e.g., `File::Temp`) within your test script before calling `script_runs`.

## Reference documentation
- [Test::Script Documentation](./references/metacpan_org_pod_Test__Script.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-script_overview.md)