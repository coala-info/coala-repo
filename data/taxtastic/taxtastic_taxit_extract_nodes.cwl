cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - extract_nodes
label: taxtastic_taxit_extract_nodes
doc: "Extract nodes from a given source in yaml format\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: "Name of SQL schema in database to query (if database flavor supports this)."
    inputBinding:
      position: 1
      prefix: "--schema"
  - id: outfile
    type:
      - 'null'
      - string
    doc: "Output file"
    inputBinding:
      position: 1
      prefix: "--outfile"
  - id: database
    type: File
    doc: "Taxonomy database (SQLite file made by new_database). Database string URI or filename; if no scheme is given sqlite:/// is prepended."
    inputBinding:
      position: 101
  - id: source_name
    type: string
    doc: "name of source identifying names and nodes to extract"
    inputBinding:
      position: 102
outputs:
  - id: outfile_file
    type:
      - 'null'
      - File
    doc: "Extracted nodes in yaml format (only with --outfile)"
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
stdout: taxtastic_taxit_extract_nodes.out
