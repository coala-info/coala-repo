---
name: perl-cpan-meta-check
description: This tool verifies that a Perl environment satisfies the version requirements and dependencies specified in CPAN metadata. Use when user asks to verify module dependencies, check for version conflicts, or validate environment consistency against META.json or META.yml files.
homepage: http://metacpan.org/pod/CPAN::Meta::Check
metadata:
  docker_image: "quay.io/biocontainers/perl-cpan-meta-check:0.014--pl526_0"
---

# perl-cpan-meta-check

## Overview

The `perl-cpan-meta-check` skill provides a mechanism to validate that a Perl environment meets the specific version requirements and dependencies defined in CPAN metadata. It is primarily used by developers and system administrators to ensure that `runtime`, `build`, and `test` phases have the necessary modules available in `@INC`. This tool is essential for pre-flight checks before running test suites or deploying Perl applications to ensure environment consistency.

## Core Usage Patterns

### Verifying Dependencies in a Script
The most common use case is calling `verify_dependencies` to identify missing or outdated modules.

```perl
use CPAN::Meta;
use CPAN::Meta::Check qw(verify_dependencies);

# Load your metadata file (META.json or META.yml)
my $meta = CPAN::Meta->load_file('META.json');

# Check runtime, build, and test requirements
my @issues = verify_dependencies($meta, [qw/runtime build test/], 'requires');

if (@issues) {
    print "Missing or incompatible dependencies found:\n";
    print "$_\n" for @issues;
}
```

### Checking Specific Requirement Objects
If you have a `CPAN::Meta::Requirements` object (e.g., from a custom configuration), use `check_requirements`.

```perl
use CPAN::Meta::Check qw(check_requirements);

# $reqs is a CPAN::Meta::Requirements object
# $type is the relationship (e.g., 'requires', 'conflicts')
my $problems = check_requirements($reqs, 'requires');

for my $module (keys %$problems) {
    if (defined $problems->{$module}) {
        warn "Problem with $module: $problems->{$module}";
    }
}
```

### Custom Library Paths
If you are installing modules to a non-standard location (like a local::lib or a specific vendor directory), pass the `incdirs` parameter.

```perl
my @incdirs = ('/opt/custom/perl/lib', @INC);
my @issues = verify_dependencies($meta, ['runtime'], 'requires', \@incdirs);
```

## Expert Tips

- **Conflict Detection**: Unlike simple version checks, `check_requirements` handles 'conflicts' dependencies by checking them in reverse (ensuring the installed version is *not* within the prohibited range).
- **Deprecated Functions**: Avoid using `requirements_for`. It is deprecated in favor of `CPAN::Meta::Prereqs->merged_requirements`.
- **Integration with Test Suites**: Use this module within a `00-check-deps.t` file to fail tests early if the environment is misconfigured, providing clearer error messages than a simple "Module not found" error deep in the code.
- **Return Values**: Remember that `check_requirements` returns a hash reference where a value of `undef` indicates the module was found and satisfies the version requirement.

## Reference documentation
- [CPAN::Meta::Check Documentation](./references/metacpan_org_pod_CPAN__Meta__Check.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-cpan-meta-check_overview.md)