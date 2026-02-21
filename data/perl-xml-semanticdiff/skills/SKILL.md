---
name: perl-xml-semanticdiff
description: This skill provides guidance on using `XML::SemanticDiff`, a Perl-based tool designed to compare XML documents semantically.
homepage: http://metacpan.org/pod/XML-SemanticDiff
---

# perl-xml-semanticdiff

## Overview
This skill provides guidance on using `XML::SemanticDiff`, a Perl-based tool designed to compare XML documents semantically. Unlike standard `diff` utilities that operate on a line-by-line basis, this tool parses the XML tree to find differences in the actual data structure. It is particularly useful for regression testing configuration files, validating data exports, or auditing changes in complex XML datasets where formatting (like indentation) should not trigger a "difference" alert.

## Usage Patterns

### Basic Command Line Comparison
The package typically provides a helper script (often named `xmlsemdiff`) to perform comparisons directly from the shell.

```bash
xmlsemdiff file1.xml file2.xml
```

### Core Semantic Rules
When using this tool, keep in mind how it evaluates "equality":
- **Whitespace:** Ignored between elements unless it is part of a text node.
- **Attribute Order:** Ignored; `<node a="1" b="2">` is considered identical to `<node b="2" a="1">`.
- **Structural Integrity:** It flags missing elements, extra elements, and mismatched character data (CDATA).

### Perl API Integration
For more complex workflows, use the Perl module directly to handle diff objects programmatically.

```perl
use XML::SemanticDiff;
my $diff = XML::SemanticDiff->new();

# Returns an array of hash references describing differences
my @differences = $diff->compare($file1, $file2);

foreach my $change (@differences) {
    print "Context: $change->{context}\n";
    print "Message: $change->{message}\n";
}
```

## Expert Tips
- **Handling Namespaces:** Ensure both XML files define namespaces consistently, as semantic diffs are sensitive to URI mismatches even if prefixes differ.
- **Large Files:** For very large XML files, ensure sufficient memory is available as the tool builds an in-memory representation of both trees to perform the comparison.
- **Exit Codes:** Use the tool in CI/CD pipelines to break builds if semantic changes are detected in critical configuration files.

## Reference documentation
- [XML::SemanticDiff Documentation](./references/metacpan_org_pod_XML-SemanticDiff.md)