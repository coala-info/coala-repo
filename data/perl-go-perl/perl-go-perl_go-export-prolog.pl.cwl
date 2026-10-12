cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-export-prolog.pl
label: perl-go-perl_go-export-prolog.pl
doc: "Exports an ontology file as Prolog facts\n\nTool homepage: http://metacpan.org/pod/go-perl"
inputs:
  - id: input_ontology
    type:
      type: array
      items: File
    doc: "Ontology file(s) to export"
    inputBinding:
      position: 200
  - id: parser_format
    type:
      - 'null'
      - string
    doc: "Parser format; if left unspecified, guessed from the file suffix"
    inputBinding:
      position: 102
      prefix: -p
  - id: force_namespace
    type:
      - 'null'
      - string
    doc: "Force this namespace on all terms"
    inputBinding:
      position: 102
      prefix: -force_namespace
  - id: replace_underscore
    type:
      - 'null'
      - boolean
    doc: "Replace underscores in names with spaces"
    inputBinding:
      position: 102
      prefix: -replace_underscore
  - id: litemode
    type:
      - 'null'
      - boolean
    doc: "Use lite mode when parsing"
    inputBinding:
      position: 102
      prefix: -litemode
  - id: multifile
    type:
      - 'null'
      - boolean
    doc: "Print the multifile directive for the Prolog facts"
    inputBinding:
      position: 102
      prefix: -multifile
  - id: expand
    type:
      - 'null'
      - boolean
    doc: "Expand the output"
    inputBinding:
      position: 102
      prefix: -expand
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go-export-prolog.pl.out
