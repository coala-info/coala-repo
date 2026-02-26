---
name: perl-xml-sax-base
description: This tool provides a base class for creating XML SAX drivers and filters in Perl. Use when user asks to build SAX-based XML parsers, implement XML event filters, or manage SAX2 method delegations and state transitions.
homepage: http://metacpan.org/pod/XML-SAX-Base
---


# perl-xml-sax-base

## Overview
This skill provides guidance on utilizing `XML::SAX::Base` to build robust XML processing components in Perl. It focuses on the implementation of SAX drivers (which generate events) and filters (which sit between a reader and a handler). By inheriting from this base class, developers ensure their components correctly manage the complex state transitions and method delegations required by the SAX2 specification without manual boilerplate.

## Implementation Patterns

### Creating a SAX Filter
To create a filter that modifies XML events on the fly, inherit from `XML::SAX::Base`. The base class automatically handles the delegation of events to the next handler in the chain (`$self->{Handler}`).

```perl
package MyFilter;
use base qw(XML::SAX::Base);

sub start_element {
    my ($self, $element) = @_;
    # Modify the element name or attributes here
    $element->{Name} = lc($element->{Name});
    # Forward the modified event to the next handler
    return $self->SUPER::start_element($element);
}
1;
```

### Creating a SAX Driver (Parser)
When writing a parser, use the base class to manage the `Handler` and `DocumentHandler` properties.

```perl
package MyParser;
use base qw(XML::SAX::Base);

sub parse {
    my ($self, $source) = @_;
    $self->start_document({});
    # ... logic to iterate through source ...
    $self->start_element({ Name => 'root' });
    $self->characters({ Data => 'content' });
    $self->end_element({ Name => 'root' });
    $self->end_document({});
}
1;
```

## Best Practices
- **Method Delegation**: Always use `$self->SUPER::method_name($data)` in filters unless you explicitly intend to drop an event. This ensures the event chain remains unbroken.
- **Attribute Handling**: SAX2 attributes are passed as a hash mapping `{NamespaceURI}LocalName` to an attribute definition hash. Always check for both `Name` and `LocalName` depending on your namespace requirements.
- **Error Handling**: Use `$self->fatal_error("message")` to trigger the `error_handler` defined in the SAX chain.
- **Constructor Usage**: Avoid overriding `new()` unless necessary. `XML::SAX::Base` provides a constructor that correctly initializes the `Handler`, `ErrorHandler`, and `EntityResolver`.

## Common Pitfalls
- **Missing SUPER calls**: Forgetting to call the parent method in a filter will "swallow" the XML tags, resulting in empty output for downstream handlers.
- **Circular References**: Be cautious when building complex filter chains; ensure handlers are properly weakened or destroyed to prevent memory leaks in long-running Perl processes.

## Reference documentation
- [XML::SAX::Base Documentation](./references/metacpan_org_pod_XML-SAX-Base.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-sax-base_overview.md)