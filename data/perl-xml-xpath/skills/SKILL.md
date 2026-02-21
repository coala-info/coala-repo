---
name: perl-xml-xpath
description: The `perl-xml-xpath` tool provides a way to interact with XML documents using the XPath (XML Path Language) specification.
homepage: https://metacpan.org/pod/XML::XPath
---

# perl-xml-xpath

## Overview
The `perl-xml-xpath` tool provides a way to interact with XML documents using the XPath (XML Path Language) specification. It allows for precise navigation of XML structures to locate specific nodes, attributes, or values. This skill is particularly useful for automated data extraction tasks where you need to pull information from complex XML files without manual parsing or when working in environments where Perl-based XML processing is the standard.

## Command Line Usage
The package typically installs a command-line utility named `xpath`.

### Basic Extraction
To extract specific elements from an XML file:
```bash
xpath -e "/root/parent/child" input.xml
```

### Extracting Attributes
To retrieve the value of a specific attribute:
```bash
xpath -e "//element/@attribute_name" input.xml
```

### Quiet Mode
Use the `-q` flag to suppress the output of the XML declaration and node count, which is useful for piping results to other tools:
```bash
xpath -q -e "//target_node/text()" input.xml
```

## Perl API Best Practices
When using the module programmatically within a Perl script, follow these patterns for efficiency.

### Object Initialization
Initialize the XPath object once per file to save resources:
```perl
use XML::XPath;
my $xp = XML::XPath->new(filename => 'data.xml');
```

### Selecting Nodes vs. Values
- Use `findnodes($path)` when you need to manipulate or inspect the node objects (e.g., for further relative queries).
- Use `findvalue($path)` when you only need the string content of the result.
- Use `exists($path)` for boolean checks to see if a node exists.

### Handling Namespaces
If the XML uses namespaces, you must register them before querying:
```perl
$xp->set_namespace("ns", "http://example.com/schema");
my $nodeset = $xp->findnodes("//ns:element");
```

### Relative Queries
You can perform queries relative to a specific node by passing the node as the second argument:
```perl
my $parent_node = $xp->findnodes("/root/parent")->[0];
my $child_value = $xp->findvalue("child_element", $parent_node);
```

## Expert Tips
- **Node Sets**: The `find()` method returns an `XML::XPath::NodeSet` object. Use `$nodeset->get_nodelist()` to get an array of nodes for iteration.
- **Stringification**: To get the raw XML of a node, use `XML::XPath::XMLParser::as_string($node)`.
- **Function Support**: The tool supports standard XPath functions like `count()`, `sum()`, `local-name()`, and string functions like `contains()` or `starts-with()`.
- **Performance**: For very large XML files, ensure you are not repeatedly calling `new()` in a loop; parse the document once and run multiple `find` calls against the same object.

## Reference documentation
- [XML::XPath](./references/metacpan_org_pod_XML__XPath.md)
- [XML::XPath::Function](./references/metacpan_org_pod_XML__XPath__Function.md)
- [XML::XPath::Node](./references/metacpan_org_pod_XML__XPath__Node.md)
- [XML::XPath::NodeSet](./references/metacpan_org_pod_XML__XPath__NodeSet.md)