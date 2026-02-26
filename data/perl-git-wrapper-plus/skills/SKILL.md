---
name: perl-git-wrapper-plus
description: This Perl toolkit provides an object-oriented API that extends Git::Wrapper to handle version-specific quirks and repository metadata. Use when user asks to manage Git branches, tags, and references or check for feature support across different Git versions.
homepage: https://github.com/kentnl/Git-Wrapper-Plus
---


# perl-git-wrapper-plus

## Overview

`Git::Wrapper::Plus` is a comprehensive Perl toolkit that extends the functionality of `Git::Wrapper` by providing a consistent object-oriented API. Its primary value lies in its ability to abstract away the "quirks" found in different versions of Git, ensuring that scripts remain functional even on legacy systems where standard commands might behave differently. It organizes Git operations into logical modules for references, branches, tags, and version-specific feature support.

## Installation

Install the package via Bioconda for environment-managed Perl setups:

```bash
conda install bioconda::perl-git-wrapper-plus
```

## Core Usage Patterns

### Initializing the Wrapper
The library supports multiple constructor forms to accommodate different coding styles and existing `Git::Wrapper` instances.

```perl
use Git::Wrapper::Plus;

# Form 1: Path string (Shorthand)
my $plus = Git::Wrapper::Plus->new('/path/to/repo');

# Form 2: Existing Git::Wrapper object
my $git_wrapper = Git::Wrapper->new('.');
my $plus = Git::Wrapper::Plus->new($git_wrapper);

# Form 3: Hash or HashRef
my $plus = Git::Wrapper::Plus->new( git => $git_wrapper );
```

### Managing Repository Metadata
Instead of parsing raw Git output, use the specialized sub-objects provided by the main instance:

*   **Branches**: Access via `$plus->branches` to list or manipulate repository branches.
*   **Tags**: Access via `$plus->tags` for tag management.
*   **Refs**: Access via `$plus->refs` for low-level reference operations.

### Version Compatibility and Feature Support
One of the most powerful features of this toolkit is the ability to check if the current Git environment supports specific arguments or behaviors.

```perl
my $support = $plus->support;

# Check if the installed Git version supports a specific command
if ($support->supports_command('cherry-pick')) {
    # Execute logic
}

# Check for specific argument support
if ($support->supports_argument('branch', '--merged')) {
    # Use advanced filtering
}
```

## Expert Tips

*   **Legacy Support**: If your script must run on Git versions as old as 1.3, use this library to avoid common pitfalls. For example, in Git 1.3, `git add` only handles new files; updates to existing files require `git update-index`. `Git::Wrapper::Plus` helps manage these procedural differences.
*   **Version Comparisons**: Use `Git::Wrapper::Plus::Versions` for logic that depends on specific Git version ranges without writing complex regex parsers for `git --version` output.
*   **Object Reuse**: The `$plus` object caches its sub-modules (refs, tags, branches). Reuse the main instance rather than re-instantiating sub-modules to maintain efficiency.

## Reference documentation
- [Git::Wrapper::Plus GitHub Overview](./references/github_com_kentnl_Git-Wrapper-Plus.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_perl-git-wrapper-plus_overview.md)