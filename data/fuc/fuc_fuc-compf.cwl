cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fuc-compf
label: fuc_fuc-compf
doc: "Compare the contents of two files.\n\nThis command will compare the contents
  of two files, returning 'True' if they\nare identical and 'False' otherwise.\n\n\
  Tool homepage: https://github.com/sbslee/fuc"
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-compf.out
