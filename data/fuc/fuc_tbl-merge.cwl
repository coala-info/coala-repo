cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - tbl-merge
label: fuc_tbl-merge
doc: "Merge two table files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: left
    type: File
    doc: Input left file.
    inputBinding:
      position: 1
  - id: right
    type: File
    doc: Input right file.
    inputBinding:
      position: 2
  - id: how
    type:
      - 'null'
      - string
    doc: Type of merge to be performed
    inputBinding:
      position: 103
      prefix: --how
  - id: lsep
    type:
      - 'null'
      - string
    doc: Delimiter to use for the left file
    inputBinding:
      position: 103
      prefix: --lsep
  - id: on
    type:
      - 'null'
      - type: array
        items: string
    doc: Column names to join on.
    inputBinding:
      position: 103
      prefix: --on
  - id: osep
    type:
      - 'null'
      - string
    doc: Delimiter to use for the output file
    inputBinding:
      position: 103
      prefix: --osep
  - id: rsep
    type:
      - 'null'
      - string
    doc: Delimiter to use for the right file
    inputBinding:
      position: 103
      prefix: --rsep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_tbl-merge.out
