# rdfextras CWL Generation Report

## rdfextras_csv2rdf

### Tool Description
Reads csv files from stdin or given files
if -d is given, use this delimiter
if -s is given, skips N lines at the start
Creates a URI from the columns given to -i, or automatically by numbering if
none is given
Outputs RDFS labels from the columns given to -l
if -c is given adds a type triple with the given classname
if -C is given, the class is defined as rdfs:Class
Outputs one RDF triple per column in each row.
Output is in n3 format.
Output is stdout, unless -o is specified

### Metadata
- **Docker Image**: quay.io/biocontainers/rdfextras:0.4--py27_2
- **Homepage**: https://github.com/RDFLib/rdfextras
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rdfextras/overview
- **Total Downloads**: 6.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/RDFLib/rdfextras
- **Stars**: N/A
### Original Help Text
```text
csv2rdf.py     -b <instance-base>     -p <property-base>     [-c <classname>]     [-i <identity column(s)>]     [-l <label columns>]     [-s <N>] [-o <output>]     [-f configfile]     [--col<N> <colspec>]     [--prop<N> <property>]     <[-d <delim>]     [-C] [files...]"

Reads csv files from stdin or given files
if -d is given, use this delimiter
if -s is given, skips N lines at the start
Creates a URI from the columns given to -i, or automatically by numbering if
none is given
Outputs RDFS labels from the columns given to -l
if -c is given adds a type triple with the given classname
if -C is given, the class is defined as rdfs:Class
Outputs one RDF triple per column in each row.
Output is in n3 format.
Output is stdout, unless -o is specified

Long options also supported:     --base,     --propbase,     --ident,     --class,     --label,     --out,     --defineclass

Long options --col0, --col1, ...
can be used to specify conversion for columns.
Conversions can be:
    float(), int(), split(sep, [more]), uri(base, [class]), date(format)

Long options --prop0, --prop1, ...
can be used to use specific properties, rather than ones auto-generated
from the headers

-f says to read config from a .ini/config file - the file must contain one
section called csv2rdf, with keys like the long options, i.e.:

[csv2rdf]
out=output.n3
base=http://example.org/
col0=split(";")
col1=split(";", uri("http://example.org/things/",
                    "http://xmlns.com/foaf/0.1/Person"))
col2=float()
col3=int()
col4=date("%Y-%b-%d %H:%M:%S")
```


## rdfextras_rdfpipe

### Tool Description
A commandline tool for parsing RDF in different formats and serializing the resulting graph to a chosen format. Reads file system paths, URLs or from stdin if '-' is given. The result is serialized to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/rdfextras:0.4--py27_2
- **Homepage**: https://github.com/RDFLib/rdfextras
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: rdfpipe [-h] [-i INPUT_FORMAT] [-o OUTPUT_FORMAT] [--ns=PFX=NS ...] [-] [FILE ...]

A commandline tool for parsing RDF in different formats and serializing the
resulting graph to a chosen format. Reads file system paths, URLs or from
stdin if '-' is given. The result is serialized to stdout.

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i INPUT_FORMAT, --input-format=INPUT_FORMAT
                        Format of the input document(s). Available input
                        formats are: trix, hturtle, trig, ntriples,
                        application/xhtml+xml, xml, rdfa, nt, rdfa1.1, ttl,
                        microdata, application/svg+xml, turtle,
                        application/n-quads, mdata, text/n3, application/trix,
                        text/turtle, application/n-triples, nquads, nt11,
                        html, n3, application/rdf+xml, text/html, rdfa1.0. If
                        no format is given, it will be guessed from the file
                        name extension. Keywords to parser can be given after
                        format like: FORMAT:(+)KW1,-KW2,KW3=VALUE.
  -o OUTPUT_FORMAT, --output-format=OUTPUT_FORMAT
                        Format of the graph serialization. Available output
                        formats are: turtle, n3, pretty-xml, text/turtle,
                        nt11, trig, application/trix, application/n-quads, nt,
                        application/n-triples, ttl, text/n3, nquads,
                        application/rdf+xml, xml, ntriples, trix. Default
                        format is: 'n3'. Keywords to serializer can be given
                        after format like: FORMAT:(+)KW1,-KW2,KW3=VALUE.
  --ns=PREFIX=NAMESPACE
                        Register a namespace binding (QName prefix to a base
                        URI). This can be used more than once.
  --no-guess            Don't guess format based on file suffix.
  --no-out              Don't output the resulting graph (useful for checking
                        validity of input).
  -w, --warn            Output warnings to stderr (by default only critical
                        errors).
