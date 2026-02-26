# perl-go-perl CWL Generation Report

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

