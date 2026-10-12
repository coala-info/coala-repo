# perl-go-perl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-go-perl_go-apply-xslt | Failed | image problem: xsltproc rejects oboxml_to_owl.xsl (xmlns attribute not allowed) and oboxml_to_obotext.xsl gives malformed output |
| perl-go-perl_go-dag-summary.pl | PASS | works on an 8-term subset; runs without end on the full 140-term GO slim |
| perl-go-perl_go-export-prolog.pl | PASS |  |
| perl-go-perl_go-filter-subset.pl | PASS |  |
| perl-go-perl_go-show-paths-to-root.pl | PASS |  |
| perl-go-perl_go2fmt.pl | PASS |  |

## perl-go-perl_go2fmt.pl

### Tool Description
parses any GO/OBO style ontology file and writes out as a different format

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
- **Homepage**: http://metacpan.org/pod/go-perl
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-go-perl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-go-perl/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
NAME
    go2fmt.pl go2obo_xml go2owl go2rdf_xml go2obo_text

SYNOPSIS
      go2fmt.pl -w obo_xml -e errlog.xml ontology/*.ontology
      go2fmt.pl -w obo_xml -e errlog.xml ontology/gene_ontology.obo

DESCRIPTION
    parses any GO/OBO style ontology file and writes out as a different
    format

  ARGUMENTS
   -e ERRFILE
    writes parse errors in XML - defaults to STDERR (there should be no
    parse errors in well formed files)

   -p FORMAT
    determines which parser to use; if left unspecified, will make a guess
    based on file suffix. See below for formats

   -w|writer FORMAT
    format for output - see below for list

   -|xslt XSLT
    The name or filename of an XSLT transform

    This can either be an absolute path to a file anywhere on the
    filesystem, or it can just be the name of the xslt; eg

      go2fmt.pl -xslt oboxml_to_owl go.obo

    If the name is specified, then first of all $GO_ROOT/xml/xsl/*.xsl will
    be searched; if GO_ROOT is not set, then the perl modules dir where GO
    is installed will be searched (the xslts will be installed here
    automatically if you follow the normal install process)

  -use_cache
    If this switch is specified, then caching mode is turned on.

    With caching mode, the first time you parse a file, then an additional
    file will be exported in a special format that is fast to parse. This
    file will have the same filename as the original file, except it will
    have the ".cache" suffix.

    The next time you parse the file, this program will automatically check
    for the existence of the ".cache" file. If it exists, and is more recent
    than the file you specified, this is parsed instead. If it does not
    exist, it is rebuilt.

    This will bring a speed improvement for b<some> of the output formats
    below (such as pathlist). Most output formats work with event-based
    parsing, so caching the object brings no benefit and will in fact be
    slower than bypassing the cache

  FORMATS
    writable formats are

    go_ont
        Files with suffix ".ontology"

        These store the ontology DAGs

    go_def
        Files with suffix ".defs"

    go_xref
        External database references for GO terms

        Files with suffix "2go" (eg ec2go, metacyc2go)

    go_assoc
        Annotations of genes or gene products using GO

        Files with prefix "gene-association."

    obo_text
        Files with suffix ".obo"

        This is a new file format replacement for the existing GO flat file
        formats. It handles ontologies, definitions and xrefs (but not
        associations)

    obo_xml
        Files with suffix ".obo.xml" or ".obo-xml"

        This is the XML version of the OBO flat file format above

    prolog
        prolog facts - you will need a prolog compiler/interpreter to use
        these. You can reason over these facts using Obol or the forthcoming
        Bio-LP project

    tbl simple (lossy) tabular representation

    summary
        can be used on both ontology files and association files

    pathlist
        shows all paths to the root

    owl OWL format (default: OWL-DL)

        OWL is a W3C standard format for ontologies

        You will need the XSL files from the full go-dev distribution to run
        this; see the XML section in <http://www.godatabase.org/dev>

    obj_yaml
        a YAML representation of a GO::Model::Graph object

    obj_storable
        A dump of the perl GO::Model::Graph object. You need Storable from
        CPAN for this to work. This is intended to cache objects on the
        filesystem, for fast access. The obj_storable representation may not
        be portable

    text_html
        A html-ified OBO output format

    godb_prestore
        XML that maps directly to the GODB relational schema (can then be
        loaded using stag-storenode.pl)

    chadodb_prestore
        XML that maps directly to the Chado relational schema (can then be
        loaded using stag-storenode.pl)

  DOCUMENTATION
    <http://www.godatabase.org/dev>
```

## perl-go-perl_go-dag-summary.pl

### Tool Description
Summarises an ontology: one row per ontology with the number of terms, relationships and paths

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
- **Homepage**: http://metacpan.org/pod/go-perl
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-go-perl/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    go-dag-summary

SYNOPSIS
      go-dag-summary ontology/gene_ontology.obo

DESCRIPTION
    Summarises an ontology

ARGUMENTS
   -e ERRFILE
    writes parse errors in XML - defaults to STDERR (there should be no
    parse errors in well formed files)

   -p FORMAT
    determines which parser to use; if left unspecified, will make a guess
    based on file suffix. See below for formats

  -use_cache
    If this switch is specified, then caching mode is turned on.

    With caching mode, the first time you parse a file, then an additional
    file will be exported in a special format that is fast to parse. This
    file will have the same filename as the original file, except it will
    have the ".cache" suffix.

    The next time you parse the file, this program will automatically check
    for the existence of the ".cache" file. If it exists, and is more recent
    than the file you specified, this is parsed instead. If it does not
    exist, it is rebuilt.

OUTPUT
    One row per ontology

    Each row has the following columns

    input filename
    total no of terms
    total no of relationships
    total no of paths
    avg no of paths per term (p/t)
    maximum no of paths for any term
    ID of term with maximum no of paths
        NOTE: obsolete terms are not included

  DOCUMENTATION
    <http://www.godatabase.org/dev>

  SEE ALSO
    <http://www.fruitfly.org/~cjm/obol/doc/go-complexity.html>
```

## perl-go-perl_go-show-paths-to-root.pl

### Tool Description
Traverses the DAG showing all possible paths from a term to the root

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
- **Homepage**: http://metacpan.org/pod/go-perl
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-go-perl/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    go-show-paths-to-root.pl - shows all possible paths from a term to the
    top

SYNOPSIS
      go-show-paths-to-root.pl -id GO:0008021 ontology/gene_ontology.obo
      go-show-paths-to-root.pl -names -id GO:0008021 ontology/gene_ontology.obo

DESCRIPTION
    traverses DAG showing all paths (terms and intervening relationships) to
    the root

    This script is purely file based; it needs to parse the ontology each
    time

    Subsequent parses can be speeded up using the use_cache option

    If you wish to use the GO MySQL db, see the script
    go-db-show-paths-to-root.pl in the go-db-perl distribution

ARGUMENTS
   -e ERRFILE
    writes parse errors in XML - defaults to STDERR (there should be no
    parse errors in well formed files)

   -p FORMAT
    determines which parser to use; if left unspecified, will make a guess
    based on file suffix. See below for formats

  -use_cache
    If this switch is specified, then caching mode is turned on.

    With caching mode, the first time you parse a file, then an additional
    file will be exported in a special format that is fast to parse. This
    file will have the same filename as the original file, except it will
    have the ".cache" suffix.

    The next time you parse the file, this program will automatically check
    for the existence of the ".cache" file. If it exists, and is more recent
    than the file you specified, this is parsed instead. If it does not
    exist, it is rebuilt.

  DOCUMENTATION
    <http://www.godatabase.org/dev>
```

## perl-go-perl_go-filter-subset.pl

### Tool Description
Extracts a subgraph from an ontology file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
- **Homepage**: http://metacpan.org/pod/go-perl
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-go-perl/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    go-filter-subset.pl - extracts a subgraph from an ontology file

SYNOPSIS
      go-filter-subset.pl -id GO:0003767 go.obo

      go-filter-subset.pl -id GO:0003767 -to png go.obo | xv -

      go-filter-subset.pl -filter_code 'sub{shift->name =~ /transcr/}' go.obo

DESCRIPTION
    Exports a subset of an ontology from a file. The subset can be based on
    a specified set of IDs, a preset "subset" filter in the ontology file
    (eg a GO "slim" or subset), or a user-defined filter.

    The subset can be exported in any format, including a graphical image

ARGUMENTS
    -id ID
        ID to use as leaf node in subgraph. All ancestors of this ID are
        included in the exported graph (unless -partial is set)

        Multiple IDs can be passed

          -id ID1 -id ID2 -id ID3 ....etc

    -subset SUBSET_ID
        Extracts a named subset from the ontology file. (only works with obo
        format files). For example, a specific GO slim

        ONLY terms belonging to the subset are exported - the -partial
        option is automatically set

    -namespace NAMESPACE
        only terms in this namespace

    -filter_code SUBROUTINE
        advanced option

        A subroutine with which the GO::Model::Term object is tested for
        inclusion in the subgraph (all ancestors are automatically included)

        You should have an understanding of the go-perl object model before
        using this option

        Example:

          go-filter-subset -filter_code 'sub {shift->namespace eq 'molecular_function'}' go.obo

        (the same things can be achieved with the -namespace option)

    -partial
        If this is set, then only terms that match the user query are
        included. Parentage is set to the next recursive parent node in the
        filter

        For example, with the -subset option: if X and Y belong to the
        subset, and Z does not, and X is_a Z is_a Y, then the exported graph
        withh have X is_a Y

    -use_cache
        If this switch is specified, then caching mode is turned on.

        With caching mode, the first time you parse a file, then an
        additional file will be exported in a special format that is fast to
        parse. This file will have the same filename as the original file,
        except it will have the ".cache" suffix.

        The next time you parse the file, this program will automatically
        check for the existence of the ".cache" file. If it exists, and is
        more recent than the file you specified, this is parsed instead. If
        it does not exist, it is rebuilt.

  DOCUMENTATION
    <http://www.godatabase.org/dev>
```

## perl-go-perl_go-export-prolog.pl

### Tool Description
Exports an ontology file as Prolog facts

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
- **Homepage**: http://metacpan.org/pod/go-perl
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-go-perl/overview
- **Validation**: PASS

### Original Help Text
```text
go-export-prolog.pl [-p FORMAT] [-force_namespace NS] [-replace_underscore] [-litemode] [-multifile] [-expand] FILE...

Exports one or more ontology files (obo and other GO formats) as Prolog facts on standard output.
(The script has no built-in help text; the options are taken from its Getopt::Long specification.)
```

## perl-go-perl_go-apply-xslt

### Tool Description
Processes Obo-XML files through an XSLT transform using xsltproc

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
- **Homepage**: http://metacpan.org/pod/go-perl
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-go-perl/overview
- **Validation**: PASS

### Original Help Text
```text
go-apply-xslt XSLT-NAME [XML FILE...] [XSLTPROC-OPTIONS...]

processes Obo-XML files through an XSLT pipeline

examples:

  go-apply-xslt oboxml_to_owl my.obo-xml
  go-apply-xslt oboxml_filter my.obo-xml --stringparam namespace cell

If your input format is not obo-xml, you can transform it in a pipeline:

  go2obo_xml so.obo | go-apply-xslt text_html -

Which is the same as:

  go2xml -x text_html so.obo

1
```