```


## rdfextras_rdf2dot

### Tool Description
Converts RDF graphs to the DOT graph description language.

### Metadata
- **Docker Image**: quay.io/biocontainers/rdfextras:0.4--py27_2
- **Homepage**: https://github.com/RDFLib/rdfextras
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Reading from stdin as None...Traceback (most recent call last):
  File "/usr/local/bin/rdf2dot", line 6, in <module>
    sys.exit(rdflib.tools.rdf2dot.main())
  File "/usr/local/lib/python2.7/site-packages/rdflib/tools/rdf2dot.py", line 129, in main
    rdflib.extras.cmdlineutils.main(rdf2dot, _help)
  File "/usr/local/lib/python2.7/site-packages/rdflib/extras/cmdlineutils.py", line 50, in main
    g.load(sys.stdin, format=f)
  File "/usr/local/lib/python2.7/site-packages/rdflib/graph.py", line 1046, in load
    self.parse(source, publicID, format)
  File "/usr/local/lib/python2.7/site-packages/rdflib/graph.py", line 1039, in parse
    parser.parse(source, self, **args)
  File "/usr/local/lib/python2.7/site-packages/rdflib/plugins/parsers/rdfxml.py", line 577, in parse
    self._parser.parse(source)
  File "/usr/local/lib/python2.7/xml/sax/expatreader.py", line 111, in parse
    xmlreader.IncrementalParser.parse(self, source)
  File "/usr/local/lib/python2.7/xml/sax/xmlreader.py", line 125, in parse
    self.close()
  File "/usr/local/lib/python2.7/xml/sax/expatreader.py", line 243, in close
    self.feed("", isFinal = 1)
  File "/usr/local/lib/python2.7/xml/sax/expatreader.py", line 224, in feed
    self._err_handler.fatalError(exc)
  File "/usr/local/lib/python2.7/xml/sax/handler.py", line 38, in fatalError
    raise exception
xml.sax._exceptions.SAXParseException: file:///dev/stdin:1:0: no element found
```


## rdfextras_rdfs2dot

### Tool Description
Converts an RDFS graph to a DOT graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/rdfextras:0.4--py27_2
- **Homepage**: https://github.com/RDFLib/rdfextras
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Reading from stdin as None...Traceback (most recent call last):
  File "/usr/local/bin/rdfs2dot", line 6, in <module>
    sys.exit(rdflib.tools.rdfs2dot.main())
  File "/usr/local/lib/python2.7/site-packages/rdflib/tools/rdfs2dot.py", line 109, in main
    rdflib.extras.cmdlineutils.main(rdfs2dot, _help)
  File "/usr/local/lib/python2.7/site-packages/rdflib/extras/cmdlineutils.py", line 50, in main
    g.load(sys.stdin, format=f)
  File "/usr/local/lib/python2.7/site-packages/rdflib/graph.py", line 1046, in load
    self.parse(source, publicID, format)
  File "/usr/local/lib/python2.7/site-packages/rdflib/graph.py", line 1039, in parse
    parser.parse(source, self, **args)
  File "/usr/local/lib/python2.7/site-packages/rdflib/plugins/parsers/rdfxml.py", line 577, in parse
    self._parser.parse(source)
  File "/usr/local/lib/python2.7/xml/sax/expatreader.py", line 111, in parse
    xmlreader.IncrementalParser.parse(self, source)
  File "/usr/local/lib/python2.7/xml/sax/xmlreader.py", line 125, in parse
    self.close()
  File "/usr/local/lib/python2.7/xml/sax/expatreader.py", line 243, in close
    self.feed("", isFinal = 1)
  File "/usr/local/lib/python2.7/xml/sax/expatreader.py", line 224, in feed
    self._err_handler.fatalError(exc)
  File "/usr/local/lib/python2.7/xml/sax/handler.py", line 38, in fatalError
    raise exception
xml.sax._exceptions.SAXParseException: file:///dev/stdin:1:0: no element found
```


## Metadata
- **Skill**: generated
