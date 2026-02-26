---
name: perl-git-wrapper
description: This tool provides a Perl interface to execute Git commands programmatically by wrapping the git binary. Use when user asks to interact with Git repositories using Perl, execute Git commands as method calls, or capture Git output and errors in a structured Perl environment.
homepage: http://genehack.github.com/Git-Wrapper/
---


# perl-git-wrapper

## Overview
This skill provides guidance on using the `Git::Wrapper` Perl library to execute Git commands programmatically. It allows for a more "Perlish" way to interact with repositories by treating Git commands as method calls on a repository object, capturing output and errors in a structured manner without manual shell execution management.

## Usage Patterns

### Initialization
To work with a repository, create a new `Git::Wrapper` object pointing to the directory:
```perl
use Git::Wrapper;
my $git = Git::Wrapper->new('/path/to/repo');
```

### Executing Commands
Commands are called as methods on the object. Arguments are passed as a list.
- **Status**: `my @status = $git->status();`
- **Adding files**: `$git->add('file.txt', 'other.pl');`
- **Committing**: `$git->commit({ message => 'Initial commit' });`
- **Pushing**: `$git->push('origin', 'master');`

### Handling Output
The wrapper returns output as a list of strings (one per line).
```perl
my @log = $git->log('-n', 5);
foreach my $line (@log) {
    print "Log entry: $line\n";
}
```

### Error Handling
`Git::Wrapper` throws exceptions when a command fails. Use `eval` or `Try::Tiny` to catch them.
```perl
eval {
    $git->checkout('non-existent-branch');
};
if ($@) {
    # $@ is a Git::Wrapper::Exception object
    warn "Git command failed: " . $@->error;
}
```

## Best Practices
- **Argument Passing**: Use hashrefs for options (e.g., `{ message => '...' }`) and positional arguments for targets.
- **Environment**: Ensure the `git` binary is in the system PATH, as this module is a wrapper, not a standalone implementation.
- **Large Output**: For commands like `log` or `diff`, be mindful of memory usage when capturing output into arrays.

## Reference documentation
- [perl-git-wrapper Overview](./references/anaconda_org_channels_bioconda_packages_perl-git-wrapper_overview.md)