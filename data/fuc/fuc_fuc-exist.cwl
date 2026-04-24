cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fuc-exist
label: fuc_fuc-exist
doc: "Check whether certain files exist.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files and directories to be tested
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-exist.out
