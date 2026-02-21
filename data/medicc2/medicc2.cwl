cwlVersion: v1.2
class: CommandLineTool
baseCommand: medicc2
label: medicc2
doc: "MEDICC2: Minimum Evolution for Individual Copy-number Alterations\n\nTool homepage:
  https://bitbucket.org/schwarzlab/medicc2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medicc2:1.1.2--py310h8ea774a_1
stdout: medicc2.out
