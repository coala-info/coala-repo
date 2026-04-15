---
name: perl-xml-twig
description: perl-xml-twig is a Perl module and suite of command-line tools designed for processing, searching, and splitting extremely large XML files using a memory-efficient tree-based approach. Use when user asks to search XML with XPath-like expressions, split massive XML files into smaller chunks, merge XML segments, or tidy and reformat XML documents.
homepage: http://metacpan.org/pod/XML-Twig
metadata:
  docker_image: "quay.io/biocontainers/perl-xml-twig:3.52--pl526_1"
---

# perl-xml-twig

## Overview
XML::Twig is a Perl module designed to bridge the gap between full DOM parsing and stream-based SAX parsing. It allows you to process XML documents by defining "handlers" for specific elements. When a handler triggers, only that sub-tree (the "twig") is loaded into memory, processed, and then flushed. This makes it the industry standard for handling multi-gigabyte XML files that would otherwise crash a standard DOM parser.

## Core CLI Utilities
The package includes several high-utility command-line tools that solve common XML tasks without writing custom Perl code:

### xml_grep
Search through XML files using XPath-like expressions.
- **Extract specific elements**: `xml_grep --group_by_tag 'item' '//record[status="active"]' file.xml`
- **Count occurrences**: `xml_grep --count '//target_node' file.xml`
- **Remove nodes**: `xml_grep --exclude '//comment' file.xml`

### xml_split and xml_merge
Handle massive files by breaking them into manageable chunks.
- **Split by size**: `xml_split -s 10Mb large_file.xml` (creates files like `large_file-01.xml`)
- **Split by element**: `xml_split -l 1 '//record' large_file.xml` (each record becomes a new file)
- **Reassemble**: `xml_merge large_file-main.xml > original_restored.xml`

### xml_tidy
Clean up and indent XML for readability.
- **Basic indent**: `xml_tidy -i file.xml`

## Expert Usage Patterns

### Memory Management in Perl Scripts
When writing custom scripts, always use `flush` or `purge` to keep memory usage constant regardless of input file size.
```perl
use XML::Twig;
my $twig = XML::Twig->new(
    twig_handlers => {
        'record' => sub { 
            my($t, $record) = @_;
            # Process the record here
            $record->print; 
            $t->flush; # Clears processed nodes from memory
        }
    }
);
$twig->parsefile('huge.xml');
```

### Fast Data Extraction
Use `twig_roots` instead of `twig_handlers` if you only need to process a small subset of a large file. This skips the creation of objects for any tags not specified in the roots, significantly increasing speed.

### Handling Broken XML
If dealing with non-well-formed XML, use the `recover` option in the constructor:
`my $twig = XML::Twig->new( recover => 1 );`

## Reference documentation
- [XML::Twig Perl Module Documentation](./references/metacpan_org_pod_XML-Twig.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-twig_overview.md)