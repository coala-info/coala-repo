---
name: perl-ppi
description: Perl-ppi parses Perl source code into a structured document tree for static analysis and manipulation without executing the code. Use when user asks to extract metadata from Perl scripts, strip comments or POD documentation, find specific code tokens, or perform programmatic code cleaning.
homepage: https://github.com/adamkennedy/PPI
---


# perl-ppi

## Overview
The `perl-ppi` (Parse::Perl::Isolated) skill enables the treatment of Perl source code as a structured document rather than executable code. Because Perl's grammar is notoriously difficult to parse without execution, PPI provides a static analysis framework that allows for robust manipulation of `.pl` and `.pm` files. Use this skill when you need to programmatically "clean" Perl scripts, extract metadata (like package names), or perform linting-style checks without the security risks or environment dependencies of running the code.

## Core Usage Patterns

### Document Initialization
To begin working with a Perl file, load it into a `PPI::Document` object. This creates a hierarchical tree of tokens and statements.

```perl
use PPI;

# Load from a file
my $doc = PPI::Document->new('script.pl');

# Load from a string
my $doc_from_string = PPI::Document->new(\'my $foo = 1; print $foo;');
```

### Content Manipulation and Stripping
One of the most common uses for PPI is "stripping" a file of non-code elements for minification or analysis.

```perl
# Remove all POD documentation
$doc->prune('PPI::Token::Pod');

# Remove all comments
$doc->prune('PPI::Token::Comment');

# Save the modified document
$doc->save('script.stripped.pl');
```

### Searching and Extraction
PPI allows you to find specific elements within the document tree using class names.

```perl
# Find the first package declaration to get the namespace
my $pkg_node = $doc->find_first('PPI::Statement::Package');
my $namespace = $pkg_node->namespace if $pkg_node;

# Check if the document uses a specific token type
if ( $doc->find_any('PPI::Token::HereDoc') ) {
    print "Document contains HereDocs\n";
}

# Get all variable names (Tokens)
my $variables = $doc->find('PPI::Token::Symbol');
```

## Expert Tips
- **Document vs. Code**: Remember that PPI does not "understand" the code's logic (e.g., it won't know if a function exists in an external library). It only understands the document's structure.
- **Memory Management**: For extremely large Perl files, PPI can be memory-intensive because it builds a full object tree. Prune unnecessary tokens early if you are performing multi-pass analysis.
- **Round-tripping**: PPI is designed for "round-tripping." If you load a document and save it immediately without changes, the output should be byte-for-byte identical to the input, preserving all whitespace and formatting.
- **Integration with Perl::Critic**: If your goal is style enforcement or bug detection, PPI is the underlying engine for `Perl::Critic`. Use PPI directly only when you need custom transformations or data extraction not covered by existing Critic policies.

## Reference documentation
- [PPI GitHub Repository](./references/github_com_Perl-Critic_PPI.md)
- [Bioconda perl-ppi Overview](./references/anaconda_org_channels_bioconda_packages_perl-ppi_overview.md)