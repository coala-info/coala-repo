cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panaln
  - index
label: panaln_index
doc: "Index a pan-genome file\n\nTool homepage: https://github.com/Lilu-guo/Panaln"
inputs:
  - id: input_pan
    type: File
    doc: Input pan-genome file
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaln:2.09--h5ca1c30_0
stdout: panaln_index.out
