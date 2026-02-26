---
name: perl-xml-namespacesupport
description: This Perl module provides a generic class for managing and resolving XML namespaces within parsers or processing scripts. Use when user asks to implement namespace handling in Perl, manage prefix-to-URI mappings, or resolve qualified names during XML processing.
homepage: https://github.com/perigrin/xml-namespacesupport
---


# perl-xml-namespacesupport

## Overview
The `perl-xml-namespacesupport` skill centers on the `XML::NamespaceSupport` Perl module, a lightweight and generic class for processing namespaced XML names. It is designed to be integrated into XML parsers or processing scripts to maintain a consistent map of prefixes to namespace URIs. You should use this skill when you need to implement robust namespace handling in Perl, especially when dealing with nested scopes where prefixes may be redefined or undeclared.

## Usage and Best Practices

### Installation
The package is available via Bioconda for bioinformatics environments or standard Perl CPAN for general development.
- **Conda**: `conda install bioconda::perl-xml-namespacesupport`
- **CPAN**: `cpan XML::NamespaceSupport`

### Core API Workflow
The module follows the SAX2 `NamespaceSupport` model. The standard procedural flow for managing namespaces during XML processing is:

1.  **Initialization**: Create a new instance of the support class.
    ```perl
    use XML::NamespaceSupport;
    my $ns_support = XML::NamespaceSupport->new();
    ```
2.  **Context Management**: At the start of every XML element, push a new context. At the end of the element, pop it.
    - `push_context()`: Starts a new namespace scope.
    - `pop_context()`: Discards the current scope and returns to the previous one.
3.  **Declaring Namespaces**: Use `declare_prefix($prefix, $uri)` within the current context. To handle the default namespace (e.g., `xmlns="uri"`), use an empty string or `undef` for the prefix.
4.  **Resolving Names**: Use `process_name($qname)` to split a qualified name (like `edi:price`) into its prefix, local name, and resolved URI.

### Expert Tips and Patterns
- **Clark Notation**: Use `parse_jclark_notation($string)` to handle "universal names" formatted as `{http://example.org/ns}local_name`. This is useful for internal data representation where prefixes are irrelevant.
- **Undeclaring Prefixes**: In XML 1.1, prefixes can be undeclared. Use `undeclare_prefix($prefix)` to remove a mapping in the current context.
- **Batch Declaration**: If you have multiple namespaces to register at once, use `declare_prefixes(%mappings)` for efficiency.
- **Context Validation**: Always ensure `push_context()` is called before attempting to retrieve declared prefixes, or the module may throw an error regarding missing context.
- **Default Namespace**: To check the current default namespace URI, call `get_uri('')`.

### Common Method Reference
- `get_prefix($uri)`: Returns one of the prefixes mapped to a URI.
- `get_prefixes($uri)`: Returns all prefixes currently mapped to a URI.
- `get_declared_prefixes()`: Returns all prefixes declared in the *current* context only.

## Reference documentation
- [Bioconda perl-xml-namespacesupport Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-namespacesupport_overview.md)
- [XML::NamespaceSupport GitHub README](./references/github_com_perigrin_xml-namespacesupport.md)
- [Module Commit History and API Changes](./references/github_com_perigrin_xml-namespacesupport_commits_master.md)