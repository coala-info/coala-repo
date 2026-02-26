cwlVersion: v1.2
class: CommandLineTool
baseCommand: go2fmt.pl
label: perl-go-perl_go2fmt.pl
doc: "parses any GO/OBO style ontology file and writes out as a different format\n\
  \nTool homepage: http://metacpan.org/pod/go-perl"
inputs:
  - id: input_ontology
    type:
      type: array
      items: File
    doc: GO/OBO style ontology file(s) to parse
    inputBinding:
      position: 1
  - id: errfile
    type:
      - 'null'
      - File
    doc: writes parse errors in XML - defaults to STDERR (there should be no 
      parse errors in well formed files)
    inputBinding:
      position: 102
      prefix: -e
  - id: parser_format
    type:
      - 'null'
      - string
    doc: determines which parser to use; if left unspecified, will make a guess 
      based on file suffix. See below for formats
    inputBinding:
      position: 102
      prefix: -p
  - id: use_cache
    type:
      - 'null'
      - string
    doc: If this switch is specified, then caching mode is turned on.
    inputBinding:
      position: 102
  - id: writer_format
    type:
      - 'null'
      - string
    doc: format for output - see below for list
    inputBinding:
      position: 102
      prefix: --writer
  - id: xslt
    type:
      - 'null'
      - string
    doc: The name or filename of an XSLT transform
    inputBinding:
      position: 102
      prefix: --xslt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go2fmt.pl.out
