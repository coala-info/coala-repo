---
name: perl-xml-dom
description: The perl-xml-dom tool extends XML::Parser to build and manipulate a complete Document Object Model in memory. Use when user asks to parse XML files into a tree structure, navigate document hierarchies, perform CRUD operations on XML nodes, or serialize DOM trees back to files.
homepage: http://metacpan.org/pod/XML-DOM
---


# perl-xml-dom

## Overview
The `XML::DOM` module extends `XML::Parser` to build a complete Document Object Model (DOM) in memory. This skill provides the procedural knowledge to instantiate the parser, navigate the resulting tree structure, and perform CRUD operations on XML nodes. It is essential for tasks where simple stream-based parsing (SAX) is insufficient and full access to the document hierarchy is required.

## Core Usage Patterns

### Basic Parsing and Node Access
To process an XML file, initialize the `XML::DOM::Parser` and use the `parsefile` method.
```perl
use XML::DOM;

my $parser = XML::DOM::Parser->new();
my $doc = $parser->parsefile("input.xml");

# Accessing the root element
my $root = $doc->getDocumentElement();

# Getting elements by tag name
my $nodes = $doc->getElementsByTagName("entry");
for (my $i = 0; $i < $nodes->getLength; $i++) {
    my $node = $nodes->item($i);
    # Process node
}
```

### Manipulating Elements and Attributes
`XML::DOM` allows for direct modification of the tree.
- **Get Attribute**: `$node->getAttribute("id")`
- **Set Attribute**: `$node->setAttribute("status", "active")`
- **Create Element**: `my $new_el = $doc->createElement("data")`
- **Append Child**: `$parent->appendChild($new_el)`

### Outputting XML
After modification, the DOM tree can be serialized back to a string or file.
```perl
# Print to STDOUT
print $doc->toString;

# Save to file
$doc->printToFile("output.xml");

# Cleanup (Important for memory management in Perl)
$doc->dispose;
```

## Expert Tips
- **Memory Management**: Always call `$doc->dispose` when finished with a document. `XML::DOM` objects have circular references that Perl's standard garbage collector cannot handle alone, leading to memory leaks in long-running scripts.
- **Node Types**: Use `$node->getNodeType` to distinguish between `ELEMENT_NODE` (1), `ATTRIBUTE_NODE` (2), and `TEXT_NODE` (3).
- **Handling Whitespace**: By default, `XML::Parser` (and thus `XML::DOM`) may preserve ignorable whitespace as text nodes. Use `$doc->normalize` to merge adjacent text nodes.

## Reference documentation
- [XML::DOM Documentation](./references/metacpan_org_pod_XML-DOM.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-dom_overview.md)