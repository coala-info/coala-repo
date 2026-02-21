---
name: perl-clone-choose
description: The `perl-clone-choose` utility acts as a wrapper and selection logic for Perl's data cloning capabilities.
homepage: https://metacpan.org/release/Clone-Choose
---

# perl-clone-choose

## Overview
The `perl-clone-choose` utility acts as a wrapper and selection logic for Perl's data cloning capabilities. It is designed to solve the problem of dependency management in Perl scripts that need to perform deep copies of complex nested data structures. Instead of hard-coding a specific cloning module, this tool detects the environment and picks the fastest available backend, falling back to pure-Perl implementations if compiled XS modules are missing.

## Usage and Best Practices

### Backend Selection Logic
The module follows a specific priority order when choosing a cloning engine:
1. **Clone**: The fastest XS-based implementation.
2. **Clone::PP**: A pure-Perl implementation used when C compilers or XS modules are unavailable.
3. **Storable**: A core Perl module used as a reliable fallback.

### Environment Configuration
You can force the tool to use a specific backend by setting the `CLONE_CHOOSE_PREFERRED_BACKEND` environment variable. This is useful for debugging or ensuring consistent behavior across heterogeneous clusters.

```bash
# Force the use of the pure-Perl implementation
export CLONE_CHOOSE_PREFERRED_BACKEND=Clone::PP

# Force the use of the high-performance XS implementation
export CLONE_CHOOSE_PREFERRED_BACKEND=Clone
```

### Integration in Perl Scripts
When writing Perl code that utilizes this skill's logic, use the following pattern to maintain portability:

```perl
use Clone::Choose;

# Create a deep copy of a complex hash or array
my $copy = clone($original_data_structure);
```

### Installation via Bioconda
In bioinformatics pipelines or managed environments, install the package using conda to ensure all potential backends are satisfied:

```bash
conda install -c bioconda perl-clone-choose
```

## Reference documentation
- [Clone::Choose - Choose appropriate clone utility](./references/metacpan_org_release_Clone-Choose.md)
- [Bioconda perl-clone-choose Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-clone-choose_overview.md)