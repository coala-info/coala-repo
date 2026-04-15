---
name: perl-html-tagset
description: This tool provides data tables and structural rules for HTML elements to assist in parsing and validating web content. Use when user asks to identify tag categories, determine element nesting rules, or find link-bearing attributes in HTML.
homepage: https://metacpan.org/pod/HTML::Tagset
metadata:
  docker_image: "quay.io/biocontainers/perl-html-tagset:3.24--pl5321hdfd78af_0"
---

# perl-html-tagset

## Overview
This skill provides access to the structural rules of HTML as defined by the `HTML::Tagset` Perl module. It is essential for developers building custom HTML parsers, scrapers, or sanitizers who need to know how specific tags behave (e.g., block vs. inline, head vs. body) without hardcoding these relationships manually.

## Usage Guidelines

### Core Data Structures
The module provides several "hashsets" (hashes where keys are tag names and values are true). All tag names are stored in **lowercase**.

*   **Element Categories**:
    *   `%HTML::Tagset::emptyElement`: Tags that cannot have content (e.g., `hr`, `br`, `img`).
    *   `%HTML::Tagset::optionalEndTag`: Tags where the closing tag is legally omissible (e.g., `li`, `p`, `tr`).
    *   `%HTML::Tagset::isKnown`: A master list of all recognized HTML tags.
    *   `%HTML::Tagset::isPhraseMarkup`: Inline/phrasal elements.

### Structural Validation
Use these sets to determine where elements belong in a document tree:
*   `%HTML::Tagset::isHeadElement`: Tags restricted to the `<head>`.
*   `%HTML::Tagset::isBodyElement`: Tags restricted to the `<body>`.
*   `%HTML::Tagset::isTableElement`: Tags that must reside within a `<table>`.
*   `%HTML::Tagset::isFormElement`: Tags that must reside within a `<form>`.

### Link and Attribute Extraction
*   **Link Attributes**: Use `%HTML::Tagset::linkElements` to find which attributes contain URLs. The value is an array reference (e.g., `a => ['href']`, `img => ['src', 'lowsrc']`).
*   **Boolean Attributes**: Use `%HTML::Tagset::boolean_attr` to identify attributes that don't require a value (e.g., `noshade` on an `hr`).

### Implementation Example
```perl
use HTML::Tagset;

# Check if a tag is an empty element
if ($HTML::Tagset::emptyElement{$tagname}) {
    print "Tag <$tagname> does not require a closing tag.\n";
}

# Identify link-bearing attributes for a specific tag
if (exists $HTML::Tagset::linkElements{$tagname}) {
    my @attrs = @{$HTML::Tagset::linkElements{$tagname}};
    print "Attributes containing links for $tagname: @attrs\n";
}
```

## Best Practices
*   **Case Sensitivity**: Always convert tags to lowercase before checking them against the Tagset hashes.
*   **Parsing Logic**: Use `@HTML::Tagset::p_closure_barriers` when implementing logic to determine if a `<p>` tag should be implicitly closed by a new block element.
*   **Modification**: While you can technically modify these hashes at runtime to support custom tags, be aware that this will affect all other modules in your script that rely on `HTML::Tagset` (like `HTML::TreeBuilder`).

## Reference documentation
- [HTML::Tagset - data tables useful in parsing HTML](./references/metacpan_org_pod_HTML__Tagset.md)