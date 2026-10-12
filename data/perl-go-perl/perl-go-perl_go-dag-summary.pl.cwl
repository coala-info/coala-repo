cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-dag-summary.pl
label: perl-go-perl_go-dag-summary.pl
doc: "Summarises an ontology: one row per ontology with the number of terms, relationships and paths\n\nTool homepage: http://metacpan.org/pod/go-perl"
inputs:
  - id: input_ontology
    type:
      type: array
      items: File
    doc: "Ontology file(s) to summarise"
    inputBinding:
      position: 200
  - id: err_file
    type:
      - 'null'
      - string
    doc: "Name of a file to write parse errors in XML to (defaults to STDERR)"
    inputBinding:
      position: 102
      prefix: -e
  - id: parser_format
    type:
      - 'null'
      - string
    doc: "Parser format; if left unspecified, guessed from the file suffix"
    inputBinding:
      position: 102
      prefix: -p
  - id: use_cache
    type:
      - 'null'
      - boolean
    doc: "Turn caching mode on (writes a .cache file next to the input)"
    inputBinding:
      position: 102
      prefix: -use_cache
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: err_file_out
    type:
      - 'null'
      - File
    doc: Parse errors written with the err_file option
    outputBinding:
      glob: $(inputs.err_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go-dag-summary.pl.out
