cwlVersion: v1.2
class: CommandLineTool
baseCommand: varda2-client seq
label: varda2-client_seq
doc: "Sequence\n\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: sequence
    type: string
    doc: Sequence
    inputBinding:
      position: 101
      prefix: --sequence
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client_seq.out
