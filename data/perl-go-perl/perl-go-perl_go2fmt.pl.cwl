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
      position: 200
  - id: errfile
    type:
      - 'null'
      - string
    doc: Name of a file to write parse errors in XML to (defaults to STDERR; there
      should be no parse errors in well formed files)
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
      - boolean
    doc: If this switch is specified, then caching mode is turned on.
    inputBinding:
      position: 102
      prefix: -use_cache
  - id: writer_format
    type:
      - 'null'
      - string
    doc: format for output - see below for list
    inputBinding:
      position: 102
      prefix: -w
  - id: xslt
    type:
      - 'null'
      - string
    doc: The name or filename of an XSLT transform
    inputBinding:
      position: 102
      prefix: -xslt
  - id: output_file
    type:
      - 'null'
      - string
    doc: Name of a file to write the converted ontology to (default is standard output)
    inputBinding:
      position: 102
      prefix: -o
  - id: datatype
    type:
      - 'null'
      - string
    doc: Type of data to parse (as used by GO::Parser)
    inputBinding:
      position: 102
      prefix: -t
  - id: litemode
    type:
      - 'null'
      - boolean
    doc: Use lite mode when parsing
    inputBinding:
      position: 102
      prefix: -l
  - id: obo_set
    type:
      - 'null'
      - boolean
    doc: Wrap the output in an obo_set element, even for a single file
    inputBinding:
      position: 102
      prefix: -obo_set
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file_out
    type:
      - 'null'
      - File
    doc: Converted ontology written with the output option
    outputBinding:
      glob: $(inputs.output_file)
  - id: errfile_out
    type:
      - 'null'
      - File
    doc: Parse errors written with the errfile option
    outputBinding:
      glob: $(inputs.errfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go2fmt.pl.out
