cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - namelookup
label: taxtastic_taxit_namelookup
doc: "Find primary name and tax_id from taxonomic names\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: "Name of SQL schema in database to query (if database flavor supports this)."
    inputBinding:
      position: 1
      prefix: "--schema"
  - id: infile
    type:
      - 'null'
      - File
    doc: "file containing a list of taxonomic names, one per line"
    inputBinding:
      position: 1
      prefix: "--infile"
  - id: names
    type:
      - 'null'
      - string
    doc: "one or more taxonomic names provided as a comma-delimited list on the command line"
    inputBinding:
      position: 1
      prefix: "--names"
  - id: outfile
    type:
      - 'null'
      - string
    doc: "output file"
    inputBinding:
      position: 1
      prefix: "--outfile"
  - id: include_unmatched
    type:
      - 'null'
      - boolean
    doc: "include names with no match"
    inputBinding:
      position: 1
      prefix: "--include-unmatched"
  - id: database
    type:
      - 'null'
      - File
    doc: "Taxonomy database (SQLite file made by new_database). Database string URI or filename; if no scheme is given sqlite:/// is prepended."
    inputBinding:
      position: 101
outputs:
  - id: outfile_file
    type:
      - 'null'
      - File
    doc: "Primary names and tax_ids (only with --outfile)"
    outputBinding:
      glob: "$(inputs.outfile)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_namelookup.out
