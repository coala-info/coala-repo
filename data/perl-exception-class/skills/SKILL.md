---
name: perl-exception-class
description: `Exception::Class` allows Perl developers to move beyond simple string-based `die` calls by declaring a hierarchy of exception objects.
homepage: http://metacpan.org/release/Exception-Class
---

# perl-exception-class

## Overview
`Exception::Class` allows Perl developers to move beyond simple string-based `die` calls by declaring a hierarchy of exception objects. This skill facilitates the creation of robust error-handling systems where exceptions are first-class objects containing error messages, time stamps, and full stack traces. It is particularly useful for large-scale Perl projects where different categories of errors (e.g., I/O, Validation, Auth) need to be caught and handled differently.

## Implementation Patterns

### Declaring Exception Hierarchies
Use the `import` syntax to define your exception tree at compile time. This centralizes error definitions.

```perl
use Exception::Class (
    'MyProject::Exception' => {
        description => 'Generic project exception'
    },
    'MyProject::Exception::IO' => {
        isa         => 'MyProject::Exception',
        description => 'Input/Output error',
        fields      => [ 'filename', 'mode' ]
    },
    'MyProject::Exception::Validation' => {
        isa         => 'MyProject::Exception',
        description => 'Data validation failed'
    }
);
```

### Throwing Exceptions
Instead of `die "message"`, use the `throw` method. You can pass additional fields defined during declaration.

```perl
MyProject::Exception::IO->throw(
    message  => 'Could not open configuration file',
    filename => 'config.json',
    mode     => 'read'
);
```

### Catching and Inspecting
Use `eval` or a try/catch block (like `Try::Tiny`) and check the exception type using `isa`.

```perl
eval { ... };
if ( my $e = Exception::Class->caught('MyProject::Exception::IO') ) {
    warn "Error in file: " . $e->filename;
    warn "Stack trace: " . $e->trace->as_string;
}
elsif ( my $e = Exception::Class->caught('MyProject::Exception') ) {
    warn "Generic error: " . $e->error;
}
else {
    my $e = $@; # Handle non-object exceptions
}
```

## Expert Tips
- **Automatic Trace**: By default, `Exception::Class` objects capture a full stack trace. If performance is a concern in high-frequency loops, you can disable traces for specific classes by setting `respect_overload => 1` or adjusting the `trace_as_html` settings.
- **Field Accessors**: When you define `fields => ['foo']`, the exception object automatically gains a `foo()` accessor method.
- **Alias Creation**: Use the `alias` attribute in the declaration to create a shortcut function for throwing that specific exception class, reducing boilerplate code.
- **Stringification**: Exception objects are overloaded to stringify to their message and stack trace, making them compatible with legacy logging that expects strings.

## Reference documentation
- [Exception::Class Documentation](./references/metacpan_org_release_Exception-Class.md)