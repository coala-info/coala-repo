# xmlstarlet CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| xmlstarlet_c14n | PASS |  |
| xmlstarlet_ed | PASS |  |
| xmlstarlet_el | PASS |  |
| xmlstarlet_esc | PASS |  |
| xmlstarlet_fo | PASS | Formats the XML correctly; the -o (omit declaration) option makes the tool exit with a random non-zero code (tool bug) while the output is right. |
| xmlstarlet_ls | PASS |  |
| xmlstarlet_p2x | PASS |  |
| xmlstarlet_pyx | PASS |  |
| xmlstarlet_sel | PASS |  |
| xmlstarlet_tr | PASS |  |
| xmlstarlet_unesc | PASS |  |
| xmlstarlet_val | PASS |  |

## xmlstarlet_sel

### Tool Description
Select data or query XML document(s) using XPath

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Select from XML document(s)
Usage: xml sel <global-options> {<template>} [ <xml-file> ... ]
where
  <global-options> - global options for selecting
  <xml-file> - input XML document file name/uri (stdin is used if missing)
  <template> - template for querying XML document with following syntax:

<global-options> are:
  -Q or --quiet             - do not write anything to standard output.
  -C or --comp              - display generated XSLT
  -R or --root              - print root element <xsl-select>
  -T or --text              - output is text (default is XML)
  -I or --indent            - indent output
  -D or --xml-decl          - do not omit xml declaration line
  -B or --noblanks          - remove insignificant spaces from XML tree
  -E or --encode <encoding> - output in the given encoding (utf-8, unicode...)
  -N <name>=<value>         - predefine namespaces (name without 'xmlns:')
                              ex: xsql=urn:oracle-xsql
                              Multiple -N options are allowed.
  --net                     - allow fetch DTDs or entities over network
  --help                    - display help

Syntax for templates: -t|--template <options>
where <options>
  -c or --copy-of <xpath>   - print copy of XPATH expression
  -v or --value-of <xpath>  - print value of XPATH expression
  -o or --output <string>   - output string literal
  -n or --nl                - print new line
  -f or --inp-name          - print input file name (or URL)
  -m or --match <xpath>     - match XPATH expression
  --var <name> <value> --break or
  --var <name>=<value>      - declare a variable (referenced by $name)
  -i or --if <test-xpath>   - check condition <xsl:if test="test-xpath">
  --elif <test-xpath>       - check condition if previous conditions failed
  --else                    - check if previous conditions failed
  -e or --elem <name>       - print out element <xsl:element name="name">
  -a or --attr <name>       - add attribute <xsl:attribute name="name">
  -b or --break             - break nesting
  -s or --sort op xpath     - sort in order (used after -m) where
  op is X:Y:Z, 
      X is A - for order="ascending"
      X is D - for order="descending"
      Y is N - for data-type="numeric"
      Y is T - for data-type="text"
      Z is U - for case-order="upper-first"
      Z is L - for case-order="lower-first"

There can be multiple --match, --copy-of, --value-of, etc options
in a single template. The effect of applying command line templates
can be illustrated with the following XSLT analogue

xml sel -t -c "xpath0" -m "xpath1" -m "xpath2" -v "xpath3" \
        -t -m "xpath4" -c "xpath5"

is equivalent to applying the following XSLT

<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <xsl:call-template name="t1"/>
  <xsl:call-template name="t2"/>
</xsl:template>
<xsl:template name="t1">
  <xsl:copy-of select="xpath0"/>
  <xsl:for-each select="xpath1">
    <xsl:for-each select="xpath2">
      <xsl:value-of select="xpath3"/>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>
<xsl:template name="t2">
  <xsl:for-each select="xpath4">
    <xsl:copy-of select="xpath5"/>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)

