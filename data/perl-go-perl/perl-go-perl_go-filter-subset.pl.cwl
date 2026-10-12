cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-filter-subset.pl
label: perl-go-perl_go-filter-subset.pl
doc: "Extracts a subgraph from an ontology file; the subset can be based on IDs, a named subset or a user filter\n\nTool homepage: http://metacpan.org/pod/go-perl"
inputs:
  - id: input_ontology
    type: File
    doc: "Ontology file to filter"
    inputBinding:
      position: 200
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -id
    doc: "ID to use as leaf node in the subgraph; all ancestors are included unless partial is set (repeat for several IDs)"
    inputBinding:
      position: 102
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
  - id: subset
    type:
      - 'null'
      - string
    doc: "Extract a named subset (for example a GO slim) from the ontology file (obo files only)"
    inputBinding:
      position: 102
      prefix: -subset
  - id: namespace
    type:
      - 'null'
      - string
    doc: "Only terms in this namespace"
    inputBinding:
      position: 102
      prefix: -namespace
  - id: filter_code
    type:
      - 'null'
      - string
    doc: "Advanced: a Perl subroutine that tests a GO::Model::Term for inclusion"
    inputBinding:
      position: 102
      prefix: -filter_code
  - id: partial
    type:
      - 'null'
      - boolean
    doc: "Only include terms that match the query; parentage is set to the next parent in the filter"
    inputBinding:
      position: 102
      prefix: -partial
  - id: to
    type:
      - 'null'
      - string
    doc: "Output format of the exported graph (default obo)"
    inputBinding:
      position: 102
      prefix: -to
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
stdout: perl-go-perl_go-filter-subset.pl.out
