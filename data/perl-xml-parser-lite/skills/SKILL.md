---
name: perl-xml-parser-lite
description: This module provides a lightweight, pure-Perl XML parser for event-based processing without external C library dependencies. Use when user asks to parse XML data using Perl, handle XML events with callbacks, or process XML in environments where libexpat is not available.
homepage: http://metacpan.org/pod/XML-Parser-Lite
---


# perl-xml-parser-lite

## Overview
The `XML::Parser::Lite` module provides a non-validating, lightweight XML parser implemented entirely in Perl. Unlike the standard `XML::Parser`, it does not require the `libexpat` C library, making it highly portable and easy to install in restricted environments. It functions as a drop-in replacement for basic event-based parsing, triggering callbacks as it encounters elements, text, and processing instructions.

## Usage Patterns

### Basic Event-Based Parsing
To use the parser, define a subclass or a set of handlers to process XML events. The parser is typically invoked through the `parse` method.

```perl
use XML::Parser::Lite;

# Initialize the parser with handler callbacks
my $parser = XML::Parser::Lite->new(
    Handlers => {
        Start => sub { shift; my ($tag, %attr) = @_; print "Start: $tag\n"; },
        End   => sub { shift; my $tag = @_; print "End: $tag\n"; },
        Char  => sub { shift; my $text = @_; print "Data: $text\n"; },
    }
);

$parser->parse($xml_string);
```

### Implementation via Subclassing
For more complex logic, create a package that inherits from `XML::Parser::Lite` and override the event methods:

- `Start($tag, %attributes)`: Called when an opening tag is found.
- `End($tag)`: Called when a closing tag is found.
- `Char($text)`: Called for text content between tags.
- `Comment($data)`: Called when a comment is encountered.
- `PI($target, $data)`: Called for processing instructions.

### Best Practices
- **Well-Formedness**: Ensure input XML is well-formed. As a "Lite" parser based on regular expressions, it may not handle deeply nested or highly complex entities as robustly as a full Expat-based parser.
- **Memory Efficiency**: Use the stream-based nature of the parser to process large files without loading the entire DOM into memory.
- **Encoding**: The parser primarily handles UTF-8. If dealing with legacy encodings, pre-process the string into Perl's internal UTF-8 representation.
- **Avoid Complex DTDs**: This tool is designed for data-centric XML. If your workflow requires DTD validation or complex entity expansion, consider a full-featured parser.

## Reference documentation
- [XML::Parser::Lite Documentation](./references/metacpan_org_pod_XML-Parser-Lite.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-parser-lite_overview.md)