cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - table-ids
label: biom-format_table_ids
doc: "Dump out the IDs found within a table.\n\nTool homepage: http://www.biom-format.org"
inputs:
  - id: input_fp
    type: File
    doc: The input BIOM table
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: observations
    type:
      - 'null'
      - boolean
    doc: Grab observation IDs
    inputBinding:
      position: 101
      prefix: --observations
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
stdout: biom-format_table_ids.out
