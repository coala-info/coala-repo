---
name: perl-html-tree
description: This tool parses HTML documents into a tree of objects for structured navigation and manipulation in Perl. Use when user asks to parse HTML into a logical model, find elements by tags or attributes, extract text from nodes, or modify HTML structures.
homepage: http://metacpan.org/pod/HTML::Tree
metadata:
  docker_image: "quay.io/biocontainers/perl-html-tree:5.07--pl526_0"
---

# perl-html-tree

## Overview
The `perl-html-tree` skill provides a robust framework for representing HTML documents as a tree of objects. Unlike simple regex-based parsing, this tool builds a complete logical model of the HTML, allowing for sophisticated navigation (parent/child/sibling), attribute modification, and "cleanup" of poorly formatted markup. It is the standard Perl solution for treating HTML as a manageable data structure.

## Core Usage Patterns

### Initializing the Parser
Always use `HTML::TreeBuilder` to initiate the tree. It is a subclass of `HTML::Element`, so all element methods apply to the root.

```perl
use HTML::TreeBuilder;
my $tree = HTML::TreeBuilder->new;
$tree->parse_file("index.html");
# Or parse from a string: $tree->parse($html_content);
$tree->eof; # Signals end of parsing
```

### Finding Elements
Use the `look_down` method for flexible searching. It is the most powerful way to locate specific nodes.

*   **By Tag:** `$tree->look_down('_tag', 'div')`
*   **By Attribute:** `$tree->look_down('class', 'sidebar')`
*   **By Regex:** `$tree->look_down('href', qr/logout/i)`
*   **Combined:** `$tree->look_down('_tag', 'a', 'class', 'external')`

### Traversing and Extracting
Once a node is found, extract data or move through the hierarchy:

*   **Get Text:** `$node->as_trimmed_text;` (removes redundant whitespace)
*   **Get Attribute:** `$node->attr('href');`
*   **Navigation:** `$node->parent;`, `$node->content_list;` (returns children)

### Memory Management
**CRITICAL:** HTML::Tree objects use circular references. You must explicitly delete the tree to prevent memory leaks, especially in long-running processes or loops.

```perl
$tree = $tree->delete;
```

## Expert Tips
*   **Implicit Tags:** By default, TreeBuilder adds missing `<html>`, `<head>`, and `<body>` tags. Use `$tree->implicit_tags(0)` before parsing if you only want to process a snippet.
*   **Ignore Unknowns:** Use `$tree->ignore_unknown(1)` to prevent the parser from creating elements for non-standard HTML tags.
*   **As HTML:** To output the modified tree back to a string, use `$tree->as_HTML('<>&', "\t")`. The first argument defines entities to escape; the second defines indentation.

## Reference documentation
- [HTML::Tree - MetaCPAN](./references/metacpan_org_pod_HTML__Tree.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-html-tree_overview.md)