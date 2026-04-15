---
name: perl-class-singleton
description: This tool facilitates the implementation of the Singleton design pattern in Perl to ensure a class has only one globally accessible instance. Use when user asks to implement the Singleton pattern, create a single-instance Perl module, or manage global state through Class::Singleton.
homepage: http://metacpan.org/pod/Class::Singleton
metadata:
  docker_image: "quay.io/biocontainers/perl-class-singleton:1.6--pl5321hdfd78af_0"
---

# perl-class-singleton

## Overview

The `perl-class-singleton` skill facilitates the implementation of the Singleton pattern in Perl environments. By using `Class::Singleton` as a base class, developers can ensure that a specific module maintains a single, globally accessible instance. This is particularly useful for managing stateful objects where multiple instances would cause conflicts or unnecessary resource consumption. This skill covers basic instantiation, class derivation, and custom object initialization.

## Implementation Patterns

### Basic Instantiation
To use the singleton logic directly or within a script:

```perl
use Class::Singleton;

# Returns a new instance if none exists, otherwise returns the existing one
my $instance = Class::Singleton->instance();
```

### Creating a Singleton Class
To make your own module a singleton, inherit from `Class::Singleton`.

```perl
package My::Config;
use base 'Class::Singleton';

sub get_value {
    my ($self, $key) = @_;
    return $self->{$key};
}

1;
```

Usage in application code:
```perl
use My::Config;
my $conf = My::Config->instance();
```

### Custom Initialization
Override the `_new_instance` method to perform specific setup (e.g., connecting to a database or parsing a file) during the first call to `instance()`.

```perl
package My::Database;
use base 'Class::Singleton';
use DBI;

sub _new_instance {
    my $class = shift;
    my $args  = shift; # instance() passes arguments here
    
    my $self = bless { }, $class;
    $self->{db} = DBI->connect($args->{dsn}, $args->{user}, $args->{pass});
    
    return $self;
}
```

## Expert Tips and Best Practices

### Parameter Handling
The `instance()` method forwards all arguments to `_new_instance()` only the first time it is called. Subsequent calls to `instance()` with different parameters will return the original instance and silently ignore the new arguments. 

**Best Practice:** Always check if an instance exists before attempting to initialize with parameters if the state might already be set.

### Checking Instance Existence
Use `has_instance()` to check if a singleton has already been initialized without accidentally triggering the constructor.

```perl
if (My::Module->has_instance()) {
    # Logic for when the object already exists
}
```

### Global State Management
While Singletons provide a clean wrapper around global variables, they still represent global state. Ensure that the singleton is truly unique to the system requirements. `Class::Singleton` keys instances by the package name, allowing different derived classes to maintain their own unique singletons simultaneously.

## Installation

If the module is missing from the environment, it can be installed via Bioconda or CPAN:

```bash
# Bioconda
conda install bioconda::perl-class-singleton

# CPAN
cpanm Class::Singleton
```

## Reference documentation
- [Class::Singleton - Implementation of a "Singleton" class](./references/metacpan_org_pod_Class__Singleton.md)
- [perl-class-singleton - bioconda](./references/anaconda_org_channels_bioconda_packages_perl-class-singleton_overview.md)