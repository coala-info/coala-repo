cwlVersion: v1.2
class: CommandLineTool
baseCommand: spyboat
label: spyboat
doc: "\nTool homepage: https://github.com/tensionhead/SpyBOAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spyboat:0.1.1
stdout: spyboat.out