Current implementation uses libxslt from GNOME codebase as XSLT processor
(see http://xmlsoft.org/ for more details)
```

## xmlstarlet_ed

### Tool Description
Edit or update XML document(s) using XPath actions

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Edit XML document(s)
Usage: xml ed <global-options> {<action>} [ <xml-file-or-uri> ... ]
where
  <global-options>  - global options for editing
  <xml-file-or-uri> - input XML document file name/uri (stdin otherwise)

<global-options> are:
  -P, or -S           - preserve whitespace nodes.
     (or --pf, --ps)    Note that space between attributes is not preserved
  -O (or --omit-decl) - omit XML declaration (<?xml ...?>)
  -L (or --inplace)   - edit file inplace
  -N <name>=<value>   - predefine namespaces (name without 'xmlns:')
                        ex: xsql=urn:oracle-xsql
                        Multiple -N options are allowed.
                        -N options must be last global options.
  --net               - allow network access
  --help or -h        - display help

where <action>
  -d or --delete <xpath>
  --var <name> <xpath>
  -i or --insert <xpath> -t (--type) elem|text|attr -n <name> [-v (--value) <value>]
  -a or --append <xpath> -t (--type) elem|text|attr -n <name> [-v (--value) <value>]
  -s or --subnode <xpath> -t (--type) elem|text|attr -n <name> [-v (--value) <value>]
  -m or --move <xpath1> <xpath2>
  -r or --rename <xpath1> -v <new-name>
  -u or --update <xpath> -v (--value) <value>
                         -x (--expr) <xpath>

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_fo

### Tool Description
Format an XML document

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Format XML document
Usage: xml fo [<options>] <xml-file>
where <options> are
  -n or --noindent            - do not indent
  -t or --indent-tab          - indent output with tabulation
  -s or --indent-spaces <num> - indent output with <num> spaces
  -o or --omit-decl           - omit xml declaration <?xml version="1.0"?>
  --net                       - allow network access
  -R or --recover             - try to recover what is parsable
  -D or --dropdtd             - remove the DOCTYPE of the input docs
  -C or --nocdata             - replace cdata section with text nodes
  -N or --nsclean             - remove redundant namespace declarations
  -e or --encode <encoding>   - output in the given encoding (utf-8, unicode...)
  -H or --html                - input is HTML
  -h or --help                - print help

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_val

### Tool Description
Validate XML document(s): well-formedness, DTD, XSD or Relax-NG

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Validate XML document(s)
Usage: xml val <options> [ <xml-file-or-uri> ... ]
where <options>
  -w or --well-formed        - validate well-formedness only (default)
  -d or --dtd <dtd-file>     - validate against DTD
  --net                      - allow network access
  -s or --xsd <xsd-file>     - validate against XSD schema
  -E or --embed              - validate using embedded DTD
  -r or --relaxng <rng-file> - validate against Relax-NG schema
  -e or --err                - print verbose error messages on stderr
  -S or --stop               - stop on first error
  -b or --list-bad           - list only files which do not validate
  -g or --list-good          - list only files which validate
  -q or --quiet              - do not list files (return result code only)

NOTE: XML Schemas are not fully supported yet due to its incomplete
      support in libxml2 (see http://xmlsoft.org)

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_el

### Tool Description
Display the element structure of an XML document

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Display element structure of XML document
Usage: xml el [<options>] <xml-file>
where
  <xml-file> - input XML document file name (stdin is used if missing)
  <options> is one of:
  -a    - show attributes as well
  -v    - show attributes and their values
  -u    - print out sorted unique lines
  -d<n> - print out sorted unique lines up to depth <n>

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_tr

### Tool Description
Transform XML document(s) using an XSLT stylesheet

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Transform XML document(s) using XSLT
Usage: xml tr [<options>] <xsl-file> {-p|-s <name>=<value>} [<xml-file>...]
where
  <xsl-file>      - main XSLT stylesheet for transformation
  <xml-file>      - input XML document file/URL (stdin is used if missing)
  <name>=<value>  - name and value of the parameter passed to XSLT processor
  -p              - parameter is XPATH expression ("'string'" to quote string)
  -s              - parameter is a string literal
<options> are:
  --help or -h    - display help message
  --omit-decl     - omit xml declaration <?xml version="1.0"?>
  --embed or -E   - allow applying embedded stylesheet
  --show-ext      - show list of extensions
  --val           - allow validate against DTDs or schemas
  --net           - allow fetch DTDs or entities over network
  --xinclude      - do XInclude processing on document input
  --maxdepth val  - increase the maximum depth
  --html          - input document(s) is(are) in HTML format

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)

Current implementation uses libxslt from GNOME codebase as XSLT processor
(see http://xmlsoft.org/ for more details)
```

## xmlstarlet_ls

### Tool Description
List a directory as XML

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: List directory as XML
Usage: xml ls [ <dir> | --help ]
Lists current directory in XML format.
Time is shown per ISO 8601 spec.

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_c14n

### Tool Description
XML canonicalization

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: XML canonicalization
Usage: xml c14n [--net] <mode> <xml-file> [<xpath-file>] [<inclusive-ns-list>]
where
  <xml-file>   - input XML document file name (stdin is used if '-')
  <xpath-file> - XML file containing XPath expression for
                 c14n XML canonicalization
    Example:
    <?xml version="1.0"?>
    <XPath xmlns:n0="http://a.example.com" xmlns:n1="http://b.example">
    (//. | //@* | //namespace::*)[ancestor-or-self::n1:elem1]
    </XPath>

  <inclusive-ns-list> - the list of inclusive namespace prefixes
                        (only for exclusive canonicalization)
    Example: 'n1 n2'

  <mode> is one of following:
  --with-comments         XML file canonicalization w comments (default)
  --without-comments      XML file canonicalization w/o comments
  --exc-with-comments     Exclusive XML file canonicalization w comments
  --exc-without-comments  Exclusive XML file canonicalization w/o comments

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_esc

### Tool Description
Escape special XML characters

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Escape special XML characters
Usage: xml esc [<options>] [<string>]
where <options> are
  --help      - print usage
  (TODO: more to be added in future)
if <string> is missing stdin is used instead.

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_unesc

### Tool Description
Unescape special XML characters

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Unescape special XML characters
Usage: xml unesc [<options>] [<string>]
where <options> are
  --help      - print usage
  (TODO: more to be added in future)
if <string> is missing stdin is used instead.

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_pyx

### Tool Description
Convert XML into PYX format

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Convert XML into PYX format (based on ESIS - ISO 8879)
Usage: xml pyx {<xml-file>}
where
  <xml-file> - input XML document file name (stdin is used if missing)

The PYX format is a line-oriented representation of
XML documents that is derived from the SGML ESIS format.
(see ESIS - ISO 8879 Element Structure Information Set spec,
ISO/IEC JTC1/SC18/WG8 N931 (ESIS))

A non-validating, ESIS generating tool originally developed for
pyxie project (see http://pyxie.sourceforge.net/)
ESIS Generation by Sean Mc Grath http://www.digitome.com/sean.html

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## xmlstarlet_p2x

### Tool Description
Convert PYX into XML

### Metadata
- **Docker Image**: quay.io/biocontainers/xmlstarlet:1.6.1
- **Homepage**: http://xmlstar.sourceforge.net/
- **Package**: https://anaconda.org/channels/bioconda/packages/xmlstarlet/overview
- **Validation**: PASS

### Original Help Text
```text
XMLStarlet Toolkit: Convert PYX into XML
Usage: xml p2x [<pyx-file>]
where
  <pyx-file> - input PYX document file name (stdin is used if missing)

The PYX format is a line-oriented representation of
XML documents that is derived from the SGML ESIS format.
(see ESIS - ISO 8879 Element Structure Information Set spec,
ISO/IEC JTC1/SC18/WG8 N931 (ESIS))

XMLStarlet is a command line toolkit to query/edit/check/transform
XML documents (for more information see http://xmlstar.sourceforge.net/)
```

## Metadata
- **Skill**: not generated
