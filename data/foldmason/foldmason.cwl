cwlVersion: v1.2
class: CommandLineTool
baseCommand: foldmason
label: foldmason
doc: "Foldmason (Note: The provided text is a container execution error log and does
  not contain help or usage information).\n\nTool homepage: https://github.com/steineggerlab/foldmason"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
stdout: foldmason.out
