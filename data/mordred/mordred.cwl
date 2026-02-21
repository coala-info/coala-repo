cwlVersion: v1.2
class: CommandLineTool
baseCommand: mordred
label: mordred
doc: "Molecular descriptor calculator\n\nTool homepage: https://github.com/mordred-descriptor/mordred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mordred:1.2.0--2
stdout: mordred.out
