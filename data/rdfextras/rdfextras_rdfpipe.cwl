cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdfpipe
label: rdfextras_rdfpipe
doc: "A commandline tool for parsing RDF in different formats and serializing the
  resulting graph to a chosen format. Reads file system paths, URLs or from stdin
  if '-' is given. The result is serialized to stdout.\n\nTool homepage: https://github.com/RDFLib/rdfextras"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files or '-' for stdin
    inputBinding:
      position: 1
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Format of the input document(s). Available input formats are: trix, hturtle,
      trig, ntriples, application/xhtml+xml, xml, rdfa, nt, rdfa1.1, ttl, microdata,
      application/svg+xml, turtle, application/n-quads, mdata, text/n3, application/trix,
      text/turtle, application/n-triples, nquads, nt11, html, n3, application/rdf+xml,
      text/html, rdfa1.0. If no format is given, it will be guessed from the file
      name extension. Keywords to parser can be given after format like: FORMAT:(+)KW1,-KW2,KW3=VALUE.'
    inputBinding:
      position: 102
      prefix: --input-format
  - id: namespace
    type:
      - 'null'
      - type: array
        items: string
    doc: Register a namespace binding (QName prefix to a base URI). This can be 
      used more than once.
    inputBinding:
      position: 102
      prefix: --ns
  - id: no_guess
    type:
      - 'null'
      - boolean
    doc: Don't guess format based on file suffix.
    inputBinding:
      position: 102
      prefix: --no-guess
  - id: no_out
    type:
      - 'null'
      - boolean
    doc: Don't output the resulting graph (useful for checking validity of 
      input).
    inputBinding:
      position: 102
      prefix: --no-out
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Format of the graph serialization. Available output formats are: turtle,
      n3, pretty-xml, text/turtle, nt11, trig, application/trix, application/n-quads,
      nt, application/n-triples, ttl, text/n3, nquads, application/rdf+xml, xml, ntriples,
      trix. Default format is: 'n3'. Keywords to serializer can be given after format
      like: FORMAT:(+)KW1,-KW2,KW3=VALUE."
    default: n3
    inputBinding:
      position: 102
      prefix: --output-format
  - id: warn
    type:
      - 'null'
      - boolean
    doc: Output warnings to stderr (by default only critical errors).
    inputBinding:
      position: 102
      prefix: --warn
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdfextras:0.4--py27_2
stdout: rdfextras_rdfpipe.out
