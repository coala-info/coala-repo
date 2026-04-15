---
name: perl-pod-simple
description: Perl-pod-simple is a modular framework used to parse and convert Perl Pod documentation into various formats like HTML, XHTML, or structural trees. Use when user asks to parse Pod markup, convert Perl documentation to HTML, extract a structural tree of a document, or generate batch documentation for Perl libraries.
homepage: https://github.com/perl-pod/pod-simple
metadata:
  docker_image: "quay.io/biocontainers/perl-pod-simple:3.35--pl5.22.0_0"
---

# perl-pod-simple

## Overview
Pod::Simple is a modular Perl framework designed to parse Pod markup. It serves as the modern foundation for Perl documentation tools, replacing the legacy Pod::Parser. You should use this skill when you need to programmatically handle Perl documentation, whether you are converting a `.pm` file to HTML, extracting a structural tree of the documentation, or building a custom renderer. It is particularly useful for maintaining documentation consistency across Perl modules and generating batch documentation for entire libraries.

## Usage and Best Practices

### Core Library Patterns
Pod::Simple is primarily used as a library within Perl scripts. The standard workflow involves instantiating a formatter subclass, configuring its output destination, and then triggering the parser.

**Basic Conversion Pattern:**
```perl
use Pod::Simple::HTML;
my $parser = Pod::Simple::HTML->new;
$parser->output_string(\my $html_content);
$parser->parse_file('path/to/Module.pm');
```

### Key Subclasses
*   **Pod::Simple::XHTML**: Use this for modern, extensible web output. It provides better support for CSS and entity encoding than the older HTML subclass.
*   **Pod::Simple::HTMLBatch**: Use this for converting entire directories of Perl files into a linked set of HTML pages.
*   **Pod::Simple::SimpleTree**: Use this when you need to analyze the structure of a Pod document without rendering it. It parses the Pod into a nested array structure (a "Pod Tree").

### Expert Tips and Constraints
*   **Single-Use Instances**: A critical constraint of Pod::Simple is that parser instances are generally intended to be used only once. Do not attempt to call `parse_file` or `parse_lines` multiple times on the same object; always create a new instance for each document.
*   **Heading Selection**: Use the `set_heading_select` method (formerly `select`) to filter which sections of the Pod are processed. This is useful for extracting specific sections like "SYNOPSIS" or "DESCRIPTION".
*   **Entity Handling**: When using `Pod::Simple::XHTML`, ensure `HTML::Entities` is installed for robust character encoding. The module includes fallbacks, but they are less comprehensive.
*   **Internal Links**: The framework handles internal section links (e.g., `L</"Methods">`). If links are failing in custom subclasses, verify that the `id` generation logic matches the link anchor generation.

### Installation
The module follows standard Perl installation procedures:
1. `perl Makefile.PL`
2. `make`
3. `make test`
4. `make install`

## Reference documentation
- [Pod::Simple README](./references/github_com_perl-pod_pod-simple.md)
- [Pod::Simple Issues (Usage Constraints)](./references/github_com_perl-pod_pod-simple_issues.md)
- [Pod::Simple Commits (Method Updates)](./references/github_com_perl-pod_pod-simple_commits_master.md)