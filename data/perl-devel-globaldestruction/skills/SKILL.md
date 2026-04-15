---
name: perl-devel-globaldestruction
description: This tool provides a reliable way to detect if the Perl interpreter is in the global destruction phase. Use when user asks to detect global destruction in Perl, prevent segmentation faults in DESTROY methods, or safely manage object cleanup during interpreter shutdown.
homepage: https://metacpan.org/release/Devel-GlobalDestruction
metadata:
  docker_image: "quay.io/biocontainers/perl-devel-globaldestruction:0.14--pl526_0"
---

# perl-devel-globaldestruction

## Overview
This tool provides a reliable way to determine if the Perl interpreter is currently shutting down and destroying global objects. In Perl, global destruction is a volatile phase where the order of object destruction is unpredictable. Using this skill helps prevent "Attempt to free unreferenced scalar" errors and other segmentation faults that occur when DESTROY methods attempt to access other objects that may have already been freed by the interpreter.

## Usage Guidelines

### Detecting Global Destruction
The primary interface is the `in_global_destruction` function. It returns a boolean value.

```perl
use Devel::GlobalDestruction;

sub DESTROY {
    my $self = shift;

    if (in_global_destruction()) {
        # During global destruction, do not trust that other objects 
        # or singletons still exist. Perform only basic memory cleanup.
        return;
    }

    # Normal cleanup: safe to call methods on other objects
    $self->{logger}->info("Closing resource...");
    $self->{db_handle}->disconnect();
}
```

### Implementation Best Practices
- **Always use in DESTROY blocks**: Any class that manages external resources (file handles, database connections, sockets) should check this flag in its destructor.
- **Avoid complex logic**: If `in_global_destruction()` is true, avoid calling methods on any objects stored within your instance, as those objects may already be garbage collected.
- **Thread Safety**: The function is thread-safe and correctly identifies the destruction phase within the specific thread context.

### Installation via Conda
If working within a Bioconda environment, ensure the dependency is present:
```bash
conda install -c bioconda perl-devel-globaldestruction
```

## Reference documentation
- [Devel::GlobalDestruction Overview](./references/anaconda_org_channels_bioconda_packages_perl-devel-globaldestruction_overview.md)
- [MetaCPAN Release Documentation](./references/metacpan_org_release_Devel-GlobalDestruction.md)