---
name: perl-xml-sax
description: This skill facilitates the use of the `XML::SAX` framework in Perl, which provides a standardized interface for event-based XML parsing.
homepage: http://metacpan.org/pod/XML::SAX
---

# perl-xml-sax

## Overview

This skill facilitates the use of the `XML::SAX` framework in Perl, which provides a standardized interface for event-based XML parsing. Unlike DOM parsers that load the entire document into memory, SAX triggers callbacks (events) as it reads the file, making it ideal for processing large XML datasets efficiently. Use this skill to configure the Perl SAX environment, select specific parser implementations (like `XML::LibXML` or `XML::SAX::PurePerl`), and develop custom event handlers.

## Parser Management

The `XML::SAX` module maintains a registry of installed SAX parsers in a `ParserDetails.ini` file.

### Inspecting and Modifying Parsers
Use these one-liners or script snippets to manage the parser registry:

```perl
use XML::SAX;

# List all registered parsers
my $parsers = XML::SAX->parsers();
foreach my $p (@$parsers) {
    print "Parser: $p->{Name}\n";
}

# Register a new parser driver
XML::SAX->add_parser(q(XML::SAX::MyDriver))->save_parsers();

# Remove a parser
XML::SAX->remove_parser(q(XML::SAX::OldDriver))->save_parsers();
```

## Using the Parser Factory

Always use `XML::SAX::ParserFactory` to instantiate parsers. This ensures code portability by allowing the system to provide the best available parser (e.g., a fast C-based parser like LibXML) while falling back to `PurePerl` if necessary.

### Basic Parsing Pattern
```perl
use XML::SAX::ParserFactory;
use MyHandler; # Your custom subclass of XML::SAX::Base or a specific handler

my $handler = MyHandler->new();
my $parser  = XML::SAX::ParserFactory->parser(Handler => $handler);

# Supported input methods
$parser->parse_uri("data.xml");
$parser->parse_file($file_handle);
$parser->parse_string("<xml>content</xml>");
```

### Requiring Features
You can request specific SAX features (like Namespace support or Validation) during factory initialization:

```perl
use XML::SAX qw(Namespaces Validation);

my $factory = XML::SAX::ParserFactory->new();
$factory->require_feature(Namespaces);
$factory->require_feature(Validation);

my $parser = $factory->parser();
```

## Writing Custom Handlers

When creating a handler to process XML events, always subclass `XML::SAX::Base`. This base class provides default "do-nothing" methods for all SAX events, allowing you to only implement the ones you need.

### Common Event Methods
- `start_document($data)`
- `end_document($data)`
- `start_element($data)`: `$data` contains `Name`, `Attributes`, `Prefix`, `LocalName`, and `NamespaceURI`.
- `end_element($data)`
- `characters($data)`: `$data` contains the string in the `Data` key.

## Installation

If the environment lacks the module, it can be installed via CPAN or Conda:

- **CPAN**: `cpan XML::SAX`
- **Conda (Bioconda)**: `conda install bioconda::perl-xml-sax`

## Reference documentation
- [XML::SAX - Simple API for XML](./references/metacpan_org_pod_XML__SAX.md)
- [perl-xml-sax Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-sax_overview.md)