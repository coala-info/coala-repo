---
name: perl-pod-coverage-trustpod
description: The `perl-pod-coverage-trustpod` skill provides guidance on using `Pod::Coverage::TrustPod`, a Perl module that extends the standard `Pod::Coverage` functionality.
homepage: https://github.com/rjbs/Pod-Coverage-TrustPod
---

# perl-pod-coverage-trustpod

## Overview
The `perl-pod-coverage-trustpod` skill provides guidance on using `Pod::Coverage::TrustPod`, a Perl module that extends the standard `Pod::Coverage` functionality. While standard coverage tools often require external lists of private or exempt methods, this tool allows you to embed "trust" hints directly in the source code's documentation. This ensures that documentation exceptions stay synchronized with the code they describe.

## Usage and Best Practices

### In-Pod Syntax
To exempt specific subroutines from coverage requirements, use the `=for` or `=begin/=end` POD commands.

**Single Subroutine:**
```perl
=for Pod::Coverage sub_name
```

**Multiple Subroutines:**
```perl
=for Pod::Coverage sub_one sub_two sub_three
```

**Block Format:**
```perl
=begin Pod::Coverage

sub_name_a
sub_name_b

=end Pod::Coverage
```

### Integration with Test::Pod::Coverage
To utilize this module during automated testing, you must instruct `Test::Pod::Coverage` to use `Pod::Coverage::TrustPod` as the coverage class.

**Standard Test Pattern (`t/pod-coverage.t`):**
```perl
use Test::More;
eval "use Test::Pod::Coverage 1.08";
plan skip_all => "Test::Pod::Coverage 1.08 required" if $@;

eval "use Pod::Coverage::TrustPod";
plan skip_all => "Pod::Coverage::TrustPod required" if $@;

all_pod_coverage_ok({ coverage_class => 'Pod::Coverage::TrustPod' });
```

### Expert Tips
- **Regex Support**: The module supports anchoring regex patterns for method names. If a regex fails to compile, the tool will report it as an error during the coverage check.
- **Parent Class Trusting**: This module is designed to respect "trust" hints in parent classes when checking child modules, provided the parent also uses the TrustPod mechanism.
- **Indentation**: While older versions were strict, current versions allow both indented and non-indented `=for` paragraphs, though non-indented is the standard POD convention.
- **Colon Prefix**: You may occasionally see `=for :Pod::Coverage`. This is a convention used by some toolchains (like Dist::Zilla) to distinguish between different types of metadata, and it is supported by this module.

## Reference documentation
- [Pod::Coverage with in-pod exceptions](./references/github_com_rjbs_Pod-Coverage-TrustPod.md)
- [perl-pod-coverage-trustpod - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-pod-coverage-trustpod_overview.md)