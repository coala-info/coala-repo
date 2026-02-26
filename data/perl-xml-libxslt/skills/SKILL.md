---
name: perl-xml-libxslt
description: This tool provides a Perl interface to the GNOME libxslt engine for performing fast and standards-compliant XSLT transformations. Use when user asks to transform XML documents, apply XSLT stylesheets, or register custom Perl functions for use within XSLT logic.
homepage: https://metacpan.org/pod/XML::LibXSLT
---


# perl-xml-libxslt

## Overview
The `perl-xml-libxslt` skill provides a procedural interface to the GNOME libxslt engine, known for being highly compliant and significantly faster than many alternative XSLT processors. This skill should be used to automate XML-to-XML, XML-to-HTML, or XML-to-text transformations where performance and standards compliance are critical. It integrates closely with `XML::LibXML` for document parsing and provides advanced hooks for security and custom extension functions.

## Core Implementation Pattern
To perform a transformation, you must coordinate `XML::LibXML` for parsing and `XML::LibXSLT` for the engine logic.

```perl
use XML::LibXSLT;
use XML::LibXML;

# 1. Initialize the engine
my $xslt = XML::LibXSLT->new();

# 2. Load the XML source and the XSL stylesheet
my $parser = XML::LibXML->new();
my $source_doc = $parser->load_xml(location => 'data.xml');
my $style_doc  = $parser->load_xml(location => 'transform.xsl', no_cdata => 1);

# 3. Parse the stylesheet and transform
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $results    = $stylesheet->transform($source_doc);

# 4. Output the result
print $stylesheet->output_as_bytes($results);
```

## Expert Tips and Best Practices

### Managing Recursion and Variables
For complex stylesheets that involve deep recursion or a high volume of variables, you must adjust the global engine limits to prevent premature termination.
- **Recursion Depth**: Use `XML::LibXSLT->max_depth(1000);` (default is 250).
- **Variable Limits**: Use `XML::LibXSLT->max_vars(100000);` if your stylesheet generates an "excessive variables" error.

### Custom Perl Extension Functions
You can call Perl subroutines directly from your XSLT logic. This is useful for complex string manipulation or database lookups that are difficult in pure XSLT 1.0.
- **Registration**: `XML::LibXSLT->register_function("urn:my-utils", "get_date", sub { scalar localtime });`
- **XSLT Usage**: Define the namespace `xmlns:utils="urn:my-utils"` and call `<xsl:value-of select="utils:get_date()"/>`.

### Security Constraints
When processing untrusted XSLT files, use the `XML::LibXSLT::Security` module to prevent unauthorized file system or network access.
```perl
use XML::LibXSLT::Security;
my $sec = XML::LibXSLT::Security->new();
$sec->register_callback('read_file', sub { return 0; }); # Disable file reading
$xslt->security($sec);
```

### Output Methods
Choose the correct output method based on your target:
- `output_as_bytes($results)`: Best for general use; returns a byte string.
- `output_as_chars($results)`: Returns a Perl Unicode string.
- `output_as_file($results, $filename)`: Efficiently writes directly to disk.

## Common CLI One-Liner
For quick transformations from the terminal:
```bash
perl -MXML::LibXSLT -MXML::LibXML -e 'print XML::LibXSLT->new->parse_stylesheet(XML::LibXML->load_xml(location => "style.xsl"))->transform(XML::LibXML->load_xml(location => "data.xml"))->toString'
```

## Reference documentation
- [XML::LibXSLT - Interface to the GNOME libxslt library](./references/metacpan_org_pod_XML__LibXSLT.md)
- [perl-xml-libxslt Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-libxslt_overview.md)