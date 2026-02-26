---
name: perl-xml-simple
description: This tool converts XML files or strings into nested Perl data structures and transforms Perl hashes or arrays back into XML. Use when user asks to parse XML into Perl hashes, generate XML from Perl data, or configure XML processing options like ForceArray and KeyAttr.
homepage: http://metacpan.org/pod/XML-Simple
---


# perl-xml-simple

## Overview
The `XML::Simple` module provides a straightforward API for transforming XML into nested Perl data structures and vice versa. It is best suited for "data-centric" XML rather than "document-centric" XML (like XHTML). This skill focuses on the core methods `XMLin()` and `XMLout()` and the critical configuration options required to maintain data consistency.

## Core Usage Patterns

### Reading XML (XMLin)
The most common use case is loading an XML file or string into a Perl hash reference.

```perl
use XML::Simple;

# Create object (Object-oriented style is recommended)
my $xml = XML::Simple->new();

# Read from a file
my $data = $xml->XMLin('config.xml');

# Accessing data (assuming <config><user name="admin"/></config>)
print $data->{user}->{name};
```

### Writing XML (XMLout)
Convert a Perl hash or array reference back into an XML string.

```perl
my $hash = {
    server => {
        host => 'localhost',
        port => 8080
    }
};

my $xml_string = XMLout($hash, RootName => 'config');
```

## Expert Tips & Best Practices

### 1. Force Array Handling
By default, `XML::Simple` collapses single elements into scalars and multiple elements into arrays. This causes "variable type" bugs. Always use `ForceArray` for elements that might appear more than once.

```perl
# Bad: $data->{item} might be a hash OR an array of hashes
# Good: $data->{item} is ALWAYS an array
my $data = XMLin($file, ForceArray => ['item']);
```

### 2. Key Folding (KeyAttr)
`XML::Simple` often tries to turn attributes like `name` or `id` into hash keys. If you want a standard nested structure without "folding," disable `KeyAttr`.

```perl
# Prevents mapping <user id="1"> to $data->{user}->{1}
my $data = XMLin($file, KeyAttr => []);
```

### 3. Handling Attributes vs. Nested Elements
When generating XML, use `NoAttr => 1` if you prefer nested elements over attributes.

```perl
# Default: <item name="foo" />
# With NoAttr => 1: <item><name>foo</name></item>
my $xml = XMLout($data, NoAttr => 1);
```

### 4. Strict Mode
To prevent unexpected behavior with the default parser (which might vary by system), explicitly set the preferred underlying parser if `XML::Parser` or `XML::SAX` is required.

## Common Pitfalls
- **Mixed Content**: `XML::Simple` does not handle elements containing both text and other elements well.
- **Memory**: It loads the entire XML tree into memory. Do not use it for multi-gigabyte XML files.
- **Sorting**: `XMLout` does not guarantee attribute order unless specific sorting options are passed.

## Reference documentation
- [XML::Simple API Documentation](./references/metacpan_org_pod_XML-Simple.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-simple_overview.md)