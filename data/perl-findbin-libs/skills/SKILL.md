---
name: perl-findbin-libs
description: This tool automatically locates and adds Perl library directories to the include path based on the script's location. Use when user asks to manage Perl library paths, find local module directories, or avoid hardcoding library locations in scripts.
homepage: http://metacpan.org/pod/FindBin::libs
---


# perl-findbin-libs

## Overview
The `FindBin::libs` module simplifies Perl library management by searching for and adding directories to `@INC` based on the location of the executing script. Instead of hardcoding absolute paths or using complex `use lib "$Bin/../lib"`, this tool heuristically finds library directories (typically named `lib`) in the script's directory or its parent directories. This ensures that Perl scripts can always find their required modules regardless of where the project is installed.

## Usage Patterns

### Basic Library Discovery
To automatically find and include the nearest `lib` directory relative to the script:
```perl
use FindBin::libs;
```

### Searching for Specific Directory Names
If your libraries are stored in directories other than `lib` (e.g., `inc` or `modules`), specify them as arguments:
```perl
use FindBin::libs qw(inc modules);
```

### Controlling Search Depth
By default, the module searches upwards. You can control how it behaves using specific flags:
- **base**: Search for a directory relative to the script's location.
- **subdir**: Look for a specific subdirectory within the found library paths.

Example of looking for a specific "plugins" directory within the discovered library structure:
```perl
use FindBin::libs subdir => 'plugins';
```

### Exporting Paths
If you need the discovered paths for purposes other than updating `@INC` (e.g., for system calls or configuration), you can capture them:
```perl
use FindBin::libs;
my @found_libs = FindBin::libs->make_items;
```

## Best Practices
- **Standardization**: Use this module in the main entry-point scripts of a Perl project to avoid "Module not found" errors when the project is cloned into different directory structures.
- **Bioinformatics Pipelines**: When using tools installed via Bioconda, `FindBin::libs` is often used to ensure that helper modules bundled with a primary script are correctly loaded without requiring the user to set `PERL5LIB` manually.
- **Avoid Hardcoding**: Prefer `FindBin::libs` over `use lib "$FindBin::Bin/../lib"` to make the code more resilient to changes in the directory hierarchy (e.g., moving a script from `bin/` to `bin/subdir/`).

## Reference documentation
- [FindBin::libs Documentation](./references/metacpan_org_pod_FindBin__libs.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-findbin-libs_overview.md)