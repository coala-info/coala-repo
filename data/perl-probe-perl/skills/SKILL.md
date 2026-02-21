---
name: perl-probe-perl
description: The `perl-probe-perl` skill provides a reliable way to inspect the Perl environment.
homepage: http://metacpan.org/pod/Probe::Perl
---

# perl-probe-perl

## Overview
The `perl-probe-perl` skill provides a reliable way to inspect the Perl environment. While Perl provides built-in variables like `$^X`, they are often unreliable across different operating systems or when Perl is invoked via a wrapper. This tool (Probe::Perl) abstracts those inconsistencies, providing a unified interface to find the absolute path to the perl binary and query its properties.

## Usage Patterns

### Finding the Perl Executable
The most common use case is identifying the exact path of the perl binary currently executing the script. This is critical for spawning child processes or generating shebang lines dynamically.

```perl
use Probe::Perl;
my $p = Probe::Perl->new;

# Get the absolute path to the current perl binary
my $perl_path = $p->find_perl;
```

### Environment Inspection
Use these methods to gather metadata about the runtime environment:

- `$p->perl_version`: Returns the version of the running perl.
- `$p->is_cygwin`: Boolean check for Cygwin environments.
- `$p->is_strawberry`: Boolean check for Strawberry Perl on Windows.
- `$p->is_activeperl`: Boolean check for ActiveState Perl.

### Handling Path Variations
When working in complex environments (like Conda or containers), `find_perl` is safer than relying on shell-level `which perl` commands, as it uses internal logic to resolve the actual binary location.

## Best Practices
- **Object Orientation**: Always instantiate the probe object using `Probe::Perl->new` rather than calling methods statically to ensure internal state is handled correctly.
- **Cross-Platform Scripts**: Use this tool specifically when your script must run on both Unix-like systems and Windows, as it handles the `.exe` extension and path separator differences automatically.
- **Process Spawning**: When using `system()` or `exec()` to run another Perl script, always use the path returned by `find_perl` to ensure the child process uses the same interpreter and library paths as the parent.

## Reference documentation
- [Probe::Perl Documentation](./references/metacpan_org_pod_Probe__Perl.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-probe-perl_overview.md)