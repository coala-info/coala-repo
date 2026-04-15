---
name: perl-class-trigger
description: Class::Trigger is a Perl mixin that allows developers to define and execute inheritable callback hooks within class methods. Use when user asks to add trigger points to a class, register callbacks for specific events, or create extensible Perl frameworks with abortable hooks.
homepage: https://github.com/miyagawa/Class-Trigger
metadata:
  docker_image: "quay.io/biocontainers/perl-class-trigger:0.15--pl5321hdfd78af_1"
---

# perl-class-trigger

## Overview
Class::Trigger is a lightweight mixin for Perl that enables "hooks" or "triggers" within a class. It allows developers to define specific points in a method where external code (callbacks) can be executed. These triggers are inheritable by subclasses and can be applied globally to a class or specifically to an individual object instance. This module is particularly useful for creating extensible frameworks where users need to "plug in" logic before, during, or after standard operations.

## Installation
To install the package via Bioconda:
```bash
conda install bioconda::perl-class-trigger
```

## Core Usage Patterns

### 1. Defining Trigger Points in a Class
To make a class trigger-capable, include the module and call `call_trigger` at the desired execution points.

```perl
package MyModule;
use Class::Trigger;

sub process_data {
    my ($self, $data) = @_;
    
    # Define a trigger point
    $self->call_trigger('before_process', $data);
    
    # ... core logic ...
    
    $self->call_trigger('after_process');
}
```

### 2. Registering Triggers
Triggers can be added at the class level (affecting all instances) or the object level (affecting only one instance).

```perl
# Class-level trigger
MyModule->add_trigger(before_process => sub {
    my ($self, $data) = @_;
    print "Processing started for: $data\n";
});

# Object-level trigger (requires object to be a hash-based ref)
my $obj = MyModule->new();
$obj->add_trigger(after_process => \&cleanup_routine);
```

### 3. Abortable Triggers
You can stop the execution of subsequent triggers at a specific point by using the `abortable` flag. If a trigger returns a false value, `call_trigger` stops and returns `undef`.

```perl
MyModule->add_trigger(
    name      => 'before_process',
    callback  => sub { 
        my ($self, $data) = @_;
        return $data =~ /valid/ ? 1 : 0; 
    },
    abortable => 1,
);
```

### 4. Accessing Trigger Results
To retrieve the return values of all callbacks executed during the last trigger event:

```perl
my @results = @{ $obj->last_trigger_results };
```

## Expert Tips and Best Practices

*   **Explicit Declaration**: To prevent typos in trigger names, declare valid trigger points during module import. This will cause the code to throw an exception if an undefined trigger name is used in `add_trigger`.
    ```perl
    use Class::Trigger qw(before_process after_process);
    ```
*   **Inheritance**: Triggers are inheritable. If a parent class defines a trigger point, subclasses can add their own triggers to that same point without interfering with the parent's triggers.
*   **Execution Order**: Triggers are invoked in the order they were defined.
*   **Context Awareness**: Every trigger callback receives the calling object as the first argument, followed by any arguments passed to `call_trigger`. Always design callbacks to expect the object reference.
*   **Validation Logic**: Use `abortable` triggers for pre-operation validation. This allows you to cancel an action (like a database write) if a plugin/trigger determines the data is invalid.

## Reference documentation
- [Class::Trigger GitHub README](./references/github_com_miyagawa_Class-Trigger.md)
- [Bioconda perl-class-trigger Overview](./references/anaconda_org_channels_bioconda_packages_perl-class-trigger_overview.md)