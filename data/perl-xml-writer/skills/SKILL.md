---
name: perl-xml-writer
description: The `perl-xml-writer` skill provides a reliable interface for producing XML output from Perl scripts.
homepage: http://metacpan.org/pod/XML-Writer
---

# perl-xml-writer

## Overview
The `perl-xml-writer` skill provides a reliable interface for producing XML output from Perl scripts. Unlike manual string manipulation, this module automatically handles attribute escaping, tag nesting, and namespace declarations. It is particularly useful for bioinformatics pipelines, data transformation tasks, and generating configuration files where XML integrity is critical.

## Core Usage Patterns

### Basic Document Generation
Initialize the writer and use method calls to define the structure. Always ensure `end()` is called to close any remaining open tags.

```perl
use XML::Writer;
use IO::File;

my $output = IO::File->new(">output.xml");
my $writer = XML::Writer->new(OUTPUT => $output, NEWLINES => 1, DATA_INDENT => 2);

$writer->xmlDecl("UTF-8");
$writer->startTag("root", "version" => "1.0");
$writer->dataElement("item", "Content here", "id" => "001");
$writer->endTag("root");
$writer->end();
$output->close();
```

### Namespace Management
To handle namespaces correctly, use the `NAMESPACES` parameter. This prevents prefix collisions and automates URI mapping.

```perl
my $writer = XML::Writer->new(NAMESPACES => 1, PREFIX_MAP => {'http://example.org/ns' => 'ex'});

$writer->startTag(['http://example.org/ns', 'element']); # Renders as <ex:element>
```

### Best Practices
- **Automatic Escaping**: Do not manually escape characters like `&` or `<`; `XML::Writer` handles this automatically within `dataElement` and `characters` methods.
- **Validation**: Use the `UNSAFE => 0` (default) setting during development to catch overlapping tags or multiple root elements.
- **Memory Efficiency**: For extremely large files, pass an object that performs incremental writes (like `IO::File`) to the `OUTPUT` parameter rather than capturing the entire document in a scalar string.

## Common Methods
- `startTag($name, [%attributes])`: Opens a new element.
- `endTag([$name])`: Closes the current element.
- `dataElement($name, $content, [%attributes])`: Shortcut for a complete element with text content.
- `emptyTag($name, [%attributes])`: Creates a self-closing tag (e.g., `<br />`).
- `comment($text)`: Inserts an XML comment.

## Reference documentation
- [XML::Writer Documentation](./references/metacpan_org_pod_XML-Writer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-writer_overview.md)