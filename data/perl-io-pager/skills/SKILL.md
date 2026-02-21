---
name: perl-io-pager
description: The `perl-io-pager` tool provides a mechanism for Perl scripts to intelligently handle large volumes of text output.
homepage: http://metacpan.org/pod/IO-Pager
---

# perl-io-pager

## Overview
The `perl-io-pager` tool provides a mechanism for Perl scripts to intelligently handle large volumes of text output. Instead of flooding a terminal, it detects whether the output destination is a user-interactive terminal (TTY). If it is, the tool selects an available system pager or uses a Perl-native paging fallback to display content one screen at a time. This skill provides the necessary patterns for integrating this paging logic into Perl environments and command-line workflows.

## Usage Patterns

### Basic Command Line Usage
While primarily a library, it can be invoked to pipe content through the preferred system pager:
```bash
# Pipe long output through the IO::Pager logic
perl -MIO::Pager -e 'print <>' large_file.txt
```

### Integration in Perl Scripts
To enable automatic paging in a Perl script, use the following idiomatic patterns:

**1. The Object-Oriented Approach (Recommended)**
This method allows for better control over when paging starts and ends.
```perl
use IO::Pager;

# Create a new pager object; it automatically selects the best pager
my $token = IO::Pager->new(*STDOUT);

print "This output will be paged if STDOUT is a TTY.\n";
# Paging ends when $token goes out of scope or is undefined
```

**2. The Procedural "Quick" Approach**
Use this for simple scripts where you want the entire output paged.
```perl
use IO::Pager;
{
    local $STDOUT = IO::Pager->open(*STDOUT);
    print "Everything in this block is paged.\n";
}
```

### Environment Variables
`IO::Pager` respects standard environment variables. You can force specific behaviors without changing code:
- `PAGER`: Set this to your preferred executable (e.g., `less -R`, `most`).
- `PERL_PAGER`: Overrides the `PAGER` variable specifically for Perl scripts using this module.

## Best Practices
- **TTY Detection**: `IO::Pager` automatically checks `-t STDOUT`. Do not manually wrap it in TTY checks unless you need to bypass the pager for specific log levels.
- **Pipe Handling**: If the script's output is redirected to a file or another command (e.g., `script.pl > output.txt`), `IO::Pager` will transparently step out of the way and act as a standard filehandle.
- **Layering**: When using `IO::Pager`, ensure it is the outermost layer if you are also using encoding layers (like `:utf8`), as the pager needs to handle the final byte stream sent to the terminal.

## Reference documentation
- [IO-Pager Documentation](./references/metacpan_org_pod_IO-Pager.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-io-pager_overview.md)