cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-show-paths-to-root.pl
label: perl-go-perl_go-show-paths-to-root.pl
doc: "Traverses the DAG showing all possible paths (terms and intervening relationships) from a term to the root\n\nTool homepage: http://metacpan.org/pod/go-perl"
inputs:
  - id: input_ontology
    type: File
    doc: "Ontology file to parse (one file)"
    inputBinding:
      position: 200
  - id: term_ids
    type:
      type: array
      items: string
      inputBinding:
        prefix: -id
    doc: "ID of the term to show paths for (repeat for several terms)"
    inputBinding:
      position: 101
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
  - id: names
    type:
      - 'null'
      - boolean
    doc: "Show term names instead of accessions in the paths"
    inputBinding:
      position: 102
      prefix: -names
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
stdout: perl-go-perl_go-show-paths-to-root.pl.out
