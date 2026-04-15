---
name: perl-term-detect-software
description: This tool identifies the terminal emulator currently running a script and maps it to supported features like color depth and mouse protocols. Use when user asks to detect terminal software, check for TrueColor or Unicode support, or determine terminal emulator capabilities.
homepage: https://metacpan.org/pod/Term::Detect::Software
metadata:
  docker_image: "quay.io/biocontainers/perl-term-detect-software:0.227--pl5321hdfd78af_0"
---

# perl-term-detect-software

## Overview
The `perl-term-detect-software` skill provides a programmatic way to identify which terminal emulator is currently running a script. Beyond simple identification, it maps terminal software to known feature sets, allowing developers to determine if a terminal supports advanced features like 256-color/TrueColor, specific mouse protocols, or box-drawing characters. This ensures a consistent user experience across diverse environments like xterm, iTerm2, GNOME Terminal, or Windows Console.

## Usage Guidelines

### Basic Detection
To detect the current terminal software, use the `detect_terminal_software` function. This returns a hash reference containing the software name and version if identifiable.

```perl
use Term::Detect::Software qw(detect_terminal_software);

my $res = detect_terminal_software();
print "Terminal: " . $res->{name} . "\n";
print "Version:  " . ($res->{version} // 'unknown') . "\n";
```

### Checking Capabilities
The primary value of this tool is determining what the terminal can actually do. Use the detection results to toggle application features:

- **Color Support**: Check if the terminal supports `color8`, `color16`, `color256`, or `color16m` (TrueColor).
- **Unicode**: Verify if `unicode` support is present before printing UTF-8 symbols or emoji.
- **Mouse**: Check for `mouse_prot_xterm` or `mouse_prot_sgr` before enabling mouse-driven menus.

### Best Practices
- **Fallback Logic**: Always implement a "dumb terminal" fallback. If detection fails or returns a generic result, default to plain ASCII and no color.
- **Environment Variables**: Be aware that this tool inspects environment variables like `TERM`, `COLORTERM`, `ITERM_SESSION_ID`, and `VTE_VERSION`. Ensure these are not stripped if running inside nested shells or screen multiplexers.
- **Performance**: Detection involves multiple regex checks against environment strings. For long-running CLI apps, run the detection once at startup and store the result.

## Reference documentation
- [Term::Detect::Software Documentation](./references/metacpan_org_pod_Term__Detect__Software.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-term-detect-software_overview.md)