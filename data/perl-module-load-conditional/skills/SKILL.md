---
name: perl-module-load-conditional
description: This tool enables Perl scripts to query module availability, check versions, and conditionally load multiple dependencies at runtime. Use when user asks to check if a Perl module is installed, verify module version requirements, or perform all-or-nothing loading of multiple Perl modules.
homepage: http://metacpan.org/pod/Module::Load::Conditional
metadata:
  docker_image: "quay.io/biocontainers/perl-module-load-conditional:0.68--pl526_2"
---

# perl-module-load-conditional

## Overview

The `perl-module-load-conditional` skill provides procedural knowledge for using the `Module::Load::Conditional` Perl module. This tool allows a script to query the system's `@INC` to see if a module is installed, check its version, and determine its file path without necessarily loading it. It also supports "all-or-nothing" loading, where a list of modules is only loaded if every single one is available and meets version constraints. This is a critical capability for building portable Perl applications and managing complex runtime dependencies.

## Core Functions

### Verifying Module Installation
Use `check_install` to inspect a module's status without loading it into memory.

```perl
use Module::Load::Conditional qw[check_install];

my $info = check_install( 
    module  => 'LWP::UserAgent', 
    version => '6.00' 
);

if ($info) {
    print "Location: $info->{file}\n";
    print "Installed Version: $info->{version}\n";
    print "Meets requirement: " . ($info->{uptodate} ? 'Yes' : 'No') . "\n";
}
```

### Conditional Loading
Use `can_load` when your script has multiple ways to solve a problem depending on which modules are present. It ensures that either all specified modules are loaded or none are.

```perl
use Module::Load::Conditional qw[can_load];

my $modules = {
    'JSON::MaybeXS' => '1.003005',
    'LWP::Protocol::https' => undef, # Any version
};

if ( can_load( modules => $modules, verbose => 0 ) ) {
    # All modules loaded successfully
    my $json = JSON::MaybeXS->new;
} else {
    warn "Required modules for HTTPS/JSON support are missing.";
}
```

### Discovering Prerequisites
Use `requires` to programmatically determine the dependencies of a specific module.

```perl
use Module::Load::Conditional qw[requires];

my @deps = requires('CPANPLUS');
print "CPANPLUS depends on: " . join(', ', @deps) . "\n";
```

## Expert Tips and Best Practices

- **Performance Tuning**: By default, `can_load` caches results. If you are modifying `@INC` at runtime or installing modules mid-execution, reset the cache using: `undef $Module::Load::Conditional::CACHE;`.
- **Deep Inspection**: Set `$Module::Load::Conditional::CHECK_INC_HASH = 1;` to allow the tool to check `%INC` (modules already loaded) rather than just scanning the file system. This is faster and more accurate for long-running processes.
- **Silent Operation**: The module is verbose by default. In production scripts, suppress warnings by setting `$Module::Load::Conditional::VERBOSE = 0;` or passing `verbose => 0` in function calls.
- **Error Handling**: When `can_load` fails, check `$Module::Load::Conditional::ERROR` to retrieve the specific error message generated during the load attempt.
- **Version Safety**: If a module has an unparsable version number, `check_install` will report `uptodate` as true by default. Always validate critical version dependencies manually if the module's versioning scheme is non-standard.

## Reference documentation
- [Module::Load::Conditional - Looking up module information / loading at runtime](./references/metacpan_org_pod_Module__Load__Conditional.md)
- [perl-module-load-conditional - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-module-load-conditional_overview.md)