---
name: perl-findbin
description: This tool locates the directory of the currently running Perl script to establish relative library paths. Use when user asks to find the script's installation location, add a sibling lib directory to the include path, or resolve the real path of a symlinked script.
homepage: https://metacpan.org/pod/FindBin
---


# perl-findbin

## Overview
The `perl-findbin` skill provides the logic for anchoring a Perl script's environment to its own installation location. It is essential for creating portable Perl software trees where the binary and library directories maintain a fixed relationship (like `bin/` and `lib/`). By using this skill, you ensure that `use lib` statements work correctly even when the script is invoked from a different directory or via a symbolic link.

## Usage Patterns

### Basic Directory Discovery
To find the directory where the script resides and add a sibling `lib` directory to the Perl include path:
```perl
use FindBin;
use lib "$FindBin::Bin/../lib";
```

### Handling Symbolic Links
If the script is a symlink and you need the path to the actual file location (resolving all links):
```perl
use FindBin;
use lib "$FindBin::RealBin/../lib";
```

### Exporting Specific Variables
To keep the namespace clean, export only the variables you need:
```perl
use FindBin qw($Bin $Script);
# $Bin is the directory path
# $Script is the filename of the script
```

## Expert Tips & Best Practices

### Persistent Environments (mod_perl/Starman)
`FindBin` uses a `BEGIN` block, meaning it only calculates the path once per interpreter lifecycle. In persistent environments, this causes issues if multiple scripts are loaded. 
**Solution:** Force a recalculation if your code might run in a persistent daemon:
```perl
use FindBin;
FindBin->again; 
```

### Avoid in CPAN Modules
Do not use `FindBin` inside a module intended for CPAN distribution. Modules should rely on standard library installation paths. `FindBin` is strictly for "top-level" executable scripts.

### Variable Reference
- `$Bin`: Path to the directory containing the invoked script.
- `$Script`: The name of the script.
- `$RealBin`: The resolved physical path (useful if the script is symlinked into `/usr/local/bin`).

## Reference documentation
- [FindBin - Locate directory of original Perl script](./references/metacpan_org_pod_FindBin.md)