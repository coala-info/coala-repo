cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fuc-bgzip
label: fuc_fuc-bgzip
doc: "Write a BGZF compressed file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: file
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Input file to be compressed (default: stdin).'
    default: stdin
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-bgzip.out
