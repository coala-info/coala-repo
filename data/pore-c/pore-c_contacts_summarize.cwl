cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, contacts, summarize]
label: pore-c_contacts_summarize
doc: "Summarise a contact table.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: user_metadata
    type:
      - 'null'
      - string
    doc: "Add additional user metadata to the summary table, must be a dictionary in json format"
    inputBinding:
      position: 1
      prefix: --user-metadata
  - id: contact_table
    type: File
    doc: "Contact table (parquet)"
    inputBinding:
      position: 10
  - id: read_summary_table
    type: File
    doc: "Read summary table (csv, from reads prepare)"
    inputBinding:
      position: 11
  - id: concatemer_table
    type: string
    doc: "Output concatemer table (parquet)"
    inputBinding:
      position: 12
  - id: concatemer_summary_csv
    type: string
    doc: "Output concatemer summary (csv)"
    inputBinding:
      position: 13
outputs:
  - id: concatemer_table_file
    type: File
    doc: "Concatemer table (parquet)"
    outputBinding:
      glob: "$(inputs.concatemer_table)"
  - id: concatemer_summary
    type: File
    doc: "Concatemer summary (csv)"
    outputBinding:
      glob: "$(inputs.concatemer_summary_csv)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
