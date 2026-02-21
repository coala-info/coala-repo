---
name: perl-xml-libxml
description: The `XML::LibXML` module provides a Perl-level interface to the C-based `libxml2` library.
homepage: https://bitbucket.org/shlomif/perl-xml-libxml
---

# perl-xml-libxml

## Overview
The `XML::LibXML` module provides a Perl-level interface to the C-based `libxml2` library. It is the industry standard for Perl XML processing due to its speed, memory efficiency, and comprehensive support for XML standards including DOM, XPath 1.0, and RelaxNG/Schema validation. This skill focuses on the core object-oriented patterns required to parse and manipulate XML data structures effectively.

## Core Usage Patterns

### Initializing the Parser
Always create a parser instance to configure behavior (e.g., handling whitespace or recovering from errors).
```perl
use XML::LibXML;

my $parser = XML::LibXML->new();
$parser->keep_blanks(0); # Remove ignorable whitespace
$parser->recover(1);     # Attempt to parse non-well-formed HTML/XML
```

### Parsing Sources
Load XML from strings, files, or filehandles into a DOM document object.
```perl
# From a file
my $dom = $parser->parse_file("data.xml");

# From a string
my $dom = $parser->parse_string($xml_string);

# For HTML specifically
my $html_dom = $parser->parse_html_file("index.html");
```

### Navigating with XPath
XPath is the most efficient way to locate nodes. Use `findnodes` to get a list of matching elements.
```perl
# Find all 'item' elements under 'root'
foreach my $node ($dom->findnodes('/root/item')) {
    print $node->getAttribute('id'), "\n";
    print $node->textContent, "\n";
}

# Find a single value directly
my $title = $dom->findvalue('//title[1]');
```

### DOM Manipulation
Create and append nodes to modify the document structure.
```perl
my $new_node = $dom->createElement('status');
$new_node->appendText('processed');

my ($root) = $dom->findnodes('/root');
$root->appendChild($new_node);

# Output the modified XML
print $dom->toString(1); # 1 enables pretty-printing
```

## Expert Tips
- **Memory Management**: For extremely large files where a full DOM tree exceeds memory, switch to the `XML::LibXML::Reader` (pull-parser) or SAX interfaces provided by the package.
- **Namespaces**: When working with namespaced XML, always use an `XML::LibXML::XPathContext` object to register prefix-to-URI mappings, otherwise XPath lookups on namespaced elements will fail.
- **Validation**: Use `$dom->validate()` with a DTD or `$rng->validate($dom)` for RelaxNG to ensure document integrity before processing.

## Reference documentation
- [perl-xml-libxml Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-libxml_overview.md)