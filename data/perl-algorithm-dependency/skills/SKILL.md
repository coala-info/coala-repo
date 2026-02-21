---
name: perl-algorithm-dependency
description: This skill provides guidance on using the `Algorithm::Dependency` Perl module to manage hierarchical relationships.
homepage: http://metacpan.org/pod/Algorithm::Dependency
---

# perl-algorithm-dependency

## Overview
This skill provides guidance on using the `Algorithm::Dependency` Perl module to manage hierarchical relationships. It is particularly useful for software packaging, task scheduling, and build systems where certain items must be completed before others can begin. The module allows for the creation of dependency objects, the validation of source data, and the generation of linear execution orders that respect all constraints.

## Core Usage Patterns

### Data Source Preparation
The module requires a "Source" object to provide the dependency data. The most common implementation is `Algorithm::Dependency::Source::HoT` (Hash of Trees).

```perl
use Algorithm::Dependency;
use Algorithm::Dependency::Source::HoT;

# Define your dependency graph
# Format: 'ItemName' => [ 'Dependency1', 'Dependency2' ]
my $data = {
    'step_c' => [ 'step_b' ],
    'step_b' => [ 'step_a' ],
    'step_a' => [],
};

my $source = Algorithm::Dependency::Source::HoT->new($data);
```

### Initializing the Engine
Create the dependency engine by passing the source. You can specify whether the engine should be "selected" (starting with a pre-existing state) or "ordered".

```perl
my $dep = Algorithm::Dependency->new(
    source   => $source,
    selected => [], # Optional: items already completed
);
```

### Retrieving Dependencies
To find out what needs to be done to satisfy a specific requirement:

```perl
# Get a linear list of all dependencies for 'step_c'
my $schedule = $dep->schedule('step_c');

# $schedule will be an array reference: [ 'step_a', 'step_b', 'step_c' ]
if ($schedule) {
    print "Execution order: " . join(", ", @$schedule) . "\n";
}
```

## Expert Tips

### Handling Circular Dependencies
`Algorithm::Dependency` will return `undef` if it encounters a circular dependency (e.g., A depends on B, and B depends on A). Always check if the result of `schedule()` or `depends()` is defined before iterating.

### Identifying Missing Items
If a dependency is referenced but not defined in the source, the module will treat it as a failure. Use the `Source` object's internal validation methods if you suspect the input data is incomplete.

### State Management
If you are using this in a long-running process where items are completed over time, update the `selected` list to prune the tree:
- Use `depends($item)` to see only the immediate requirements.
- Use `schedule($item)` to get the full path to completion.

## Reference documentation
- [Algorithm::Dependency Documentation](./references/metacpan_org_pod_Algorithm__Dependency.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-algorithm-dependency_overview.md)