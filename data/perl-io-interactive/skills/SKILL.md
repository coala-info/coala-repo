---
name: perl-io-interactive
description: This tool provides functions to detect and manage interactive terminal sessions within Perl scripts. Use when user asks to check if a script is running in a terminal, suppress output in non-interactive environments, or manage terminal-aware I/O.
homepage: https://github.com/briandfoy/io-interactive
---


# perl-io-interactive

## Overview
The `perl-io-interactive` skill provides guidance on using the `IO::Interactive` Perl module to manage terminal-aware I/O. It allows developers to distinguish between a user-facing terminal and a background process or data pipe. By using this tool, you can ensure that your Perl utilities behave gracefully in both interactive shells and automated environments (like cron jobs or CI/CD pipelines) by suppressing unnecessary output or avoiding blocked inputs when no terminal is attached.

## Installation
To use this module in your environment, install it via Bioconda or CPAN:

```bash
# Via Bioconda
conda install bioconda::perl-io-interactive

# Via CPAN
cpanm IO::Interactive
```

## Core Functions and Usage
The module provides three primary functions to handle interactivity:

### 1. is_interactive()
Returns true if the specified filehandle (or `STDOUT` by default) is connected to an interactive terminal.

```perl
use IO::Interactive qw(is_interactive);

if ( is_interactive() ) {
    print "Running in a terminal. I can ask questions!\n";
}
```

### 2. interactive()
Returns a special filehandle that only sends output to the terminal if the session is interactive. If the session is not interactive (e.g., redirected to a file), the output is silently discarded.

```perl
use IO::Interactive qw(interactive);

# This message only appears if a user is watching
print {interactive} "Initializing system components...\n";

# Standard data output still goes to STDOUT/redirected file
print "DATA: 1,2,3,4,5\n";
```

### 3. busy()
Provides a simple way to signal that the script is working. It takes a block of code and executes it while potentially displaying a "busy" indicator to the user.

## Best Practices
- **Separate Data from Chatter**: Use `STDOUT` for the actual data your script produces and `{interactive}` for status updates, progress bars, or "verbose" messages. This allows users to pipe your data to another tool without the "chatter" corrupting the stream.
- **Conditional Prompts**: Always wrap `STDIN` prompts in an `is_interactive` check. This prevents your script from hanging indefinitely when run in a non-interactive environment where no one can answer the prompt.
- **Testing Redirection**: Test your script's behavior by piping it to `cat` or redirecting to `/dev/null` to ensure that interactive-only messages disappear as expected.

## Reference documentation
- [GitHub Repository for IO::Interactive](./references/github_com_briandfoy_io-interactive.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-io-interactive_overview.md)